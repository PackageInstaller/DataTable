#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class KnapsackService : IKnapsackService
{
	private readonly IMessenger messenger;

	private ISubscription<UserThingCountChangeNotify> subscription_PropCountChange;

	private KnapsackViewModel knapsackViewModel;

	public IMessenger GetMessager()
	{
		return messenger;
	}

	public KnapsackService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		knapsackViewModel = new KnapsackViewModel();
		subscription_PropCountChange = Singleton<NetworkSystem>.Instance.Subscribe<UserThingCountChangeNotify>(OnThingCountChange);
	}

	public async UniTask<bool> RequestKnapsackData()
	{
		C2H_GetPackageData rst = C2H_GetPackageData.Create();
		H2C_GetPackageData response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_GetPackageData>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求背包数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求背包数据失败"))
			{
				knapsackViewModel?.InitData(response.Items, response.ExpireItems, response.AlreadyExpiredItems);
				Dictionary<int, int> dictionary = new Dictionary<int, int>();
				if (response.CumulativeItems != null)
				{
					foreach (PbItem item in response.CumulativeItems.ToList())
					{
						int itemId = item.ItemId;
						int value = (int)item.Count;
						if (!dictionary.ContainsKey(itemId))
						{
							dictionary.Add(itemId, value);
						}
					}
				}
				Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().SaveAcumCount(dictionary);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<RewardGetData> RequestDecomposeEquipment(List<long> uids, EquipmentEnum type)
	{
		DecomposeEquipRequest rst = DecomposeEquipRequest.Create();
		rst.Uuid = uids;
		rst.ThingType = (int)type;
		DecomposeEquipResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<DecomposeEquipResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "装备分解") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "装备分解失败"))
			{
				Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().RemoveEquipments(uids);
				return PropHelper.AnalyzeRewardFromServer(response.GetItems);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<List<int>> GetEquipmentDecomposePreferences(EquipmentEnum equipmentEnum)
	{
		List<int> list = knapsackViewModel?.GetEquipmentDecomposePreferences(equipmentEnum);
		if (list != null)
		{
			return new List<int>(list);
		}
		GetEquipmentDecomposePreferencesRequest rst = GetEquipmentDecomposePreferencesRequest.Create();
		rst.Type = (int)equipmentEnum;
		GetEquipmentDecomposePreferencesResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetEquipmentDecomposePreferencesResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取分解偏好") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取分解偏好失败"))
			{
				if (response.Preferences != null)
				{
					List<int> list2 = new List<int>(response.Preferences);
					knapsackViewModel?.SetEquipmentDecomposePreferences(equipmentEnum, list2);
					return list2;
				}
				return await SaveDefaultDecomposePreferencesIfNeeded(equipmentEnum);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return await SaveDefaultDecomposePreferencesIfNeeded(equipmentEnum);
	}

	public async UniTask<bool> SetEquipmentDecomposePreferences(List<int> preferences)
	{
		return await SetEquipmentDecomposePreferences(EquipmentEnum.Armour, preferences);
	}

	public async UniTask<bool> SetEquipmentDecomposePreferences(EquipmentEnum equipmentEnum, List<int> preferences)
	{
		SetEquipmentDecomposePreferencesRequest rst = SetEquipmentDecomposePreferencesRequest.Create();
		rst.Preferences = preferences ?? new List<int>();
		rst.Type = (int)equipmentEnum;
		SetEquipmentDecomposePreferencesResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SetEquipmentDecomposePreferencesResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "保存分解偏好") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "保存分解偏好失败"))
			{
				knapsackViewModel?.SetEquipmentDecomposePreferences(equipmentEnum, rst.Preferences);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	private async UniTask<List<int>> SaveDefaultDecomposePreferencesIfNeeded(EquipmentEnum equipmentEnum)
	{
		List<int> list = knapsackViewModel?.GetEquipmentDecomposePreferences(equipmentEnum);
		if (list != null)
		{
			return new List<int>(list);
		}
		List<int> defaultPreferences = BuildDefaultDecomposePreferences(equipmentEnum);
		knapsackViewModel?.SetEquipmentDecomposePreferences(equipmentEnum, defaultPreferences);
		try
		{
			await SetEquipmentDecomposePreferences(equipmentEnum, defaultPreferences);
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		return defaultPreferences;
	}

	private static List<int> BuildDefaultDecomposePreferences(EquipmentEnum equipmentEnum)
	{
		List<int> list = new List<int>();
		EquipmentFilterScene filterScene = EquipmentFilterDefinition.GetWarehouseScene(equipmentEnum);
		DREquipmentFilterType[] dataRows = GameEntry.DataTable.GetDataRows((DREquipmentFilterType p) => p.IsActive && EquipmentFilterDefinition.ContainsScene(p, filterScene));
		DREquipmentFilter[] dataRows2 = GameEntry.DataTable.GetDataRows((DREquipmentFilter p) => p.IsAcquiesce);
		if (dataRows == null || dataRows.Length == 0 || dataRows2 == null || dataRows2.Length == 0)
		{
			return list;
		}
		for (int num = 0; num < dataRows.Length; num++)
		{
			int typeId = dataRows[num].Id;
			DREquipmentFilter[] array = (from p in dataRows2
				where p.TypeId == typeId
				orderby p.Id
				select p).ToArray();
			for (int num2 = 0; num2 < array.Length; num2++)
			{
				if (array[num2].IsAcquiesce)
				{
					list.Add(array[num2].Id);
				}
			}
		}
		return list;
	}

	public async UniTask<KeyValuePair<bool, RewardGetData>> RequestDecomposeThing(List<PropData> things)
	{
		DecomposeThingRequest rst = DecomposeThingRequest.Create();
		List<PbItem> list = new List<PbItem>();
		foreach (PropData thing in things)
		{
			list.Add(new PbItem
			{
				ItemId = thing.Id,
				Count = thing.Amount
			});
		}
		rst.SelectThings = list;
		KeyValuePair<bool, RewardGetData> result = new KeyValuePair<bool, RewardGetData>(key: false, null);
		DecomposeThingResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<DecomposeThingResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "道具分解") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "道具分解失败"))
			{
				PropHelper.AnalyzeRewardFromServer(response.LeftSelectThings);
				RewardGetData value = PropHelper.AnalyzeRewardFromServer(response.GetItems);
				result = new KeyValuePair<bool, RewardGetData>(key: true, value);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public async UniTask<KeyValuePair<bool, List<KnapsackPropData>>> RequestPropWholeApart(int targetId, int opeCount, int opeType)
	{
		PropWholeApartExchangeRequest rst = PropWholeApartExchangeRequest.Create();
		rst.TargetId = targetId;
		rst.Count = opeCount;
		rst.OpeType = opeType;
		KeyValuePair<bool, List<KnapsackPropData>> result = new KeyValuePair<bool, List<KnapsackPropData>>(key: false, null);
		string msg = ((opeType == 1) ? "道具合成" : "道具拆解");
		PropWholeApartExchangeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<PropWholeApartExchangeResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, msg) && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, msg + "失败"))
			{
				PropHelper.AnalyzeRewardFromServer(new List<PbItemChange> { response.CostItem });
				List<PropDataBase> propList = PropHelper.AnalyzeRewardFromServer(new List<PbItemChange> { response.GetItem }).PropList;
				List<KnapsackPropData> knapsackItems = new List<KnapsackPropData>();
				propList.ForEach(delegate(PropDataBase p)
				{
					if (p is KnapsackPropData item)
					{
						knapsackItems.Add(item);
					}
				});
				result = new KeyValuePair<bool, List<KnapsackPropData>>(key: true, knapsackItems);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public void AddProp(List<KnapsackPropData> datas)
	{
		knapsackViewModel.AddProps(datas);
	}

	public void AddProp(KnapsackPropData propData)
	{
		knapsackViewModel.AddProp(propData);
	}

	public bool CheckEnough(List<PropDataBase> needProps)
	{
		if (needProps == null)
		{
			return true;
		}
		foreach (PropDataBase needProp in needProps)
		{
			if (needProp != null)
			{
				KnapsackPropData prop = knapsackViewModel.GetProp(needProp.Id);
				if (prop == null || prop.Amount < needProp.Amount)
				{
					return false;
				}
			}
		}
		return true;
	}

	public bool CheckEnough(PropDataBase needProp)
	{
		if (needProp == null || needProp.Amount <= 0)
		{
			return true;
		}
		KnapsackPropData prop = knapsackViewModel.GetProp(needProp.Id);
		if (prop == null || prop.Amount < needProp.Amount)
		{
			return false;
		}
		return true;
	}

	public void PublishPropChangeMessage(PropChangeMessageEnum messageEnum, List<KnapsackPropData> propDatas)
	{
		messenger.Publish(new PropChangeMessage(this, messageEnum, propDatas));
	}

	private void OnThingCountChange(UserThingCountChangeNotify message)
	{
		if (message.Things != null)
		{
			PropHelper.AnalyzeRewardFromServer(message.Things);
		}
	}

	public KnapsackViewModel GetKnapsackViewModel()
	{
		return knapsackViewModel;
	}

	public async UniTask<RewardThings> OpenPackRequest(int packId, int packCount, List<int> itemIdList)
	{
		C2H_ItemUserRequest itemUserRequest = new C2H_ItemUserRequest
		{
			ItemId = packId,
			Count = packCount
		};
		List<PbThingBase> list = new List<PbThingBase>();
		foreach (int itemId in itemIdList)
		{
			PbThingBase pbThingBase = new PbThingBase();
			pbThingBase.Id = itemId;
			list.Add(pbThingBase);
		}
		itemUserRequest.PackChoose = list;
		H2C_ItemUserResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_ItemUserResponse>(itemUserRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "使用道具", "使用礼包失败"))
			{
				return (await PropHelper.AnalyzeRewardFromServer(response.Rewards)).ConvertToRewardThings();
			}
			Toast.ShowInfo("打开礼包失败");
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			throw;
		}
		finally
		{
			itemUserRequest.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<PropGetViewModel> SendCurrencyExchange(int usePropId, int targetPropId, int count)
	{
		CurrencyExchangeRequest request = CurrencyExchangeRequest.Create();
		request.SourceId = usePropId;
		request.TargetId = targetPropId;
		request.TargetNum = count;
		CurrencyExchangeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<CurrencyExchangeResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "兑换", $"道具{usePropId} 兑换 {targetPropId} 数量 {count} 失败"))
			{
				RewardGetData rewardGetData = PropHelper.AnalyzeRewardFromServer(response.ItemChange);
				if (rewardGetData.PropList.Count > 0)
				{
					return new PropGetViewModel(null, rewardGetData.PropList);
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error($"道具{usePropId} 兑换 {targetPropId} 数量 {count} 失败，发生异常！{ex2.Message} / {ex2.StackTrace}");
			return null;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<PropGetViewModel> SendCurrencyExchange(int targetPropId, int count)
	{
		CurrencyExchangeRequest request = CurrencyExchangeRequest.Create();
		request.TargetId = targetPropId;
		request.TargetNum = count;
		CurrencyExchangeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<CurrencyExchangeResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "兑换", $"兑换 {targetPropId} 数量 {count} 失败"))
			{
				RewardGetData rewardGetData = PropHelper.AnalyzeRewardFromServer(response.ItemChange);
				if (rewardGetData.PropList.Count > 0)
				{
					return new PropGetViewModel(null, rewardGetData.PropList);
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return null;
		}
		catch (Exception ex2)
		{
			Log.Error($"兑换 {targetPropId} 数量 {count} 失败，发生异常！{ex2.Message} / {ex2.StackTrace}");
			return null;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask SetExpiredPropShowed()
	{
		ProtoDefaultGetRequest request = ProtoDefaultGetRequest.Create();
		request.Type = 1;
		try
		{
			await Singleton<NetworkSystem>.Instance.Call<CurrencyExchangeResponse>(request);
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2.Message + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
		}
	}
}
