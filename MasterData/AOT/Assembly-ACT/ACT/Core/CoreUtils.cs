using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Game;
using ACT.Game.Data;
using ACT.Initialize;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using UnityEngine;

namespace ACT.Core;

public static class CoreUtils
{
	public static Dictionary<int, float> s_PropertyCal = new Dictionary<int, float>();

	public static Dictionary<int, int> s_itemKvsCal = new Dictionary<int, int>();

	private static int did = 0;

	public static float GetChangeCD => RuntimeConfigs.data.game.changeCharacterCoolDownTime;

	public static T Find<T>(this RepeatedField<T> repeatedField, Predicate<T> predicate)
	{
		foreach (T item in repeatedField)
		{
			if (predicate(item))
			{
				return item;
			}
		}
		return default;
	}

	public static int FindIndex<T>(this RepeatedField<T> repeatedField, Predicate<T> predicate)
	{
		for (int i = 0; i < repeatedField.Count; i++)
		{
			if (predicate(repeatedField[i]))
			{
				return i;
			}
		}
		return -1;
	}

	public static bool Find<T>(this RepeatedField<T> repeatedField, Predicate<T> predicate, out T result)
	{
		foreach (T item in repeatedField)
		{
			if (predicate(item))
			{
				result = item;
				return true;
			}
		}
		result = default;
		return false;
	}

	public static List<T> FindAll<T>(this RepeatedField<T> repeatedField, Predicate<T> match) where T : class
	{
		List<T> list = new List<T>();
		for (int i = 0; i < repeatedField.Count; i++)
		{
			if (match(repeatedField[i]))
			{
				list.Add(repeatedField[i]);
			}
		}
		return list;
	}

	public static Dictionary<int, float> GetWeaponProperties(int weaponId, int level, int stage)
	{
		StartPropertyCal();
		ItemWeaponData data = GetData(weaponId, RuntimeConfigs.data.itemWeaponDatas);
		if (data == null)
		{
			return s_PropertyCal;
		}
		ItemWeaponProperty data2 = GetData(data.PropertyID, RuntimeConfigs.data.itemWeaponPropertys);
		if (data2 == null)
		{
			return s_PropertyCal;
		}
		float num = 0f;
		float num2 = TransInt10000(data2.atkUpgrade[0].val);
		float num3 = TransInt10000(data2.atkBreakthrough[0].val);
		num = (float)data.initAtk + num2 * (float)(level - 1) + num3 * (float)stage;
		AddPropertyCal(200, num);
		float num4 = 0f;
		float num5 = TransInt10000(data.weaponSubPropertyValue[0].val);
		float num6 = TransInt10000(data2.subPropertyUpgrade[0].val);
		num4 = num5 + (float)(level - 1) * num6;
		AddPropertyCal(data.weaponSubProperty, num4);
		return s_PropertyCal;
	}

	public static float TransInt10000(int value)
	{
		return (float)value * 0.0001f;
	}

	public static int CalculateWeaponExp(List<Item> items, List<Weapon> weapons)
	{
		int num = 0;
		foreach (Weapon weapon in weapons)
		{
			ItemWeaponData data = GetData(weapon.WeaponId, RuntimeConfigs.data.itemWeaponDatas);
			if (data != null)
			{
				ItemWeaponUpgrade data2 = GetData(TableRule.GetWeaponUpGradeId(data.upgradeType, weapon.Level), RuntimeConfigs.data.itemWeaponUpgrades);
				if (data2 != null)
				{
					float weaponTransPercent = RuntimeConfigs.data.game.weaponTransPercent;
					num += Mathf.CeilToInt((float)data2.totalEXPRequired * weaponTransPercent);
				}
			}
		}
		foreach (Item item in items)
		{
			ItemData data3 = GetData(item.Id, RuntimeConfigs.data.itemDatas);
			if (data3?.canBeTransited != null && data3.canBeTransited.Count > 1)
			{
				num += data3.canBeTransited[1].count * item.Count;
			}
		}
		return num;
	}

	public static Dictionary<int, float> CalSelfProperty(ICharacterSource pbCharacter)
	{
		int num = pbCharacter.Level();
		int key = pbCharacter.Id();
		EntityCharacterData entityCharacterData = RuntimeConfigs.data.entityCharacterDatas[key];
		StartPropertyCal();
		AddProperties(entityCharacterData.characterPorpertyBase);
		int num2 = 1;
		List<Properties> characterPorpertyAdd = RuntimeConfigs.data.entityCharacterDatas[key].characterPorpertyAdd;
		int mul = Mathf.Max(0, num - num2);
		AddProperties(characterPorpertyAdd, mul);
		return s_PropertyCal;
	}

