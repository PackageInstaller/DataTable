#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class KnapsackViewModel : ViewModelBase
{
	private ObservableDictionary<long, KnapsackPropData> propList = new ObservableDictionary<long, KnapsackPropData>();

	private ObservableDictionary<long, KnapsackPropData> expirePropList = new ObservableDictionary<long, KnapsackPropData>();

	private bool expiredChecking;

	private Dictionary<long, KnapsackPropData> waitExpiredPropDatas = new Dictionary<long, KnapsackPropData>();

	private Dictionary<long, KnapsackPropData> expiredPropList = new Dictionary<long, KnapsackPropData>();

	private Dictionary<int, KnapsackPropData> expireSetDatas = new Dictionary<int, KnapsackPropData>();

	private readonly Dictionary<EquipmentEnum, List<int>> equipmentDecomposePreferencesByType = new Dictionary<EquipmentEnum, List<int>>();

	public Dictionary<long, KnapsackPropData> ExpiredPropList => expiredPropList;

	public KnapsackViewModel()
	{
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.AddNormalSecondUpdateAction(Tick);
	}

	public List<int> GetEquipmentDecomposePreferences()
	{
		return GetEquipmentDecomposePreferences(EquipmentEnum.Armour);
	}

	public void SetEquipmentDecomposePreferences(List<int> preferences)
	{
		SetEquipmentDecomposePreferences(EquipmentEnum.Armour, preferences);
	}

	public List<int> GetEquipmentDecomposePreferences(EquipmentEnum equipmentEnum)
	{
		if (equipmentDecomposePreferencesByType.TryGetValue(equipmentEnum, out var value))
		{
			return value;
		}
		return null;
	}

	public void SetEquipmentDecomposePreferences(EquipmentEnum equipmentEnum, List<int> preferences)
	{
		if (preferences == null)
		{
			equipmentDecomposePreferencesByType.Remove(equipmentEnum);
		}
		else
		{
			equipmentDecomposePreferencesByType[equipmentEnum] = new List<int>(preferences);
		}
	}

	public void InitData(List<PbItem> list, List<PbExpireItem> expireList, List<PbExpireItem> expiredList)
	{
		InitKnapsackData(list);
		InitKnapsackExpireData(expireList);
		InitExpiredData(expiredList);
	}

	public void AddProp(int propId, int count)
	{
		KnapsackPropData knapsackPropData = KnapsackPropData.Create(propId, count);
		if (knapsackPropData != null && !knapsackPropData.Empty)
		{
			AddProp(knapsackPropData);
		}
	}

	public void AddProp(long uid, int propId, long expireTimeStamp, int count)
	{
		KnapsackPropData knapsackPropData = KnapsackPropData.Create(uid, propId, expireTimeStamp, count);
		if (knapsackPropData != null && !knapsackPropData.Empty)
		{
			AddProp(knapsackPropData);
		}
	}

	public void AddProp(KnapsackPropData propData)
	{
		if (!propData.IsKnapsackType())
		{
			return;
		}
		PropChangeMessageEnum messageEnum = ((propData.Amount > 0) ? PropChangeMessageEnum.Increase : PropChangeMessageEnum.Reduce);
		ObservableDictionary<long, KnapsackPropData> dataList = GetDataList(propData.PropTimeLimitEnum);
		long dataKey = GetDataKey(propData);
		if (propData.PropTimeLimitEnum != PropTimeLimitEnum.Permanent && propData.Amount < 0)
		{
			KnapsackPropData knapsackPropData = expirePropList.Values.ToList().Find((KnapsackPropData p) => p.Id == propData.Id);
			if (knapsackPropData != null && !knapsackPropData.Empty)
			{
				knapsackPropData.Attach(propData);
				if (knapsackPropData.Amount <= 0)
				{
					messageEnum = PropChangeMessageEnum.Delete;
				}
			}
		}
		else if (dataList.ContainsKey(dataKey))
		{
			if (dataList[dataKey].Attach(propData) <= 0)
			{
				messageEnum = PropChangeMessageEnum.Delete;
			}
		}
		else if (propData.Amount > 0)
		{
			dataList.Add(dataKey, InitKnapsackPropData(propData));
			messageEnum = PropChangeMessageEnum.Add;
		}
		if (propData.PropTimeLimitEnum != PropTimeLimitEnum.Permanent)
		{
			RefreshExpireSetData(propData.Id);
		}
		if (propData.Amount > 0)
		{
			Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().AddAcumCount(propData.Id, propData.Amount);
		}
		Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().PublishPropChangeMessage(messageEnum, new List<KnapsackPropData> { propData });
	}

	public void AddProps(List<KnapsackPropData> propDatas)
	{
		if (propDatas == null)
		{
			return;
		}
		List<KnapsackPropData> list = new List<KnapsackPropData>();
		List<KnapsackPropData> list2 = new List<KnapsackPropData>();
		List<KnapsackPropData> list3 = new List<KnapsackPropData>();
		List<KnapsackPropData> list4 = new List<KnapsackPropData>();
		List<int> list5 = new List<int>();
		foreach (KnapsackPropData propData in propDatas)
		{
			if (!propData.IsKnapsackType())
			{
				continue;
			}
			if (propData.PropTimeLimitEnum != PropTimeLimitEnum.Permanent && !list5.Contains(propData.Id))
			{
				list5.Add(propData.Id);
			}
			ObservableDictionary<long, KnapsackPropData> dataList = GetDataList(propData.PropTimeLimitEnum);
			long dataKey = GetDataKey(propData);
			PropChangeMessageEnum propChangeMessageEnum = ((propData.Amount > 0) ? PropChangeMessageEnum.Increase : PropChangeMessageEnum.Reduce);
			if (propData.PropTimeLimitEnum != PropTimeLimitEnum.Permanent && propData.Amount < 0)
			{
				KnapsackPropData knapsackPropData = expirePropList.Values.ToList().Find((KnapsackPropData p) => p.Id == propData.Id);
				if (knapsackPropData != null && !knapsackPropData.Empty)
				{
					knapsackPropData.Attach(propData);
					if (knapsackPropData.Amount <= 0)
					{
						propChangeMessageEnum = PropChangeMessageEnum.Delete;
					}
				}
			}
			else if (dataList.ContainsKey(dataKey))
			{
				if (dataList[dataKey].Attach(propData) <= 0)
				{
					propChangeMessageEnum = PropChangeMessageEnum.Delete;
				}
			}
			else if (propData.Amount > 0)
			{
				dataList.Add(dataKey, InitKnapsackPropData(propData));
				propChangeMessageEnum = PropChangeMessageEnum.Add;
			}
			switch (propChangeMessageEnum)
			{
			case PropChangeMessageEnum.Add:
				list.Add(propData);
				break;
			case PropChangeMessageEnum.Delete:
				list2.Add(propData);
				break;
			case PropChangeMessageEnum.Increase:
				list3.Add(propData);
				break;
			case PropChangeMessageEnum.Reduce:
				list4.Add(propData);
				break;
			}
		}
		if (list5.Count > 0)
		{
			RefreshExpireSetData(list5);
		}
		IKnapsackService service = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>();
		if (list.Count > 0)
		{
			service.PublishPropChangeMessage(PropChangeMessageEnum.Add, list);
		}
		if (list2.Count > 0)
		{
			service.PublishPropChangeMessage(PropChangeMessageEnum.Delete, list2);
		}
		if (list3.Count > 0)
		{
			service.PublishPropChangeMessage(PropChangeMessageEnum.Increase, list3);
		}
		if (list4.Count > 0)
		{
			service.PublishPropChangeMessage(PropChangeMessageEnum.Reduce, list4);
		}
	}

	public KnapsackPropData GetProp(int propId, bool emptyCreate = false)
	{
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(propId);
		if (dataRow == null)
		{
			return null;
		}
		if (!Enum.IsDefined(typeof(PropTimeLimitEnum), dataRow.TimeLimited))
		{
			return null;
		}
		if (dataRow.TimeLimited == 0)
		{
			return GetPermanentPropData(propId, emptyCreate);
		}
		return GetExpirePropDataSet(propId, emptyCreate);
	}

	public List<KnapsackPropData> GetDisplayProps(bool negative = false)
	{
		return GetAllPropList().FindAll((KnapsackPropData p) => (!negative) ? (p.Amount > 0) : (p.Amount != 0));
	}

	public void ClearExpiredDataList()
	{
		expiredPropList.Clear();
	}

	private void InitKnapsackData(List<PbItem> list)
	{
		try
		{
			if (list == null)
			{
				return;
			}
			foreach (long key in propList.Keys.ToList())
			{
				if (!list.Exists((PbItem p) => p.ItemId == key))
				{
					propList.Remove(key);
				}
			}
			foreach (PbItem item in list)
			{
				if (item == null)
				{
					continue;
				}
				int itemId = item.ItemId;
				int amount = (int)item.Count;
				DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(itemId);
				if (dataRow == null)
				{
					Log.Error($"请求背包数据，根据道具Id【{itemId}】没有找到相应的道具配置");
				}
				else if (KnapsackPropDataExtension.IsKnapsackType(dataRow.Type))
				{
					if (propList.ContainsKey(itemId))
					{
						propList[itemId].Cover(dataRow, amount);
					}
					else
					{
						propList.Add(itemId, new KnapsackPropData(dataRow, amount));
					}
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
	}

	private void InitKnapsackExpireData(List<PbExpireItem> expireList)
	{
		if (expireList == null)
		{
			return;
		}
		List<int> list = new List<int>();
		foreach (long key in expirePropList.Keys.ToList())
		{
			if (!expireList.Exists((PbExpireItem p) => p.Uuid == key))
			{
				if (!list.Contains(expirePropList[key].Id))
				{
					list.Add(expirePropList[key].Id);
				}
				RemoveExpirePropData(key, refreshSet: false);
			}
		}
		foreach (PbExpireItem expire in expireList)
		{
			if (expire == null)
			{
				continue;
			}
			int itemId = expire.ItemId;
			int num = (int)expire.Count;
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(itemId);
			if (dataRow == null)
			{
				Log.Error($"请求背包数据，根据道具Id【{itemId}】没有找到相应的道具配置");
			}
			else
			{
				if (!KnapsackPropDataExtension.IsKnapsackType(dataRow.Type))
				{
					continue;
				}
				if (!list.Contains(itemId))
				{
					list.Add(itemId);
				}
				if (num > 0)
				{
					if (expirePropList.ContainsKey(expire.Uuid))
					{
						expirePropList[expire.Uuid].Cover(expire.Uuid, itemId, expire.ExpireTime, num);
						continue;
					}
					KnapsackPropData propData = KnapsackPropData.Create(expire.Uuid, itemId, expire.ExpireTime, num);
					AddExpirePropData(propData, refreshSet: false);
				}
			}
		}
		RefreshExpireSetData(list);
	}

	private void InitExpiredData(List<PbExpireItem> expiredList)
	{
		if (expiredList == null)
		{
			return;
		}
		foreach (long key in expiredPropList.Keys.ToList())
		{
			if (!expiredList.Exists((PbExpireItem p) => p.ItemId == key))
			{
				expiredPropList.Remove(key);
			}
		}
		foreach (PbExpireItem expired in expiredList)
		{
			if (expired == null)
			{
				continue;
			}
			int itemId = expired.ItemId;
			int num = (int)expired.Count;
			DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(itemId);
			if (dataRow == null)
			{
				Log.Error($"请求背包数据，根据道具Id【{itemId}】没有找到相应的道具配置");
			}
			else
			{
				if (!KnapsackPropDataExtension.IsKnapsackType(dataRow.Type) || num <= 0)
				{
					continue;
				}
				if (expiredPropList.ContainsKey(itemId))
				{
					expiredPropList[itemId].Cover(expired.Uuid, itemId, expired.ExpireTime, num);
					continue;
				}
				KnapsackPropData knapsackPropData = KnapsackPropData.Create(expired.Uuid, itemId, expired.ExpireTime, num);
				if (!knapsackPropData.Empty)
				{
					expiredPropList.Add(knapsackPropData.Id, knapsackPropData);
				}
			}
		}
	}

	private KnapsackPropData GetExpirePropDataSet(int propId, bool emptyCreate = false)
	{
		if (expireSetDatas != null && expireSetDatas.ContainsKey(propId))
		{
			return expireSetDatas[propId];
		}
		List<KnapsackPropData> expirePropDataList = GetExpirePropDataList(propId);
		if ((expirePropDataList == null || expirePropDataList.Count <= 0) && !emptyCreate)
		{
			return null;
		}
		KnapsackPropData knapsackPropData = KnapsackPropData.CreateExpireSet(propId, expirePropDataList);
		if (knapsackPropData != null)
		{
			expireSetDatas?.Add(propId, knapsackPropData);
		}
		return knapsackPropData;
	}

	private List<KnapsackPropData> GetExpirePropDataList(int propId)
	{
		if (expirePropList != null)
		{
			return expirePropList.Values.ToList().FindAll((KnapsackPropData p) => p.Id == propId);
		}
		return new List<KnapsackPropData>();
	}

	private KnapsackPropData GetPermanentPropData(int propId, bool emptyCreate = false)
	{
		if (propList != null && propList.ContainsKey(propId))
		{
			return propList[propId];
		}
		if (emptyCreate)
		{
			KnapsackPropData knapsackPropData = KnapsackPropData.Create(propId, 0);
			if (knapsackPropData != null)
			{
				propList?.Add(propId, knapsackPropData);
				return knapsackPropData;
			}
		}
		return null;
	}

	private void AddExpirePropData(KnapsackPropData propData, bool refreshSet = true)
	{
		if (propData != null && !propData.Empty)
		{
			expirePropList.Add(propData.Uid, propData);
			if (refreshSet)
			{
				RefreshExpireSetData(propData.Id);
			}
		}
	}

	private void RemoveExpirePropData(long key, bool refreshSet = true)
	{
		int propId = (expiredPropList.ContainsKey(key) ? expiredPropList[key].Id : 0);
		if (expirePropList.Remove(key) & refreshSet)
		{
			RefreshExpireSetData(propId);
		}
	}

	private void RefreshExpireSetData(List<int> propIds)
	{
		if (propIds == null)
		{
			return;
		}
		foreach (int propId in propIds)
		{
			RefreshExpireSetData(propId);
		}
	}

	private void RefreshExpireSetData(int propId)
	{
		if (expireSetDatas.TryGetValue(propId, out var value))
		{
			List<KnapsackPropData> expirePropDataList = GetExpirePropDataList(propId);
			value?.RefreshChildList(expirePropDataList);
		}
	}

	private void Tick(long serverTimeStamp)
	{
		if (propList == null)
		{
			return;
		}
		foreach (KeyValuePair<long, KnapsackPropData> expireProp in expirePropList)
		{
			KnapsackPropData value = expireProp.Value;
			if (value != null)
			{
				value.UpdateExpireByServerTime(serverTimeStamp);
				if (expiredPropList.ContainsKey(value.Uid))
				{
					RemoveExpirePropData(expireProp.Key);
				}
				else if (!waitExpiredPropDatas.ContainsKey(value.Uid) && value.ExpireTimeStamp <= serverTimeStamp)
				{
					waitExpiredPropDatas.Add(value.Uid, value);
				}
			}
		}
		if (waitExpiredPropDatas.Count > 0)
		{
			ExpiredCheck();
		}
	}

	private async void ExpiredCheck()
	{
		if (expiredChecking)
		{
			return;
		}
		ITimeService service = Singleton<ServiceSystem>.Instance.GetService<ITimeService>();
		if (service == null || waitExpiredPropDatas == null || waitExpiredPropDatas.Count <= 0)
		{
			expiredChecking = false;
			return;
		}
		try
		{
			expiredChecking = true;
			long num = await service.GetServiceTime();
			if (num <= 0)
			{
				return;
			}
			List<long> list = new List<long>();
			foreach (KeyValuePair<long, KnapsackPropData> waitExpiredPropData in waitExpiredPropDatas)
			{
				KnapsackPropData value = waitExpiredPropData.Value;
				if (value.ExpireTimeStamp <= num)
				{
					list.Add(value.Uid);
				}
			}
			if (list.Count <= 0)
			{
				return;
			}
			foreach (long item in list)
			{
				waitExpiredPropDatas.TryGetValue(item, out var value2);
				if (value2 != null)
				{
					if (!expiredPropList.ContainsKey(item))
					{
						expiredPropList.Add(item, value2);
					}
					waitExpiredPropDatas.Remove(item);
					RemoveExpirePropData(item);
				}
			}
			Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.PublishPropChangeMessage(PropChangeMessageEnum.Expired, expiredPropList.Values.ToList());
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
		}
		finally
		{
			expiredChecking = false;
		}
	}

	private ObservableDictionary<long, KnapsackPropData> GetDataList(PropTimeLimitEnum timeLimitEnum)
	{
		if (timeLimitEnum != PropTimeLimitEnum.Permanent)
		{
			return expirePropList;
		}
		return propList;
	}

	private long GetDataKey(KnapsackPropData knapsackPropData)
	{
		if (knapsackPropData.PropTimeLimitEnum == PropTimeLimitEnum.Permanent)
		{
			return knapsackPropData.Id;
		}
		return knapsackPropData.Uid;
	}

	private KnapsackPropData InitKnapsackPropData(KnapsackPropData propData)
	{
		if (propData == null || propData.Empty)
		{
			return new KnapsackPropData();
		}
		if (propData.PropTimeLimitEnum == PropTimeLimitEnum.Permanent)
		{
			return KnapsackPropData.Create(propData.DrProp, propData.Amount, isNew: true);
		}
		return KnapsackPropData.Create(propData.Uid, propData.Id, propData.ExpireTimeStamp, propData.Amount, isNew: true);
	}

	private void Clear()
	{
		propList.Clear();
		expirePropList.Clear();
		waitExpiredPropDatas.Clear();
		expiredPropList.Clear();
		expireSetDatas.Clear();
	}

	protected override void Dispose(bool disposing)
	{
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.RemoveNormalSecondUpdateAction(Tick);
		Clear();
		base.Dispose(disposing);
	}

	private List<KnapsackPropData> GetAllPropList()
	{
		List<KnapsackPropData> list = new List<KnapsackPropData>();
		list.AddRange(propList.Values.ToList());
		list.AddRange(expirePropList.Values.ToList());
		return list;
	}

	private void DelExpirePropTemp(int propId)
	{
	}
}
