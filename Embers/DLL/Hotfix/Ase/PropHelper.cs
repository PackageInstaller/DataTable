#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;

namespace Ase;

public static class PropHelper
{
	public static OpenViewArg OpenPopupWindow(PropDataBase dataBase, OptionBase parent, Action callBack = null, bool showOutsideMask = true, bool showOwnCount = true, bool allowSkipWindow = true, string groupName = "DEFAULT")
	{
		PropTypeEnum propTypeEnum = dataBase.PropTypeEnum;
		switch (propTypeEnum)
		{
		case PropTypeEnum.Title:
		case PropTypeEnum.HeadDecorate:
		case PropTypeEnum.ChatEmoji:
		case PropTypeEnum.ChatBubble:
		case PropTypeEnum.BattleEmoji:
		{
			DecoratePopupViewModel userData2 = new DecoratePopupViewModel(parent, dataBase);
			return new OpenViewArg(typeof(DecoratePopupView), userData2, parent.GetType().ToString(), isOpenWindow: true, groupName, callBack);
		}
		case PropTypeEnum.CardFrame:
		{
			RectDecoratePopViewModel userData3 = new RectDecoratePopViewModel(parent, dataBase);
			return new OpenViewArg(typeof(RectDecoratePopWindow), userData3, parent.GetType().ToString(), isOpenWindow: true, groupName, callBack);
		}
		case PropTypeEnum.Weapon:
			if (dataBase is WeaponData weaponData)
			{
				WeaponPopupViewModel userData = new WeaponPopupViewModel(parent, weaponData, showHeroInfo: false, 0f, 0f, showMask1: true, showMask2: false);
				return new OpenViewArg(typeof(WeaponPopupWindow), userData, parent.GetType().ToString(), isOpenWindow: true, groupName, callBack);
			}
			break;
		}
		if (propTypeEnum == PropTypeEnum.Equipment && dataBase is ArmourData armourData)
		{
			ArmourPopupViewModel userData4 = new ArmourPopupViewModel(parent, armourData, showHeroInfo: false, 0f, 0f, showOutsideMask);
			return new OpenViewArg(typeof(ArmourPopupWindow), userData4, parent.GetType().ToString(), isOpenWindow: true, groupName, callBack);
		}
		if (propTypeEnum == PropTypeEnum.SuitBox && dataBase is ArmourData armourData2)
		{
			SuitBoxPreviewUtil.FillPreviewEntriesIfEmpty(armourData2);
			RockPopupViewModel rockPopupViewModel = new RockPopupViewModel(parent, armourData2);
			rockPopupViewModel.LoadDefaultEntry();
			return new OpenViewArg(typeof(RockPopupWindow), rockPopupViewModel, parent.GetType().ToString(), isOpenWindow: true, groupName, callBack);
		}
		int num;
		switch (propTypeEnum)
		{
		case PropTypeEnum.Hero:
		{
			HeroCultivatePreviewViewModel userData7 = new HeroCultivatePreviewViewModel(parent, dataBase.Id, 0);
			return new OpenViewArg(typeof(HeroCultivatePreviewWindow), userData7, parent.GetType().ToString(), isOpenWindow: true, groupName, callBack);
		}
		case PropTypeEnum.GiftPack:
		{
			PackPopupViewModel userData6 = new PackPopupViewModel(parent, dataBase);
			return new OpenViewArg(typeof(PackPopupWindow), userData6, parent.GetType().ToString(), isOpenWindow: true, groupName, callBack);
		}
		case PropTypeEnum.HeroSkin:
		{
			DRUIHeroSkin dataRow = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(dataBase.Id);
			HeroSkinPopupViewModel userData5 = new HeroSkinPopupViewModel(parent, dataRow);
			return new OpenViewArg(typeof(HeroSkinPopupWindow), userData5, parent.GetType().ToString(), isOpenWindow: true, groupName, callBack);
		}
		default:
			num = ((propTypeEnum != PropTypeEnum.Passport) ? 1 : 0);
			break;
		case PropTypeEnum.AccountExp:
			num = 0;
			break;
		}
		bool showOwnCount2 = (byte)((uint)num & (showOwnCount ? 1u : 0u)) != 0;
		PropWindowViewModel propWindowViewModel = new PropWindowViewModel(parent, showOutsideMask, showOwnCount2, allowSkipWindow);
		propWindowViewModel.RefreshData(dataBase);
		return new OpenViewArg(typeof(PropPopupWindow), propWindowViewModel, parent.GetType().ToString(), isOpenWindow: true, groupName, callBack);
	}