	public static int CalculateCharacterExp(List<Item> items)
	{
		int result = 0;
		foreach (Item item in items)
		{
			ItemData itemData = RuntimeConfigs.data.itemDatas[item.Id];
			result = item.Count * itemData.canBeTransited[0].count;
		}
		return result;
	}

	public static Dictionary<int, float> GetEquipProperty(this Character character)
	{
		Dictionary<int, float> dictionary = new Dictionary<int, float>();
		foreach (KeyValuePair<int, int> equip in character.Equips)
		{
			foreach (EquipAttr attribute in character.GetEquip(equip.Value).Attributes)
			{
				EquipAttrData data = GetData(attribute.Id, RuntimeConfigs.data.equipAttrDatas);
				if (data != null && !dictionary.TryAdd(data.attrId, attribute.Value))
				{
					dictionary[data.attrId] += attribute.Value;
				}
			}
		}
		List<int> list = ListPool<int>.Get();
		character.GetAllFeatureIDs(list);
		foreach (int item in list)
		{
			EquipFeatureData data2 = GetData(item, RuntimeConfigs.data.equipFeatureDatas);
			if (data2 == null)
			{
				continue;
			}
			SkillGroupData data3 = GetData(data2.skillGroupData, RuntimeConfigs.data.skillGroupDatas);
			if (data3 == null)
			{
				continue;
			}
			int featureData = character.GetFeatureData(item);
			SkillGroupLevelData skillGroupLevelData = TableRule.GetSkillGroupLevelData(data3.id, featureData);
			if (skillGroupLevelData == null)
			{
				continue;
			}
			foreach (Properties item2 in skillGroupLevelData.skillProperty)
			{
				if (!dictionary.TryAdd(item2.property, item2.value))
				{
					dictionary[item2.property] += item2.value;
				}
			}
		}
		ListPool<int>.Release(list);
		return dictionary;
	}

	public static void StartPropertyCal()
	{
		foreach (KeyValuePair<int, PropertyData> propertyData2 in RuntimeConfigs.data.propertyDatas)
		{
			PropertyData propertyData = RuntimeConfigs.data.propertyDatas[propertyData2.Value.id];
			s_PropertyCal[propertyData.id] = 0f;
		}
	}

	public static void AddPropertyCal(int id, float value)
	{
		if (s_PropertyCal.TryGetValue(id, out var value2))
		{
			s_PropertyCal[id] = value2 + value;
		}
		else
		{
			s_PropertyCal.Add(id, value);
		}
	}

	public static void AddProperties(List<Properties> properties, int mul = 1)
	{
		if (mul == 0 || properties.Count == 0)
		{
			return;
		}
		foreach (Properties property in properties)
		{
			AddPropertyCal(property.property, (float)mul * property.value);
		}
	}

	public static void AddProperties(List<Properties> properties, List<PropertiesMulti> muls)
	{
		if (properties.Count == 0)
		{
			return;
		}
		foreach (Properties propertie in properties)
		{
			float num = 1f;
			PropertiesMulti propertiesMulti = muls.Find((PropertiesMulti x) => propertie.property == x.property);
			if (propertiesMulti != null)
			{
				num = propertiesMulti.multi;
			}
			AddPropertyCal(propertie.property, num * propertie.value);
		}
	}

	private static T GetRandom<T>(this IList<T> list, Func<T, int> weightSelecter)
	{
		int num = UnityEngine.Random.Range(0, list.Sum(weightSelecter));
		int num2 = 0;
		for (int i = 0; i < list.Count; i++)
		{
			num2 += weightSelecter(list[i]);
			if (num < num2)
			{
				return list[i];
			}
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("没有随机到，随机数为：" + num);
		}
		return default;
	}

	private static T Find<T>(this IList<T> list, Predicate<T> predicate)
	{
		for (int i = 0; i < list.Count; i++)
		{
			if (predicate(list[i]))
			{
				return list[i];
			}
		}
		return default;
	}

	public static int DetermineActualCollection(int collectionPointId)
	{
		return RuntimeConfigs.data.collectionPoints[collectionPointId].collectionId.GetRandom((ItemKv e) => e.count).id;
	}

	public static int DetermineActualMonster(int monsterPointId)
	{
		return RuntimeConfigs.data.enemySpawns[monsterPointId].enemy.GetRandom((Maybe e) => e.weight).id;
	}

