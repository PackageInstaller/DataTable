using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.UI.DataProxy;
using ACT.World.StateObject;
using Bamboo.ECS;
using Google.Protobuf.Collections;
using UnityEngine;

namespace ACT.Utility;

public static class SortUtility
{
	public static Func<Character, Character, int>[][] CompareBaseCharacter = new Func<Character, Character, int>[9][]
	{
		new Func<Character, Character, int>[5] { CharacterTeamIndex, CharacterLevel, CharacterQuality, CharacterStage, CharacterId },
		new Func<Character, Character, int>[5] { CharacterTeamIndex, CharacterQuality, CharacterLevel, CharacterStage, CharacterId },
		new Func<Character, Character, int>[5] { CharacterLevel, CharacterQuality, CharacterAtk, CharacterLife, CharacterDef },
		new Func<Character, Character, int>[5] { CharacterQuality, CharacterLevel, CharacterAtk, CharacterLife, CharacterDef },
		new Func<Character, Character, int>[5] { CharacterAtk, CharacterQuality, CharacterLevel, CharacterLife, CharacterDef },
		new Func<Character, Character, int>[5] { CharacterDef, CharacterQuality, CharacterLevel, CharacterAtk, CharacterLife },
		new Func<Character, Character, int>[5] { CharacterLife, CharacterQuality, CharacterAtk, CharacterLevel, CharacterDef },
		new Func<Character, Character, int>[4] { CharacterQuality, CharacterLevel, CharacterStage, CharacterId },
		new Func<Character, Character, int>[5] { CharacterAbyssTeamIndex, CharacterLevel, CharacterQuality, CharacterStage, CharacterId }
	};

	public static Func<Weapon, Weapon, int>[][] CompareInventoryWeapon = new Func<Weapon, Weapon, int>[2][]
	{
		new Func<Weapon, Weapon, int>[7] { WeaponQuality, WeaponEquiperID, WeaponLevel, WeaponType, WeaponRefine, WeaponId, WeaponUID },
		new Func<Weapon, Weapon, int>[7] { WeaponLevel, WeaponEquiperID, WeaponQuality, WeaponType, WeaponRefine, WeaponId, WeaponUID }
	};

	public static Func<Weapon, Weapon, int>[][] CompareWeapon = new Func<Weapon, Weapon, int>[2][]
	{
		new Func<Weapon, Weapon, int>[7] { WeaponQuality, WeaponEquiperID, WeaponLevel, WeaponType, WeaponRefine, WeaponId, WeaponUID },
		new Func<Weapon, Weapon, int>[7] { WeaponLevel, WeaponEquiperID, WeaponQuality, WeaponType, WeaponRefine, WeaponId, WeaponUID }
	};

	public static Func<Chip, Chip, int>[][] CompareInventoryChip = new Func<Chip, Chip, int>[2][]
	{
		new Func<Chip, Chip, int>[9] { ChipIsSelect, ChipEquiperID, ChipIsCoreID, ChipSpaceID, ChipIsNew, ChipLevel, ChipSuitID, ChipId, ChipUid },
		new Func<Chip, Chip, int>[8] { ChipIsSelect, ChipEquiperID, ChipLevel, ChipSpaceID, ChipIsNew, ChipSuitID, ChipId, ChipUid }
	};

	public static Func<Chip, Chip, int>[][] CompareSideChip = new Func<Chip, Chip, int>[1][] { new Func<Chip, Chip, int>[5] { ChipSpaceID, ChipIsNew, ChipExp, ChipId, ChipUid } };

	public static Func<Equip, Equip, int>[][] CompareInventoryEquip = new Func<Equip, Equip, int>[4][]
	{
		new Func<Equip, Equip, int>[5] { EquipLock, EquipQuality, EquipLevel, EquipId, EquipUid },
		new Func<Equip, Equip, int>[4] { EquipLevel, EquipQuality, EquipId, EquipUid },
		new Func<Equip, Equip, int>[5] { EquipLock, EquipLevel, EquipQuality, EquipId, EquipUid },
		new Func<Equip, Equip, int>[6] { EquipLevel, EquipQuality, EquipSuit, EquipType, EquipId, EquipUid }
	};

	public static Func<Gem, Gem, int>[][] CompareInventoryGem = new Func<Gem, Gem, int>[4][]
	{
		new Func<Gem, Gem, int>[5] { GemLock, GemCharacterEquipped, GemQuality, GemId, GemUid },
		new Func<Gem, Gem, int>[3] { GemQualityReverse, GemId, GemUid },
		new Func<Gem, Gem, int>[2] { GemLock, GemHotValue },
		new Func<Gem, Gem, int>[3] { GemQuality, GemId, GemUid }
	};

	public static Func<Item, Item, int>[][] CompareItemQualityAndId = new Func<Item, Item, int>[1][] { new Func<Item, Item, int>[2] { ItemQuality, ItemId } };