	public static bool CheckPropEnough(int propId, int needCount)
	{
		return GetPropOwnedCount(propId) >= needCount;
	}

	public static int GetChangeNameCardId()
	{
		return Constant.ConstantConfig.ChangeNameCard;
	}

	public static int GetPropOwnedCount(int propId)
	{
		int num = 0;
		if (Enum.IsDefined(typeof(RoleMoneyEnum), propId))
		{
			return (int)MoneyDefinition.GetMoneyCount(propId);
		}
		if (propId == GuildDefinition.GetGuildFundPropId())
		{
			return (Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.GetMyGuildData()?.Funds).GetValueOrDefault();
		}
		return (Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.GetKnapsackViewModel()?.GetProp(propId))?.Amount ?? 0;
	}

	public static async Task<RewardGetData> AnalyzeRewardFromServer(PbDropThing dropThing, bool rewardInPack = true)
	{
		RewardGetData data = new RewardGetData();
		if (dropThing == null)
		{
			return data;
		}
		foreach (PbItemBase item3 in dropThing.Items)
		{
			PropDataBase propDataBase = PropDataBase.CreateByType(item3.ItemType, item3.ItemId, (int)item3.ItemCount);
			if (propDataBase == null || propDataBase.Empty)
			{
				continue;
			}
			if (item3.ItemType == 11 || item3.ItemType == 12)
			{
				data.PropList.Add(propDataBase);
				continue;
			}
			if (item3.ItemType == 13)
			{
				data.PropList.Add(propDataBase);
				continue;
			}
			if (Enum.IsDefined(typeof(RoleMoneyEnum), item3.ItemId))
			{
				if (rewardInPack)
				{
					MoneyDefinition.AddMoney(item3.ItemId, item3.ItemCount);
				}
				if (item3.ItemCount > 0)
				{
					data.PropList.Add(propDataBase);
				}
				continue;
			}
			if (item3.ItemType == 20)
			{
				if (rewardInPack)
				{
					if (Singleton<ServiceSystem>.Instance.GetService<IHeroService>().AddHeroSkin(item3.ItemId))
					{
						data.HeroSkinList.Add(item3.ItemId);
					}
				}
				else
				{
					data.HeroSkinList.Add(item3.ItemId);
				}
				continue;
			}
			if (item3.ItemType == 4)
			{
				HeroRewardInfo heroRewardInfo = null;
				foreach (PbNormalRoleInfo role in dropThing.Roles)
				{
					if (role.RoleId == item3.ItemId)
					{
						heroRewardInfo = GetHeroRewardInfo(item3.ItemId, role, rewardInPack);
						break;
					}
				}
				if (heroRewardInfo == null)
				{
					heroRewardInfo = GetHeroRewardInfo(item3.ItemId, null, rewardInPack);
				}
				data.HeroRewardInfos.Add(heroRewardInfo);
				continue;
			}
			if (item3.ItemType == 21)
			{
				DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(item3.ItemId);
				if (dataRow != null)
				{
					if (dataRow.UseType.Contains(80) & rewardInPack)
					{
						Singleton<ServiceSystem>.Instance.GetService<IShopService>()?.RequestGetMonthlyCardInfo();
					}
					data.PropList.Add(propDataBase);
				}
				continue;
			}
			if (item3.ItemType == 25 || item3.ItemType == 24 || item3.ItemType == 26 || item3.ItemType == 22 || item3.ItemType == 28)
			{
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.SetItemNew((PropTypeEnum)item3.ItemType, item3.ItemId);
				data.PropList.Add(propDataBase);
				continue;
			}
			KnapsackPropData knapsackPropData = KnapsackPropData.Create(item3.ItemId, (int)item3.ItemCount);
			if (knapsackPropData != null && !knapsackPropData.Empty)
			{
				if (rewardInPack)
				{
					Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().AddProp(knapsackPropData);
				}
				if (item3.ItemCount > 0)
				{
					data.PropList.Add(knapsackPropData);
				}
			}
		}
		IEquipmentService equipService = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>();
		foreach (PbEquipBase equip in dropThing.Equips)
		{
			if (equip.Type == 16 || equip.Type == 2)
			{
				ArmourData item = (rewardInPack ? equipService.AddArmour(equip) : equipService.CreateArmour(equip));
				data.PropList.Add(item);
			}
			else if (equip.Type == 5)
			{
				WeaponData weaponData = ((!rewardInPack) ? equipService.CreateWeapon(equip) : (await equipService.AddWeapon(equip)));
				WeaponData item2 = weaponData;
				data.PropList.Add(item2);
			}
		}
		foreach (PbNormalRoleInfo role2 in dropThing.Roles)
		{
			HeroModel heroModel = HeroModel.CreateByPbData(role2);
			if (rewardInPack && !heroModel.IsNullOrEmpty())
			{
				Singleton<ServiceSystem>.Instance.GetService<IHeroService>().AddHeroData(heroModel.Id, heroModel);
			}
		}
		foreach (PbExpireItem item4 in dropThing.ExpireItem)
		{
			KnapsackPropData knapsackPropData2 = KnapsackPropData.Create(item4.Uuid, item4.ItemId, item4.ExpireTime, (int)item4.Count);
			if (knapsackPropData2 != null && !knapsackPropData2.Empty)
			{
				if (rewardInPack)
				{
					Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.GetKnapsackViewModel()?.AddProp(knapsackPropData2);
				}
				data.PropList.Add(knapsackPropData2);
			}
		}
		return data;
	}

