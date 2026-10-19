using System.Collections.Generic;
using ACT.Game.Data;
using Fundamental;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class DeleteItemSelectBar : UIBehaviour
{
	public DeleteQuickSelectItem[] levelSelectBtns;

	public DeleteInventoryItemView deleteView;

	private Dictionary<int, List<Item>> items;

	private Dictionary<int, List<Weapon>> weapons;

	private Dictionary<int, List<Chip>> chips;

	private MonoInventoryView bagView;

	public void Init()
	{
		bagView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BAGPANEL) as MonoInventoryView;
		items = new Dictionary<int, List<Item>>();
		weapons = new Dictionary<int, List<Weapon>>();
		chips = new Dictionary<int, List<Chip>>();
		for (int i = 0; i < levelSelectBtns.Length; i++)
		{
			int quality = levelSelectBtns[i].quality;
			if (items.TryGetValue(quality, out var value))
			{
				levelSelectBtns[i].ChangeCountText(value.Count);
				continue;
			}
			if (weapons.TryGetValue(quality, out var value2))
			{
				levelSelectBtns[i].ChangeCountText(value2.Count);
				continue;
			}
			if (chips.TryGetValue(quality, out var value3))
			{
				levelSelectBtns[i].ChangeCountText(value3.Count);
			}
			levelSelectBtns[i].isChoose = false;
		}
		gameObject.SetActive(value: true);
	}

	public void UnInit()
	{
		ReSetUIState();
		items?.Clear();
		weapons?.Clear();
		chips?.Clear();
		gameObject.SetActive(value: false);
	}

	private void GetItemsFromInventory()
	{
	}

	public void AddDeleteItemsByQUality()
	{
		for (int i = 0; i < levelSelectBtns.Length; i++)
		{
			if (levelSelectBtns[i].isChoose)
			{
				_ = levelSelectBtns[i].quality;
				if (bagView == null)
				{
					return;
				}
			}
		}
		UnInit();
	}

	private void ReSetUIState()
	{
		for (int i = 0; i < levelSelectBtns.Length; i++)
		{
			if (levelSelectBtns[i].isChoose)
			{
				levelSelectBtns[i].isChoose = false;
			}
		}
	}
}