	public static Func<Item, Item, int>[][] CompareInventoryItem = new Func<Item, Item, int>[1][] { new Func<Item, Item, int>[4] { ItemSpecial, ItemQuality, ItemType, ItemId } };

	public static Func<Item, Item, int>[][] CompareDropItem = new Func<Item, Item, int>[1][] { new Func<Item, Item, int>[3] { ItemIsRare, ItemQuality, ItemId } };

	public static Func<Chip, Chip, int>[][] CompareChip = new Func<Chip, Chip, int>[1][] { new Func<Chip, Chip, int>[9] { ChipIsSelect, ChipEquiperID, ChipIsCore, ChipSpace, ChipIsNew, ChipLevel, ChipSuitID, ChipId, ChipUid } };

	public static Func<Equip, Equip, int>[][] CompareEquip = new Func<Equip, Equip, int>[1][] { new Func<Equip, Equip, int>[5] { EquipLock, EquipCharacterWear, EquipLevel, EquipQuality, EquipUid } };

	public static Func<Item, Item, int>[][] CookMainItem = new Func<Item, Item, int>[2][]
	{
		new Func<Item, Item, int>[5] { CookItemCount, CookItemSelected, CookItemQuality, CookMainItemCapacity, ItemId },
		new Func<Item, Item, int>[4] { CookItemCount, CookMainItemCapacity, CookItemQuality, ItemId }
	};

	public static Func<int, int, int>[][] CookBookItem = new Func<int, int, int>[1][] { new Func<int, int, int>[1] { CookBookCapacity } };

	public static Func<BloodBottleData, BloodBottleData, int>[][] CompareBloodBottle = new Func<BloodBottleData, BloodBottleData, int>[2][]
	{
		new Func<BloodBottleData, BloodBottleData, int>[5] { BloodBottleUnlock, BloodBottleEquiped, BloodBottleQuality, BloodBottleLevel, BloodBottleId },
		new Func<BloodBottleData, BloodBottleData, int>[4] { BloodBottleIsCurEquip, BloodBottleQuality, BloodBottleLevel, BloodBottleId }
	};

	public static Func<BloodBottleMaterial, BloodBottleMaterial, int>[][] CompareBloodBottleMaterial = new Func<BloodBottleMaterial, BloodBottleMaterial, int>[1][] { new Func<BloodBottleMaterial, BloodBottleMaterial, int>[4] { WineMatIsCurEquip, WineMatIsEquipButNotCur, WineMatQuality, WineMatId } };

	public static Func<ItemUnifierProxy, ItemUnifierProxy, int>[][] CompareBloodBottleAndMaterial = new Func<ItemUnifierProxy, ItemUnifierProxy, int>[1][] { new Func<ItemUnifierProxy, ItemUnifierProxy, int>[6] { ItemUnifierType, BloodBottleIsCurBattleEquip, BloodBottleLevel, BloodMaterialIsCurEquip, ItemUnifierQuality, ItemUnifierId } };

	public static Func<ItemUnifierProxy, ItemUnifierProxy, int>[][] CompareItemUnifierProxy = new Func<ItemUnifierProxy, ItemUnifierProxy, int>[3][]
	{
		new Func<ItemUnifierProxy, ItemUnifierProxy, int>[4] { ItemUnifierType, ItemUnifierQuality, ItemUnifierCount, ItemUnifierId },
		new Func<ItemUnifierProxy, ItemUnifierProxy, int>[3] { ItemUnifierQuality, ItemUnifierCount, ItemUnifierId },
		new Func<ItemUnifierProxy, ItemUnifierProxy, int>[2] { ItemUnifierQuality, ItemUnifierId }
	};

	public static Func<int, int, int>[] CompareTargetGuideProxy = new Func<int, int, int>[2] { TargetGuideHasRewaed, TargetGuideMissionProgressing };

	public static Func<InteractEntry, InteractEntry, int>[] CompareInteractEntry = new Func<InteractEntry, InteractEntry, int>[2] { InteractCompareWeight, InteractCompareDistanceX };

	private static int CharacterTeamIndex(Character x, Character y)
	{
		IReadOnlyList<Character> characters = MonoECS.instance.localPlayer.CurrentRuntimeBattleTeam.Characters;
		int num = -1;
		int num2 = -1;
		for (int i = 0; i < characters.Count; i++)
		{
			Character character = characters[i];
			if (character != null)
			{
				if (character.UID == x.UID)
				{
					num = 3 - i;
				}
				if (character.UID == y.UID)
				{
					num2 = 3 - i;
				}
				if (num != -1 && num2 != -1)
				{
					break;
				}
			}
		}
		return num - num2;
	}

	private static int CharacterAbyssTeamIndex(Character x, Character y)
	{
		int teamIndex = Model<AbyssModel>.Interface.GetTeamIndex(x.Id);
		int teamIndex2 = Model<AbyssModel>.Interface.GetTeamIndex(y.Id);
		teamIndex = ((teamIndex != -1) ? (6 - teamIndex) : teamIndex);
		teamIndex2 = ((teamIndex2 != -1) ? (6 - teamIndex2) : teamIndex2);
		return teamIndex - teamIndex2;
	}