	public static async Task<RewardGetData> AnalyzeRewardFromServer(PbLotteryDropThing dropThing)
	{
		RewardGetData data = new RewardGetData();
		if (dropThing == null)
		{
			return data;
		}
		foreach (PbItemBase item3 in dropThing.items)
		{
			PropDataBase propDataBase = PropDataBase.CreateByType(item3.ItemType, item3.ItemId, (int)item3.ItemCount);
			if (propDataBase == null || propDataBase.Empty)
			{
				continue;
			}
			if (item3.ItemType == 11 || item3.ItemType == 12)
			{
				data.PropList.Add(propDataBase);
				continue;
			}
			if (item3.ItemType == 25 || item3.ItemType == 24 || item3.ItemType == 26 || item3.ItemType == 22 || item3.ItemType == 28)
			{
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.SetItemNew((PropTypeEnum)item3.ItemType, item3.ItemId);
				data.PropList.Add(propDataBase);
				continue;
			}
			if (item3.ItemType == 13)
			{
				data.PropList.Add(propDataBase);
				continue;
			}
			if (Enum.IsDefined(typeof(RoleMoneyEnum), item3.ItemId))
			{
				MoneyDefinition.AddMoney(item3.ItemId, item3.ItemCount);
				if (item3.ItemCount > 0)
				{
					data.PropList.Add(propDataBase);
				}
				continue;
			}
			if (item3.ItemType == 20)
			{
				if (Singleton<ServiceSystem>.Instance.GetService<IHeroService>().AddHeroSkin(item3.ItemId))
				{
					data.HeroSkinList.Add(item3.ItemId);
				}
				continue;
			}
			if (item3.ItemType == 4)
			{
				HeroRewardInfo heroRewardInfo = null;
				foreach (PbNormalRoleInfo role in dropThing.roles)
				{
					if (role.RoleId == item3.ItemId)
					{
						heroRewardInfo = GetHeroRewardInfo(item3.ItemId, role);
						break;
					}
				}
				if (heroRewardInfo == null)
				{
					heroRewardInfo = GetHeroRewardInfo(item3.ItemId);
				}
				data.HeroRewardInfos.Add(heroRewardInfo);
				continue;
			}
			KnapsackPropData knapsackPropData = KnapsackPropData.Create(item3.ItemId, (int)item3.ItemCount);
			if (knapsackPropData != null && !knapsackPropData.Empty)
			{
				Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().AddProp(knapsackPropData);
				if (item3.ItemCount > 0)
				{
					data.PropList.Add(knapsackPropData);
				}
			}
		}
		foreach (PbEquipBase equip in dropThing.equips)
		{
			if (equip.Type == 16 || equip.Type == 2)
			{
				ArmourData item = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().AddArmour(equip);
				data.PropList.Add(item);
			}
			else if (equip.Type == 5)
			{
				WeaponData item2 = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().AddWeapon(equip);
				data.PropList.Add(item2);
			}
		}
		foreach (PbNormalRoleInfo role2 in dropThing.roles)
		{
			HeroModel heroModel = HeroModel.CreateByPbData(role2);
			if (!heroModel.IsNullOrEmpty())
			{
				Singleton<ServiceSystem>.Instance.GetService<IHeroService>().AddHeroData(heroModel.Id, heroModel);
			}
		}
		return data;
	}

