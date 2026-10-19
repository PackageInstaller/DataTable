using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Utility;

namespace ACT.UI;

public static class BundleOverflowHelper
{
	public static bool TryGetOverflowItems(Dictionary<int, long> rewardCounts, out List<ItemKv> overflowItems)
	{
		overflowItems = null;
		if (rewardCounts == null || rewardCounts.Count == 0)
		{
			return false;
		}
		bool flag = false;
		foreach (var (num3, num4) in rewardCounts)
		{
			if (!RuntimeConfigs.data.itemDatas.TryGetValue(num3, out var _))
			{
				continue;
			}
			int gainCount = (int)((num4 > int.MaxValue) ? int.MaxValue : num4);
			bool flag2 = GameUtility.CheckItemQuantityOwnedIsValid(num3, gainCount, out var result);
			if (!flag2)
			{
				flag = true;
			}
			if ((flag2 && num4 <= int.MaxValue) || result.leftCount < 0)
			{
				continue;
			}
			long num5 = num4 - Math.Max(result.leftCount, 0);
			if (num5 > 0)
			{
				if (overflowItems == null)
				{
					overflowItems = new List<ItemKv>();
				}
				overflowItems.Add(new ItemKv(num3, (int)((num5 > int.MaxValue) ? int.MaxValue : num5)));
			}
		}
		if (!flag)
		{
			List<ItemKv> list = overflowItems;
			if (list != null)
			{
				return list.Count > 0;
			}
			return false;
		}
		return true;
	}
}