	private static int CharacterId(Character x, Character y)
	{
		return y.Id - x.Id;
	}

	private static int CharacterStage(Character x, Character y)
	{
		return x.Stage - y.Stage;
	}

	private static int CharacterLevel(Character x, Character y)
	{
		return x.Level - y.Level;
	}

	private static int CharacterQuality(Character x, Character y)
	{
		return x.GetQuality() - y.GetQuality();
	}

	private static int CharacterAtk(Character x, Character y)
	{
		return x.Atk - y.Atk;
	}

	private static int CharacterDef(Character x, Character y)
	{
		return x.Define - y.Define;
	}

	private static int CharacterLife(Character x, Character y)
	{
		return x.Hp - y.Hp;
	}

	private static int WeaponQuality(Weapon x, Weapon y)
	{
		return 0;
	}

	private static int WeaponLevel(Weapon x, Weapon y)
	{
		return x.Level - y.Level;
	}

	private static int WeaponType(Weapon x, Weapon y)
	{
		return x.Type - y.Type;
	}

	private static int WeaponId(Weapon x, Weapon y)
	{
		return x.WeaponId - y.WeaponId;
	}

	private static int WeaponUID(Weapon x, Weapon y)
	{
		return x.Uid - y.Uid;
	}

	private static int WeaponEquiperID(Weapon x, Weapon y)
	{
		if (x.GetEquiperID() != -1 && y.GetEquiperID() != -1)
		{
			return 0;
		}
		return x.GetEquiperID() - y.GetEquiperID();
	}

	private static int WeaponRefine(Weapon x, Weapon y)
	{
		return x.Refine - y.Refine;
	}

	private static int WeaponTotalExp(Weapon x, Weapon y)
	{
		return x.TotalExp - y.TotalExp;
	}

	private static int ChipIsSelect(Chip x, Chip y)
	{
		return 0;
	}

	private static int ChipIsNew(Chip x, Chip y)
	{
		return 0;
	}

	private static int ChipLevel(Chip x, Chip y)
	{
		return 0;
	}

	private static int ChipExp(Chip x, Chip y)
	{
		return 0;
	}

	private static int ChipId(Chip x, Chip y)
	{
		return 0;
	}

	private static int ChipUid(Chip x, Chip y)
	{
		return 0;
	}

	private static int ChipSuitID(Chip x, Chip y)
	{
		return 0;
	}

	private static int ChipSpaceID(Chip x, Chip y)
	{
		return 0;
	}

	private static int ChipSpace(Chip x, Chip y)
	{
		return 0;
	}

	private static int ChipIsCoreID(Chip x, Chip y)
	{
		return 0;
	}

	private static int ChipIsCore(Chip x, Chip y)
	{
		return 0;
	}

	private static int ChipEquiperID(Chip x, Chip y)
	{
		return 0;
	}

	private static int EquipCharacterWear(Equip x, Equip y)
	{
		return x.WearCharacter - y.WearCharacter;
	}

	private static int EquipLevel(Equip x, Equip y)
	{
		return x.Level - y.Level;
	}

	private static int EquipId(Equip x, Equip y)
	{
		return x.Id - y.Id;
	}

	private static int EquipUid(Equip x, Equip y)
	{
		return x.Uid - y.Uid;
	}

	private static int EquipQuality(Equip x, Equip y)
	{
		return x.GetQuality() - y.GetQuality();
	}

	private static int EquipLock(Equip x, Equip y)
	{
		if (x.IsLock)
		{
			if (!y.IsLock)
			{
				return -1;
			}
		}
		else if (y.IsLock)
		{
			return 1;
		}
		return 0;
	}

	private static int EquipSuit(Equip x, Equip y)
	{
		RuntimeConfigs.data.equipDatas.TryGetValue(x.Id, out var value);
		RuntimeConfigs.data.equipDatas.TryGetValue(y.Id, out var value2);
		if (value == null || value2 == null)
		{
			return 0;
		}
		return value.suitId - value2.suitId;
	}

	private static int EquipType(Equip x, Equip y)
	{
		EquipData data = CoreUtils.GetData(x.Id, RuntimeConfigs.data.equipDatas);
		EquipData data2 = CoreUtils.GetData(y.Id, RuntimeConfigs.data.equipDatas);
		return data.equipType - data2.equipType;
	}

	private static int GemInlay(Gem x, Gem y)
	{
		return x.InlayEquip - y.InlayEquip;
	}

	private static int GemCharacterEquipped(Gem x, Gem y)
	{
		Equip equip = G.localPlayer.Inventory.GetEquip(x.InlayEquip);
		Equip equip2 = G.localPlayer.Inventory.GetEquip(y.InlayEquip);
		int num = equip?.WearCharacter ?? 0;
		int num2 = equip2?.WearCharacter ?? 0;
		return num - num2;
	}

