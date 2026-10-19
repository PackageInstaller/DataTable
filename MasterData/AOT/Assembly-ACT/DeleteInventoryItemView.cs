using System;
using System.Collections.Generic;
using ACT.Event;
using ACT.UI;
using ACT.Utility;
using Bamboo.NumberString;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class DeleteInventoryItemView : UIBehaviour
{
	[Header("删除组件")]
	public Button add;

	public Button reduse;

	public Button maxAdd;

	public GameObject addForbiden;

	public GameObject reduseForbiden;

	public TextMeshProUGUI deleteCountUI;

	public GameObject tipsTitle;

	public GameObject deleteOptionsRoot;

	[Header("子页面")]
	public DeleteBag deleteBag;

	public DeleteItemSelectBar leftSelectBar;

	public TextMeshProUGUI curItemsCount;

	public Action setBagItemState;

	[NonSerialized]
	public bool isOpen;

	private ItemUIComponent _curSelectItem;

	private HashSet<ItemUIComponent> selectItems;

	private int m_itemTypeCount;

	private MonoInventoryView bagView;

	private int _deleteCount = 1;

	public ItemUIComponent curSelectItem
	{
		get
		{
			return _curSelectItem;
		}
		set
		{
			_curSelectItem = value;
		}
	}

	public int itemTypeCount
	{
		get
		{
			return m_itemTypeCount;
		}
		set
		{
			if (value >= 0)
			{
				m_itemTypeCount = value;
				curItemsCount.text = itemTypeCount.FastToString();
			}
		}
	}

	public int deleteCount
	{
		get
		{
			return _deleteCount;
		}
		set
		{
			if (value < 0)
			{
				return;
			}
			_deleteCount = value;
			deleteCountUI.text = _deleteCount.FastToString();
			tipsTitle.SetActive(_deleteCount == 0);
			deleteOptionsRoot.SetActive(_deleteCount != 0);
			if (_curSelectItem != null && !deleteBag.isShow)
			{
				if (_curSelectItem.ItemType != ItemUIComponentBase.InitType.BagWeapon)
				{
					ForibidAdd(_deleteCount == curSelectItem.item.Count);
					maxAdd.gameObject.SetActive(value: true);
				}
				else
				{
					maxAdd.gameObject.SetActive(value: false);
					ForibidAdd(forbiden: true);
				}
			}
		}
	}

	private void ListenEvt()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_OnItemUIComentCountChange, OnDeleteItemSelectCountChange);
	}

	private void RemoveListenEvt()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_OnItemUIComentCountChange, OnDeleteItemSelectCountChange);
	}

	private void OnDeleteItemSelectCountChange(BaseEventContent obj)
	{
		if (obj is OnItemMutipleChoose onItemMutipleChoose)
		{
			itemTypeCount = onItemMutipleChoose.ItemTypeCount;
			_curSelectItem = onItemMutipleChoose.Choose;
			deleteCount = onItemMutipleChoose.itemCount;
		}
	}

	public void init()
	{
		if (!isOpen)
		{
			isOpen = true;
			bagView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BAGPANEL) as MonoInventoryView;
			selectItems = new HashSet<ItemUIComponent>();
			itemTypeCount = 0;
			deleteCount = 0;
			tipsTitle.SetActive(isOpen);
			deleteOptionsRoot.SetActive(!isOpen);
			setBagItemState?.Invoke();
			DeleteBtnAddListener();
			ListenEvt();
		}
	}

	public void UnInit()
	{
		if (isOpen)
		{
			isOpen = false;
			gameObject.SetActive(isOpen);
			ResetData();
			setBagItemState?.Invoke();
			deleteBag.CloseBag();
			leftSelectBar.UnInit();
		}
	}

	public void OnSelected(ItemUIComponent select)
	{
	}

	public void ForibidAdd(bool forbiden)
	{
		add.interactable = !forbiden;
		addForbiden.SetActive(forbiden);
	}

	public void ForibidReduse(bool forbiden)
	{
		reduse.interactable = !forbiden;
		reduseForbiden.SetActive(forbiden);
	}

	public void AddDeleItem()
	{
	}

	public void ReduceDeleItem()
	{
	}

	public void MaxNumSelect()
	{
	}

	public void OpenDeleteBag()
	{
		if (deleteBag.isShow)
		{
			deleteBag.CloseBag();
		}
		else
		{
			deleteBag.init();
		}
	}

	public void ComfirmDelete()
	{
		GameUtility.OpenToolTip(1596);
	}

	public void DeleteBtnAddListener()
	{
		add.onClick.RemoveAllListeners();
		add.onClick.AddListener(() =>
		{
			AddDeleItem();
		});
		reduse.onClick.RemoveAllListeners();
		reduse.onClick.AddListener(() =>
		{
			ReduceDeleItem();
		});
		maxAdd.onClick.RemoveAllListeners();
		maxAdd.onClick.AddListener(() =>
		{
			MaxNumSelect();
		});
	}

	public void ResetData()
	{
		itemTypeCount = 0;
		selectItems.Clear();
		addForbiden.SetActive(value: false);
		reduseForbiden.SetActive(value: false);
		_curSelectItem = null;
		RemoveListenEvt();
	}
}