	public static void DetermineActualRewards(int collectionId, IList<Item> items, bool merge = true)
	{
		if (!RuntimeConfigs.data.collections.TryGetValue(collectionId, out var value))
		{
			return;
		}
		for (int i = 0; i < value.rewards.Count; i++)
		{
			int id = value.rewards[i].id;
			int count = value.rewards[i].count;
			for (int j = 0; j < count; j++)
			{
				Maybe config = RuntimeConfigs.data.rewards[id].dropItem.GetRandom((Maybe e) => e.weight);
				if (merge)
				{
					Item item = items.Find((Item x) => x.Id == config.id);
					if (item != null)
					{
						item.Count += config.count;
						continue;
					}
					items.Add(new Item
					{
						Id = config.id,
						Count = config.count
					});
				}
				else
				{
					items.Add(new Item
					{
						Id = config.id,
						Count = config.count
					});
				}
			}
		}
	}

	public static void CertainRewards(int collectionId, IList<Item> items, bool merge = true)
	{
		if (!RuntimeConfigs.data.collections.TryGetValue(collectionId, out var value))
		{
			return;
		}
		for (int i = 0; i < value.certain.Count; i++)
		{
			ItemKv config = value.certain[i];
			if (RuntimeConfigs.data.itemDatas[config.id].type < 0)
			{
				continue;
			}
			if (merge)
			{
				Item item = items.Find((Item x) => x.Id == config.id);
				if (item != null)
				{
					item.Count += config.count;
					continue;
				}
				items.Add(new Item
				{
					Id = config.id,
					Count = config.count
				});
			}
			else
			{
				items.Add(new Item
				{
					Id = config.id,
					Count = config.count
				});
			}
		}
	}

	public static void DetermineActualMonsterRewards(int monsterId, int worldLevel, IList<DropItem> dItems, bool merge = true)
	{
		if (RuntimeConfigs.data.entityEnemyDatas.TryGetValue(monsterId, out var value) && value.collectionId.Length != 0)
		{
			DetermineActualCollectionRewards(value.collectionId[worldLevel], dItems, merge);
		}
	}

	public static void DetermineActualCollectionRewards(int collectionId, IList<DropItem> dItems, bool merge = true)
	{
		if (!RuntimeConfigs.data.collections.TryGetValue(collectionId, out var temp))
		{
			return;
		}
		for (int i = 0; i < temp.rewards.Count; i++)
		{
			int id = temp.rewards[i].id;
			int count = temp.rewards[i].count;
			for (int j = 0; j < count; j++)
			{
				Maybe config = RuntimeConfigs.data.rewards[id].dropItem.GetRandom((Maybe e) => e.weight);
				if (merge)
				{
					DropItem dropItem = dItems.Find((DropItem x) => x.ItemId == config.id);
					if (dropItem != null)
					{
						dropItem.Count += config.count;
						continue;
					}
					dItems.Add(new DropItem
					{
						Uid = did++,
						ItemId = config.id,
						Count = config.count
					});
				}
				else
				{
					dItems.Add(new DropItem
					{
						Uid = did++,
						ItemId = config.id,
						Count = config.count
					});
				}
			}
		}
		int i2;
		for (i2 = 0; i2 < temp.certain.Count; i2++)
		{
			if (merge)
			{
				DropItem dropItem2 = dItems.Find((DropItem x) => x.ItemId == temp.certain[i2].id);
				if (dropItem2 != null)
				{
					dropItem2.Count += temp.certain[i2].count;
					continue;
				}
				dItems.Add(new DropItem
				{
					Uid = did++,
					ItemId = temp.certain[i2].id,
					Count = temp.certain[i2].count
				});
			}
			else
			{
				dItems.Add(new DropItem
				{
					Uid = did++,
					ItemId = temp.certain[i2].id,
					Count = temp.certain[i2].count
				});
			}
		}
	}

	public static void DeltaItemNtfToItemNtf(ItemNtf itemNtf)
	{
		foreach (Item change in itemNtf.Changes)
		{
			Item itemInfo = G.localPlayer.Inventory.GetItemInfo(change.Id);
			if (itemInfo != null)
			{
				change.Count += itemInfo.Count;
			}
		}
	}

	public static int GetTopQuality(DropItemAddNtf dropItemAddNtf)
	{
		if (dropItemAddNtf == null && LuminRuntimeInitializer.GameLoader.mode == GameLoader.GameMode.ConfigSave)
		{
			return 1;
		}
		List<int> list = ListPool<int>.Get();
		if (dropItemAddNtf != null)
		{
			foreach (DropItem ditem in dropItemAddNtf.Ditems)
			{
				int quality = RuntimeConfigs.data.itemDatas[ditem.ItemId].quality;
				list.Add(quality);
			}
		}
		int result = ((list.Count > 0) ? list.Max() : 0);
		ListPool<int>.Release(list);
		return result;
	}

