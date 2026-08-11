#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Sirenix.Utilities;
using UnityEngine;

namespace Ase;

public class HomeLandService : IHomeLandService
{
	private HomeLandViewModel homeLandVm;

	private ISubscription<SOOpenNotifyMessager> subscription_SONotify;

	private Dictionary<int, bool> farmSeedDic;

	private Dictionary<long, int[]> friendFarmStateDic;

	private int[] todayCount;

	private FarmInfo farmInfo;

	private Dictionary<int, BPData> bpWarehouse = new Dictionary<int, BPData>();

	private Dictionary<int, BPData> bpCarrying;

	private ISubscription<BattlePropChangeNotify> subscription_BPChangeNotify;

	private Action<BattlePropGetViewModel> showGetBP;

	private Action<BattleProps> equipNewBP;

	private HomeShopViewModel _homeShopViewModel;

	private SailInfo sailInfo;

	private Timer farmRedPointTimer;

	private Timer sailRedPointTimer;

	public Dictionary<int, BPData> BpCarrying => bpCarrying;

	public HomeLandService()
	{
		subscription_SONotify = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<SOOpenNotifyMessager>(OnSystemOpen);
		subscription_BPChangeNotify = Singleton<NetworkSystem>.Instance.Subscribe<BattlePropChangeNotify>(OnBattlePropChange);
		_homeShopViewModel = new HomeShopViewModel();
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.AddDailyUpdateAction(OnDailyUpdated);
	}

	private async void OnSystemOpen(SOOpenNotifyMessager messager)
	{
		if (messager.serviceId == 70013 && messager.state)
		{
			await RequsetBattlePropData();
		}
		else if (messager.serviceId == 70014 && messager.state)
		{
			await RequestAllData();
		}
	}