	public static RewardGetData AnalyzeRewardFromServer(List<PbItemChange> pbItemChanges)
	{
		RewardGetData rewardGetData = new RewardGetData();
		if (pbItemChanges == null)
		{
			return rewardGetData;
		}
		List<KnapsackPropData> list = new List<KnapsackPropData>();
		foreach (PbItemChange pbItemChange in pbItemChanges)
		{
			PropDataBase propDataBase = PropDataBase.CreateByType(pbItemChange.ItemType, pbItemChange.ItemId, (int)pbItemChange.ItemDelta);
			if (propDataBase == null || propDataBase.Empty)
			{
				continue;
			}
			if (pbItemChange.ItemType == 11 || pbItemChange.ItemType == 12)
			{
				rewardGetData.PropList.Add(propDataBase);
				continue;
			}
			if (pbItemChange.ItemType == 25 || pbItemChange.ItemType == 24 || pbItemChange.ItemType == 26 || pbItemChange.ItemType == 22 || pbItemChange.ItemType == 28)
			{
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.SetItemNew((PropTypeEnum)pbItemChange.ItemType, pbItemChange.ItemId);
				rewardGetData.PropList.Add(propDataBase);
				continue;
			}
			if (pbItemChange.ItemType == 13)
			{
				rewardGetData.PropList.Add(propDataBase);
				continue;
			}
			if (Enum.IsDefined(typeof(RoleMoneyEnum), pbItemChange.ItemId))
			{
				MoneyDefinition.AddMoney(pbItemChange.ItemId, pbItemChange.ItemDelta);
				if (pbItemChange.ItemDelta > 0)
				{
					rewardGetData.PropList.Add(propDataBase);
				}
				continue;
			}
			if (pbItemChange.ItemType == 20)
			{
				if (Singleton<ServiceSystem>.Instance.GetService<IHeroService>().AddHeroSkin(pbItemChange.ItemId))
				{
					rewardGetData.HeroSkinList.Add(pbItemChange.ItemId);
				}
				continue;
			}
			if (pbItemChange.ItemType == 21)
			{
				DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(pbItemChange.ItemId);
				if (dataRow != null)
				{
					if (dataRow.UseType.Contains(80))
					{
						Singleton<ServiceSystem>.Instance.GetService<IShopService>()?.RequestGetMonthlyCardInfo();
					}
					rewardGetData.PropList.Add(propDataBase);
				}
				continue;
			}
			DRProp dataRow2 = GameEntry.DataTable.GetDataRow<DRProp>(pbItemChange.ItemId);
			if (dataRow2 != null)
			{
				KnapsackPropData item = new KnapsackPropData(dataRow2, (int)pbItemChange.ItemDelta);
				list.Add(item);
				if (pbItemChange.ItemDelta > 0)
				{
					rewardGetData.PropList.Add(item);
				}
			}
		}
		if (list.Count > 0)
		{
			Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().AddProp(list);
		}
		return rewardGetData;
	}

