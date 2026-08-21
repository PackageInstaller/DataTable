#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public class CopyService : ICopyService
{
	private ISubscription<RoleExpOrLevelUpNotifyMessager> subscription_UpdateLevel;

	private ISubscription<CopyEnterLimitChangeNotify> subscription_EnterLimit;

	private ISubscription<SOOpenNotifyMessager> subscription_SONotify;

	private Dictionary<int, int> copyDropRateDatas = new Dictionary<int, int>();

	private string SaveKey = "RedPoint_";

	private string systemName = "Copy";

	private string systemType1SortName = "CopyType1Sort";

	private string systemType4RecordName = "CopyType4RecordFlag_";

	private string EffectSaveKey = "EffectPlay_";

	private string SaveKeyType5CopySelect = "T5CopySelect_";

	private string SaveKeyType5Config = "T5Team_";

	private CopyViewModel copyVM;

	private string towerConfigBattle = "TowerBattle";

	private string towerConfigAreaRed = "TowerAreaRed";

	private int towerActivityVersion;

	private Dictionary<int, int> towerAreaRedPoint = new Dictionary<int, int>(6);

	public int GetCacheDropRate(int copyId)
	{
		if (copyDropRateDatas.ContainsKey(copyId))
		{
			return copyDropRateDatas[copyId];
		}
		return -1;
	}

	public void SetCacheDropRate(int copyId, int dropRate)
	{
		if (copyDropRateDatas.ContainsKey(copyId))
		{
			copyDropRateDatas[copyId] = dropRate;
		}
		else
		{
			copyDropRateDatas.Add(copyId, dropRate);
		}
	}

	private static List<CopyType3CurrentData> CreateType3CurrentDatas(List<PbSuitboxCopyInfo> infos)
	{
		List<CopyType3CurrentData> list = new List<CopyType3CurrentData>();
		if (infos == null)
		{
			return list;
		}
		for (int i = 0; i < infos.Count; i++)
		{
			if (TryGetType3Mode(infos[i].Type, out var mode))
			{
				list.Add(new CopyType3CurrentData(mode, infos[i].CopyType, infos[i].Score, infos[i].RewardCount, infos[i].CopyEndTime));
			}
		}
		return list;
	}

	private static bool TryGetType3Mode(int type, out CopyType3Mode mode)
	{
		switch (type)
		{
		case 0:
			mode = CopyType3Mode.Multi;
			return true;
		case 1:
			mode = CopyType3Mode.FirePower;
			return true;
		case 2:
			mode = CopyType3Mode.ExtremeChallenge;
			return true;
		default:
			mode = CopyType3Mode.Multi;
			return false;
		}
	}

	public void ResetCacheDropRate(int copyId)
	{
		SetCacheDropRate(copyId, -1);
	}

	public CopyService()
	{
		subscription_SONotify = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<SOOpenNotifyMessager>(OnSystemOpen);
		subscription_UpdateLevel = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<RoleExpOrLevelUpNotifyMessager>(GetLevelNotify);
		subscription_EnterLimit = Singleton<NetworkSystem>.Instance.Subscribe<CopyEnterLimitChangeNotify>(GetEnterLimitNotify);
		copyVM = new CopyViewModel();
	}

	private async void OnSystemOpen(SOOpenNotifyMessager messager)
	{
		if ((messager.serviceId == 70004 || messager.serviceId == 70010 || messager.serviceId == 70016) && messager.state)
		{
			await RequestData();
		}
		if (messager.serviceId == 70017 && messager.state)
		{
			await GetFloorCopyStarInfo();
		}
	}

	public void CopyComplete(int copyId, int star, int score, bool isSingle)
	{
		copyVM.RefreshCopyAccess(copyId, star, score, isSingle);
	}

	public void CopyType3RefreshCount()
	{
		copyVM.CopyType3RefreshCount();
	}

	public async UniTask<CopyEnterInfoData> EnterBattleWorld(CopyData copyData, List<int> roleIds, List<TeamMember> teamMembers, int battleMode, int dropType, List<int> battlePropIds)
	{
		if (roleIds == null)
		{
			roleIds = new List<int>();
			foreach (TeamMember teamMember in teamMembers)
			{
				roleIds.Add(teamMember.HeroModel.Id);
			}
		}
		C2S_EnterCopyRequest request = C2S_EnterCopyRequest.Create();
		request.CopyId = copyData.Id;
		request.RoleIds = roleIds;
		request.Type = battleMode;
		request.DropType = dropType;
		request.RewardTimes = copyData.DropRate;
		if (battlePropIds != null)
		{
			request.BattlePropIds = battlePropIds;
		}
		else
		{
			request.BattlePropIds = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetCarringBPIds();
		}
		Debug.Log($"C2S_EnterCopyRequest RewardTimes = {copyData.DropRate}");
		S2C_EnterCopyResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_EnterCopyResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "单人副本请求") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "副本进入失败"))
			{
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
					.SetMoney(MoneyEnum.Energy, response.AccountEnergy);
				CopyEnterInfoData copyEnterInfoData = new CopyEnterInfoData
				{
					CopyData = copyData,
					TeamMembers = teamMembers,
					MaterialId = dropType,
					CheckCode = response.CheckCode,
					RoomId = response.RoomId,
					SeedID = response.RandSeed,
					IsSingle = true,
					IsMatch = false,
					MatchTime = 0f,
					IsBattleSend = ((!copyData.IsBoss || battleMode == 2 || copyData.CopyType == 99000 || copyData.CopyType == 99100) ? 2 : 0),
					IsCampaignBattle = (copyData.CopyMainId == 91)
				};
				Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SavaCopyEnterInfo(copyEnterInfoData);
				SetCacheDropRate(copyData.Id, copyData.DropRate);
				return copyEnterInfoData;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("单人副本进入请求，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			Toast.ShowInfo("进入战斗失败!请重试!");
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<bool> RequestData()
	{
		List<CopyRedData> copyRedDatas = GetCopyRedDatas();
		copyVM.SaveAllRedData(copyRedDatas);
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70004))
		{
			return false;
		}
		GetCopyEnterLimitRequest request = GetCopyEnterLimitRequest.Create();
		GetCopyEnterLimitResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetCopyEnterLimitResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取副本进入限制") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取副本进入限制"))
			{
				Dictionary<int, int> dictionary = new Dictionary<int, int>();
				HashSet<int> hashSet = new HashSet<int>();
				for (int i = 0; i < response.CopyEnterLimit.CopyDifficultyInfos.Count; i++)
				{
					int copyId = response.CopyEnterLimit.CopyDifficultyInfos[i].CopyId;
					int passedDifficulty = response.CopyEnterLimit.CopyDifficultyInfos[i].PassedDifficulty;
					if (GameEntry.DataTable.GetDataRow<DRCopyType>(copyId) != null)
					{
						int key = copyId;
						if (!dictionary.ContainsKey(key))
						{
							dictionary.Add(key, passedDifficulty);
						}
						else
						{
							dictionary[key] = Mathf.Max(dictionary[key], passedDifficulty);
						}
						continue;
					}
					int num = copyId;
					hashSet.Add(num);
					if (GameEntry.DataTable.GetDataRow<DRCopy>(num) == null)
					{
						Log.Error($"CopyEnterLimit返回了不存在的CopyId:{num}");
					}
				}
				copyVM.UpdateAccessCopys(response.CopyEnterLimit.PermitLevel, dictionary, hashSet);
				if (Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70019))
				{
					copyVM.InitCopyMain1();
				}
				if (Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70010))
				{
					copyVM.InitCopyMain2();
				}
				if (Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70016))
				{
					List<CopyType3CurrentData> type3Params = CreateType3CurrentDatas(response.SuitboxCopyInfos);
					copyVM.SetType3Params(type3Params);
					copyVM.InitCopyMain3(copyVM.GetType3ModeScore(CopyType3Mode.Multi), copyVM.GetType3ModeRewardCount(CopyType3Mode.Multi));
				}
				List<PermitTaskData> list = new List<PermitTaskData>();
				for (int j = 0; j < response.CopyEnterLimit.PermitTasks.Count; j++)
				{
					list.Add(new PermitTaskData(response.CopyEnterLimit.PermitTasks[j].TaskId, response.CopyEnterLimit.PermitTasks[j].TaskValue));
				}
				copyVM.InitPermitData(list);
			}
			copyVM.LoadActivityCopys();
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取副本进入限制！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		await GetFloorCopyStarInfo();
		return true;
	}

	public async UniTask RefreshType3Param()
	{
		GetCopyEnterLimitRequest request = GetCopyEnterLimitRequest.Create();
		GetCopyEnterLimitResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetCopyEnterLimitResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取副本类型3进入限制") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取副本类型3进入限制"))
			{
				List<CopyType3CurrentData> type3Params = CreateType3CurrentDatas(response.SuitboxCopyInfos);
				copyVM.SetType3Params(type3Params);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取副本类型3进入限制！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
	}

	public void UpdateRealisticTime()
	{
		if (!copyVM.RegisterTimer(0L))
		{
			try
			{
				long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
				copyVM.RegisterTimer(curServerTime);
			}
			catch (TimeoutException)
			{
				Toast.ShowInfo("网络信号弱，请稍后再试");
			}
			catch (Exception ex2)
			{
				Log.Error("获取服务器时间异常！" + ex2.Message + " / " + ex2.StackTrace);
			}
		}
	}

	public void RemoveCopyTimer()
	{
		if (copyVM != null)
		{
			copyVM.RemoveTimer();
		}
	}

	public List<CopyRedData> GetCopyRedDatas()
	{
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			List<CopyRedData> list = JsonConvert.DeserializeObject<List<CopyRedData>>(PlayerPrefs.GetString(SaveKey + $"{uid}_{systemName}", ""));
			if (list == null)
			{
				return new List<CopyRedData>();
			}
			return list;
		}
		catch (Exception)
		{
			Log.Error("获取红点保存数据失败！" + systemName);
		}
		return new List<CopyRedData>();
	}

	public void SaveCopyRedDatas(List<CopyRedData> obj)
	{
		string text = null;
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			text = ((obj == null) ? "" : JsonConvert.SerializeObject(obj));
			PlayerPrefs.SetString(SaveKey + $"{uid}_{systemName}", text);
		}
		catch (Exception)
		{
			Log.Error("保存红点数据失败！" + systemName);
		}
	}

	public Dictionary<int, int> GetCopyType1SortDatas()
	{
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			string text = PlayerPrefs.GetString(SaveKey + $"{uid}_{systemType1SortName}", "");
			if (!string.IsNullOrEmpty(text))
			{
				string[] array = text.Split('|');
				for (int i = 0; i < array.Length; i++)
				{
					string[] array2 = array[i].Split(':');
					if (array2.Length > 1)
					{
						int key = int.Parse(array2[0]);
						int value = int.Parse(array2[1]);
						if (!dictionary.ContainsKey(key))
						{
							dictionary.Add(key, value);
						}
					}
				}
			}
			return dictionary;
		}
		catch (Exception)
		{
			Log.Error("保存副本选中材料数据失败！" + systemType1SortName);
			return dictionary;
		}
	}

	public void SaveCopyType1SortDatas(Dictionary<int, int> sortDatas)
	{
		string text = "";
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			int num = 0;
			foreach (KeyValuePair<int, int> sortData in sortDatas)
			{
				if (num > 0)
				{
					text += "|";
				}
				text += $"{sortData.Key}:{sortData.Value}";
				num++;
			}
			PlayerPrefs.SetString(SaveKey + $"{uid}_{systemType1SortName}", text);
		}
		catch (Exception)
		{
			Log.Error("保存副本选中材料数据失败！" + systemType1SortName);
		}
	}

	public int GetType4RecordFlag()
	{
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			return PlayerPrefs.GetInt(systemType4RecordName + $"{uid}", 0);
		}
		catch (Exception)
		{
			Log.Error("获取极黯裂隙记录数据失败！");
		}
		return 0;
	}

	public void SaveType4RecordFlag(int copyTypeId)
	{
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			PlayerPrefs.SetInt(systemType4RecordName + $"{uid}", copyTypeId);
		}
		catch (Exception)
		{
			Log.Error("保存极黯裂隙记录数据失败！");
		}
	}

	public CopyUnlockSaveData GetCopyUnlockSaveData()
	{
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			CopyUnlockSaveData copyUnlockSaveData = JsonConvert.DeserializeObject<CopyUnlockSaveData>(PlayerPrefs.GetString(EffectSaveKey + $"{uid}_{systemName}", ""));
			if (copyUnlockSaveData == null)
			{
				return new CopyUnlockSaveData();
			}
			return copyUnlockSaveData;
		}
		catch (Exception)
		{
			Log.Error("获取解锁动效保存数据失败！" + systemName);
		}
		return new CopyUnlockSaveData();
	}

	public void SaveCopyUnlockSaveData(CopyUnlockSaveData obj)
	{
		string text = null;
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			text = ((obj == null) ? "" : JsonConvert.SerializeObject(obj));
			PlayerPrefs.SetString(EffectSaveKey + $"{uid}_{systemName}", text);
		}
		catch (Exception)
		{
			Log.Error("保存解锁动效数据失败！" + systemName);
		}
	}

	private void GetLevelNotify(RoleExpOrLevelUpNotifyMessager messager)
	{
		copyVM.UpdatePlayerLevel(messager.Level);
		copyVM.UpdateAllCopyRed();
	}

	private void GetEnterLimitNotify(CopyEnterLimitChangeNotify messager)
	{
		List<PermitTaskData> list = new List<PermitTaskData>();
		if (messager.NewCopyEnterLimit?.PermitTasks != null)
		{
			for (int i = 0; i < messager.NewCopyEnterLimit.PermitTasks.Count; i++)
			{
				list.Add(new PermitTaskData(messager.NewCopyEnterLimit.PermitTasks[i].TaskId, messager.NewCopyEnterLimit.PermitTasks[i].TaskValue));
			}
			copyVM.RefreshPermitData(messager.NewCopyEnterLimit.PermitLevel, list);
		}
		copyVM.UpdatePerimitLevel(messager.NewCopyEnterLimit.PermitLevel);
		copyVM.UpdateAllCopyRed();
	}

	public void UpdateMaxCopyIdx(long maxCopyOpenIndex)
	{
		copyVM.UpdateMaxCopyIdx(maxCopyOpenIndex);
		copyVM.UpdateAllCopyRed();
	}

	public bool CheckCopyOpen(int copyId)
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70004))
		{
			Toast.ShowInfo("副本系统未开放！");
			return false;
		}
		return !copyVM.GetCopyById(copyId).IsLock;
	}

	public bool CheckCopyTypeOpen(int copyType)
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70004))
		{
			Toast.ShowInfo("副本系统未开放！");
			return false;
		}
		CopyTypeData copyTypeById = copyVM.GetCopyTypeById(copyType);
		if (copyTypeById == null)
		{
			return false;
		}
		return !copyTypeById.IsLock;
	}

	public void SaveCarringBPs(int copyId, int bpId1, int bpId2)
	{
		copyVM.SaveCarringBPs(copyId, bpId1, bpId2);
	}

	public async UniTask GetFloorCopyStarInfo()
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70017))
		{
			return;
		}
		try
		{
			(int, List<PbFloorCopyStarInfo>)? tuple = await GetFloorCopyStarInfoAsync();
			if (!tuple.HasValue)
			{
				Log.Error("获取深渊本星星数据失败");
				return;
			}
			int item = tuple.Value.Item1;
			List<PbFloorCopyStarInfo> item2 = tuple.Value.Item2;
			copyVM.SetCopyType4ZoneOpen(item);
			await SettleFloorStarCopyDatas(item2);
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取深渊本星星数据！" + ex2.Message + " / " + ex2.StackTrace);
		}
	}

	private async UniTask SettleFloorCopyDatas(List<PbFloorCopySettleInfo> copySettleInfos)
	{
		try
		{
			List<CopyType4TeamConfig> list = new List<CopyType4TeamConfig>();
			List<CopyBPCarrying> list2 = JsonConvert.DeserializeObject<List<CopyBPCarrying>>(Singleton<OuterSystem>.Instance.LoadPlayerPrefs("BPFloorCopyCarrying")) ?? new List<CopyBPCarrying>();
			for (int i = 0; i < copySettleInfos.Count; i++)
			{
				PbFloorCopySettleInfo pbFloorCopySettleInfo = copySettleInfos[i];
				CopyData copyById = copyVM.GetCopyById(pbFloorCopySettleInfo.CopyId);
				if (copyById == null)
				{
					Log.Error($"副本数据未创建，请检查！【{pbFloorCopySettleInfo.CopyId}】");
					continue;
				}
				copyById.SetCopyStar(pbFloorCopySettleInfo.CurrentSettingStar, pbFloorCopySettleInfo.MaxStar);
				if (pbFloorCopySettleInfo.RoleSettingInfos == null)
				{
					continue;
				}
				List<int> list3 = new List<int>();
				for (int j = 0; j < list2.Count; j++)
				{
					if (list2[j].copyId == pbFloorCopySettleInfo.CopyId)
					{
						list3.Add(list2[j].bpId1);
						list3.Add(list2[j].bpId2);
					}
				}
				CopyType4TeamConfig item = new CopyType4TeamConfig(pbFloorCopySettleInfo.CopyId, pbFloorCopySettleInfo.RoleSettingInfos, list3);
				list.Add(item);
			}
			copyVM.AddCopyConfig(list);
			copyVM.InitCopyMain4();
		}
		catch (Exception ex)
		{
			Log.Error("处理深渊本星星数据！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private async UniTask SettleFloorStarCopyDatas(List<PbFloorCopyStarInfo> copyStarInfos)
	{
		try
		{
			for (int i = 0; i < copyStarInfos.Count; i++)
			{
				PbFloorCopyStarInfo pbFloorCopyStarInfo = copyStarInfos[i];
				CopyData copyById = copyVM.GetCopyById(pbFloorCopyStarInfo.CopyId);
				if (copyById == null)
				{
					Log.Error($"设置深渊副本星星数据，副本数据未创建，请检查！【{pbFloorCopyStarInfo.CopyId}】");
				}
				else
				{
					copyById.SetCopyStar(pbFloorCopyStarInfo.CurrentSettingStar, pbFloorCopyStarInfo.MaxStar);
				}
			}
			copyVM.InitCopyMain4();
		}
		catch (Exception ex)
		{
			Log.Error("处理深渊本星星数据！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	private async UniTask<(int, List<PbFloorCopyStarInfo>)?> GetFloorCopyStarInfoAsync()
	{
		List<PbFloorCopyStarInfo> copyStarInfos = new List<PbFloorCopyStarInfo>();
		int item = 0;
		List<int> zoneList = new List<int>();
		DRCopyType[] dataRows = GameEntry.DataTable.GetDataRows((DRCopyType p) => p.MainCopyId == 4);
		for (int num = 0; num < dataRows.Length; num++)
		{
			if (!zoneList.Contains(dataRows[num].Zone))
			{
				zoneList.Add(dataRows[num].Zone);
			}
		}
		for (int i = 0; i < zoneList.Count; i++)
		{
			GetFloorCopyStarInfoRequest request = GetFloorCopyStarInfoRequest.Create();
			request.Zone = zoneList[i];
			GetFloorCopyStarInfoResponse getFloorCopyStarInfoResponse = await Singleton<NetworkSystem>.Instance.Call<GetFloorCopyStarInfoResponse>(request);
			if (!getFloorCopyStarInfoResponse.Validate())
			{
				getFloorCopyStarInfoResponse.Dispose();
				request.Dispose();
				return null;
			}
			item = getFloorCopyStarInfoResponse.Zone;
			copyStarInfos.AddRange(getFloorCopyStarInfoResponse.CopyStarInfos);
			request.Dispose();
			getFloorCopyStarInfoResponse.Dispose();
		}
		return (item, copyStarInfos);
	}

	public async UniTask<bool> GetType4CopySettingInfos(List<CopyData> copyDatas)
	{
		if (copyDatas == null)
		{
			return true;
		}
		List<int> list = new List<int>();
		for (int i = 0; i < copyDatas.Count; i++)
		{
			if (!copyVM.HasTeamConfig(copyDatas[i].Id))
			{
				list.Add(copyDatas[i].Id);
			}
		}
		if (list.Count == 0)
		{
			return true;
		}
		return await GetType4CopySettingInfos(list);
	}

	public async UniTask<bool> GetType4CopySettingInfos(CopyData copyData)
	{
		if (copyData == null)
		{
			return true;
		}
		List<int> list = new List<int>();
		list.Add(copyData.Id);
		return await GetType4CopySettingInfos(list);
	}

	public async UniTask<bool> GetType4CopySettingInfos(List<int> copyIds)
	{
		GetFloorCopySettingInfoRequest request = GetFloorCopySettingInfoRequest.Create();
		request.CopyIds = copyIds;
		GetFloorCopySettingInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetFloorCopySettingInfoResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取深渊副本组队配置") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取深渊副本组队配置失败"))
			{
				if (response.CopySettleInfos == null)
				{
					return true;
				}
				List<CopyType4TeamConfig> list = new List<CopyType4TeamConfig>();
				List<CopyBPCarrying> list2 = JsonConvert.DeserializeObject<List<CopyBPCarrying>>(Singleton<OuterSystem>.Instance.LoadPlayerPrefs("BPFloorCopyCarrying")) ?? new List<CopyBPCarrying>();
				for (int i = 0; i < response.CopySettleInfos.Count; i++)
				{
					PbFloorCopySettleInfo pbFloorCopySettleInfo = response.CopySettleInfos[i];
					CopyData copyById = copyVM.GetCopyById(pbFloorCopySettleInfo.CopyId);
					if (copyById == null)
					{
						Log.Error($"副本数据未创建，请检查！【{pbFloorCopySettleInfo.CopyId}】");
						continue;
					}
					copyById.SetCopyStar(pbFloorCopySettleInfo.CurrentSettingStar, pbFloorCopySettleInfo.MaxStar);
					if (pbFloorCopySettleInfo.RoleSettingInfos == null)
					{
						continue;
					}
					List<int> list3 = new List<int>();
					for (int j = 0; j < list2.Count; j++)
					{
						if (list2[j].copyId == pbFloorCopySettleInfo.CopyId)
						{
							list3.Add(list2[j].bpId1);
							list3.Add(list2[j].bpId2);
						}
					}
					CopyType4TeamConfig item = new CopyType4TeamConfig(pbFloorCopySettleInfo.CopyId, pbFloorCopySettleInfo.RoleSettingInfos, list3);
					list.Add(item);
				}
				copyVM.AddCopyConfig(list);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取深渊副本组队配置，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			Toast.ShowInfo("获取深渊副本组队配置!请重试!");
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask GetFloorCopyRewardInfo(int zone, int zoneId, int index)
	{
		GetFloorCopyRewardInfoRequest request = GetFloorCopyRewardInfoRequest.Create();
		GetFloorCopyRewardInfoResponse response = null;
		try
		{
			request.Zone = zoneId;
			response = await Singleton<NetworkSystem>.Instance.Call<GetFloorCopyRewardInfoResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取深渊区域奖励信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取深渊区域奖励信息"))
			{
				copyVM.SetReward4State(zone, index, response.RewardState);
				copyVM.SetStarInfo4State(zone, response.Star);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error($"获取深渊区域奖励信息，区域【{zone}】！{ex2.Message} / {ex2.StackTrace}");
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
	}

	public async UniTask GetFloorCopyRewardInfo(int zone)
	{
		DRDepthsStar[] dataRows = GameEntry.DataTable.GetDataRows((DRDepthsStar p) => p.Zone == zone);
		if (dataRows == null || dataRows.Length == 0)
		{
			return;
		}
		if (dataRows.Length <= 31)
		{
			await GetFloorCopyRewardInfo(zone, zone, 0);
			return;
		}
		int rstCount = dataRows.Length / 31;
		for (int i = 0; i <= rstCount; i++)
		{
			int zoneId = i + zone * 10000;
			await GetFloorCopyRewardInfo(zone, zoneId, i);
		}
	}

	public async UniTask<RewardThings> GetFloorCopyReward(int zone, int index)
	{
		GetFloorCopyRewardRequest request = GetFloorCopyRewardRequest.Create();
		request.Zone = zone;
		request.Idx = index;
		GetFloorCopyRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetFloorCopyRewardResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取区域星级奖励") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取区域星级奖励"))
			{
				return (await PropHelper.AnalyzeRewardFromServer(response.Rewards)).ConvertToRewardThings();
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error($"获取区域星级奖励，区域【{zone}】，奖励序号【{index}】！{ex2.Message} / {ex2.StackTrace}");
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<bool> SetFloorCopySetting(List<CopyType4TeamConfig> copyConfigs)
	{
		try
		{
			SetFloorCopySettingRequest setFloorCopySettingRequest = SetFloorCopySettingRequest.Create();
			List<PbSetFloorCopyRoleSetting> list = new List<PbSetFloorCopyRoleSetting>();
			List<CopyBPCarrying> list2 = new List<CopyBPCarrying>();
			for (int i = 0; i < copyConfigs.Count; i++)
			{
				PbSetFloorCopyRoleSetting pbSetFloorCopyRoleSetting = new PbSetFloorCopyRoleSetting();
				pbSetFloorCopyRoleSetting.CopyId = copyConfigs[i].CopyId;
				pbSetFloorCopyRoleSetting.RoleIds = new List<int>();
				for (int j = 0; j < copyConfigs[i].HeroList.Count; j++)
				{
					if (copyConfigs[i].HeroList[j] != 0)
					{
						pbSetFloorCopyRoleSetting.RoleIds.Add(copyConfigs[i].HeroList[j]);
					}
				}
				list.Add(pbSetFloorCopyRoleSetting);
				list2.Add(copyConfigs[i].GetCopyBPCarrying());
			}
			string v = JsonConvert.SerializeObject(list2);
			Singleton<OuterSystem>.Instance.SavePlayerPrefs("BPFloorCopyCarrying", v);
			setFloorCopySettingRequest.CopyRoleSettingInfo = list;
			return await SendFloorCopySetting(setFloorCopySettingRequest);
		}
		catch (Exception ex)
		{
			Log.Error("设置深渊本配置失败！" + ex.Message + " / " + ex.StackTrace);
			return false;
		}
	}

	public bool SetFloorCopySettingBPConfig(List<CopyType4TeamConfig> copyConfigs)
	{
		try
		{
			List<CopyBPCarrying> list = new List<CopyBPCarrying>();
			for (int i = 0; i < copyConfigs.Count; i++)
			{
				list.Add(copyConfigs[i].GetCopyBPCarrying());
			}
			string v = JsonConvert.SerializeObject(list);
			Singleton<OuterSystem>.Instance.SavePlayerPrefs("BPFloorCopyCarrying", v);
			return true;
		}
		catch (Exception ex)
		{
			Log.Error("保存战斗道具配置失败！" + ex.Message + " / " + ex.StackTrace);
			return false;
		}
	}

	private async UniTask<bool> SendFloorCopySetting(SetFloorCopySettingRequest request)
	{
		SetFloorCopySettingResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SetFloorCopySettingResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "设置深渊本配置") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "设置深渊本配置"))
			{
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("设置深渊本配置失败！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			request = null;
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> ResetFloorCopySetting(List<int> copyIds)
	{
		try
		{
			SetFloorCopySettingRequest setFloorCopySettingRequest = SetFloorCopySettingRequest.Create();
			List<PbSetFloorCopyRoleSetting> list = new List<PbSetFloorCopyRoleSetting>();
			for (int i = 0; i < copyIds.Count; i++)
			{
				PbSetFloorCopyRoleSetting pbSetFloorCopyRoleSetting = new PbSetFloorCopyRoleSetting();
				pbSetFloorCopyRoleSetting.CopyId = copyIds[i];
				pbSetFloorCopyRoleSetting.RoleIds = null;
				list.Add(pbSetFloorCopyRoleSetting);
			}
			setFloorCopySettingRequest.CopyRoleSettingInfo = list;
			return await SendFloorCopySetting(setFloorCopySettingRequest);
		}
		catch (Exception ex)
		{
			Log.Error("设置深渊本配置失败！" + ex.Message + " / " + ex.StackTrace);
			return false;
		}
	}

	public Dictionary<int, int> GetType5CopySelects()
	{
		return GetCopyInfos<Dictionary<int, int>>(SaveKeyType5CopySelect, "获取Type5难度选择数据！");
	}

	public void SaveType5CopySelects(Dictionary<int, int> obj)
	{
		SaveCopyInfos(obj, SaveKeyType5CopySelect, "保存Type5难度选择数据失败！");
	}

	public List<CopyType5TeamConfig> GetType5Teams()
	{
		return GetCopyInfos<List<CopyType5TeamConfig>>(SaveKeyType5Config, "获取Type5队伍数据失败！");
	}

	public void SaveType5Teams(List<CopyType5TeamConfig> obj)
	{
		SaveCopyInfos(obj, SaveKeyType5Config, "保存Type5队伍数据失败！");
	}

	public void SaveCopyInfos<T>(T obj, string key, string errorInfo)
	{
		string text = null;
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			text = ((obj == null) ? "" : JsonConvert.SerializeObject(obj));
			PlayerPrefs.SetString($"{key}{uid}_{systemName}", text);
		}
		catch (Exception)
		{
			Log.Error(errorInfo + "！" + systemName);
		}
	}

	public T GetCopyInfos<T>(string key, string errorInfo) where T : new()
	{
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			T val = JsonConvert.DeserializeObject<T>(PlayerPrefs.GetString($"{key}{uid}_{systemName}", ""));
			if (val == null)
			{
				return new T();
			}
			return val;
		}
		catch (Exception)
		{
			Log.Error(errorInfo + "！" + systemName);
		}
		return new T();
	}

	public async UniTask GetRaceCopyInfo()
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70018))
		{
			return;
		}
		copyVM.InitCopyMain5();
		GetRaceCopyInfoRequest request1 = GetRaceCopyInfoRequest.Create();
		GetRaceCopyInfoResponse response1 = null;
		GetRaceCopyRewardInfoRequest request2 = GetRaceCopyRewardInfoRequest.Create();
		GetRaceCopyRewardInfoResponse response2 = null;
		try
		{
			response1 = await Singleton<NetworkSystem>.Instance.Call<GetRaceCopyInfoResponse>(request1);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response1, "获取竞速副本信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response1.Error, "获取竞速副本信息"))
			{
				copyVM.SetType5TotalScore(0L);
				for (int i = 0; i < response1.CopyInfos.Count; i++)
				{
					int copyType = response1.CopyInfos[i].CopyType;
					if (copyType == 999)
					{
						copyVM.SetType5TotalScore(response1.CopyInfos[i].Score);
						continue;
					}
					long totalScore = response1.CopyInfos[i].Score;
					CopyTypeData copyTypeById = copyVM.GetCopyTypeById(5, copyType);
					if (copyTypeById != null)
					{
						copyTypeById.SetTotalScore(totalScore);
						List<CopyData> copyDataList = copyTypeById.CopyDataList;
						for (int j = 0; j < copyDataList.Count; j++)
						{
							copyDataList[j].SetTotalScore(totalScore);
						}
					}
				}
				for (int k = 0; k < response1.CurCopyInfos.Count; k++)
				{
					int copyType2 = response1.CurCopyInfos[k].CopyType;
					long curScore = response1.CurCopyInfos[k].Score;
					CopyTypeData copyTypeById2 = copyVM.GetCopyTypeById(5, copyType2);
					if (copyTypeById2 != null)
					{
						copyTypeById2.SetCurScore(curScore);
						List<CopyData> copyDataList2 = copyTypeById2.CopyDataList;
						for (int l = 0; l < copyDataList2.Count; l++)
						{
							copyDataList2[l].SetCurScore(curScore);
						}
					}
				}
				SettleCopyRaceTroops(response1.Troops);
			}
			response2 = await Singleton<NetworkSystem>.Instance.Call<GetRaceCopyRewardInfoResponse>(request2);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response2, "获取竞速奖励信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response2.Error, "获取竞速奖励信息"))
			{
				copyVM.ClearReward5State();
				copyVM.SetReward5State(response2.RewardStates);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取竞速副本信息失败 " + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request1.Dispose();
			request2.Dispose();
			response2?.Dispose();
			response1?.Dispose();
		}
	}

	public async UniTask GetRaceCopyTotalScore()
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70018))
		{
			return;
		}
		copyVM.InitCopyMain5();
		GetRaceCopyInfoRequest request1 = GetRaceCopyInfoRequest.Create();
		GetRaceCopyInfoResponse response1 = null;
		try
		{
			response1 = await Singleton<NetworkSystem>.Instance.Call<GetRaceCopyInfoResponse>(request1);
			if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(response1, "获取竞速副本信息") || !Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response1.Error, "获取竞速副本信息"))
			{
				return;
			}
			copyVM.SetType5TotalScore(0L);
			for (int i = 0; i < response1.CopyInfos.Count; i++)
			{
				if (response1.CopyInfos[i].CopyType == 999)
				{
					copyVM.SetType5TotalScore(response1.CopyInfos[i].Score);
					break;
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取竞速副本信息失败 " + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request1.Dispose();
			response1?.Dispose();
		}
	}

	public async UniTask<KeyValuePair<bool, Dictionary<int, int>>> GetChallengeCopyPlayerRankInfo()
	{
		GetChallengeCopyPlayerRankInfoRequest request = GetChallengeCopyPlayerRankInfoRequest.Create();
		GetChallengeCopyPlayerRankInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetChallengeCopyPlayerRankInfoResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取挑战副本排行信息") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取挑战副本排行信息"))
			{
				Dictionary<int, int> dictionary = null;
				if (response.CopyScores != null && response.CopyScores.Count > 0)
				{
					dictionary = new Dictionary<int, int>(response.CopyScores.Count);
					for (int i = 0; i < response.CopyScores.Count; i++)
					{
						PbChallengeCopyPlayerScoreInfo pbChallengeCopyPlayerScoreInfo = response.CopyScores[i];
						if (pbChallengeCopyPlayerScoreInfo != null)
						{
							dictionary[pbChallengeCopyPlayerScoreInfo.CopyType] = pbChallengeCopyPlayerScoreInfo.Score;
						}
					}
				}
				return new KeyValuePair<bool, Dictionary<int, int>>(key: true, dictionary);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取挑战副本排行信息失败 " + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return new KeyValuePair<bool, Dictionary<int, int>>(key: false, null);
	}

	private void SettleCopyRaceTroops(List<PbRaceCopyTroopInfo> troopInfos)
	{
		copyVM.LoadT5LocalTeam();
		if (troopInfos == null || troopInfos.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < troopInfos.Count; i++)
		{
			CopyType5Team type5TeamConfig = copyVM.GetType5TeamConfig(troopInfos[i].TroopId);
			if (troopInfos[i].Block || type5TeamConfig == null)
			{
				CopyTypeData copyTypeById = copyVM.GetCopyTypeById(5, troopInfos[i].TroopId);
				CopyType5Team type5TeamConfigFromServer = CopyType5Team.CreateFromServer(troopInfos[i].TroopId, troopInfos[i].RoleIds, type5TeamConfig?.BpList, type5TeamConfig?.BuffId ?? troopInfos[i].BuffId, troopInfos[i].Block, copyTypeById.EndTime);
				copyVM.SetType5TeamConfigFromServer(type5TeamConfigFromServer);
			}
		}
	}

	public async UniTask<RewardThings> GetRaceCopyReward(int id)
	{
		GetRaceCopyRewardRequest request = GetRaceCopyRewardRequest.Create();
		request.Id = id;
		GetRaceCopyRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetRaceCopyRewardResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取竞速积分奖励") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取竞速积分奖励"))
			{
				return (await PropHelper.AnalyzeRewardFromServer(response.Reward)).ConvertToRewardThings();
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error($"获取竞速积分奖励，序号【{id}】！{ex2.Message} / {ex2.StackTrace}");
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<CopyPlayerRankData>> GetRankList(int type, int copyType)
	{
		GetRankListRequest request = GetRankListRequest.Create();
		request.Type = type;
		request.SubType = copyType;
		GetRankListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetRankListResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取竞速排名数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取竞速排名数据"))
			{
				List<CopyPlayerRankData> list = new List<CopyPlayerRankData>();
				for (int i = 0; i < response.RaceCopyRankInfos.Count; i++)
				{
					if (response.RaceCopyRankInfos[i].Rank > 3)
					{
						continue;
					}
					CopyPlayerRankData copyPlayerRankData = new CopyPlayerRankData();
					copyPlayerRankData.icon = response.RaceCopyRankInfos[i].Icon;
					copyPlayerRankData.iconFrame = response.RaceCopyRankInfos[i].IconFrame;
					copyPlayerRankData.iconTitle = response.RaceCopyRankInfos[i].Title;
					copyPlayerRankData.playerName = response.RaceCopyRankInfos[i].UserName;
					copyPlayerRankData.index = response.RaceCopyRankInfos[i].Rank;
					copyPlayerRankData.score = response.RaceCopyRankInfos[i].Score;
					if (copyPlayerRankData.index == 1)
					{
						list.Insert(0, copyPlayerRankData);
					}
					else if (copyPlayerRankData.index == 3)
					{
						list.Add(copyPlayerRankData);
					}
					else if (copyPlayerRankData.index == 2)
					{
						if (list.Count > 0 && list[0].index == 1)
						{
							list.Insert(1, copyPlayerRankData);
						}
						else if (list.Count > 0 && list[0].index == 3)
						{
							list.Insert(0, copyPlayerRankData);
						}
						else
						{
							list.Add(copyPlayerRankData);
						}
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
			Log.Error($"获取竞速排名，类型【{type}】【{copyType}】！{ex2.Message} / {ex2.StackTrace}");
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<bool> SetRaceCopyTroop(CopyType5Team config)
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70018))
		{
			return false;
		}
		C2H_SetRaceCopyTroopRequest request = C2H_SetRaceCopyTroopRequest.Create();
		H2C_SetRaceCopyTroopResponse response = null;
		request.TypeId = 0;
		request.TroopId = config.CopyType;
		request.RoleIds = config.HeroList;
		request.BuffId = config.BuffId;
		request.Block = true;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_SetRaceCopyTroopResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "设置竞速副本队伍") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "设置竞速副本队伍"))
			{
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("设置竞速副本队伍 " + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> ResetRaceCopyTroop(int troopId)
	{
		if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70018))
		{
			return false;
		}
		C2H_SetRaceCopyTroopRequest request = C2H_SetRaceCopyTroopRequest.Create();
		H2C_SetRaceCopyTroopResponse response = null;
		request.TypeId = 2;
		request.TroopId = troopId;
		request.RoleIds = new List<int> { 0, 0, 0 };
		request.BuffId = 0;
		request.Block = false;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_SetRaceCopyTroopResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "重置竞速副本队伍") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "重置竞速副本队伍"))
			{
				for (int i = 0; i < response.CurCopyInfos.Count; i++)
				{
					int copyType = response.CurCopyInfos[i].CopyType;
					if (copyType != 999)
					{
						long val = response.CurCopyInfos[i].Score;
						CopyTypeData copyTypeById = copyVM.GetCopyTypeById(5, copyType);
						copyTypeById.ResetCurScore(val);
						List<CopyData> copyDataList = copyTypeById.CopyDataList;
						for (int j = 0; j < copyDataList.Count; j++)
						{
							copyDataList[j].ResetCurScore(val);
						}
					}
				}
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("设置竞速副本队伍 " + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public CopyViewModel GetCopyVM()
	{
		return copyVM;
	}

	public bool CheckInviteCopyOpen(int copyId)
	{
		CopyData copyData = GetCopyVM()?.GetCopyById(copyId);
		bool flag = false;
		flag = copyData?.CopyMainId switch
		{
			1 => Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70004), 
			2 => Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70010), 
			3 => Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70016), 
			4 => Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70017), 
			5 => Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70018), 
			_ => true, 
		};
		return !copyData.IsLock & flag;
	}

	public bool GetIsCampaignWorldBoss(int copyId)
	{
		bool result = false;
		if (GameEntry.DataTable.GetDataRow((DRCampaignLevel p) => p.CopyId == copyId).Type == 90)
		{
			result = true;
		}
		return result;
	}

	public async UniTask<bool> RequestTowerData()
	{
		copyVM.InitTowerTalentData();
		copyVM.GetDefaultUnLockTowerTalent();
		C2SGetTowerTalentInfoRequest request = C2SGetTowerTalentInfoRequest.Create();
		S2CGetTowerTalentInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2CGetTowerTalentInfoResponse>(request);
			if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取爬塔数据"))
			{
				return false;
			}
			if (!Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取爬塔数据"))
			{
				return false;
			}
			if (response.Infos == null || response.Infos.Count <= 0)
			{
				return false;
			}
			GameEntry.DataTable.GetAllDataRow<DRTowerTalent>();
			for (int i = 0; i < response.Infos.Count; i++)
			{
				List<PbTowerTalentInfo> towerTalentInfos = response.Infos[i].TowerTalentInfos;
				if (towerTalentInfos != null && towerTalentInfos.Count > 0)
				{
					for (int j = 0; j < towerTalentInfos.Count; j++)
					{
						copyVM.SetTowerTalentLevel(towerTalentInfos[j].TalentId, towerTalentInfos[j].Level, playEffect: false);
					}
				}
			}
			copyVM.UpdateTowerTalentUnLockLevel();
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取爬塔数据！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return await RequestTowerRoguelikeInfoData();
	}

	public int GetCurChallengeTowerLayer()
	{
		if (copyVM == null)
		{
			return 0;
		}
		return copyVM.GetCurChallengeTowerLayer();
	}

	private async UniTask<bool> RequestTowerRoguelikeInfoData()
	{
		C2SGetRoguelikeInfoRequest request = C2SGetRoguelikeInfoRequest.Create();
		S2CGetRoguelikeInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2CGetRoguelikeInfoResponse>(request);
			if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取爬塔肉鸽数据"))
			{
				return false;
			}
			if (!Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取爬塔肉鸽数据"))
			{
				return false;
			}
			copyVM.SetTowerBuffData(response.StrengBuffId, response.RefreshTimes, response.RoleId, response.TeamSetId, response.BattlePropIds, response.MaxLayer, response.EndlessLayer);
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取爬塔肉鸽数据！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return true;
	}

	public async UniTask<bool> RequestSaveTowerBuffData(List<int> selectBuffs, int refreshCount, int towerNum, int endlessLayer)
	{
		bool saveSuccess = false;
		C2SChooseTowerBuffRequest request = C2SChooseTowerBuffRequest.Create();
		request.RoguelikeBuffId = selectBuffs;
		request.RefreshTimes = refreshCount;
		if (endlessLayer > 0)
		{
			endlessLayer++;
		}
		request.EndlessLayer = endlessLayer;
		S2CChooseTowerBuffResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2CChooseTowerBuffResponse>(request);
			if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "", showToast: false))
			{
				return false;
			}
			if (!Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "", showToast: false))
			{
				return false;
			}
			copyVM.UpdateBuffData(selectBuffs, refreshCount, towerNum, endlessLayer);
			saveSuccess = true;
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("重置爬塔天赋数据！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return saveSuccess;
	}

	public async UniTask<bool> RequestClearTowerBuffData()
	{
		bool clearSuccess = false;
		C2SResetRoguelikeRequest request = C2SResetRoguelikeRequest.Create();
		S2CResetRoguelikeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2CResetRoguelikeResponse>(request);
			if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "", showToast: false))
			{
				return false;
			}
			if (!Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "", showToast: false))
			{
				return false;
			}
			copyVM.ClearTowerBuffData();
			clearSuccess = true;
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("重置爬塔天赋数据！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return clearSuccess;
	}

	public async UniTask UpTowerTalentLevel(int upTalentId)
	{
		C2SUpLevelTowerTalentRequest request = C2SUpLevelTowerTalentRequest.Create();
		request.TalentId = upTalentId;
		S2CUpLevelTowerTalentResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2CUpLevelTowerTalentResponse>(request);
			if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "", showToast: false) || !Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, ""))
			{
				return;
			}
			PropHelper.AnalyzeRewardFromServer(response.ItemChange);
			if (response.Infos == null || response.Infos.Count <= 0)
			{
				return;
			}
			for (int i = 0; i < response.Infos.Count; i++)
			{
				List<PbTowerTalentInfo> towerTalentInfos = response.Infos[i].TowerTalentInfos;
				if (towerTalentInfos != null && towerTalentInfos.Count > 0)
				{
					for (int j = 0; j < towerTalentInfos.Count; j++)
					{
						copyVM.SetTowerTalentLevel(towerTalentInfos[j].TalentId, towerTalentInfos[j].Level, playEffect: true);
					}
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("升级爬塔天赋数据！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		copyVM.UpdateTowerTalentUnLockLevel();
	}

	public void UpdateTowerTalentUpLevel()
	{
		copyVM?.UpdateTowerTalentCanUp();
	}

	public async UniTask ResetTowerTalent()
	{
		C2SResetTowerTalentRequest request = C2SResetTowerTalentRequest.Create();
		S2CResetTowerTalentResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2CResetTowerTalentResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "", showToast: false) && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "", showToast: false))
			{
				PropHelper.AnalyzeRewardFromServer(response.ItemChange);
				copyVM.ResetTowerTalentViewModel();
				copyVM.GetDefaultUnLockTowerTalent();
				copyVM.UpdateTowerTalentUnLockLevel();
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("重置爬塔天赋数据！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
	}

	private void GetTowerActivityVersion()
	{
		if (towerActivityVersion != 0)
		{
			return;
		}
		int towerCopyType = copyVM.TowerCopyType;
		if (towerCopyType != -1)
		{
			DRCopyType dataRow = GameEntry.DataTable.GetDataRow<DRCopyType>(towerCopyType);
			if (dataRow != null)
			{
				towerActivityVersion = dataRow.Version;
			}
		}
	}

	public void SetTowerBattleConfig(int roleId, int teamSetId, List<int> propIds)
	{
		copyVM.SetTowerBattleData(roleId, teamSetId, propIds);
	}

	public void SetTowerActivityRedPoint(int activityId, int value)
	{
		GetTowerActivityVersion();
		if (towerAreaRedPoint.ContainsKey(activityId))
		{
			towerAreaRedPoint[activityId] = value;
		}
		else
		{
			towerAreaRedPoint.Add(activityId, value);
		}
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
		PlayerPrefs.SetInt(towerConfigAreaRed + $"_{uid}_{systemName}_{towerActivityVersion}_{activityId}", value);
		bool value2 = false;
		if (value == 0)
		{
			value2 = true;
		}
		else
		{
			foreach (int value3 in towerAreaRedPoint.Values)
			{
				if (value3 == 0)
				{
					value2 = true;
					break;
				}
			}
		}
		Context.GetApplicationContext().GetService<IMessenger>().Publish(new ClimbTowerActivityMessager(this, null, value2));
	}

	public bool GetTowerUpTalentRedPoint(bool broadcastMessage)
	{
		if (copyVM == null)
		{
			return false;
		}
		return copyVM.UpTalentRedPoint(broadcastMessage);
	}

	public int GetTowerOneAreaRedPoint(int activityId)
	{
		if (towerAreaRedPoint.ContainsKey(activityId))
		{
			return towerAreaRedPoint[activityId];
		}
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
		GetTowerActivityVersion();
		int num = PlayerPrefs.GetInt(towerConfigAreaRed + $"_{uid}_{systemName}_{towerActivityVersion}_{activityId}", -1);
		towerAreaRedPoint.Add(activityId, num);
		return num;
	}

	private List<int> GetTowerTalentBuff()
	{
		if (copyVM == null)
		{
			return null;
		}
		return copyVM.GetTowerTalentBuff();
	}

	private List<int> GetTowerRogueBuff()
	{
		if (copyVM == null)
		{
			return null;
		}
		return copyVM.GetTowerRogueBuff();
	}

	private int GetTowerRogueRefreshCount()
	{
		if (copyVM == null)
		{
			return 0;
		}
		return copyVM.GetTowerRogueRefreshCount();
	}

	private List<TeamMember> GetHeroTryHeroModel(List<int> useRoleIds, out int teamSetId)
	{
		if (useRoleIds == null)
		{
			useRoleIds = new List<int>(1);
		}
		HeroModel heroModel = null;
		teamSetId = 0;
		int roleId = 0;
		List<int> list = new List<int>(2);
		copyVM.GetTowerBattleData(out roleId, out teamSetId, list);
		if (teamSetId != 0)
		{
			DRTeamSet dataRow = GameEntry.DataTable.GetDataRow<DRTeamSet>(teamSetId);
			for (int i = 0; i < dataRow.TryHero.Count; i++)
			{
				DRPresetHeroData dataRow2 = GameEntry.DataTable.GetDataRow<DRPresetHeroData>(dataRow.TryHero[i]);
				if (dataRow2.HeroId == roleId)
				{
					WeaponData weaponData = WeaponData.CreateWeaponData(dataRow2.Weapon);
					weaponData.SetLevel(weaponData, dataRow2.WeaponLv, dataRow2.WeaponLv / 20, dataRow2.WeaponRefine);
					heroModel = HeroModel.CreateByPreset(dataRow2, weaponData);
					break;
				}
			}
			if (heroModel == null)
			{
				heroModel = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(roleId, emptyCreateNew: true);
			}
		}
		else
		{
			heroModel = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(roleId);
		}
		useRoleIds.Add(heroModel.Id);
		List<TeamMember> list2 = new List<TeamMember>();
		list2.Add(new TeamMember(1, isCaptain: true, heroModel));
		if (list.Count > 0)
		{
			Dictionary<int, BPData> dictionary = new Dictionary<int, BPData>();
			for (int j = 0; j < list.Count; j++)
			{
				BPData bpDataById = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBpDataById(list[j]);
				dictionary.Add((j == 0) ? 1 : 2, bpDataById);
			}
			heroModel.AddBPData(dictionary);
		}
		return list2;
	}

	public async UniTask<bool> PlayTower(int copyId, int towerNum, int endlessIndex, string preSceneName, bool sendTowerBattleData)
	{
		CopyData copyById = copyVM.GetCopyById(copyId);
		return await PlayTower(copyById, towerNum, endlessIndex, preSceneName, sendTowerBattleData);
	}

	public async UniTask<bool> ContinuePlayTower()
	{
		int towerMaxLayerCopyId = copyVM.GetTowerMaxLayerCopyId();
		int curChallengeTowerLayer = copyVM.GetCurChallengeTowerLayer();
		int towerEndlessLayer = GetTowerEndlessLayer(towerMaxLayerCopyId);
		int copyId = towerMaxLayerCopyId;
		int num = curChallengeTowerLayer;
		if (towerEndlessLayer <= 0)
		{
			copyId = copyVM.GetNextLayerCopyId();
			num++;
		}
		return await PlayTower(copyId, num, towerEndlessLayer, "Outer/Outer", sendTowerBattleData: false);
	}

	private int GetTowerEndlessLayer(int maxLayerCopyId)
	{
		int num = copyVM.GetTowerEndlessLayer();
		if (num > 0)
		{
			return num;
		}
		if (GetTowerAreaFinishByCopyId(maxLayerCopyId))
		{
			num = 1;
		}
		return num;
	}

	private async UniTask<bool> SendTowerBattleData(int roleId, int teamSetId, List<int> propIds)
	{
		bool success = false;
		C2SSetRoguelikeTeamRequest request = C2SSetRoguelikeTeamRequest.Create();
		request.TeamSetId = teamSetId;
		request.BattlePropIds = propIds;
		request.RoleId = roleId;
		S2CSetRoguelikeTeamResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2CSetRoguelikeTeamResponse>(request);
			if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "", showToast: false))
			{
				return false;
			}
			if (!Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "", showToast: false))
			{
				return false;
			}
			success = true;
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("发送爬塔肉鸽战斗数据！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return success;
	}

	public async UniTask<bool> PlayTower(CopyData copyData, int towerNum, int endlessLayer, string preSceneName, bool sendTowerBattleData)
	{
		if (copyData.IsLock)
		{
			return false;
		}
		List<int> list = new List<int>(1);
		int teamSetId = 0;
		List<TeamMember> heroTryHeroModel = GetHeroTryHeroModel(list, out teamSetId);
		if (heroTryHeroModel == null || heroTryHeroModel.Count <= 0)
		{
			return false;
		}
		PeripheryHeroData peripheryHeroData = heroTryHeroModel[0].GetPeripheryHeroData();
		CopyEnterInfoData copyEnterInfoData = await EnterBattleWorld(copyData, list, heroTryHeroModel, 1, 0, peripheryHeroData.GetBattleProps());
		if (sendTowerBattleData)
		{
			await SendTowerBattleData(peripheryHeroData.Id, teamSetId, peripheryHeroData.GetBattleProps());
		}
		_ = copyEnterInfoData;
		List<TeamMember> teamMembers = copyEnterInfoData.TeamMembers;
		List<PeripheryHeroData> heroList = new List<PeripheryHeroData>();
		foreach (TeamMember item in teamMembers)
		{
			if (copyData.HasFirstBuff())
			{
				item.HeroModel.AddOuterBuff(OuterBuffEnum.CopyFirstAccessBuff, copyData.CopyEnvironId);
			}
			heroList.Add(item.GetPeripheryHeroData());
		}
		List<AchievementMedal> battleAchievementList = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetBattleAchievementMedals(copyData.CopyType == 99000 || copyData.CopyType == 99100);
		TowerConfig towerConfig = await GameEntry.Resource.LoadAssetAsync<TowerConfig>(AssetUtility.GetActivityMapDataAsset("TowerConfig"));
		if (towerConfig == null)
		{
			return false;
		}
		TowerConfig towerConfig2 = UnityEngine.Object.Instantiate(towerConfig);
		if (towerConfig2 == null)
		{
			return false;
		}
		int num = towerNum - 1;
		TowerFloorData towerFloorData = towerConfig2.FloorConfigs[num];
		WorldData worldData = ClimbTowerWorldData.CreateClimbTowerWorldData(0u, towerFloorData.SceneName, copyData.CopyType, towerNum, num, endlessLayer, towerConfig2, towerFloorData.NavMesh, heroList, battleAchievementList, teamMembers, GetTowerTalentBuff(), GetTowerRogueBuff(), GetTowerRogueRefreshCount());
		worldData.RoomId = copyEnterInfoData.RoomId;
		worldData.RandomSeed = copyEnterInfoData.SeedID;
		LoadingTowerViewModel loadingSingleViewModel = new LoadingTowerViewModel(preSceneName, autoUnload: true, worldData);
		DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Battle);
		loadingSingleViewModel.SetRandomLoadingTap(randomLoadingTap);
		await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadingSingleViewModel);
		await UniTask.WaitUntil(() => loadingSingleViewModel.IsLoadingFinish);
		if (loadingSingleViewModel.LoadingSuccess)
		{
			UIWindowHelper.WindowRelease();
			await loadingSingleViewModel.CloseLoading();
			Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSingleViewModel.LoadingSuccess);
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddEnterCopyTDA(copyEnterInfoData);
			Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetIsSingleBattle(value: true);
			return true;
		}
		return false;
	}

	public bool GetTowerCopyUnLock(int copyId)
	{
		PhasedActivityViewModel phasedActivityVM = null;
		bool areaLastCopy = false;
		int towerAreaIdByCopyId = GetTowerAreaIdByCopyId(copyId, ref phasedActivityVM, out areaLastCopy);
		if (towerAreaIdByCopyId == 0)
		{
			return false;
		}
		List<ActivityTabItemData2> phasedItemList = phasedActivityVM.PhasedItemList;
		if (phasedItemList == null)
		{
			return false;
		}
		for (int i = 0; i < phasedItemList.Count; i++)
		{
			if (phasedItemList[i].TagId == towerAreaIdByCopyId)
			{
				return phasedItemList[i].StateEnum != ActivityTabStateEnum.Lock;
			}
		}
		return false;
	}

	private int GetTowerAreaIdByCopyId(int copyId, ref PhasedActivityViewModel phasedActivityVM, out bool areaLastCopy)
	{
		areaLastCopy = false;
		CopyData copyData = copyVM.GetCopyById(copyId);
		if (copyData == null)
		{
			return 0;
		}
		ActivityViewModelBase activityViewModel = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().GetActivityViewModel(copyData.ActivityTypeId);
		if (activityViewModel == null)
		{
			return 0;
		}
		phasedActivityVM = activityViewModel as PhasedActivityViewModel;
		if (phasedActivityVM == null)
		{
			return 0;
		}
		List<ActivityTabItemData2> phasedItemList = phasedActivityVM.PhasedItemList;
		if (phasedItemList == null)
		{
			return 0;
		}
		DRActivityRank[] dataRows = GameEntry.DataTable.GetDataRows((DRActivityRank p) => p.ActivityTypeId == copyData.ActivityTypeId);
		Array.Sort(dataRows, (DRActivityRank x, DRActivityRank y) => x.Id.CompareTo(y.Id));
		for (int num = 0; num < dataRows.Length; num++)
		{
			int areaId = dataRows[num].Id;
			DRActivityRankTask[] dataRows2 = GameEntry.DataTable.GetDataRows((DRActivityRankTask p) => p.ActivityRankId == areaId);
			Array.Sort(dataRows2, (DRActivityRankTask x, DRActivityRankTask y) => x.Id.CompareTo(y.Id));
			int num2 = dataRows2.Length;
			for (int num3 = 0; num3 < num2; num3++)
			{
				int activityTaskId = dataRows2[num3].ActivityTaskId;
				DRActivityTask dataRow = GameEntry.DataTable.GetDataRow<DRActivityTask>(activityTaskId);
				if (dataRow == null || dataRow.RequireValue[0] != copyId)
				{
					continue;
				}
				for (int num4 = 0; num4 < phasedItemList.Count; num4++)
				{
					if (phasedItemList[num4].TagId == areaId)
					{
						areaLastCopy = num3 == num2 - 1;
						return areaId;
					}
				}
			}
		}
		return 0;
	}

	public bool GetTowerAreaFinishByCopyId(int copyId)
	{
		PhasedActivityViewModel phasedActivityVM = null;
		bool areaLastCopy = false;
		int towerAreaIdByCopyId = GetTowerAreaIdByCopyId(copyId, ref phasedActivityVM, out areaLastCopy);
		if (!areaLastCopy)
		{
			return false;
		}
		if (towerAreaIdByCopyId == 0)
		{
			return false;
		}
		if (phasedActivityVM.PhasedItemList == null)
		{
			return false;
		}
		phasedActivityVM.GetActivityTaskItemByRankId(towerAreaIdByCopyId);
		List<ActivityTaskItemData> showActivityTaskItemDataList = phasedActivityVM.ShowActivityTaskItemDataList;
		for (int i = 0; i < showActivityTaskItemDataList.Count; i++)
		{
			if (showActivityTaskItemDataList[i].TaskState != ActivityTaskStateEnum.Accept && showActivityTaskItemDataList[i].TaskState != ActivityTaskStateEnum.Finished)
			{
				return false;
			}
		}
		return true;
	}

	public async UniTask<bool> RequestEnterTower(int copyId, List<int> addBuffs, List<AchievementMedal> achievementMedals)
	{
		CopyData copyData = copyVM.GetCopyById(copyId);
		List<int> list = new List<int>(1);
		int teamSetId = 0;
		List<TeamMember> heroTryHeroModel = GetHeroTryHeroModel(list, out teamSetId);
		if (heroTryHeroModel == null || heroTryHeroModel.Count <= 0)
		{
			return false;
		}
		addBuffs.AddRange(GetTowerTalentBuff());
		PeripheryHeroData peripheryHeroData = heroTryHeroModel[0].GetPeripheryHeroData();
		CopyEnterInfoData copyEnterInfoData = await EnterBattleWorld(copyData, list, heroTryHeroModel, 1, 0, peripheryHeroData.GetBattleProps());
		if (copyEnterInfoData != null)
		{
			achievementMedals = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetBattleAchievementMedals(copyData.CopyType == 99000 || copyData.CopyType == 99100);
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddEnterCopyTDA(copyEnterInfoData);
			return true;
		}
		return true;
	}

	public bool GetRandomBuffCollectState(int copyId, int buffId)
	{
		CopyData copyById = copyVM.GetCopyById(copyId);
		return Singleton<ServiceSystem>.Instance.GetService<IActivityAchievementService>().GetActivityAchievementStateRst(copyById.ActivityTypeId, buffId) == ActivityAchievementState.Collected;
	}

	public void Dispose()
	{
		RemoveCopyTimer();
	}
}
