using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Game.Data;

namespace ACT.UI.DataProxy;

public static class ItemUnifierMerger
{
	public static List<UniversalItem> MergeUniversalItems(IList<UniversalItem> items)
	{
		List<UniversalItem> list = new List<UniversalItem>();
		if (items == null)
		{
			return list;
		}
		foreach (UniversalItem item in items)
		{
			if (item == null)
			{
				continue;
			}
			UniversalItem universalItem = list.FirstOrDefault((UniversalItem current) => current.Index == item.Index && current.Tag == item.Tag);
			if (universalItem == null)
			{
				list.Add(item.Clone());
				continue;
			}
			universalItem.Count += item.Count;
			if (universalItem.Uid >= 0 && item.Uid < 0)
			{
				universalItem.Uid = item.Uid;
			}
		}
		return list;
	}

	public static bool TryGetUniversalItemTag(ItemUnifierProxy proxy, out UniversalItemTag tag)
	{
		if (proxy != null && proxy.RewardTag != UniversalItemTag.Default)
		{
			tag = proxy.RewardTag;
			return true;
		}
		if (proxy?.Context is UniversalItemTag universalItemTag)
		{
			tag = universalItemTag;
			return true;
		}
		tag = UniversalItemTag.Default;
		return false;
	}

	private static (int id, int tagKey) GetMergeGroupKey(ItemUnifierProxy item)
	{
		if (TryGetUniversalItemTag(item, out var tag))
		{
			return (id: item.Id, tagKey: (int)tag);
		}
		return (id: item.Id, tagKey: -1);
	}

	public static List<ItemUnifierProxy> MergeItems(List<ItemUnifierProxy> items)
	{
		if (items == null || items.Count == 0)
		{
			return new List<ItemUnifierProxy>();
		}
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		foreach (IGrouping<(int, int), ItemUnifierProxy> item in items.Where((ItemUnifierProxy item) => item != null && item.Source != null).GroupBy(GetMergeGroupKey).ToList())
		{
			ItemUnifierProxy itemUnifierProxy = item.First();
			long totalCount = item.Sum((ItemUnifierProxy item) => item.Count);
			ItemUnifierProxy itemUnifierProxy2 = CreateMergedProxy(itemUnifierProxy, totalCount);
			if (itemUnifierProxy2 != null)
			{
				itemUnifierProxy2.Context = itemUnifierProxy.Context;
				itemUnifierProxy2.RewardTag = itemUnifierProxy.RewardTag;
				list.Add(itemUnifierProxy2);
			}
		}
		return list;
	}

	public static void MergeItemsInPlace(List<ItemUnifierProxy> items)
	{
		if (items == null || items.Count <= 1)
		{
			return;
		}
		Dictionary<(int, int), ItemUnifierProxy> dictionary = new Dictionary<(int, int), ItemUnifierProxy>();
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		foreach (ItemUnifierProxy item2 in items)
		{
			if (item2 != null && item2.Source != null)
			{
				(int, int) mergeGroupKey = GetMergeGroupKey(item2);
				if (dictionary.TryGetValue(mergeGroupKey, out var value))
				{
					MergeIntoExistingItem(value, item2);
					list.Add(item2);
				}
				else
				{
					dictionary[mergeGroupKey] = item2;
				}
			}
		}
		for (int num = list.Count - 1; num >= 0; num--)
		{
			ItemUnifierProxy itemUnifierProxy = list[num];
			items.Remove(itemUnifierProxy);
			ItemUnifierProxy item = itemUnifierProxy;
			ItemUnifierProxy.ItemUnifierPool.Release(ref item);
		}
	}

	private static ItemUnifierProxy CreateMergedProxy(ItemUnifierProxy baseItem, long totalCount)
	{
		if (baseItem.Source == null)
		{
			return null;
		}
		IBagItem source = baseItem.Source;
		ItemUnifierProxy itemUnifierProxy;
		if (!(source is Item))
		{
			if (!(source is Equip))
			{
				if (!(source is Gem))
				{
					if (!(source is Character))
					{
						throw new NotImplementedException($"Unsupported IBagItem type: {baseItem.Source.GetType()}");
					}
					itemUnifierProxy = CreateCharacterProxy(baseItem.Id);
				}
				else
				{
					itemUnifierProxy = CreateGemProxy(baseItem.Id);
				}
			}
			else
			{
				itemUnifierProxy = CreateEquipProxy(baseItem.Id);
			}
		}
		else
		{
			itemUnifierProxy = CreateItemProxy(baseItem.Id, totalCount);
		}
		ItemUnifierProxy itemUnifierProxy2 = itemUnifierProxy;
		itemUnifierProxy2.Count = totalCount;
		return itemUnifierProxy2;
	}

	private static ItemUnifierProxy CreateItemProxy(int id, long count)
	{
		return ItemUnifierProxy.ItemUnifierPool.Get<Item>(id, count);
	}

	private static ItemUnifierProxy CreateEquipProxy(int id)
	{
		return ItemUnifierProxy.ItemUnifierPool.Get<Equip>(id, 0L);
	}

	private static ItemUnifierProxy CreateGemProxy(int id)
	{
		return ItemUnifierProxy.ItemUnifierPool.Get<Gem>(id, 0L);
	}

	private static ItemUnifierProxy CreateCharacterProxy(int id)
	{
		return ItemUnifierProxy.ItemUnifierPool.Get<Character>(id, 0L);
	}

	private static void MergeIntoExistingItem(ItemUnifierProxy target, ItemUnifierProxy source)
	{
		if (target.Source is Item item && source.Source is Item)
		{
			target.Count += source.Count;
			item.Count = (int)target.Count;
		}
	}

	public static List<ItemUnifierProxy> MergeAndRelease(List<ItemUnifierProxy> originalList)
	{
		List<ItemUnifierProxy> result = MergeItems(originalList);
		if (originalList != null)
		{
			for (int num = originalList.Count - 1; num >= 0; num--)
			{
				ItemUnifierProxy item = originalList[num];
				ItemUnifierProxy.ItemUnifierPool.Release(ref item);
			}
			originalList.Clear();
		}
		return result;
	}

	public static List<ItemUnifierProxy> MergeMultipleLists(params List<ItemUnifierProxy>[] lists)
	{
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		foreach (List<ItemUnifierProxy> list2 in lists)
		{
			if (list2 != null)
			{
				list.AddRange(list2);
			}
		}
		return MergeItems(list);
	}

	public static void SafeReleaseList(List<ItemUnifierProxy> list)
	{
		if (list != null)
		{
			for (int num = list.Count - 1; num >= 0; num--)
			{
				ItemUnifierProxy item = list[num];
				ItemUnifierProxy.ItemUnifierPool.Release(ref item);
			}
			list.Clear();
		}
	}
}