	public static async Task<RewardGetData> AnalyzeRewardFromServer(List<PbEquipBase> pbEquipBases)
	{
		RewardGetData data = new RewardGetData();
		foreach (PbEquipBase pbEquipBasis in pbEquipBases)
		{
			if (pbEquipBasis.Type == 16 || pbEquipBasis.Type == 2)
			{
				ArmourData item = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().AddArmour(pbEquipBasis);
				data.PropList.Add(item);
			}
			else if (pbEquipBasis.Type == 5)
			{
				WeaponData item2 = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().AddWeapon(pbEquipBasis);
				data.PropList.Add(item2);
			}
		}
		return data;
	}

	public static List<PropDataBase> AnalyzePropListByConfig(List<int> types, List<int> ids, List<int> counts)
	{
		List<PropDataBase> list = new List<PropDataBase>();
		if (types == null || ids == null || counts == null)
		{
			return list;
		}
		for (int i = 0; i < types.Count; i++)
		{
			if (ids.Count > i && counts.Count > i)
			{
				PropDataBase propDataBase = PropDataBase.CreateByType(types[i], ids[i], counts[i]);
				if (propDataBase != null && !propDataBase.Empty)
				{
					list.Add(propDataBase);
				}
			}
		}
		return list;
	}

	private static HeroRewardInfo GetHeroRewardInfo(int heroId, PbNormalRoleInfo roleInfo = null, bool rewardInPack = true)
	{
		HeroRewardInfo heroRewardInfo = new HeroRewardInfo();
		heroRewardInfo.heroId = heroId;
		if (Singleton<ServiceSystem>.Instance.GetService<IHeroService>().HasHero(heroId))
		{
			heroRewardInfo.heroProducts = new List<KnapsackPropData>();
			DRHeroInfo dataRow = GameEntry.DataTable.GetDataRow((DRHeroInfo p) => p.Id == heroId);
			int heroRarity = dataRow.Rarity;
			int heroPieceId = dataRow.HeroSeat;
			if (GameEntry.DataTable.GetDataRow((DRProp p) => p.Id == heroPieceId) == null)
			{
				Log.Error($"Prop表，找不到Id为{heroPieceId}的道具！");
				return heroRewardInfo;
			}
			DRCardByProduct dataRow2 = GameEntry.DataTable.GetDataRow((DRCardByProduct p) => p.CardType == 4 && p.CardSetRarity == heroRarity);
			if (dataRow2 == null)
			{
				Log.Error($"CardByProduct表，找不到CardType为4(英雄),CardSetRarity为{heroRarity}的数据！");
				return heroRewardInfo;
			}
			KnapsackPropData item = KnapsackPropData.Create(heroPieceId, dataRow2.HeroSeatCount);
			heroRewardInfo.heroProducts.Add(item);
		}
		else if (roleInfo == null)
		{
			Log.Error($"新获得英雄{heroId} 没有完整英雄数据！");
		}
		else if (rewardInPack)
		{
			Singleton<ServiceSystem>.Instance.GetService<IHeroService>().AddHero(roleInfo, addNewWeapon: true);
		}
		return heroRewardInfo;
	}

	public static List<HeroRewardInfo> GetHeroRewardInfos(List<int> heroIds)
	{
		List<HeroRewardInfo> list = new List<HeroRewardInfo>();
		if (heroIds == null || heroIds.Count == 0)
		{
			return list;
		}
		for (int i = 0; i < heroIds.Count; i++)
		{
			list.Add(GetHeroRewardInfo(heroIds[i]));
		}
		return list;
	}