	private static int GemHotValue(Gem x, Gem y)
	{
		EquipGemData data = CoreUtils.GetData(x.Id, RuntimeConfigs.data.equipGemDatas);
		EquipGemData data2 = CoreUtils.GetData(y.Id, RuntimeConfigs.data.equipGemDatas);
		return data.recycleValue - data2.recycleValue;
	}

	private static int GemQuality(Gem x, Gem y)
	{
		return x.GetQuality() - y.GetQuality();
	}

	private static int GemQualityReverse(Gem x, Gem y)
	{
		return y.GetQuality() - x.GetQuality();
	}

	private static int GemLevel(Gem x, Gem y)
	{
		return x.Level - y.Level;
	}

	private static int GemId(Gem x, Gem y)
	{
		return x.Id - y.Id;
	}

	private static int GemUid(Gem x, Gem y)
	{
		return x.Uid - y.Uid;
	}

	private static int GemLock(Gem x, Gem y)
	{
		if (x.IsLock)
		{
			if (!y.IsLock)
			{
				return -1;
			}
		}
		else if (y.IsLock)
		{
			return 1;
		}
		return 0;
	}

	private static int ItemIsRare(Item x, Item y)
	{
		if (IsRareItem(x.Id))
		{
			return 1;
		}
		if (IsRareItem(y.Id))
		{
			return -1;
		}
		return 0;
		static bool IsRareItem(int id)
		{
			return RuntimeConfigs.data.itemDatas[id].isNeedRareTip;
		}
	}

	private static int ItemSpecial(Item x, Item y)
	{
		if (x.Id == GameUtility.ActivePointExtraRewardId())
		{
			return 1;
		}
		if (y.Id == GameUtility.ActivePointExtraRewardId())
		{
			return -1;
		}
		return 0;
	}

	private static int ItemQuality(Item x, Item y)
	{
		return x.GetQuality() - y.GetQuality();
	}

	private static int CookItemCount(Item x, Item y)
	{
		return 0;
	}

	private static int CookItemSelected(Item x, Item y)
	{
		return 0;
	}

	private static int CookItemQuality(Item x, Item y)
	{
		return 0;
	}

	private static int ItemId(Item x, Item y)
	{
		return x.Id - y.Id;
	}

	private static int ItemType(Item x, Item y)
	{
		return y.itemType - x.itemType;
	}

	private static int CookMainItemCapacity(Item x, Item y)
	{
		return 0;
	}

	private static int CookBookCapacity(int x, int y)
	{
		return 0;
	}

	public static int TeamCharacterSort(Character x, Character y)
	{
		TeamModel teamModel = Model<TeamModel>.Interface;
		int[] array = teamModel.DeepCopyArray(teamModel.CurSelectedTeamCharacters);
		int num = Array.IndexOf(array, x.Id);
		int num2 = Array.IndexOf(array, y.Id);
		if (num == -1 && num2 != -1)
		{
			return 1;
		}
		if (num != -1 && num2 == -1)
		{
			return -1;
		}
		if (num >= 0 && num2 >= 0)
		{
			return num - num2;
		}
		if (x.Level != y.Level)
		{
			return y.Level - x.Level;
		}
		if (x.GetQuality() != y.GetQuality())
		{
			return y.GetQuality() - x.GetQuality();
		}
		if (x.Stage != y.Stage)
		{
			return y.Stage - x.Stage;
		}
		return x.Id - y.Id;
	}

	[Obsolete]
	public static int TeamPanelCharacterSort(Character x, Character y)
	{
		int num = 0;
		int num2 = 0;
		RepeatedField<int> characterIds = G.localPlayer.teamInfo.PresetTeams[Model<TeamModel>.Interface.curSelectedIndex].CharacterIds;
		num = characterIds.IndexOf(x.Id);
		num2 = characterIds.IndexOf(y.Id);
		if (num == -1 && num2 != -1)
		{
			return 1;
		}
		if (num != -1 && num2 == -1)
		{
			return -1;
		}
		if (num >= 0 && num2 >= 0)
		{
			return num - num2;
		}
		if (x.Level != y.Level)
		{
			return y.Level - x.Level;
		}
		if (x.GetQuality() != y.GetQuality())
		{
			return y.GetQuality() - x.GetQuality();
		}
		if (x.Stage != y.Stage)
		{
			return y.Stage - x.Stage;
		}
		return x.Id - y.Id;
	}

