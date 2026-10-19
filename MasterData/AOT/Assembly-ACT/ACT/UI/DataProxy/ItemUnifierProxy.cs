using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using Fundamental;

namespace ACT.UI.DataProxy;

public class ItemUnifierProxy
{
	public static class ItemUnifierPool
	{
		public static ItemUnifierProxy Get<T>(T source) where T : IBagItem
		{
			ItemUnifierProxy itemUnifierProxy = new ItemUnifierProxy();
			itemUnifierProxy.Source = source;
			itemUnifierProxy.AddListener();
			return itemUnifierProxy;
		}

		public static ItemUnifierProxy Get<T>(int id, long count = 0L) where T : IBagItem, new()
		{
			T val = new T();
			if (!(val is Item item))
			{
				if (!(val is Equip equip))
				{
					if (!(val is Gem gem))
					{
						if (!(val is Character character))
						{
							if (!(val is BloodBottleData bloodBottleData))
							{
								if (!(val is BloodBottleMaterial bloodBottleMaterial))
								{
									throw new NotImplementedException();
								}
								PotionAdditives bloodBottleMaterialByItemId = TableRule.GetBloodBottleMaterialByItemId(id);
								if (bloodBottleMaterialByItemId == null)
								{
									return null;
								}
								bloodBottleMaterial.BindAdditivesData(bloodBottleMaterialByItemId);
							}
							else
							{
								PotionData bloodBottleByItemId = TableRule.GetBloodBottleByItemId(id);
								if (bloodBottleByItemId == null)
								{
									return null;
								}
								bloodBottleData.BindPotionData(bloodBottleByItemId);
							}
						}
						else
						{
							character.Id = id;
							character.Refresh();
						}
					}
					else
					{
						gem.Id = id;
						gem.Refresh();
					}
				}
				else
				{
					equip.Id = id;
					equip.Refresh();
				}
			}
			else
			{
				item.Id = id;
				item.Count = (int)count;
				item.Refresh();
			}
			ItemUnifierProxy itemUnifierProxy = new ItemUnifierProxy();
			itemUnifierProxy.Source = val;
			itemUnifierProxy.AddListener();
			return itemUnifierProxy;
		}

		public static void GetList<T>(IEnumerable<T> list, List<ItemUnifierProxy> output) where T : IBagItem
		{
			foreach (T item2 in list)
			{
				ItemUnifierProxy item = Get(item2);
				output.Add(item);
			}
		}

		public static void GetReplaceList<T>(IEnumerable<T> list, List<ItemUnifierProxy> output) where T : IBagItem
		{
			int num = 0;
			foreach (T item in list)
			{
				if (num < output.Count)
				{
					ItemUnifierProxy itemUnifierProxy = output[num];
					itemUnifierProxy.Source = item;
				}
				else
				{
					ItemUnifierProxy itemUnifierProxy = Get(item);
					output.Add(itemUnifierProxy);
				}
				num++;
			}
		}

		public static void Release(ref ItemUnifierProxy item)
		{
			if (item != null)
			{
				item.Source = null;
				item.RewardTag = UniversalItemTag.Default;
				item.Context = null;
				item.RemoveListener();
			}
		}

		public static void Release(List<ItemUnifierProxy> items)
		{
			foreach (ItemUnifierProxy item2 in items)
			{
				if (item2 != null)
				{
					ItemUnifierProxy item = item2;
					Release(ref item);
				}
			}
			items.Clear();
		}
	}

	public static ItemUnifierProxy Empty = new ItemUnifierProxy
	{
		Source = null
	};

	private IBagItem m_Source;

	public int Quality { get; protected set; }

	public int Id { get; protected set; }

	public long Count { get; set; }

	public int Name { get; set; }

	public ItemData ItemData { get; private set; }

	public int Uid { get; private set; }

	public IBagItem Source
	{
		get
		{
			return m_Source;
		}
		private set
		{
			m_Source = value;
			if (value == null)
			{
				Id = 0;
				Quality = 0;
				Count = 0L;
				ItemData = null;
				Name = 0;
				Uid = 0;
			}
			else
			{
				Id = value.GetId();
				Quality = value.GetQuality();
				Count = value.GetCount();
				Name = value.GetLocalizationName();
				ItemData = CoreUtils.GetData(Id, RuntimeConfigs.data.itemDatas);
				Uid = value.GetUid();
			}
		}
	}

	public object Context { get; set; }

	public UniversalItemTag RewardTag { get; set; }

	public long ExpireTime
	{
		get
		{
			if (!(Source is Item item))
			{
				return 0L;
			}
			return item.GetExpireTime();
		}
	}

	public Action<ItemUnifierProxy> OnValueChanged { get; set; }

	~ItemUnifierProxy()
	{
		RemoveListener();
	}

	private ItemUnifierProxy()
	{
	}

	public T As<T>() where T : IBagItem
	{
		return (T)Source;
	}

	private void AddListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, NotifyChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, NotifyChange);
	}

	private void RemoveListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, NotifyChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, NotifyChange);
		OnValueChanged = null;
	}

	private void NotifyChange(BaseEventContent baseEventContent)
	{
		if (baseEventContent is ItemChangeEvt itemChangeEvt && itemChangeEvt.ItemProxies.Exists((ItemUnifierProxy x) => x.Id == Id))
		{
			OnValueChanged?.Invoke(this);
		}
		else if (baseEventContent is PlayerAttributeChangeEvt playerAttributeChangeEvt && playerAttributeChangeEvt.id == Id)
		{
			OnValueChanged?.Invoke(this);
		}
	}

	public virtual T GetItemData<T>(Dictionary<int, T> table)
	{
		return CoreUtils.GetData(Id, table);
	}
}
