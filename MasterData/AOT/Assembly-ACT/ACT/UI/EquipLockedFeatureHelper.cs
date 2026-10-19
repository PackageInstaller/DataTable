using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Utility;
using Fundamental;

namespace ACT.UI;

public static class EquipLockedFeatureHelper
{
	public static void AddLockedEquipFeatures(Equip equip, EquipBuffDetail equipBuffDetail)
	{
		if (equip == null || equipBuffDetail == null)
		{
			return;
		}
		EquipData data = CoreUtils.GetData(equip.Id, RuntimeConfigs.data.equipDatas);
		if (data == null)
		{
			return;
		}
		EquipStrengthenListData data2 = CoreUtils.GetData(data.strengthen, RuntimeConfigs.data.equipStrengthenListDatas);
		if (data2 == null)
		{
			return;
		}
		List<int> unlockedFeatureIds = ListPool<int>.Get();
		equip.GetAllFeatureIDs(unlockedFeatureIds);
		HashSet<int> previousTierFeatureIds = HashSetPool<int>.Get();
		List<(List<ItemKv>, int)> list = ListPool<(List<ItemKv>, int)>.Get();
		list.Add((data2.equipFeature10, 10));
		list.Add((data2.equipFeature20, 20));
		foreach (var item in list)
		{
			TryAddLockedFeatures(item.Item1, item.Item2);
			AppendTierFeatureIds(item.Item1);
		}
		ListPool<(List<ItemKv>, int)>.Release(list);
		HashSetPool<int>.Release(previousTierFeatureIds);
		ListPool<int>.Release(unlockedFeatureIds);
		void AppendTierFeatureIds(List<ItemKv> featureList)
		{
			if (featureList == null || featureList.Count == 0)
			{
				return;
			}
			foreach (ItemKv feature in featureList)
			{
				previousTierFeatureIds.Add(feature.id);
			}
		}
		void TryAddLockedFeatures(List<ItemKv> featureList, int unlockLevel)
		{
			if (featureList == null || featureList.Count == 0 || equip.Level >= unlockLevel)
			{
				return;
			}
			foreach (ItemKv feature2 in featureList)
			{
				if (!previousTierFeatureIds.Contains(feature2.id) && !unlockedFeatureIds.Contains(feature2.id))
				{
					equipBuffDetail.AddLockStyle(feature2.id, GetEquipFeatureLockReason(unlockLevel));
				}
			}
		}
	}

	private static string GetEquipFeatureLockReason(int unlockLevel)
	{
		return LocalizationUtility.GetLocalizeString("Common", 2805, new object[1] { unlockLevel });
	}
}