	public static int TempleTeamCharacterSort(Character x, Character y)
	{
		int num = Array.IndexOf(Model<TeamModel>.Interface.templeCharactersId, x.Id);
		int num2 = Array.IndexOf(Model<TeamModel>.Interface.templeCharactersId, y.Id);
		List<int> limitElements = Model<TempleModel>.Interface.GetLimitElements(Model<TeamModel>.Interface.templeId);
		if (limitElements != null && limitElements.Count > 0)
		{
			bool flag = limitElements.Contains((int)x.element);
			bool flag2 = limitElements.Contains((int)y.element);
			if (flag && !flag2)
			{
				return -1;
			}
			if (!flag & flag2)
			{
				return 1;
			}
		}
		if (num == -1 && num2 != -1)
		{
			return 1;
		}
		if (num != -1 && num2 == -1)
		{
			return -1;
		}
		if (num >= 0 && num2 >= 0)
		{
			return num - num2;
		}
		if (x.Level != y.Level)
		{
			return y.Level - x.Level;
		}
		if (x.GetQuality() != y.GetQuality())
		{
			return y.GetQuality() - x.GetQuality();
		}
		if (x.Stage != y.Stage)
		{
			return y.Stage - x.Stage;
		}
		return x.Id - y.Id;
	}

	public static int ItemQualityAndIdSort(Item x, Item y)
	{
		for (int i = 0; i < CompareItemQualityAndId[0].Length; i++)
		{
			int num = CompareItemQualityAndId[0][i](x, y);
			if (num != 0)
			{
				return num * -1;
			}
		}
		return 0;
	}

	public static int DefaultItemSort(Item x, Item y)
	{
		for (int i = 0; i < CompareInventoryItem[0].Length; i++)
		{
			int num = CompareInventoryItem[0][i](x, y);
			if (num != 0)
			{
				return num * -1;
			}
		}
		return 0;
	}

	public static int DropItemSort(Item x, Item y)
	{
		for (int i = 0; i < CompareDropItem[0].Length; i++)
		{
			int num = CompareDropItem[0][i](x, y);
			if (num != 0)
			{
				return num * -1;
			}
		}
		return 0;
	}

	public static int ReverseSortEquip(Equip x, Equip y)
	{
		return SortEquip(x, y, reverse: true);
	}

	public static int SortEquip(Equip x, Equip y)
	{
		return SortEquip(x, y, reverse: false);
	}