	public async UniTask<bool> RequestAllData()
	{
		if (Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70013))
		{
			await RequsetBattlePropData();
		}
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70014))
		{
			return true;
		}
		bool homeland = await RequsetHomelandData();
		bool homeShop = await RequestShopData();
		await RequestAllFriendShopList();
		bool farm = await RequestFarmInfo();
		SailInfo sailInfo = await GetSailLightEventList();
		return (homeShop & homeland & farm) && sailInfo.IsInit;
	}

	private async void OnDailyUpdated()
	{
		await RequestShopData();
		Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new HomelandMsg(this, HomelandMsgType.ShopRefreshRed));
		Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new HomelandMsg(this, HomelandMsgType.FriendShopRefreshRed));
	}

	public async UniTask<bool> RequsetHomelandData()
	{
		Dictionary<int, int> buildingLevels = new Dictionary<int, int>();
		GetHomeLandInfoRequest request = GetHomeLandInfoRequest.Create();
		GetHomeLandInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetHomeLandInfoResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取家园信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取家园信息失败"))
			{
				for (int i = 0; i < response.Buildings.Count; i++)
				{
					buildingLevels.Add(response.Buildings[i].BuildingType, response.Buildings[i].BuildingLevel);
				}
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
					.SetMoney(MoneyEnum.HomelandCoin, response.HomeLandCoin);
				homeLandVm = new HomeLandViewModel(response.Level, buildingLevels);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取家园信息，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		if (homeLandVm == null)
		{
			homeLandVm = new HomeLandViewModel(1, buildingLevels);
		}
		return false;
	}

	public HomeLandViewModel GetVm()
	{
		return homeLandVm;
	}

	public async UniTask<bool> UpgradeHomeland(int buildingType)
	{
		UpgradeHomeLandLevelRequest request = UpgradeHomeLandLevelRequest.Create();
		request.BuildingType = buildingType;
		UpgradeHomeLandLevelResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<UpgradeHomeLandLevelResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "家园升级") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "家园升级失败"))
			{
				PropHelper.AnalyzeRewardFromServer(response.CostItems);
				if (buildingType == 0)
				{
					homeLandVm.UpgradeLevel(homeLandVm.HomelandLevel + 1);
				}
				else
				{
					homeLandVm.UpgradeBuildingLevel(buildingType);
				}
				Context.GetApplicationContext().GetService<IMessenger>()?.Publish(new HomelandMsg(this, HomelandMsgType.HomelandLevelUpgradeRed));
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("家园升级，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<List<HomelandBuildingData>> GetFriendBuildingInfos(PlayerData data)
	{
		List<HomelandBuildingData> buildingDatas = new List<HomelandBuildingData>();
		GetFriendHomeLandInfoRequest request = GetFriendHomeLandInfoRequest.Create();
		request.FriendId = data.Uid;
		GetFriendHomeLandInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetFriendHomeLandInfoResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取好友家园数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取好友家园数据失败"))
			{
				data.SetHomelandLevel(response.Level);
				int i;
				for (i = 0; i < response.Buildings.Count; i++)
				{
					DRBuildingInfo dataRow = GameEntry.DataTable.GetDataRow((DRBuildingInfo p) => p.Id == response.Buildings[i].BuildingType);
					HomelandBuildingData item = new HomelandBuildingData(dataRow, response.Buildings[i].BuildingLevel, data.HomelandLevel < dataRow.NeedHomelandLevel);
					buildingDatas.Add(item);
				}
				return buildingDatas;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("家园升级，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			if (response != null)
			{
				response.Dispose();
				response = null;
			}
		}
		DRBuildingInfo[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRBuildingInfo>();
		for (int num = 0; num < allDataRow.Length; num++)
		{
			HomelandBuildingData item2 = new HomelandBuildingData(allDataRow[num], 1, data.HomelandLevel < allDataRow[num].NeedHomelandLevel);
			buildingDatas.Add(item2);
		}
		return buildingDatas;
	}

	public async UniTask<bool> RequestFarmInfo()
	{
		GetFarmInfoRequest request = GetFarmInfoRequest.Create();
		GetFarmInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetFarmInfoResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求余温熔炉数据失败"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求余温熔炉数据失败"))
				{
					List<FarmData> list = new List<FarmData>();
					foreach (PbFarmGridInfo grid in response.Grids)
					{
						FarmData item = default(FarmData);
						item.GridId = grid.GirdId;
						item.IsInCrease = grid.State == 1;
						item.HarvestTime = grid.HarvestTime;
						item.SeedId = grid.SeedId;
						item.FruitCount = grid.Fruit.Count;
						item.Init();
						list.Add(item);
					}
					farmSeedDic = new Dictionary<int, bool>();
					DRFarmSeed[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRFarmSeed>();
					for (int i = 0; i < allDataRow.Length; i++)
					{
						bool value = PlayerPrefs.GetInt("RedPoint" + $"FarmSeed_{allDataRow[i].Id}") == 1;
						if (allDataRow[i].UnlockType == 1 && allDataRow[i].UnlockTypeEx <= homeLandVm.BuildingDatas[1].Level)
						{
							farmSeedDic.Add(allDataRow[i].Id, value);
						}
						else if (Bitwise(response.UnlockedFarmSeedList, allDataRow[i].OpenIndex - 1))
						{
							farmSeedDic.Add(allDataRow[i].Id, value);
						}
					}
					friendFarmStateDic = new Dictionary<long, int[]>();
					foreach (PbFriendFarmGridState friendFarmState in response.FriendFarmStates)
					{
						if (!friendFarmStateDic.ContainsKey(friendFarmState.FriendId))
						{
							int[] value2 = new int[2] { friendFarmState.GridIdIncreaseState, friendFarmState.GridIdHarvestState };
							friendFarmStateDic.Add(friendFarmState.FriendId, value2);
						}
					}
					todayCount = new int[2] { response.TodayFriendIncreaseCount, response.TodayFriendHarvestCount };
					farmInfo.Level = homeLandVm.BuildingDatas[1].Level;
					farmInfo.FarmDataList = list;
					SetFarmRedPoint();
					return true;
				}
				Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response.Error, "请求余温熔炉数据失败，请重试！"));
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("请求余温熔炉数据失败！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public FarmInfo GetFarmInfo()
	{
		return farmInfo;
	}

	public int[] GetFriendFarmState(long friendUid)
	{
		int[] value = new int[0];
		friendFarmStateDic.TryGetValue(friendUid, out value);
		return value;
	}

	public int[] GetTodayCount()
	{
		return todayCount;
	}

	public Dictionary<int, bool> GetUnLockSeedList()
	{
		return farmSeedDic;
	}

	private bool Bitwise(int num, int index)
	{
		return (num & (1 << index)) > 0;
	}

	public async UniTask<long[]> StartPlant(int gridId, int seedId)
	{
		HomeLandStartPlantRequest request = HomeLandStartPlantRequest.Create();
		request.GridId = gridId;
		request.SeedId = seedId;
		HomeLandStartPlantResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HomeLandStartPlantResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求种植失败"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求种植失败"))
				{
					return new long[2] { response.HarvestTime, response.FruitCount };
				}
				Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response.Error, "请求种植失败，请重试！"));
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("请求种植失败！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<bool> AbortPlant(int gridId)
	{
		HomeLandAbortPlantRequest request = HomeLandAbortPlantRequest.Create();
		request.GridId = gridId;
		HomeLandAbortPlantResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HomeLandAbortPlantResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "取消种植物失败"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "取消种植物失败"))
				{
					return true;
				}
				Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response.Error, "取消种植物失败，请重试！"));
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("取消种植物失败！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<HarvestData> HarvestPlant(int gridId)
	{
		HomeLandHarvestPlantRequest request = HomeLandHarvestPlantRequest.Create();
		request.GridId = gridId;
		HomeLandHarvestPlantResponse response = null;
		HarvestData harvestData = default(HarvestData);
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HomeLandHarvestPlantResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "收获种植物失败"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "收获种植物失败"))
				{
					RewardGetData rewardGetData = PropHelper.AnalyzeRewardFromServer(response.FruitItems);
					PropGetViewModel propGetViewModel = new PropGetViewModel(null, rewardGetData.PropList);
					harvestData.PropGetViewModel = propGetViewModel;
					List<FarmData> list = new List<FarmData>();
					foreach (PbFarmGridInfo newGridInfo in response.NewGridInfos)
					{
						FarmData item = default(FarmData);
						item.GridId = newGridInfo.GirdId;
						item.IsInCrease = newGridInfo.State == 1;
						item.HarvestTime = newGridInfo.HarvestTime;
						item.SeedId = newGridInfo.SeedId;
						item.FruitCount = newGridInfo.Fruit.Count;
						item.Init();
						list.Add(item);
					}
					farmInfo.UpdateFarmData(list);
					harvestData.FarmDataList = list;
					SetFarmRedPoint();
				}
				else
				{
					Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response.Error, "收获种植物失败，请重试！"));
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("收获种植物失败！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return harvestData;
	}

	public async UniTask<long> SpeedUpPlant(int gridId, int itemId, int itemCount)
	{
		HomeLandSpeedUpPlantRequest request = HomeLandSpeedUpPlantRequest.Create();
		request.GridId = gridId;
		request.SelectItemId = itemId;
		request.SelectItemCount = itemCount;
		HomeLandSpeedUpPlantResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HomeLandSpeedUpPlantResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "使用加速道具失败"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "使用加速道具失败"))
				{
					SetFarmRedPoint();
					return response.HarvestTime;
				}
				Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response.Error, "使用加速道具失败，请重试！"));
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("使用加速道具失败！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return -1L;
	}

	public async UniTask<bool> GetFriendFarmInfo(long friendUid)
	{
		GetFriendFarmInfoRequest request = GetFriendFarmInfoRequest.Create();
		request.FriendId = friendUid;
		GetFriendFarmInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetFriendFarmInfoResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "余温熔炉", "进入好友余温熔炉失败"))
			{
				List<FarmData> list = new List<FarmData>();
				foreach (PbFarmGridInfo grid in response.Grids)
				{
					FarmData item = new FarmData
					{
						GridId = grid.GirdId,
						HarvestTime = grid.HarvestTime,
						SeedId = grid.SeedId,
						FruitCount = grid.Fruit.Count
					};
					if (friendFarmStateDic != null && friendFarmStateDic.ContainsKey(friendUid))
					{
						item.FriendIncrease = Bitwise(friendFarmStateDic[friendUid][0], grid.GirdId - 1);
						item.FriendHarvest = Bitwise(friendFarmStateDic[friendUid][1], grid.GirdId - 1);
					}
					item.Init();
					list.Add(item);
				}
				farmInfo.Level = response.Level;
				farmInfo.FarmDataList = list;
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Toast.ShowInfo("进入好友余温熔炉失败");
			Log.Error("进入好友余温熔炉失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> IncreaseFriendPlant(long friendUid, int gridId)
	{
		HomeLandIncreaseFriendGridRequest request = HomeLandIncreaseFriendGridRequest.Create();
		request.FriendId = friendUid;
		request.GridId = gridId;
		HomeLandIncreaseFriendGridResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HomeLandIncreaseFriendGridResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "增产好友农作物失败"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "增产好友农作物失败"))
				{
					friendFarmStateDic.TryGetValue(friendUid, out var value);
					int num = ((value != null) ? value[1] : 0);
					int[] value2 = new int[2] { response.GridIdIncreaseState, num };
					if (value != null)
					{
						friendFarmStateDic[friendUid] = value2;
					}
					else
					{
						friendFarmStateDic.Add(friendUid, value2);
					}
					todayCount[0]++;
					return true;
				}
				Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response.Error, "增产好友农作物失败，请重试！"));
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("增产好友农作物失败！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<HarvestData> HarvestFriendPlant(long friendUid, int gridId)
	{
		FarmHarvestFriendRequest request = FarmHarvestFriendRequest.Create();
		request.FriendId = friendUid;
		request.GridId = gridId;
		FarmHarvestFriendResponse response = null;
		HarvestData harvestData = default(HarvestData);
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<FarmHarvestFriendResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "收获好友种植物失败"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "收获好友种植物失败"))
				{
					todayCount[1]++;
					List<PropDataBase> list = new List<PropDataBase>();
					KnapsackPropData knapsackPropData = KnapsackPropData.Create(response.Fruit.ItemId, (int)response.Fruit.ItemDelta);
					Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().AddProp(knapsackPropData);
					list.Add(knapsackPropData);
					PropGetViewModel propGetViewModel = new PropGetViewModel(null, list);
					harvestData.PropGetViewModel = propGetViewModel;
					harvestData.FriendCount = (int)response.Fruit.ItemDelta;
					friendFarmStateDic.TryGetValue(friendUid, out var value);
					int num = ((value != null) ? value[0] : 0);
					int[] value2 = new int[2] { num, response.GridIdHarvestState };
					if (value != null)
					{
						friendFarmStateDic[friendUid] = value2;
					}
					else
					{
						friendFarmStateDic.Add(friendUid, value2);
					}
					return harvestData;
				}
				Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response.Error, "收获好友种植物失败，请重试！"));
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("收获好友种植物失败！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return harvestData;
	}

	public async void UseBattleProp(BPData bpData)
	{
		BattlePropUseRequest rst = BattlePropUseRequest.Create();
		rst.PropId = bpData.TeamId;
		BattlePropUseResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<BattlePropUseResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求战斗道具消耗") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求战斗道具消耗失败"))
			{
				if (bpWarehouse.ContainsKey(bpData.TeamId))
				{
					bpWarehouse[bpData.TeamId].Consume();
				}
				return;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("请求战斗道具消耗失败！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		Toast.ShowInfo("使用" + bpData.Name + "发生异常！");
	}

	public async void UseBattleProp(int teamId)
	{
		BattlePropUseRequest rst = BattlePropUseRequest.Create();
		rst.PropId = teamId;
		BattlePropUseResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<BattlePropUseResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求战斗道具消耗") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求战斗道具消耗失败"))
			{
				if (bpWarehouse.ContainsKey(teamId))
				{
					bpWarehouse[teamId].Consume();
				}
				return;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("请求战斗道具消耗失败！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		Toast.ShowInfo($"使用战斗道具{teamId}发生异常！");
	}

	public int SetCarryPropDataMax(int index)
	{
		if (bpCarrying.TryGetValue(index, out var value))
		{
			value.SetCarryPropNumberToMax();
			return value.CarryPropNumber;
		}
		return 0;
	}

	public int SetPropDataMax(int propId)
	{
		if (bpWarehouse.TryGetValue(propId, out var value))
		{
			value.SetCarryPropNumberToMax();
			return value.CarryPropNumber;
		}
		return 0;
	}

	private void OnBattlePropChange(BattlePropChangeNotify obj)
	{
		if (bpWarehouse == null)
		{
			bpWarehouse = new Dictionary<int, BPData>();
		}
		DRBattlePropInfo dataRow = GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.TeamId == obj.Id && p.Lev == obj.Level);
		if (dataRow == null)
		{
			Log.Error($"找不到战斗道具数据 BattlePropInfo teamId:{obj.Id} lev:{obj.Level}");
		}
		if (bpWarehouse.ContainsKey(obj.Id))
		{
			bpWarehouse[obj.Id].UpdateLevelAndCount(dataRow, obj.Count);
		}
		else
		{
			bpWarehouse.Add(obj.Id, BPData.Create(dataRow, isLock: false, obj.Count));
		}
		BattlePropGetViewModel obj2 = new BattlePropGetViewModel(bpWarehouse[obj.Id], obj.Level == 1, obj.Level - 1);
		showGetBP?.Invoke(obj2);
		if (obj.Level == 1)
		{
			bpWarehouse[obj.Id].SetCarryPropNumberToMax();
			BattleProps obj3 = BattleProps.Create(bpWarehouse[obj.Id]);
			equipNewBP?.Invoke(obj3);
		}
	}

	public BPData ShowBattlePropDrawingGet(int id)
	{
		if (bpWarehouse == null || !bpWarehouse.ContainsKey(id))
		{
			Log.Error($"找不到战斗道具数据 teamId:{id}");
			return null;
		}
		return bpWarehouse[id];
	}

	public void AddShowGetBPListener(Action<BattlePropGetViewModel> action)
	{
		showGetBP = null;
		showGetBP = action;
	}

	public void AddEquipNewBPListener(Action<BattleProps> action)
	{
		equipNewBP = action;
	}

	public void RemoveGetBPListener()
	{
		showGetBP = null;
		equipNewBP = null;
	}

	public async UniTask<bool> RequsetBattlePropData()
	{
		BattlePropGetListRequest rst = BattlePropGetListRequest.Create();
		BattlePropGetListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<BattlePropGetListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求战斗道具"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求战斗道具失败"))
				{
					int i;
					for (i = 0; i < response.BattleProps.Count; i++)
					{
						BPData bPData = null;
						DRBattlePropInfo dataRow = GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.TeamId == response.BattleProps[i].Id && p.Lev == response.BattleProps[i].Level);
						if (dataRow != null)
						{
							bPData = BPData.Create(dataRow, isLock: false, response.BattleProps[i].Count);
						}
						if (!bpWarehouse.ContainsKey(response.BattleProps[i].Id))
						{
							bpWarehouse.Add(response.BattleProps[i].Id, bPData);
						}
						else
						{
							bpWarehouse[response.BattleProps[i].Id].RefreshFromServer(bPData);
						}
					}
				}
				else
				{
					Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response.Error, "请求战斗道具失败，请重试！"));
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("请求战斗道具发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			if (response != null)
			{
				response.Dispose();
				response = null;
			}
		}
		DRBattlePropInfo[] dataRows = GameEntry.DataTable.GetDataRows((DRBattlePropInfo p) => p.Lev == 1);
		for (int num = 0; num < dataRows.Length; num++)
		{
			if (!bpWarehouse.ContainsKey(dataRows[num].TeamId))
			{
				BPData value = BPData.Create(dataRows[num], isLock: true, 0);
				bpWarehouse.Add(dataRows[num].TeamId, value);
			}
		}
		return true;
	}

	public async UniTask<bool> MakeBattleProp(int propId, int count)
	{
		BattlePropMakeRequest rst = BattlePropMakeRequest.Create();
		rst.PropId = propId;
		rst.Count = count;
		BattlePropMakeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<BattlePropMakeResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求合成战斗道具") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求合成战斗道具失败"))
			{
				PropHelper.AnalyzeRewardFromServer(response.CostItems);
				SendBPDatas();
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("请求合成战斗道具发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public Dictionary<int, BPCarryItemViewModel> GetCarringBPs()
	{
		Dictionary<int, BPCarryItemViewModel> dictionary = new Dictionary<int, BPCarryItemViewModel>();
		if (bpCarrying == null)
		{
			bpCarrying = new Dictionary<int, BPData>();
			string text = Singleton<OuterSystem>.Instance.LoadPlayerPrefs("BattlePropCarrying");
			try
			{
				if (!string.IsNullOrEmpty(text))
				{
					string[] array = text.Split(';');
					for (int i = 0; i < array.Length; i++)
					{
						string[] array2 = array[i].Split(':');
						int key = int.Parse(array2[0]);
						int key2 = int.Parse(array2[1]);
						bpCarrying.Add(key, bpWarehouse.ContainsKey(key2) ? bpWarehouse[key2] : null);
					}
				}
			}
			catch (Exception)
			{
				Log.Error("保存的数据处理发生异常！");
			}
		}
		dictionary.Add(1, new BPCarryItemViewModel(null, bpCarrying.ContainsKey(1) ? bpCarrying[1] : null, 1));
		dictionary.Add(2, new BPCarryItemViewModel(null, bpCarrying.ContainsKey(2) ? bpCarrying[2] : null, 2));
		return dictionary;
	}

	public List<int> GetCarringBPIds()
	{
		if (bpCarrying == null)
		{
			GetCarringBPs();
		}
		List<int> list = new List<int>();
		foreach (KeyValuePair<int, BPData> item in bpCarrying)
		{
			if (item.Value != null && item.Value.Id > 0)
			{
				list.Add(item.Value.TeamId);
			}
		}
		return list;
	}

	public Dictionary<int, BPCarryItemViewModel> GetCarringBPs(List<int> bpIds)
	{
		return new Dictionary<int, BPCarryItemViewModel>
		{
			{
				1,
				new BPCarryItemViewModel(null, (bpIds != null && bpIds.Count > 0 && bpWarehouse.ContainsKey(bpIds[0])) ? bpWarehouse[bpIds[0]] : null, 1)
			},
			{
				2,
				new BPCarryItemViewModel(null, (bpIds != null && bpIds.Count > 1 && bpWarehouse.ContainsKey(bpIds[1])) ? bpWarehouse[bpIds[1]] : null, 2)
			}
		};
	}

	public void SaveCarringBPs(BPData d1, BPData d2)
	{
		string v = $"1:{d1?.TeamId ?? 0};2:{d2?.TeamId ?? 0}";
		Singleton<OuterSystem>.Instance.SavePlayerPrefs("BattlePropCarrying", v);
		if (bpCarrying == null)
		{
			bpCarrying = new Dictionary<int, BPData>();
		}
		if (bpCarrying.ContainsKey(1))
		{
			bpCarrying[1] = d1;
		}
		else
		{
			bpCarrying.Add(1, d1);
		}
		if (bpCarrying.ContainsKey(2))
		{
			bpCarrying[2] = d2;
		}
		else
		{
			bpCarrying.Add(2, d2);
		}
	}

	public List<BPData> GetAllBPDatas()
	{
		return bpWarehouse.Values.ToList();
	}

	public Dictionary<int, BPData> GetBpCarrying()
	{
		return bpCarrying;
	}

	public Dictionary<int, BPData> GetBPCarryings(List<PbRoomBattlePropInfo> battlePropInfos)
	{
		Dictionary<int, BPData> dictionary = new Dictionary<int, BPData>();
		BPData value = null;
		BPData value2 = null;
		if (battlePropInfos.Count >= 1 && battlePropInfos[0].Id != 0)
		{
			value = BPData.Create(GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.TeamId == battlePropInfos[0].Id && p.Lev == battlePropInfos[0].Level), isLock: false, battlePropInfos[0].Count);
		}
		if (battlePropInfos.Count >= 2 && battlePropInfos[1].Id != 0)
		{
			value2 = BPData.Create(GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.TeamId == battlePropInfos[1].Id && p.Lev == battlePropInfos[1].Level), isLock: false, battlePropInfos[1].Count);
		}
		dictionary.Add(1, value);
		dictionary.Add(2, value2);
		return dictionary;
	}

	public Dictionary<int, BPData> GetBPWarehouse()
	{
		return bpWarehouse;
	}

	public BPData GetBpDataById(int bpId)
	{
		if (bpWarehouse != null && bpWarehouse.ContainsKey(bpId))
		{
			return bpWarehouse[bpId];
		}
		return null;
	}

	public HomeShopViewModel GetHomeShopViewModel()
	{
		return _homeShopViewModel;
	}

	public int GetTodayBoughtCountInShop()
	{
		return _homeShopViewModel.TodayBoughtCountInShop;
	}

	public int GetTodayBuyLimitInShop()
	{
		return _homeShopViewModel.TodayBuyLimitInShop;
	}

	public HomeShopInfoData GetSelfHomeShopData()
	{
		return _homeShopViewModel.GetShopData();
	}

	public HomeShopInfoData GetFriendHomeShopData(long friendId)
	{
		return _homeShopViewModel.GetFriendSingleShopData(friendId);
	}

	public List<HomeShopInfoData> GetAllFriendHomeShopDatas()
	{
		return _homeShopViewModel.GetAllFriendShopDatas().Values.ToList();
	}

	public async UniTask<bool> RequestShopData()
	{
		GetHomeLandShopListRequest rst = GetHomeLandShopListRequest.Create();
		GetHomeLandShopListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetHomeLandShopListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取家园商店信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取家园商店信息失败"))
			{
				_homeShopViewModel.TodayBoughtCountInShop = response.TodayBoughtCount;
				_homeShopViewModel.TodayBuyLimitInShop = response.TodayBuyLimit;
				long num = Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData().PlayerInfo.Uid ?? 0;
				_homeShopViewModel.InitShopData(HomeShopInfoData.Create((int)num, response.ShopItems, selfShop: true, 0L));
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取家园商店信息！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<List<PropDataBase>> RequestShopBuy(int gridId, int buyCount)
	{
		HomeLandShopBuyRequest rst = HomeLandShopBuyRequest.Create();
		rst.GridId = gridId;
		rst.BuyCount = buyCount;
		HomeLandShopBuyResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<HomeLandShopBuyResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"家园商店购买：gridId:{gridId} buyCount:{buyCount}") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "家园商店购买失败"))
			{
				_homeShopViewModel.ApplyBuyResult(gridId, buyCount);
				List<PropDataBase> list = new List<PropDataBase>();
				for (int i = 0; i < response.Goods.Count; i++)
				{
					PropDataBase propDataBase = AttachReward(response.Goods[i].ItemType, response.Goods[i].ItemId, (int)response.Goods[i].ItemDelta);
					if (propDataBase != null && !propDataBase.Empty && propDataBase.Amount > 0)
					{
						list.Add(propDataBase);
					}
				}
				return list;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("家园商店购买！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<HomeShopInfoData>> RequestAllFriendShopList()
	{
		GetAllFriendShopListRequest rst = GetAllFriendShopListRequest.Create();
		GetAllFriendShopListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetAllFriendShopListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取 好友家园商店信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取 好友家园商店信息失败"))
			{
				Dictionary<long, List<PbHomeLandShopItem>> dictionary = new Dictionary<long, List<PbHomeLandShopItem>>();
				Dictionary<long, long> friendAddTimes = new Dictionary<long, long>();
				foreach (PbFriendShopInfo friendShop in response.FriendShops)
				{
					if (!dictionary.ContainsKey(friendShop.FriendId))
					{
						dictionary.Add(friendShop.FriendId, new List<PbHomeLandShopItem>());
					}
					if (!friendAddTimes.ContainsKey(friendShop.FriendId))
					{
						friendAddTimes.Add(friendShop.FriendId, friendShop.FriendAddTime);
					}
					foreach (PbFriendShopSingleItem shopItem in friendShop.ShopItems)
					{
						dictionary[friendShop.FriendId].Add(new PbHomeLandShopItem
						{
							GridId = shopItem.GridId,
							ConfigId = shopItem.ConfigId,
							BoughtCount = 0
						});
					}
				}
				foreach (PbFriendShopBoughtState friendShopBoughtState in response.FriendShopBoughtStates)
				{
					if (!dictionary.TryGetValue(friendShopBoughtState.FriendId, out var value))
					{
						continue;
					}
					foreach (PbFriendShopItemBoughtState boughtState in friendShopBoughtState.BoughtState)
					{
						PbHomeLandShopItem pbHomeLandShopItem = value.Find((PbHomeLandShopItem p) => p.GridId.Equals(boughtState.GridId));
						if (pbHomeLandShopItem != null)
						{
							pbHomeLandShopItem.BoughtCount = boughtState.BoughtCount;
						}
					}
				}
				long selfShopId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData().PlayerInfo.Uid ?? 0;
				Dictionary<long, HomeShopInfoData> allFriendShops = new Dictionary<long, HomeShopInfoData>();
				dictionary.ForEach(delegate(KeyValuePair<long, List<PbHomeLandShopItem>> p)
				{
					allFriendShops.Add(p.Key, HomeShopInfoData.Create((int)p.Key, p.Value, p.Key.Equals(selfShopId), friendAddTimes.ContainsKey(p.Key) ? friendAddTimes[p.Key] : 0));
				});
				_homeShopViewModel.InitFriendShopData(allFriendShops);
				return _homeShopViewModel.GetAllFriendShopDatas().Values.ToList();
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取好友家园商店信息失败！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<HomeShopInfoData> RequestEnterFriendShop(long friendId)
	{
		EnterFriendShopRequest rst = EnterFriendShopRequest.Create();
		rst.FriendId = friendId;
		EnterFriendShopResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<EnterFriendShopResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求指定好友家园商店数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求指定好友家园商店数据 失败"))
			{
				List<PbHomeLandShopItem> list = new List<PbHomeLandShopItem>();
				if (response.FriendShops == null)
				{
					return null;
				}
				foreach (PbFriendShopSingleItem shopItem in response.FriendShops.ShopItems)
				{
					list.Add(new PbHomeLandShopItem
					{
						GridId = shopItem.GridId,
						ConfigId = shopItem.ConfigId,
						BoughtCount = 0
					});
				}
				foreach (PbFriendShopItemBoughtState boughtState in response.FriendShopBoughtStates.BoughtState)
				{
					PbHomeLandShopItem pbHomeLandShopItem = list.Find((PbHomeLandShopItem p) => p.GridId.Equals(boughtState.GridId));
					if (pbHomeLandShopItem != null)
					{
						pbHomeLandShopItem.BoughtCount = boughtState.BoughtCount;
					}
				}
				long obj = Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData().PlayerInfo.Uid ?? 0;
				HomeShopInfoData homeShopInfoData = HomeShopInfoData.Create((int)friendId, list, friendId.Equals(obj), response.FriendShops.FriendAddTime);
				_homeShopViewModel.RefreshSingleFriendShopData(friendId, homeShopInfoData);
				return homeShopInfoData;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("请求指定好友家园商店数据！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<PropDataBase>> RequestFriendShopBuy(long friendId, int gridId, int buyCount)
	{
		BuyFriendShopItemRequest rst = BuyFriendShopItemRequest.Create();
		rst.FriendId = friendId;
		rst.GridId = gridId;
		rst.BuyCount = buyCount;
		BuyFriendShopItemResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<BuyFriendShopItemResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"好友家园商店购买：friendId:{friendId} gridId:{gridId} buyCount:{buyCount}") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "好友家园商店购买 失败"))
			{
				_homeShopViewModel.ApplyFriendBuyResult(friendId, gridId, buyCount);
				List<PropDataBase> list = new List<PropDataBase>();
				for (int i = 0; i < response.Goods.Count; i++)
				{
					PropDataBase propDataBase = AttachReward(response.Goods[i].ItemType, response.Goods[i].ItemId, (int)response.Goods[i].ItemDelta);
					if (propDataBase != null && !propDataBase.Empty && propDataBase.Amount > 0)
					{
						list.Add(propDataBase);
					}
				}
				return list;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("好友家园商店购买！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	private PropDataBase AttachReward(int propType, int propId, int propCount)
	{
		if (propType == 1 || propType == 3)
		{
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(propId);
			if (dataRow == null)
			{
				Log.Error($"Prop表 未找到Id为【{propId}】的道具！");
				return null;
			}
			KnapsackPropData knapsackPropData = new KnapsackPropData(dataRow, propCount);
			if (propType == 1)
			{
				Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().AddProp(knapsackPropData);
			}
			else if (Enum.IsDefined(typeof(RoleMoneyEnum), knapsackPropData.Id))
			{
				MoneyDefinition.AddMoney((RoleMoneyEnum)knapsackPropData.Id, knapsackPropData.Amount);
			}
			return knapsackPropData;
		}
		Log.Error($"找不到物品类型{propType}");
		return null;
	}

	public async UniTask<SailInfo> GetSailLightEventList()
	{
		GetSailLightEventsRequest request = GetSailLightEventsRequest.Create();
		GetSailLightEventsResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetSailLightEventsResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取航海信息失败"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取航海信息失败"))
				{
					sailInfo = default(SailInfo);
					sailInfo.IsInit = false;
					sailInfo.EventList = response.EventIds;
					sailInfo.SailingHeroList = response.SailingHeroIds;
					sailInfo.OldDispatchInfoList = new List<SailEventInfo>();
					foreach (PbSailLightDispatchInfo oldDispatchInfo in response.OldDispatchInfos)
					{
						SailEventInfo sailEventInfo = new SailEventInfo();
						sailEventInfo.EventId = oldDispatchInfo.EventId;
						sailEventInfo.Uid = oldDispatchInfo.Idx;
						sailEventInfo.StartTime = oldDispatchInfo.StartTime;
						sailEventInfo.heroIds = oldDispatchInfo.HeroIds;
						sailEventInfo.IsRewarded = oldDispatchInfo.Rewarded;
						sailInfo.OldDispatchInfoList.Add(sailEventInfo);
					}
					sailInfo.TodayDispatchInfoList = new List<SailEventInfo>();
					foreach (PbSailLightDispatchInfo todayDispatchInfo in response.TodayDispatchInfos)
					{
						SailEventInfo sailEventInfo2 = new SailEventInfo();
						sailEventInfo2.EventId = todayDispatchInfo.EventId;
						sailEventInfo2.Uid = todayDispatchInfo.Idx;
						sailEventInfo2.StartTime = todayDispatchInfo.StartTime;
						sailEventInfo2.heroIds = todayDispatchInfo.HeroIds;
						sailEventInfo2.IsRewarded = todayDispatchInfo.Rewarded;
						sailInfo.TodayDispatchInfoList.Add(sailEventInfo2);
					}
					sailInfo.IsInit = true;
					SetSailRedPoint();
					return sailInfo;
				}
				Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response.Error, "获取航海信息失败，请重试！"));
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取航海信息失败！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return sailInfo;
	}

	public async UniTask<long> SendSailLightDispatch(List<int> heroIds, int eventId)
	{
		SailLightDispatchRequest request = SailLightDispatchRequest.Create();
		request.HeroIds = heroIds;
		request.EventIdx = eventId;
		SailLightDispatchResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SailLightDispatchResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "航海启动失败"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "航海启动失败"))
				{
					if (sailInfo.onlineList == null)
					{
						sailInfo.onlineList = new List<SailEventInfo>();
					}
					SailEventInfo sailEventInfo = new SailEventInfo();
					sailEventInfo.EventId = eventId;
					sailEventInfo.Uid = response.Idx;
					sailEventInfo.StartTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
					sailEventInfo.heroIds = heroIds;
					sailEventInfo.IsRewarded = false;
					sailInfo.onlineList.Add(sailEventInfo);
					SetSailRedPoint();
					return response.Idx;
				}
				Toast.ShowInfo(Singleton<NetResponseHandler>.Instance.GetErrorCodeInfo(response.Error, "航海启动失败，请重试！"));
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("航海启动失败！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return 0L;
	}

	public async UniTask<SailReward> GetSailLightReward(long eventId)
	{
		GetSailLightRewardRewardRequest request = GetSailLightRewardRewardRequest.Create();
		request.Idx = eventId;
		SailReward sailReward = default(SailReward);
		GetSailLightRewardRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetSailLightRewardRewardResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "家园", "获取航海事件奖励"))
			{
				sailReward.IsInit = true;
				sailReward.GreatSuccess = response.GreatSuccess;
				sailReward.PropGetViewModel = await GetReward(response.Rewards);
				SetSailRewarded(eventId);
				SetSailRedPoint();
			}
			else if (response.Error == 200159)
			{
				Toast.ShowInfo("道具数量超出限制，已发送至邮箱");
				SetSailRewarded(eventId);
				sailReward.IsInit = true;
				sailReward.PropGetViewModel = null;
				SetSailRedPoint();
				return sailReward;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取航海事件奖励！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return sailReward;
	}

	private void SetSailRewarded(long eventId)
	{
		List<SailEventInfo> list = new List<SailEventInfo>();
		list.AddRange(sailInfo.TodayDispatchInfoList);
		list.AddRange(sailInfo.OldDispatchInfoList);
		if (sailInfo.onlineList != null)
		{
			list.AddRange(sailInfo.onlineList);
		}
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i].Uid == eventId)
			{
				list[i].IsRewarded = true;
			}
		}
	}

	private async UniTask<PropGetViewModel> GetReward(PbDropThing dropThing)
	{
		if (dropThing == null)
		{
			return null;
		}
		return new PropGetViewModel(null, (await PropHelper.AnalyzeRewardFromServer(dropThing)).PropList);
	}

	private void SendBPDatas()
	{
	}

	private void SetFarmRedPoint()
	{
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		long num = 0L;
		bool flag = false;
		foreach (FarmData farmData in farmInfo.FarmDataList)
		{
			if (farmData.HarvestTime <= curServerTime)
			{
				flag = true;
				homeLandVm.UpdateBuildingHarvestPoint(1, redPoint: true);
				break;
			}
			if (num == 0L)
			{
				num = farmData.HarvestTime;
			}
			else if (num > farmData.HarvestTime)
			{
				num = farmData.HarvestTime;
			}
		}
		if (farmRedPointTimer != null)
		{
			Timer.Cancel(farmRedPointTimer);
			farmRedPointTimer = null;
		}
		long num2 = num - curServerTime;
		if (!flag)
		{
			homeLandVm.UpdateBuildingHarvestPoint(1, redPoint: false);
		}
		if (num2 > 0)
		{
			farmRedPointTimer = Timer.Register(num2, delegate
			{
				homeLandVm.UpdateBuildingHarvestPoint(1, redPoint: true);
				Timer.Cancel(farmRedPointTimer);
				farmRedPointTimer = null;
			});
		}
	}

	private void SetSailRedPoint()
	{
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		long num = 0L;
		List<SailEventInfo> list = new List<SailEventInfo>();
		list.AddRange(sailInfo.TodayDispatchInfoList);
		list.AddRange(sailInfo.OldDispatchInfoList);
		if (sailInfo.onlineList != null)
		{
			list.AddRange(sailInfo.onlineList);
		}
		bool flag = false;
		foreach (SailEventInfo item in list)
		{
			if (item.IsRewarded)
			{
				continue;
			}
			DRSailEvent dataRow = GameEntry.DataTable.GetDataRow<DRSailEvent>(item.EventId);
			if (dataRow != null)
			{
				long num2 = dataRow.Time - (curServerTime - item.StartTime);
				if (num2 <= 0)
				{
					flag = true;
					homeLandVm.UpdateBuildingHarvestPoint(2, redPoint: true);
				}
				else if (num == 0L)
				{
					num = num2;
				}
				else if (num > num2)
				{
					num = num2;
				}
			}
		}
		if (sailRedPointTimer != null)
		{
			Timer.Cancel(sailRedPointTimer);
			sailRedPointTimer = null;
		}
		if (!flag)
		{
			homeLandVm.UpdateBuildingHarvestPoint(2, redPoint: false);
		}
		if (num > 0)
		{
			sailRedPointTimer = Timer.Register(num, delegate
			{
				homeLandVm.UpdateBuildingHarvestPoint(2, redPoint: true);
				Timer.Cancel(sailRedPointTimer);
				sailRedPointTimer = null;
			});
		}
	}

	public void Dispose()
	{
		SendBPDatas();
	}
}
