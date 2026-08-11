#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;

namespace Ase;

public class EquipmentService : IEquipmentService
{
	private ISubscription<AddEquipmentListNotify> subscription_AddEquips;

	private Dictionary<long, WeaponData> allWeaponsData = new Dictionary<long, WeaponData>();

	private Dictionary<long, ArmourData> allArmoursData = new Dictionary<long, ArmourData>();

	private Dictionary<int, int> weaponIdCount = new Dictionary<int, int>();

	private Dictionary<int, List<RockDevelopEntryItemData>> developEntryDic = new Dictionary<int, List<RockDevelopEntryItemData>>();

	private Dictionary<int, int> oldEntryDic;

	private long unselectSuitboxUuid;

	private List<KnapsackPropData> returnMaterialList = new List<KnapsackPropData>();

	public EquipmentService()
	{
		subscription_AddEquips = Singleton<NetworkSystem>.Instance.Subscribe<AddEquipmentListNotify>(AddEquips);
	}

	public async UniTask<bool> RequestEquipmentData()
	{
		allWeaponsData.Clear();
		allArmoursData.Clear();
		C2S_GetEquipmentListRequest c2SGetWeaponListRequest = C2S_GetEquipmentListRequest.Create();
		c2SGetWeaponListRequest.Typ = 5;
		S2C_GetEquipmentListResponse weaponResult = null;
		C2S_GetEquipmentListRequest c2SGetArmourListRequest = C2S_GetEquipmentListRequest.Create();
		c2SGetArmourListRequest.Typ = 2;
		S2C_GetEquipmentListResponse armourResult = null;
		C2S_GetEquipmentListRequest c2SGetSuitBoxListRequest = C2S_GetEquipmentListRequest.Create();
		c2SGetSuitBoxListRequest.Typ = 16;
		S2C_GetEquipmentListResponse suitBoxResult = null;
		try
		{
			weaponResult = await Singleton<NetworkSystem>.Instance.Call<S2C_GetEquipmentListResponse>(c2SGetWeaponListRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(weaponResult, "Equipment", "请求武魂数据失败"))
			{
				List<PbEquipBase> list = weaponResult.Equipments.ToList();
				foreach (PbEquipBase item in list)
				{
					await AddWeapon(item, isNew: false);
				}
				armourResult = await Singleton<NetworkSystem>.Instance.Call<S2C_GetEquipmentListResponse>(c2SGetArmourListRequest);
				if (Singleton<NetResponseHandler>.Instance.ValidateResponse(armourResult, "Equipment", "请求明饰数据失败"))
				{
					foreach (PbEquipBase item2 in armourResult.Equipments.ToList())
					{
						AddArmour(item2, isNew: false);
					}
					suitBoxResult = await Singleton<NetworkSystem>.Instance.Call<S2C_GetEquipmentListResponse>(c2SGetSuitBoxListRequest);
					if (Singleton<NetResponseHandler>.Instance.ValidateResponse(weaponResult, "Equipment", "请求护石数据失败"))
					{
						foreach (PbEquipBase item3 in suitBoxResult.Equipments.ToList())
						{
							AddArmour(item3, isNew: false);
						}
						unselectSuitboxUuid = suitBoxResult.UnselectSuitboxUuid;
						return true;
					}
					return false;
				}
				return false;
			}
			return false;
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error("获取Equipment数据失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			c2SGetWeaponListRequest.Dispose();
			weaponResult?.Dispose();
			c2SGetArmourListRequest.Dispose();
			armourResult?.Dispose();
			c2SGetSuitBoxListRequest.Dispose();
			suitBoxResult?.Dispose();
		}
	}

	public async UniTask<bool> RequestUsedEquipmentData()
	{
		allWeaponsData.Clear();
		allArmoursData.Clear();
		C2S_GetEquipmentListRequest c2SGetWeaponListRequest = C2S_GetEquipmentListRequest.Create();
		c2SGetWeaponListRequest.Typ = 10005;
		S2C_GetEquipmentListResponse weaponResult = null;
		C2S_GetEquipmentListRequest c2SGetArmourListRequest = C2S_GetEquipmentListRequest.Create();
		c2SGetArmourListRequest.Typ = 10002;
		S2C_GetEquipmentListResponse armourResult = null;
		C2S_GetEquipmentListRequest c2SGetSuitBoxListRequest = C2S_GetEquipmentListRequest.Create();
		c2SGetSuitBoxListRequest.Typ = 10016;
		S2C_GetEquipmentListResponse suitBoxResult = null;
		try
		{
			weaponResult = await Singleton<NetworkSystem>.Instance.Call<S2C_GetEquipmentListResponse>(c2SGetWeaponListRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(weaponResult, "Equipment", "请求武魂数据失败"))
			{
				List<PbEquipBase> list = weaponResult.Equipments.ToList();
				foreach (PbEquipBase item in list)
				{
					await AddWeapon(item, isNew: false);
				}
				armourResult = await Singleton<NetworkSystem>.Instance.Call<S2C_GetEquipmentListResponse>(c2SGetArmourListRequest);
				if (Singleton<NetResponseHandler>.Instance.ValidateResponse(armourResult, "Equipment", "请求明饰数据失败"))
				{
					foreach (PbEquipBase item2 in armourResult.Equipments.ToList())
					{
						AddArmour(item2, isNew: false);
					}
					suitBoxResult = await Singleton<NetworkSystem>.Instance.Call<S2C_GetEquipmentListResponse>(c2SGetSuitBoxListRequest);
					if (Singleton<NetResponseHandler>.Instance.ValidateResponse(weaponResult, "Equipment", "请求护石数据失败"))
					{
						foreach (PbEquipBase item3 in suitBoxResult.Equipments.ToList())
						{
							AddArmour(item3, isNew: false);
						}
						if (suitBoxResult.UnselectSuitboxUuid != 0L)
						{
							unselectSuitboxUuid = suitBoxResult.UnselectSuitboxUuid;
						}
						return true;
					}
					return false;
				}
				return false;
			}
			return false;
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error("获取Equipment数据失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			c2SGetWeaponListRequest.Dispose();
			weaponResult?.Dispose();
			c2SGetArmourListRequest.Dispose();
			armourResult?.Dispose();
			c2SGetSuitBoxListRequest.Dispose();
			suitBoxResult?.Dispose();
		}
	}

	public async UniTask<bool> RequestUnusedEquipmentData()
	{
		C2S_GetEquipmentListRequest c2SGetWeaponListRequest = C2S_GetEquipmentListRequest.Create();
		c2SGetWeaponListRequest.Typ = 20000;
		S2C_GetEquipmentListResponse weaponResult = null;
		try
		{
			weaponResult = await Singleton<NetworkSystem>.Instance.Call<S2C_GetEquipmentListResponse>(c2SGetWeaponListRequest);
			if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(weaponResult, "Equipment", "请求武魂数据失败"))
			{
				return false;
			}
			await UniTask.WaitUntil(() => weaponResult.UnselectSuitboxUuid <= allWeaponsData.Count + allArmoursData.Count);
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error("获取Equipment数据失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			c2SGetWeaponListRequest.Dispose();
			if (weaponResult != null)
			{
				weaponResult.Dispose();
				weaponResult = null;
			}
		}
		return true;
	}

	private async void AddEquips(AddEquipmentListNotify notify)
	{
		foreach (PbEquipBase equipment in notify.Equipments)
		{
			if (equipment.Type == 5)
			{
				await AddWeapon(equipment, isNew: false);
			}
			else if (equipment.Type == 2 || equipment.Type == 16)
			{
				AddArmour(equipment, isNew: false);
			}
		}
	}

	public Dictionary<long, WeaponData> GetAllWeaponData()
	{
		return allWeaponsData;
	}

	public Dictionary<long, ArmourData> GetAllArmourData()
	{
		return allArmoursData;
	}

	public WeaponData GetWeaponById(long uid)
	{
		allWeaponsData.TryGetValue(uid, out var value);
		return value;
	}

	public ArmourData GetArmourById(long uid)
	{
		allArmoursData.TryGetValue(uid, out var value);
		return value;
	}

	public List<ArmourData> GetArmourListByType(ArmourEnum armourType)
	{
		List<ArmourData> list = new List<ArmourData>();
		foreach (KeyValuePair<long, ArmourData> allArmoursDatum in allArmoursData)
		{
			if (allArmoursDatum.Value.ArmourEnum == armourType)
			{
				list.Add(allArmoursDatum.Value);
			}
		}
		return list;
	}

	public List<WeaponData> GetWeaponListByType(WeaponEnum weaponType)
	{
		List<WeaponData> list = new List<WeaponData>();
		foreach (KeyValuePair<long, WeaponData> allWeaponsDatum in allWeaponsData)
		{
			if (allWeaponsDatum.Value.WeaponEnum == weaponType)
			{
				list.Add(allWeaponsDatum.Value);
			}
		}
		return list;
	}

	public async UniTask<WeaponData> AddWeapon(PbEquipBase weapon, bool isNew = true)
	{
		WeaponData tempWeapon = CreateWeapon(weapon);
		if (tempWeapon != null)
		{
			tempWeapon.New = isNew;
		}
		if (tempWeapon != null && !allWeaponsData.ContainsKey(weapon.Uuid))
		{
			allWeaponsData.Add(weapon.Uuid, tempWeapon);
			if (weaponIdCount.ContainsKey(weapon.EquipId))
			{
				weaponIdCount[weapon.EquipId]++;
			}
			else
			{
				weaponIdCount.Add(weapon.EquipId, 1);
			}
			if (isNew && tempWeapon.Rarity >= 3 && !tempWeapon.IsLock && GameEntry.Setting.GetBool("自动锁定紫色武魂"))
			{
				await ChangeLock(5, tempWeapon.Uid);
			}
		}
		return tempWeapon;
	}

	public WeaponData CreateWeapon(PbEquipBase weapon)
	{
		return WeaponData.CreateWeaponData(ConvertEquipmentDataBase(weapon));
	}

	public WeaponData CreateWeapon(PbFloorSettingEquipmentInfo equipmentInfo, int refine)
	{
		List<AttributeBase> attributeBaseList = ConvertAttributeBaseList(equipmentInfo.Attribute);
		List<EntryBase> entryBaseList = ConvertEntryBaseList(equipmentInfo.Entries);
		WeaponData weaponData = WeaponData.CreateWeaponData(equipmentInfo.EquipmentId, attributeBaseList, entryBaseList, refine);
		weaponData.UpdateProperty();
		return weaponData;
	}

	public WeaponData CopyWeapon(WeaponData oriData)
	{
		WeaponData weaponData = WeaponData.CreateWeaponData(oriData.Id);
		List<EquipAttribute> list = new List<EquipAttribute>();
		foreach (EquipAttribute equipAttribute in oriData.EquipAttributeList)
		{
			list.Add(new EquipAttribute(equipAttribute));
		}
		weaponData.EquipAttributeList = list;
		List<EntryData> list2 = new List<EntryData>();
		foreach (EntryData entryData in oriData.EntryDataList)
		{
			list2.Add(new EntryData(entryData));
		}
		weaponData.EntryDataList = list2;
		weaponData.SetRefine(oriData.WeaponRefine);
		weaponData.UpdateProperty();
		return weaponData;
	}

	public ArmourData AddArmour(PbEquipBase armour, bool isNew = true)
	{
		ArmourData armourData = CreateArmour(armour);
		if (armourData != null)
		{
			armourData.New = isNew;
		}
		if (armourData != null && !allArmoursData.ContainsKey(armour.Uuid))
		{
			allArmoursData.Add(armour.Uuid, armourData);
		}
		return armourData;
	}

	public ArmourData CreateArmour(PbEquipBase armour)
	{
		EquipBase equipBase = ConvertEquipmentDataBase(armour);
		if (armour.Type != 2)
		{
			return ArmourData.CreateSuitBox(equipBase);
		}
		return ArmourData.CreateArmourData(equipBase);
	}

	public Dictionary<int, ArmourData> CreateAllArmourAndSuitbox(List<PbFloorSettingEquipmentInfo> armourInfos, PbFloorSettingEquipmentInfo suitBoxInfo)
	{
		Dictionary<int, ArmourData> dictionary = new Dictionary<int, ArmourData>();
		if (suitBoxInfo.EquipmentId != 0)
		{
			List<AttributeBase> attributeBaseList = ConvertAttributeBaseList(suitBoxInfo.Attribute);
			List<EntryBase> entryBaseList = ConvertEntryBaseList(suitBoxInfo.Entries);
			ArmourData armourData = ArmourData.CreateSuitBox(suitBoxInfo.EquipmentId, attributeBaseList, entryBaseList);
			if (armourData != null)
			{
				dictionary.Add(armourData.Id, armourData);
				armourData.UpdateProperty();
			}
		}
		for (int i = 0; i < armourInfos.Count; i++)
		{
			List<AttributeBase> attributeBaseList2 = ConvertAttributeBaseList(armourInfos[i].Attribute);
			List<EntryBase> entryBaseList2 = ConvertEntryBaseList(armourInfos[i].Entries);
			ArmourData armourData2 = ArmourData.CreateArmourData(armourInfos[i].EquipmentId, attributeBaseList2, entryBaseList2);
			armourData2?.UpdateProperty();
			dictionary.Add(armourData2.Id, armourData2);
		}
		return dictionary;
	}

	public Dictionary<int, ArmourData> CopyAllArmourAndSuitbox(Dictionary<int, ArmourData> allOriData)
	{
		Dictionary<int, ArmourData> dictionary = new Dictionary<int, ArmourData>();
		foreach (KeyValuePair<int, ArmourData> allOriDatum in allOriData)
		{
			if (allOriDatum.Value != null)
			{
				dictionary.Add(allOriDatum.Key, CopyArmour(allOriDatum.Value));
			}
		}
		return dictionary;
	}

	private ArmourData CopyArmour(ArmourData oriData)
	{
		ArmourData armourData = null;
		armourData = ((oriData.EquipmentEnum != EquipmentEnum.SuitBox) ? ArmourData.CreateArmourData(oriData.Id) : ArmourData.CreateSuitBox(oriData.Id));
		List<EquipAttribute> list = new List<EquipAttribute>();
		for (int i = 0; i < oriData.EquipAttributeList.Count; i++)
		{
			list.Add(new EquipAttribute(oriData.EquipAttributeList[i]));
		}
		armourData.EquipAttributeList = list;
		List<EntryData> list2 = new List<EntryData>();
		for (int j = 0; j < oriData.EntryDataList.Count; j++)
		{
			list2.Add(new EntryData(oriData.EntryDataList[j]));
		}
		armourData.EntryDataList = list2;
		List<EntryData> list3 = new List<EntryData>();
		for (int k = 0; k < oriData.AdditionalEntryList.Count; k++)
		{
			list3.Add(new EntryData(oriData.AdditionalEntryList[k]));
		}
		armourData.AdditionalEntryList = list3;
		armourData.UpdateProperty();
		return armourData;
	}

	private bool RemoveWeaponByUid(long uid)
	{
		if (allWeaponsData.ContainsKey(uid))
		{
			allWeaponsData.Remove(uid);
			return true;
		}
		return false;
	}

	private bool RemoveArmourByUid(long uid)
	{
		return allArmoursData.Remove(uid);
	}

	public async UniTask<bool> EquipUpgrade(EquipmentDataBase data, List<ItemResult> itemChange, List<long> equipChange, int coinNeed)
	{
		if (itemChange == null)
		{
			itemChange = new List<ItemResult>();
		}
		if (equipChange == null)
		{
			equipChange = new List<long>();
		}
		string tip = ((data.EquipmentEnum == EquipmentEnum.Weapon) ? "武魂" : "明饰");
		List<PbItemBase> list = new List<PbItemBase>();
		for (int i = 0; i < itemChange.Count; i++)
		{
			PbItemBase pbItemBase = new PbItemBase();
			pbItemBase.ItemId = itemChange[i].itemId;
			pbItemBase.ItemType = itemChange[i].itemType;
			pbItemBase.ItemCount = itemChange[i].itemCount;
			list.Add(pbItemBase);
		}
		C2S_UpgradeEquipRequest request = C2S_UpgradeEquipRequest.Create();
		request.EquipId = data.Id;
		request.EquipUuid = data.Uid;
		request.EquipType = (int)data.EquipmentEnum;
		request.Items = list;
		request.Equips = equipChange;
		request.SelectGold = coinNeed;
		S2C_UpgradeEquipResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_UpgradeEquipResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, tip ?? "", tip + "升级失败"))
			{
				List<PbEquipBase> list2 = response.EquipChange.ToList();
				PropHelper.AnalyzeRewardFromServer(response.ItemChange);
				for (int j = 0; j < list2.Count; j++)
				{
					if (allWeaponsData.ContainsKey(list2[j].Uuid))
					{
						allWeaponsData.Remove(list2[j].Uuid);
					}
					else if (allArmoursData.ContainsKey(list2[j].Uuid))
					{
						allArmoursData.Remove(list2[j].Uuid);
					}
					else
					{
						Toast.ShowError($"无法移除{tip}:{list2[j].Uuid};ID:{list2[j].EquipId}");
					}
				}
				EquipBase equipBase = ConvertEquipmentDataBase(response.Equip);
				if (data.EquipmentEnum == EquipmentEnum.Weapon)
				{
					WeaponData weaponData = allWeaponsData[data.Uid];
					weaponData.PbEquipAttributeConvert(equipBase.AttributeBaseList);
					weaponData.PbEquipEntryConvert(equipBase.EntryBaseList);
					weaponData.Exp = response.Equip.Exp;
					weaponData.Level = response.Equip.Level;
					allWeaponsData[data.Uid] = weaponData;
				}
				else
				{
					ArmourData armourData = allArmoursData[data.Uid];
					armourData.PbEquipAttributeConvert(equipBase.AttributeBaseList);
					armourData.Exp = response.Equip.Exp;
					armourData.Level = response.Equip.Level;
					allArmoursData[data.Uid] = armourData;
				}
				UpdateHeroAttribute(data.Uid);
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetMoneyData()?.AddMoney(MoneyEnum.Coin, (int)(-response.GoldCost));
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
			Log.Error(tip + "升级失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> WeaponUpStar(int weaponId, long weaponUid)
	{
		returnMaterialList.Clear();
		C2S_StarUpEquipmentRequest request = C2S_StarUpEquipmentRequest.Create();
		request.EquipId = weaponId;
		request.EquipUuid = weaponUid;
		S2C_StarUpEquipmentResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_StarUpEquipmentResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "武魂", "武魂升星失败"))
			{
				WeaponData weaponData = allWeaponsData[weaponUid];
				weaponData.SetStarUp(ConvertEquipmentDataBase(response.Equip));
				allWeaponsData[weaponUid] = weaponData;
				List<PbItemChange> list = response.ItemChange.ToList();
				List<KnapsackPropData> list2 = new List<KnapsackPropData>();
				for (int i = 0; i < list.Count; i++)
				{
					KnapsackPropData item = KnapsackPropData.Create(list[i].ItemId, (int)list[i].ItemDelta);
					list2.Add(item);
					if ((int)list[i].ItemDelta > 0)
					{
						returnMaterialList.Add(item);
					}
				}
				PropHelper.AnalyzeRewardFromServer(response.ItemChange);
				MoneyDefinition.AddMoney(RoleMoneyEnum.Coin, -response.GoldCost);
				UpdateHeroAttribute(weaponUid);
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
			Log.Error("武魂升星失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public List<KnapsackPropData> GetKnapsackPropDataList()
	{
		return returnMaterialList;
	}

	public async UniTask<bool> WeaponUpRefine(int weaponId, long weaponUid, List<long> equipUidList)
	{
		C2S_RefineUpEquipmentRequest request = C2S_RefineUpEquipmentRequest.Create();
		request.EquipId = weaponId;
		request.EquipUuid = weaponUid;
		request.Equips = equipUidList;
		S2C_RefineUpEquipmentResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_RefineUpEquipmentResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "武魂", "武魂精炼失败"))
			{
				WeaponData weaponData = allWeaponsData[weaponUid];
				weaponData.SetRefine(response.EquipRefine);
				allWeaponsData[weaponUid] = weaponData;
				List<PbEquipBase> list = response.EquipChange.ToList();
				for (int i = 0; i < list.Count; i++)
				{
					RemoveWeaponByUid(list[i].Uuid);
				}
				UpdateHeroAttribute(weaponUid);
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
			Log.Error("武魂精炼失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	private void UpdateHeroAttribute(long uid)
	{
		Singleton<ServiceSystem>.Instance.GetService<IHeroService>().UpdateHeroEquip(uid);
	}

	public async UniTask<bool> ChangeLock(int type, long uid)
	{
		C2H_LockEquipmentRequest request = C2H_LockEquipmentRequest.Create();
		request.EquipType = type;
		request.EquipUuid = uid;
		string tip = "明饰";
		switch (type)
		{
		case 5:
			tip = "武魂";
			break;
		case 16:
			tip = "手提箱";
			break;
		}
		H2C_LockEquipmentResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_LockEquipmentResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "设置" + tip + "锁定状态", showToast: false))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "设置" + tip + "锁定状态失败", showToast: false))
				{
					switch (type)
					{
					case 5:
						allWeaponsData[uid].IsLock = !allWeaponsData[uid].IsLock;
						break;
					case 2:
					case 16:
						allArmoursData[uid].IsLock = !allArmoursData[uid].IsLock;
						break;
					}
					UpdateHeroAttribute(uid);
					return true;
				}
				if (response.Error == 200014)
				{
					Toast.ShowInfo("无法锁定此" + tip);
				}
				else if (response.Error == 200148)
				{
					Toast.ShowInfo("无法锁定此手提箱");
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error("武魂精炼失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public void RemoveEquipments(List<long> uids)
	{
		if (uids == null)
		{
			return;
		}
		foreach (long uid in uids)
		{
			if (!RemoveWeaponByUid(uid))
			{
				RemoveArmourByUid(uid);
			}
		}
	}

	public async UniTask<bool> UnLockArmourEntry(long equipUid)
	{
		C2H_UnlockArmourEntryRequest request = new C2H_UnlockArmourEntryRequest
		{
			EquipUuid = equipUid,
			EntryIndex = -1
		};
		H2C_UnlockArmourEntryResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_UnlockArmourEntryResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "明饰", "解锁明饰词条"))
			{
				List<EntryData> list = new List<EntryData>();
				foreach (PbEntryBase entry in response.Equip.Entries)
				{
					if (entry != null)
					{
						EntryData entryData = new EntryData(entry.Id, entry.Level);
						if (entryData.IsRealData)
						{
							list.Add(entryData);
						}
					}
				}
				allArmoursData[equipUid].SetAdditionalEntryList(list);
				List<EntryBase> list2 = new List<EntryBase>();
				foreach (PbEntryBase cacheEntry in response.Equip.CacheEntries)
				{
					EntryBase item = default(EntryBase);
					if (cacheEntry == null)
					{
						item.Id = 0;
					}
					else
					{
						item.Id = cacheEntry.Id;
						item.Level = cacheEntry.Level;
					}
					list2.Add(item);
				}
				allArmoursData[equipUid].SetBackUpEntryList(list2);
				UpdateHeroAttribute(equipUid);
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetMoneyData()?.AddMoney(MoneyEnum.Coin, -response.GoldCost);
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
			Log.Error("解锁明饰词条，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> ResetArmourEntry(long equipUid, int entryIndex, int poolIndex, int type)
	{
		C2H_ReplaceArmourEntryRequest request = new C2H_ReplaceArmourEntryRequest
		{
			EquipUuid = equipUid,
			EntryIndex = entryIndex,
			PoolIndex = poolIndex,
			Type = type
		};
		H2C_ReplaceArmourEntryResponse response = null;
		string tip = ((type == 1) ? "更换词条失败!" : "刷新词条失败!");
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_ReplaceArmourEntryResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "明饰词条", "tip"))
			{
				List<EntryData> list = new List<EntryData>();
				if (response.Equip.Entries != null)
				{
					foreach (PbEntryBase entry in response.Equip.Entries)
					{
						if (entry != null)
						{
							list.Add(new EntryData(entry.Id, entry.Level));
						}
					}
					allArmoursData[equipUid].SetAdditionalEntryList(list);
				}
				List<EntryBase> list2 = new List<EntryBase>();
				foreach (PbEntryBase cacheEntry in response.Equip.CacheEntries)
				{
					EntryBase item = default(EntryBase);
					if (cacheEntry == null)
					{
						item.Id = 0;
					}
					else
					{
						item.Id = cacheEntry.Id;
						item.Level = cacheEntry.Level;
					}
					list2.Add(item);
				}
				allArmoursData[equipUid].SetBackUpEntryList(list2);
				UpdateHeroAttribute(equipUid);
				PropHelper.AnalyzeRewardFromServer(response.ItemChange);
				MoneyDefinition.AddMoney(RoleMoneyEnum.Coin, -response.GoldCost);
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
			Log.Error(tip + "，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RefreshArmourAffixRst(long equipUid)
	{
		C2H_CarvingArmourAttributeRequest request = new C2H_CarvingArmourAttributeRequest
		{
			EquipUuid = equipUid
		};
		H2C_CarvingArmourAttributeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_CarvingArmourAttributeResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "明饰", "刷新明饰副属性"))
			{
				if (allArmoursData.ContainsKey(equipUid))
				{
					allArmoursData[equipUid].PbEquipAttributeConvert(ConvertAttributeBaseList(response.Equip.Attribute));
					allArmoursData[equipUid].UpdateProperty();
					UpdateHeroAttribute(equipUid);
				}
				PropHelper.AnalyzeRewardFromServer(response.ItemChange);
				MoneyDefinition.AddMoney(RoleMoneyEnum.Coin, -response.GoldCost);
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
			Log.Error("发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public Dictionary<int, List<RockDevelopEntryItemData>> GetDevelopEntryDic()
	{
		return developEntryDic;
	}

	public Dictionary<int, int> GetOldEntryDic()
	{
		return oldEntryDic;
	}

	public async UniTask<bool> MakeSuitBox(long suitBoxId, int propId, List<EntryData> oldEntryList, int costCoin)
	{
		developEntryDic.Clear();
		MakeSuitBoxRequest request = new MakeSuitBoxRequest
		{
			SuitBoxId = suitBoxId,
			StoneId = propId
		};
		MakeSuitBoxResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<MakeSuitBoxResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "护石打造", "打造护石失败"))
			{
				oldEntryDic = new Dictionary<int, int>();
				foreach (EntryData oldEntry in oldEntryList)
				{
					oldEntryDic.Add(oldEntry.DrEntry.EntryId, oldEntry.CurLevel);
				}
				for (int i = 0; i < response.Results.Count; i++)
				{
					Dictionary<int, int> dictionary = new Dictionary<int, int>();
					List<RockDevelopEntryItemData> list = new List<RockDevelopEntryItemData>();
					EntryData entryData = allArmoursData[suitBoxId].EntryDataList[0];
					RockDevelopEntryItemData rockDevelopEntryItemData = new RockDevelopEntryItemData(null, entryData);
					rockDevelopEntryItemData.SetIsNew(isNew: false, entryData.CurLevel);
					list.Add(rockDevelopEntryItemData);
					foreach (PbEntryBase item in response.Results[i].EntryResult)
					{
						dictionary.Add(item.Id, item.Level);
						EntryData entryData2 = new EntryData(item.Id, item.Level);
						RockDevelopEntryItemData rockDevelopEntryItemData2 = new RockDevelopEntryItemData(null, entryData2);
						bool flag = !oldEntryDic.ContainsKey(item.Id);
						int oldLevel = (flag ? item.Level : oldEntryDic[item.Id]);
						rockDevelopEntryItemData2.SetIsNew(flag, oldLevel);
						list.Add(rockDevelopEntryItemData2);
					}
					foreach (EntryData oldEntry2 in oldEntryList)
					{
						if (!dictionary.ContainsKey(oldEntry2.DrEntry.EntryId))
						{
							RockDevelopEntryItemData rockDevelopEntryItemData3 = new RockDevelopEntryItemData(null, oldEntry2);
							rockDevelopEntryItemData3.SetDisMiss(isMiss: true, oldEntry2.CurLevel);
							list.Add(rockDevelopEntryItemData3);
						}
					}
					developEntryDic.Add(response.Results[i].Idx, list);
				}
				UpdateHeroAttribute(suitBoxId);
				KnapsackPropData propData = KnapsackPropData.Create(propId, -1);
				Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().AddProp(propData);
				MoneyDefinition.AddMoney(RoleMoneyEnum.Coin, -costCoin);
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
			Log.Error("打造护石失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> SelectSuitBox(int index, long uid)
	{
		SelectSuitboxMakeIndexRequest request = new SelectSuitboxMakeIndexRequest
		{
			SelectIdx = index,
			SuitboxUuid = uid
		};
		SelectSuitboxMakeIndexResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SelectSuitboxMakeIndexResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "护石", "选择护石失败"))
			{
				unselectSuitboxUuid = 0L;
				developEntryDic.Clear();
				List<EntryData> list = new List<EntryData>();
				if (response.NewSuitbox.Entries != null)
				{
					foreach (PbEntryBase entry in response.NewSuitbox.Entries)
					{
						if (entry != null)
						{
							list.Add(new EntryData(entry.Id, entry.Level));
						}
					}
					allArmoursData[uid].SetAdditionalEntryList(list);
				}
				UpdateHeroAttribute(uid);
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
			Log.Error("获取活跃度数据失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public long GetUnselectSuitBox()
	{
		return unselectSuitboxUuid;
	}

	public async UniTask<bool> EnterMakeSuitBox(long uid, List<EntryData> oldEntryList)
	{
		developEntryDic.Clear();
		EnterMakeSuitboxPanelRequest request = new EnterMakeSuitboxPanelRequest();
		EnterMakeSuitboxPanelResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<EnterMakeSuitboxPanelResponse>(request);
			oldEntryDic = new Dictionary<int, int>();
			foreach (EntryData oldEntry in oldEntryList)
			{
				oldEntryDic.Add(oldEntry.DrEntry.EntryId, oldEntry.CurLevel);
			}
			for (int i = 0; i < response.Results.Count; i++)
			{
				Dictionary<int, int> dictionary = new Dictionary<int, int>();
				List<RockDevelopEntryItemData> list = new List<RockDevelopEntryItemData>();
				EntryData entryData = allArmoursData[uid].EntryDataList[0];
				RockDevelopEntryItemData rockDevelopEntryItemData = new RockDevelopEntryItemData(null, entryData);
				rockDevelopEntryItemData.SetIsNew(isNew: false, entryData.CurLevel);
				list.Add(rockDevelopEntryItemData);
				foreach (PbEntryBase item in response.Results[i].EntryResult)
				{
					dictionary.Add(item.Id, item.Level);
					EntryData entryData2 = new EntryData(item.Id, item.Level);
					RockDevelopEntryItemData rockDevelopEntryItemData2 = new RockDevelopEntryItemData(null, entryData2);
					bool flag = !oldEntryDic.ContainsKey(item.Id);
					int oldLevel = (flag ? item.Level : oldEntryDic[item.Id]);
					rockDevelopEntryItemData2.SetIsNew(flag, oldLevel);
					list.Add(rockDevelopEntryItemData2);
				}
				foreach (EntryData oldEntry2 in oldEntryList)
				{
					if (!dictionary.ContainsKey(oldEntry2.DrEntry.EntryId))
					{
						RockDevelopEntryItemData rockDevelopEntryItemData3 = new RockDevelopEntryItemData(null, oldEntry2);
						rockDevelopEntryItemData3.SetDisMiss(isMiss: true, oldEntry2.CurLevel);
						list.Add(rockDevelopEntryItemData3);
					}
				}
				developEntryDic.Add(response.Results[i].Idx, list);
			}
			return true;
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error("获取护石，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
	}

	public async UniTask<(bool, RewardGetData)> RequestMakeCustomEquip(int usePropId, int targetEquipId, int mainAttrId, List<int> subAttrIds)
	{
		C2H_MakeCustomEquipment request = new C2H_MakeCustomEquipment
		{
			UsedItemId = usePropId,
			EquipmentId = targetEquipId,
			MainAttributeId = mainAttrId,
			SubAttributeIds = subAttrIds
		};
		H2C_MakeCustomEquipment response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_MakeCustomEquipment>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "自选防具") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "自选防具失败"))
			{
				PropHelper.AnalyzeRewardFromServer(new List<PbItemChange> { response.PackItem });
				return (true, await PropHelper.AnalyzeRewardFromServer(new List<PbEquipBase> { response.EquipmentInfo }));
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return (false, null);
		}
		catch (Exception ex2)
		{
			Log.Error("防具自选，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return (false, null);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return (false, null);
	}

	public async UniTask<List<ArmourPresetSlotData>> GetPresetEquipments(int roleId)
	{
		C2S_GetPresetEquipment request = C2S_GetPresetEquipment.Create();
		request.RoleIds = new List<int> { roleId };
		S2C_GetPresetEquipment response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_GetPresetEquipment>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取预设") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取预设失败"))
			{
				List<ArmourPresetSlotData> list = new List<ArmourPresetSlotData>();
				if (response.Infos == null)
				{
					return list;
				}
				for (int i = 0; i < response.Infos.Count; i++)
				{
					PbRolePresetEquipmentInfo pbRolePresetEquipmentInfo = response.Infos[i];
					if (pbRolePresetEquipmentInfo == null || pbRolePresetEquipmentInfo.RoleId != roleId || pbRolePresetEquipmentInfo.Slots == null)
					{
						continue;
					}
					for (int j = 0; j < pbRolePresetEquipmentInfo.Slots.Count; j++)
					{
						ArmourPresetSlotData armourPresetSlotData = CreatePresetSlotData(roleId, pbRolePresetEquipmentInfo.Slots[j]);
						if (armourPresetSlotData != null)
						{
							list.Add(armourPresetSlotData);
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
			Log.Error("获取预设，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<ArmourPresetSlotData> SetPresetEquipment(int roleId, ArmourPresetSlotData slotData)
	{
		C2S_SetPresetEquipment request = C2S_SetPresetEquipment.Create();
		request.RoleId = roleId;
		request.Slot = CreatePresetSlotInfo(slotData);
		S2C_SetPresetEquipment response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_SetPresetEquipment>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "保存预设") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "保存预设失败"))
			{
				return (response.Slot != null) ? CreatePresetSlotData(roleId, response.Slot) : CreatePresetSlotData(roleId, request.Slot);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("保存预设，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<ArmourPresetSlotData> RenamePresetEquipment(int roleId, ArmourPresetSlotData slotData, string presetName)
	{
		if (slotData == null)
		{
			return null;
		}
		C2S_RenamePresetEquipment request = C2S_RenamePresetEquipment.Create();
		request.RoleId = roleId;
		request.SlotId = slotData.SlotId;
		request.PresetName = presetName;
		S2C_RenamePresetEquipment response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_RenamePresetEquipment>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "重命名预设") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "重命名预设失败"))
			{
				if (response.Slot != null)
				{
					return CreatePresetSlotData(roleId, response.Slot);
				}
				ArmourPresetSlotData armourPresetSlotData = new ArmourPresetSlotData(roleId, slotData.SlotId, presetName, slotData.IsCreated);
				foreach (KeyValuePair<int, long> item in slotData.EquipmentUidsByPosition)
				{
					armourPresetSlotData.SetEquipment(item.Key, item.Value);
				}
				return armourPresetSlotData;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("重命名预设，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<ArmourPresetSlotData> DeletePresetEquipment(int roleId, int slotId)
	{
		C2S_DeletePresetEquipment request = C2S_DeletePresetEquipment.Create();
		request.RoleId = roleId;
		request.SlotId = slotId;
		S2C_DeletePresetEquipment response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_DeletePresetEquipment>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "删除预设") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "删除预设失败"))
			{
				return (response.Slot != null) ? CreatePresetSlotData(roleId, response.Slot) : new ArmourPresetSlotData(roleId, slotId, ArmourPresetSlotData.GetDefaultName(slotId), isCreated: false);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("删除预设，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	public async UniTask<ArmourPresetApplyResultData> ApplyPresetEquipment(int roleId, int slotId, bool forceApply = true)
	{
		C2S_ApplyPresetEquipment request = C2S_ApplyPresetEquipment.Create();
		request.RoleId = roleId;
		request.SlotId = slotId;
		request.ForceApply = forceApply;
		S2C_ApplyPresetEquipment response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_ApplyPresetEquipment>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "应用预设") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "应用预设失败"))
			{
				ArmourPresetApplyResultData result = new ArmourPresetApplyResultData();
				if (response.Conflicts != null)
				{
					for (int i = 0; i < response.Conflicts.Count; i++)
					{
						PbPresetEquipmentConflictInfo pbPresetEquipmentConflictInfo = response.Conflicts[i];
						if (pbPresetEquipmentConflictInfo != null)
						{
							result.Conflicts.Add(new ArmourPresetConflictData(pbPresetEquipmentConflictInfo.ThingType, pbPresetEquipmentConflictInfo.Position, pbPresetEquipmentConflictInfo.EquipmentUuid, pbPresetEquipmentConflictInfo.EquippedRoleId));
						}
					}
				}
				if (!result.HasConflicts)
				{
					await RefreshPresetApplyResult(response);
				}
				return result;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("应用预设，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return null;
	}

	private ArmourPresetSlotData CreatePresetSlotData(int roleId, PbPresetEquipmentSlotInfo pbSlot)
	{
		if (pbSlot == null)
		{
			return null;
		}
		int slotId = pbSlot.SlotId;
		ArmourPresetSlotData armourPresetSlotData = new ArmourPresetSlotData(roleId, slotId, string.IsNullOrEmpty(pbSlot.PresetName) ? ArmourPresetSlotData.GetDefaultName(slotId) : pbSlot.PresetName, pbSlot.IsCreated);
		if (pbSlot.Equipments != null)
		{
			for (int i = 0; i < pbSlot.Equipments.Count; i++)
			{
				PbPresetEquipmentItemInfo pbPresetEquipmentItemInfo = pbSlot.Equipments[i];
				if (pbPresetEquipmentItemInfo != null && pbPresetEquipmentItemInfo.EquipmentUuid > 0)
				{
					armourPresetSlotData.SetEquipment(pbPresetEquipmentItemInfo.Position, pbPresetEquipmentItemInfo.EquipmentUuid);
				}
			}
		}
		return armourPresetSlotData;
	}

	private PbPresetEquipmentSlotInfo CreatePresetSlotInfo(ArmourPresetSlotData slotData)
	{
		PbPresetEquipmentSlotInfo pbPresetEquipmentSlotInfo = PbPresetEquipmentSlotInfo.Create(isFromPool: false);
		if (slotData == null)
		{
			return pbPresetEquipmentSlotInfo;
		}
		pbPresetEquipmentSlotInfo.SlotId = slotData.SlotId;
		pbPresetEquipmentSlotInfo.IsCreated = slotData.IsCreated;
		pbPresetEquipmentSlotInfo.PresetName = (string.IsNullOrEmpty(slotData.PresetName) ? ArmourPresetSlotData.GetDefaultName(slotData.SlotId) : slotData.PresetName);
		pbPresetEquipmentSlotInfo.Equipments = new List<PbPresetEquipmentItemInfo>();
		foreach (KeyValuePair<int, long> item in slotData.EquipmentUidsByPosition)
		{
			if (item.Value > 0)
			{
				PbPresetEquipmentItemInfo pbPresetEquipmentItemInfo = PbPresetEquipmentItemInfo.Create(isFromPool: false);
				pbPresetEquipmentItemInfo.ThingType = ((item.Key == 5) ? 16 : 2);
				pbPresetEquipmentItemInfo.Position = item.Key;
				pbPresetEquipmentItemInfo.EquipmentUuid = item.Value;
				pbPresetEquipmentSlotInfo.Equipments.Add(pbPresetEquipmentItemInfo);
			}
		}
		return pbPresetEquipmentSlotInfo;
	}

	private async UniTask RefreshPresetApplyResult(S2C_ApplyPresetEquipment response)
	{
		if (response == null)
		{
			return;
		}
		if (response.RoleInfos != null)
		{
			for (int i = 0; i < response.RoleInfos.Count; i++)
			{
				await Singleton<ServiceSystem>.Instance.GetService<IHeroService>().AddHero(response.RoleInfos[i]);
			}
		}
		if (response.EquipInfos != null)
		{
			for (int j = 0; j < response.EquipInfos.Count; j++)
			{
				AddArmour(response.EquipInfos[j]);
			}
		}
	}

	public bool CheckWeaponId(int weaponId)
	{
		List<long> collection = Singleton<ServiceSystem>.Instance.GetService<IGameNoteService>().GetCollection();
		if (!weaponIdCount.ContainsKey(weaponId))
		{
			return collection.Contains(weaponId);
		}
		return true;
	}

	private EquipBase ConvertEquipmentDataBase(PbEquipBase pbEquipBase)
	{
		EquipBase result = new EquipBase
		{
			Type = pbEquipBase.Type,
			EquipId = pbEquipBase.EquipId,
			Uuid = pbEquipBase.Uuid,
			RoleId = pbEquipBase.RoleId,
			Level = pbEquipBase.Level,
			Exp = pbEquipBase.Exp,
			Locked = pbEquipBase.Locked,
			Star = pbEquipBase.Star,
			Refine = pbEquipBase.Refine,
			Rank = pbEquipBase.Rank,
			SubType = pbEquipBase.SubType,
			AttributeBaseList = ConvertAttributeBaseList(pbEquipBase.Attribute),
			EntryBaseList = ConvertEntryBaseList(pbEquipBase.Entries),
			BackUpEntryList = new List<EntryBase>()
		};
		foreach (PbEntryBase cacheEntry in pbEquipBase.CacheEntries)
		{
			EntryBase item = default(EntryBase);
			if (cacheEntry == null)
			{
				item.Id = 0;
			}
			else
			{
				item.Id = cacheEntry.Id;
				item.Level = cacheEntry.Level;
			}
			result.BackUpEntryList.Add(item);
		}
		return result;
	}

	private List<AttributeBase> ConvertAttributeBaseList(List<PbAttributeBase> equipAttributeBase)
	{
		List<AttributeBase> list = new List<AttributeBase>();
		foreach (PbAttributeBase item in equipAttributeBase)
		{
			list.Add(new AttributeBase
			{
				Id = item.Id,
				Value = item.Value
			});
		}
		return list;
	}

	private List<AttributeBase> ConvertAttributeBaseList(List<PbIdValue> equipAttributeBase)
	{
		List<AttributeBase> list = new List<AttributeBase>();
		foreach (PbIdValue item in equipAttributeBase)
		{
			list.Add(new AttributeBase
			{
				Id = item.Id,
				Value = item.Value
			});
		}
		return list;
	}

	private List<EntryBase> ConvertEntryBaseList(List<PbEntryBase> pbEntryBaseList)
	{
		List<EntryBase> list = new List<EntryBase>();
		foreach (PbEntryBase pbEntryBase in pbEntryBaseList)
		{
			if (pbEntryBase != null)
			{
				list.Add(new EntryBase
				{
					Id = pbEntryBase.Id,
					Level = pbEntryBase.Level
				});
			}
		}
		return list;
	}

	private List<EntryBase> ConvertEntryBaseList(List<PbIdValue> pbEntryBaseList)
	{
		List<EntryBase> list = new List<EntryBase>();
		foreach (PbIdValue pbEntryBase in pbEntryBaseList)
		{
			if (pbEntryBase != null)
			{
				list.Add(new EntryBase
				{
					Id = pbEntryBase.Id,
					Level = pbEntryBase.Value
				});
			}
		}
		return list;
	}
}