	public static int SortInventoryEquip(Equip x, Equip y)
	{
		for (int i = 0; i < CompareInventoryEquip[3].Length; i++)
		{
			int num = CompareInventoryEquip[3][i](x, y);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	private static int SortEquip(Equip x, Equip y, bool reverse)
	{
		for (int i = 0; i < CompareInventoryEquip[0].Length; i++)
		{
			int num = CompareInventoryEquip[0][i](x, y);
			if (num != 0)
			{
				return num * ((!reverse) ? 1 : (-1));
			}
		}
		return 0;
	}

	public static int ReverseSortGem(Gem x, Gem y)
	{
		return SortGem(x, y, reverse: true);
	}

	public static int SortGem(Gem x, Gem y)
	{
		return SortGem(x, y, reverse: false);
	}

	public static int SortGem2(Gem x, Gem y)
	{
		for (int i = 0; i < CompareInventoryGem[1].Length; i++)
		{
			int num = CompareInventoryGem[1][i](x, y);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	private static int SortGem(Gem x, Gem y, bool reverse)
	{
		for (int i = 0; i < CompareInventoryGem[0].Length; i++)
		{
			int num = CompareInventoryGem[0][i](x, y);
			if (num != 0)
			{
				return num * ((!reverse) ? 1 : (-1));
			}
		}
		return 0;
	}

	public static int SortInventoryGem(Gem x, Gem y, bool reverse)
	{
		for (int i = 0; i < CompareInventoryGem[3].Length; i++)
		{
			int num = CompareInventoryGem[3][i](x, y);
			if (num != 0)
			{
				return num * ((!reverse) ? 1 : (-1));
			}
		}
		return 0;
	}

	public static int SortItemUnifierProxyByType(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		for (int i = 0; i < CompareItemUnifierProxy[0].Length; i++)
		{
			int num = CompareItemUnifierProxy[0][i](x, y);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	public static int SortItemUnifierProxy1(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		for (int i = 0; i < CompareItemUnifierProxy[1].Length; i++)
		{
			int num = CompareItemUnifierProxy[1][i](x, y);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	public static int SortItemUnifierProxyPopReward(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		ItemUnifierMerger.TryGetUniversalItemTag(x, out var tag);
		ItemUnifierMerger.TryGetUniversalItemTag(y, out var tag2);
		if (tag != tag2)
		{
			if (IsTargetTag(tag) && IsTargetTag(tag2))
			{
				return tag.CompareTo(tag2);
			}
			return tag2.CompareTo(tag);
		}
		return SortItemUnifierProxy1(x, y);
	}

	private static bool IsTargetTag(UniversalItemTag itemTag)
	{
		if (itemTag == UniversalItemTag.TargetOne || itemTag == UniversalItemTag.TargetTwo || itemTag == UniversalItemTag.TargetThree)
		{
			return true;
		}
		return false;
	}

	public static int SortItemUnifierProxy2(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		for (int i = 0; i < CompareItemUnifierProxy[2].Length; i++)
		{
			int num = CompareItemUnifierProxy[2][i](x, y);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	public static int SortItemUnifierProxyInBag(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		if (x.ItemData.type != 23 && y.ItemData.type != 23)
		{
			int num = ItemUnifierExpireTime(x, y);
			if (num != 0)
			{
				return num;
			}
		}
		int num2 = ItemUnifierQuality(x, y);
		if (num2 != 0)
		{
			return num2;
		}
		if (x.ItemData.type == 23 || y.ItemData.type == 23)
		{
			int type = x.ItemData.type;
			if (type.CompareTo(y.ItemData.type) == 0)
			{
				Item obj = x.Source as Item;
				Item item = y.Source as Item;
				return obj.ExpireTime.CompareTo(item.ExpireTime);
			}
			if (x.ItemData.type != 23)
			{
				return 1;
			}
			return -1;
		}
		int num3 = ItemUnifierId(x, y);
		if (num3 != 0)
		{
			return num3;
		}
		return 0;
	}

	public static int SortBloodBottleInCultivate(BloodBottleData x, BloodBottleData y)
	{
		for (int i = 0; i < CompareBloodBottle[0].Length; i++)
		{
			int num = CompareBloodBottle[0][i](x, y);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	public static int SortBloodBottleInTeamView(BloodBottleData x, BloodBottleData y)
	{
		for (int i = 0; i < CompareBloodBottle[1].Length; i++)
		{
			int num = CompareBloodBottle[1][i](x, y);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	public static int SortBottleMatInChangePanel(BloodBottleMaterial x, BloodBottleMaterial y)
	{
		for (int i = 0; i < CompareBloodBottleMaterial[0].Length; i++)
		{
			int num = CompareBloodBottleMaterial[0][i](x, y);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	public static int SortBottleMatInBag(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		for (int i = 0; i < CompareBloodBottleAndMaterial[0].Length; i++)
		{
			int num = CompareBloodBottleAndMaterial[0][i](x, y);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	public static int NormalTutorialSort(TutorialModel.TutorialData data1, TutorialModel.TutorialData data2)
	{
		if (data1.type != data2.type)
		{
			return data1.type - data2.type;
		}
		return data2.id - data1.id;
	}

	private static int InteractCompareDistanceX(InteractEntry x, InteractEntry y)
	{
		if (MonoECS.instance == null || !MonoECS.instance.mainEntity.IsValid || MonoECS.instance.mainEntity.GetCompTransform() == null)
		{
			return -1;
		}
		Vector3 mainPos = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
		Vector3 tangent = MonoECS.instance.mainEntity.GetCompPhysics().pathTangent;
		float num = MathF.Abs(ProjectOnTangent(x.StateObjectPosition()));
		float value = MathF.Abs(ProjectOnTangent(y.StateObjectPosition()));
		return num.CompareTo(value);
		float ProjectOnTangent(Vector3 pos)
		{
			return Vector3.Dot(pos - mainPos, tangent);
		}
	}

	private static int InteractCompareWeight(InteractEntry x, InteractEntry y)
	{
		return y.Weight.CompareTo(x.Weight);
	}

	public static int SortTargetGuide(TargetGuideCellData x, TargetGuideCellData y)
	{
		for (int i = 0; i < CompareTargetGuideProxy.Length; i++)
		{
			int num = CompareTargetGuideProxy[i](x.missionGroupId, y.missionGroupId);
			if (num != 0)
			{
				return num;
			}
		}
		return 0;
	}

	public static void QuickSort<T>(this Span<T> span) where T : IComparable<T>
	{
		if (span.Length <= 1 || span.Length < 2)
		{
			return;
		}
		try
		{
			int index = span.Length / 2;
			T other = span[index];
			int i = 0;
			int num = span.Length - 1;
			while (i <= num)
			{
				for (; i < span.Length && span[i].CompareTo(other) < 0; i++)
				{
				}
				while (num >= 0 && span[num].CompareTo(other) > 0)
				{
					num--;
				}
				if (i > num || i >= span.Length || num < 0)
				{
					break;
				}
				ref T reference = ref span[i];
				ref T reference2 = ref span[num];
				T val = span[num];
				T val2 = span[i];
				reference = val;
				reference2 = val2;
				i++;
				num--;
			}
			if (num > 0)
			{
				Span<T> span2 = span.Slice(0, num + 1);
				if (span2.Length > 1)
				{
					span2.QuickSort();
				}
			}
			if (i < span.Length)
			{
				Span<T> span3 = span.Slice(i);
				if (span3.Length > 1)
				{
					span3.QuickSort();
				}
			}
		}
		catch (Exception)
		{
			T[] array = span.ToArray();
			Array.Sort(array);
			array.CopyTo(span);
		}
	}

	public static int BloodBottleUnlock(BloodBottleData x, BloodBottleData y)
	{
		if (!x.isLock && !y.isLock)
		{
			return 0;
		}
		if (!x.isLock)
		{
			return -1;
		}
		if (!y.isLock)
		{
			return 1;
		}
		return 0;
	}

	private static int BloodBottleEquiped(BloodBottleData x, BloodBottleData y)
	{
		if (x.isEquip && y.isEquip)
		{
			if (x.uid == MPPlayer.local.CurrentBattleTeam.EquipPotionId)
			{
				return -1;
			}
			if (y.uid == MPPlayer.local.CurrentBattleTeam.EquipPotionId)
			{
				return 1;
			}
			return 0;
		}
		if (x.isEquip)
		{
			return -1;
		}
		if (y.isEquip)
		{
			return 1;
		}
		return 0;
	}

	public static int BloodBottleIsCurEquip(BloodBottleData x, BloodBottleData y)
	{
		if (Model<TeamModel>.Interface.source == TeamProfileSource.Temple)
		{
			int curSceneEquipBloodBottleId = Model<BloodBottleModel>.Interface.curSceneEquipBloodBottleId;
			if (x.uid == curSceneEquipBloodBottleId)
			{
				return -1;
			}
			if (y.uid == curSceneEquipBloodBottleId)
			{
				return 1;
			}
			return 0;
		}
		int equipPotionId = Model<TeamModel>.Interface.CurSelectedTeamProfile.EquipPotionId;
		if (x.uid == equipPotionId)
		{
			return -1;
		}
		if (y.uid == equipPotionId)
		{
			return 1;
		}
		return 0;
	}

	public static int BloodBottleIsCurBattleTeamEquip(BloodBottleData x, BloodBottleData y)
	{
		int equipPotionId = MPPlayer.local.CurrentBattleTeam.EquipPotionId;
		if (x.uid == equipPotionId)
		{
			return -1;
		}
		if (y.uid == equipPotionId)
		{
			return 1;
		}
		return 0;
	}

	public static int BloodBottleIsCurBattleEquip(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		if (x.Source is BloodBottleData)
		{
			return BloodBottleIsCurBattleTeamEquip(x.As<BloodBottleData>(), y.As<BloodBottleData>());
		}
		return 0;
	}

	public static int BloodMaterialIsCurEquip(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		if (x.Source is BloodBottleMaterial)
		{
			return WineMatIsCurEquip(x.As<BloodBottleMaterial>(), y.As<BloodBottleMaterial>());
		}
		return 0;
	}

	public static int BloodBottleLevel(BloodBottleData x, BloodBottleData y)
	{
		return y.curLevel - x.curLevel;
	}

	public static int BloodBottleLevel(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		if (x.Source is BloodBottleData)
		{
			return y.As<BloodBottleData>().curLevel - x.As<BloodBottleData>().curLevel;
		}
		return 0;
	}

	public static int BloodBottleQuality(BloodBottleData x, BloodBottleData y)
	{
		Item itemInfo = G.localPlayer.Inventory.GetItemInfo(x.id);
		Item itemInfo2 = G.localPlayer.Inventory.GetItemInfo(y.id);
		if (itemInfo == null || itemInfo2 == null)
		{
			return 0;
		}
		return itemInfo2.GetQuality() - itemInfo.GetQuality();
	}

	public static int BloodBottleId(BloodBottleData x, BloodBottleData y)
	{
		return y.uid - x.uid;
	}

	public static int WineMatIsCurEquip(BloodBottleMaterial x, BloodBottleMaterial y)
	{
		List<int> list = Model<BloodBottleModel>.Interface.CurTeamEquipBottle?.materialIds;
		List<int> list2 = ((Model<BloodBottleModel>.Interface.curOperationBottle != null) ? Model<BloodBottleModel>.Interface.curOperationBottle.materialIds : list);
		if (list2 == null)
		{
			return 0;
		}
		if (list2.Contains(x.uid) && !list2.Contains(y.uid))
		{
			return -1;
		}
		if (!list2.Contains(x.uid) && list2.Contains(y.uid))
		{
			return 1;
		}
		return 0;
	}

	public static int WineMatIsEquip(BloodBottleMaterial x, BloodBottleMaterial y)
	{
		if (x.isEquip && !y.isEquip)
		{
			return 1;
		}
		if (!x.isEquip && y.isEquip)
		{
			return -1;
		}
		return 0;
	}

	public static int WineMatIsEquipButNotCur(BloodBottleMaterial x, BloodBottleMaterial y)
	{
		List<int> list = Model<BloodBottleModel>.Interface.CurTeamEquipBottle?.materialIds;
		List<int> list2 = ((Model<BloodBottleModel>.Interface.curOperationBottle != null) ? Model<BloodBottleModel>.Interface.curOperationBottle.materialIds : list);
		if (list2 == null)
		{
			return 0;
		}
		bool flag = list2.Contains(x.uid);
		bool flag2 = list2.Contains(y.uid);
		bool flag3 = x.isEquip && !flag;
		bool flag4 = y.isEquip && !flag2;
		if (flag3 && !flag4)
		{
			return 1;
		}
		if (!flag3 & flag4)
		{
			return -1;
		}
		return 0;
	}

	public static int WineMatQuality(BloodBottleMaterial x, BloodBottleMaterial y)
	{
		Item itemInfo = G.localPlayer.Inventory.GetItemInfo(x.id);
		return G.localPlayer.Inventory.GetItemInfo(y.id).GetQuality() - itemInfo.GetQuality();
	}

	public static int WineMatId(BloodBottleMaterial x, BloodBottleMaterial y)
	{
		return y.uid - x.uid;
	}

	public static int SortBottleAndMat(Item x, Item y)
	{
		if (x.itemType == 15)
		{
			return 1;
		}
		if (y.itemType == 15)
		{
			return -1;
		}
		return 0;
	}

	public static int ItemUnifierId(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		return y.Id - x.Id;
	}

	public static int ItemUnifierCount(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		return (int)(y.Count - x.Count);
	}

	public static int ItemUnifierQuality(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		return y.Quality - x.Quality;
	}

	public static int ItemUnifierType(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		if (x.ItemData == null || y.ItemData == null)
		{
			return 0;
		}
		return x.ItemData.type - y.ItemData.type;
	}

	public static int ItemUnifierExpireTime(ItemUnifierProxy x, ItemUnifierProxy y)
	{
		Item item = x.Source as Item;
		Item item2 = y.Source as Item;
		if (item == null && item2 == null)
		{
			return 0;
		}
		if (item != null && item2 == null)
		{
			if (item.IsLimitTimeItem())
			{
				return -1;
			}
		}
		else if (item2 != null && item == null)
		{
			if (item2.IsLimitTimeItem())
			{
				return 1;
			}
		}
		else if (item.IsLimitTimeItem() && item2.IsLimitTimeItem())
		{
			return item.GetExpireTime().CompareTo(item2.GetExpireTime());
		}
		return 0;
	}

	public static int HudUIQueueItemPriority(HudCpQueueItem x, HudCpQueueItem y)
	{
		if (x == null || y == null)
		{
			return 0;
		}
		if (x.Priority != y.Priority)
		{
			return x.Priority - y.Priority;
		}
		return x.EnqueueTime.CompareTo(y.EnqueueTime);
	}

	public static int TargetGuideHasRewaed(int missionGroupIdx, int missionGroupIdy)
	{
		bool num = Model<TargetGuideModel>.Interface?.CurGudieMissionCanReward(missionGroupIdx) ?? false;
		bool flag = Model<TargetGuideModel>.Interface?.CurGudieMissionCanReward(missionGroupIdy) ?? false;
		TargetGuideModel targetGuideModel = Model<TargetGuideModel>.Interface;
		bool flag2 = targetGuideModel != null && !targetGuideModel.GetGuideMissionRewardState(missionGroupIdx);
		TargetGuideModel targetGuideModel2 = Model<TargetGuideModel>.Interface;
		bool flag3 = targetGuideModel2 != null && !targetGuideModel2.GetGuideMissionRewardState(missionGroupIdy);
		bool flag4 = num & flag2;
		bool flag5 = flag & flag3;
		if (!flag4 & flag5)
		{
			return 1;
		}
		if (flag4 && !flag5)
		{
			return -1;
		}
		return 0;
	}

	public static int TargetGuideMissionProgressing(int missionGroupIdx, int missionGroupIdy)
	{
		TargetGuideModel targetGuideModel = Model<TargetGuideModel>.Interface;
		bool flag = targetGuideModel != null && !targetGuideModel.CurGudieMissionCanReward(missionGroupIdx);
		TargetGuideModel targetGuideModel2 = Model<TargetGuideModel>.Interface;
		bool flag2 = targetGuideModel2 != null && !targetGuideModel2.CurGudieMissionCanReward(missionGroupIdy);
		if (!flag & flag2)
		{
			return 1;
		}
		if (flag && !flag2)
		{
			return -1;
		}
		return 0;
	}

	public static int SelfSelectBoxItemCanUseCountSort(GiftPackage bagChest, Item x, Item y)
	{
		if (x == null || y == null || bagChest == null)
		{
			return 0;
		}
		int canChooseCountInSelfSelectBagChest = Model<GiftPackageModel>.Interface.GetCanChooseCountInSelfSelectBagChest(bagChest, x);
		int canChooseCountInSelfSelectBagChest2 = Model<GiftPackageModel>.Interface.GetCanChooseCountInSelfSelectBagChest(bagChest, y);
		if (canChooseCountInSelfSelectBagChest == -1 && canChooseCountInSelfSelectBagChest2 != -1)
		{
			return 1;
		}
		if (canChooseCountInSelfSelectBagChest != -1 && canChooseCountInSelfSelectBagChest2 == -1)
		{
			return -1;
		}
		if (canChooseCountInSelfSelectBagChest == 0 && canChooseCountInSelfSelectBagChest2 != 0)
		{
			return 1;
		}
		if (canChooseCountInSelfSelectBagChest != 0 && canChooseCountInSelfSelectBagChest2 == 0)
		{
			return -1;
		}
		return 0;
	}
}