	public static int ServiceSaveStateId(int wid, int swid)
	{
		if (G.localPlayer.Maps.TryGetValue(wid, out var value))
		{
			if (value.ServiceSaveStateIds.TryGetValue(swid, out var value2))
			{
				return value2;
			}
			throw new Exception($"存档中找不到地图[{wid}]上的交互物[{swid}]");
		}
		throw new Exception($"存档中找不到地图[{wid}]");
	}

	public static bool TryGetServiceSaveStateId(int wid, int swid, out int stateId)
	{
		stateId = -1;
		if (G.localPlayer.Maps.TryGetValue(wid, out var value))
		{
			if (value.ServiceSaveStateIds.TryGetValue(swid, out var value2))
			{
				stateId = value2;
				return true;
			}
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"存档中找不到地图[{wid}]上的交互物[{swid}]");
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"存档中找不到地图[{wid}]");
		}
		return false;
	}

	public static int ServiceBehaveId(int wid, int swid)
	{
		return G.localPlayer.Maps[wid].ServiceBehaveIds[swid];
	}

	public static bool TryGetServiceBehaveId(int wid, int swid, out int behaveId)
	{
		behaveId = 0;
		if (G.localPlayer.Maps.TryGetValue(wid, out var value))
		{
			return value.ServiceBehaveIds.TryGetValue(swid, out behaveId);
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"存档中找不到地图[{wid}]");
		}
		return false;
	}

	public static bool TryGetServiceCleanedTs(int wid, int swid, out int cleanedTs)
	{
		cleanedTs = 0;
		if (G.localPlayer.Maps.TryGetValue(wid, out var value))
		{
			return value.ServiceCleanedTs.TryGetValue(swid, out cleanedTs);
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"存档中找不到地图[{wid}]");
		}
		return false;
	}

	public static int CalEnytityTemplateId(int type, int level)
	{
		return type * 10000 + level;
	}

	public static T GetData<T>(int id, Dictionary<int, T> dataDictionary, string errorMessage = null)
	{
		try
		{
			if (dataDictionary.TryGetValue(id, out var value))
			{
				return value;
			}
			_ = LuminApplication.LogEnabled;
			return default;
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
			return default;
		}
	}

	public static T GetData<T>(long id, Dictionary<long, T> dataDictionary, string errorMessage = null)
	{
		try
		{
			if (dataDictionary.TryGetValue(id, out var value))
			{
				return value;
			}
			if (errorMessage == null)
			{
				errorMessage = $"id: {id} is not present in the data dictionary.";
			}
			_ = LuminApplication.LogEnabled;
			return default;
		}
		catch (Exception)
		{
			_ = LuminApplication.LogEnabled;
			return default;
		}
	}

	public static T GetData<T>(long id, Dictionary<int, T> dataDictionary, string errorMessage = null)
	{
		if (id > int.MaxValue || id < int.MinValue)
		{
			if (errorMessage == null)
			{
				errorMessage = $"id: {id} is outside the Int32 key range.";
			}
			_ = LuminApplication.LogEnabled;
			return default;
		}
		return GetData((int)id, dataDictionary, errorMessage);
	}

	public static int[] GetSkillMessageId(int skillGroupId, int level = 1)
	{
		return GetData(skillGroupId * 100 + level, RuntimeConfigs.data.skillGroupLevelDatas)?.skillDes;
	}

	public static int GetEquipFeatureNameLocalId(int equipFeatureId)
	{
		return GetEquipFeatureNameLocalId(GetData(equipFeatureId, RuntimeConfigs.data.equipFeatureDatas));
	}

	public static int GetEquipFeatureNameLocalId(EquipFeatureData equipFeatureData)
	{
		if (equipFeatureData == null)
		{
			return 0;
		}
		SkillGroupLevelData skillGroupLevelData = TableRule.GetSkillGroupLevelData(equipFeatureData.skillGroupData, 1);
		int[] array = skillGroupLevelData?.skillDes;
		if (array == null || array.Length <= 0)
		{
			return equipFeatureData.name;
		}
		return GetData(skillGroupLevelData.skillDes[0], RuntimeConfigs.data.skillDetailMessageDatas)?.nameLocal ?? equipFeatureData.name;
	}

	public static int UnixTimeSeconds()
	{
		return (int)new DateTimeOffset(System.DateTime.Now).ToUnixTimeSeconds();
	}
}