	public static List<ReceiveItemViewModel> GetActivityCopyDrop(OptionBase parent, int rewardId)
	{
		List<ReceiveItemViewModel> list = new List<ReceiveItemViewModel>();
		DRCopyDrop dataRow = GameEntry.DataTable.GetDataRow((DRCopyDrop p) => p.RewardGroupId == rewardId);
		if (dataRow != null)
		{
			if (dataRow.PropTypeShow.Count != dataRow.PropIDShow.Count)
			{
				return null;
			}
			for (int num = 0; num < dataRow.PropTypeShow.Count; num++)
			{
				PropDataBase propDataBase = PropDataBase.CreateByType(dataRow.PropTypeShow[num], dataRow.PropIDShow[num]);
				if (propDataBase == null)
				{
					Log.Error($"CopyDrop2 配置表，Id【{dataRow.Id}】CopyDrop.PropTypeShow {dataRow.PropTypeShow[num]}，CopyDrop.PropIDShow {dataRow.PropIDShow[num]}配置有误！");
					continue;
				}
				ReceiveItemViewModel receiveItemViewModel = new ReceiveItemViewModel(propDataBase, parent);
				list.Add(receiveItemViewModel);
				if (dataRow.IsShowNum.Count > num && dataRow.IsShowNum[num] == 1 && dataRow.PropNumShow.Count > num)
				{
					receiveItemViewModel.SetCountRange(dataRow.PropNumShow[num]);
				}
				else
				{
					receiveItemViewModel.SetCountRange("");
				}
			}
		}
		return list;
	}

	public static List<KnapsackItemViewModel> GetPropList(OptionBase parent, List<int> propIds, List<int> propTypes, List<int> propAmounts)
	{
		List<KnapsackItemViewModel> list = new List<KnapsackItemViewModel>();
		if (propIds == null || propTypes == null || propAmounts == null || propIds.Count == 0 || propTypes.Count == 0 || propAmounts.Count == 0 || propIds.Count != propTypes.Count || propIds.Count != propAmounts.Count)
		{
			return list;
		}
		if (propIds.Count != propTypes.Count || propIds.Count != propAmounts.Count)
		{
			return list;
		}
		for (int i = 0; i < propTypes.Count; i++)
		{
			PropDataBase propDataBase = PropDataBase.CreateByType(propTypes[i], propIds[i], propAmounts[i]);
			if (propDataBase == null)
			{
				Log.Error($"创建道具 Id【{propIds[i]}】【{propTypes[i]}】配置有误！");
				continue;
			}
			KnapsackItemViewModel item = new KnapsackItemViewModel(parent, propDataBase);
			list.Add(item);
		}
		return list;
	}

	public static List<PropDataBase> MergeProp(List<PropDataBase> rawList)
	{
		Dictionary<long, PropDataBase> dictionary = new Dictionary<long, PropDataBase>();
		if (rawList == null)
		{
			return dictionary.Values.ToList();
		}
		List<PropDataBase> collection = rawList.FindAll((PropDataBase p) => !NeedMerge(p.PropTypeEnum));
		foreach (PropDataBase raw in rawList)
		{
			if (!NeedMerge(raw.PropTypeEnum))
			{
				continue;
			}
			if (raw.PropTimeLimitEnum != PropTimeLimitEnum.Permanent && raw.Uid > 0)
			{
				if (!dictionary.ContainsKey(raw.Uid))
				{
					dictionary.Add(raw.Uid, raw);
				}
			}
			else if (!dictionary.ContainsKey(raw.Id))
			{
				dictionary.Add(raw.Id, raw);
			}
			else
			{
				dictionary[raw.Id].Amount += raw.Amount;
			}
		}
		List<PropDataBase> list = dictionary.Values.ToList();
		list.AddRange(collection);
		return list;
		static bool NeedMerge(PropTypeEnum propTypeEnum)
		{
			if (propTypeEnum != PropTypeEnum.Weapon && propTypeEnum != PropTypeEnum.Equipment)
			{
				return propTypeEnum != PropTypeEnum.SuitBox;
			}
			return false;
		}
	}
}
