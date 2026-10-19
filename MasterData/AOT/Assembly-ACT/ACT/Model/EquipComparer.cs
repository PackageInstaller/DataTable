using System.Collections;
using System.Collections.Generic;
using ACT.Game.Data;
using ACT.UI.DataProxy;
using ACT.Utility;

namespace ACT.Model;

public class EquipComparer : IComparer<ItemUnifierProxy>
{
	private Dictionary<SortType, List<int>> _sortDic;

	public EquipComparer(Dictionary<SortType, List<int>> sortDic)
	{
		_sortDic = sortDic;
	}

	public void SetSortDic(Dictionary<SortType, List<int>> sortDic)
	{
		_sortDic = sortDic;
	}

	public int Compare(ItemUnifierProxy xProxy, ItemUnifierProxy yProxy)
	{
		if (xProxy == null && yProxy == null)
		{
			return 0;
		}
		if (xProxy == null)
		{
			return -1;
		}
		if (yProxy == null)
		{
			return 1;
		}
		int num = 0;
		Equip equip = xProxy.As<Equip>();
		Equip equip2 = yProxy.As<Equip>();
		if (_sortDic != null && _sortDic.ContainsKey(SortType.Propety))
		{
			foreach (int item in _sortDic[SortType.Propety])
			{
				float propertyValue = equip.GetPropertyValue(item);
				float propertyValue2 = equip2.GetPropertyValue(item);
				num = Comparer.Default.Compare(propertyValue, propertyValue2);
				if (num != 0)
				{
					break;
				}
			}
		}
		if (num == 0 && _sortDic != null && _sortDic.TryGetValue(SortType.Assist, out var value) && value.Count > 0)
		{
			if (value[0] == 0)
			{
				int level = equip.Level;
				int level2 = equip2.Level;
				if (level != level2)
				{
					num = level.CompareTo(level2);
				}
			}
			else
			{
				int quality = xProxy.Quality;
				int quality2 = yProxy.Quality;
				if (quality != quality2)
				{
					num = quality.CompareTo(quality2);
				}
			}
		}
		if (num == 0)
		{
			num = SortUtility.SortInventoryEquip(equip, equip2);
		}
		if (_sortDic != null && _sortDic.TryGetValue(SortType.SortRule, out var value2) && value2.Count > 0)
		{
			if (value2[0] == 0)
			{
				return -num;
			}
			return num;
		}
		return num;
	}
}
