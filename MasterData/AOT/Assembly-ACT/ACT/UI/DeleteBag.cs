using System;
using Bamboo.NumberString;
using Fundamental;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.UI;

public class DeleteBag : UIBehaviour
{
	public MonoScrollBagComponent scrollComponent;

	private MonoScrollBagComponent.Param m_ScrollBagParam;

	public DeleteInventoryItemView deleteView;

	private MonoInventoryView _bagView;

	private ItemUIComponent _lastSelected;

	private int curSelectItemCount;

	public bool isShow { get; set; }

	public void init()
	{
		if (!isShow)
		{
			isShow = true;
			_bagView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BAGPANEL) as MonoInventoryView;
			scrollComponent.InitSortDropDown(MonoScrollBagComponent.SortType.Inventory);
			RefreshDeleteBag();
			ReListenDeleteBtnEvent();
			deleteView.curSelectItem = null;
			gameObject.SetActive(value: true);
		}
	}

	public void RefreshDeleteBag()
	{
		ClearScrollBagParamData();
		curSelectItemCount = 0;
		scrollComponent.UnLoadLastChosen();
		m_ScrollBagParam.needRefeshState = false;
		m_ScrollBagParam.isLock = false;
		m_ScrollBagParam.isMultiSelect = false;
		scrollComponent.Init(m_ScrollBagParam, -1, -1);
		ReSetDeleteViewUIComponent(OpenDeleteRoot: false);
		_lastSelected = null;
	}

	public void CloseBag()
	{
		if (isShow)
		{
			isShow = false;
			deleteView.DeleteBtnAddListener();
			deleteView.curSelectItem = null;
			ReSetDeleteViewUIComponent(OpenDeleteRoot: false);
			gameObject.SetActive(value: false);
		}
	}

	private void ClearScrollBagParamData()
	{
		if (m_ScrollBagParam.allItems.items != null)
		{
			m_ScrollBagParam.allItems.items = null;
		}
		if (m_ScrollBagParam.allItems.weapons != null)
		{
			m_ScrollBagParam.allItems.weapons = null;
		}
		if (m_ScrollBagParam.allItems.chips != null)
		{
			m_ScrollBagParam.allItems.chips = null;
		}
	}

	public void RefreshCellState(ItemUIComponent btn, int index)
	{
		btn.gameObject.SetActive(value: true);
		btn.showDetailPanel = false;
		btn.OnItemClick = null;
		ItemUIComponent itemUIComponent = btn;
		itemUIComponent.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			OnSelectItem(btn);
		}));
		if ((bool)btn.reduceBtn)
		{
			btn.reduceBtn.onClick.RemoveAllListeners();
		}
		btn.OnMulitSelect();
	}

	private void OnSelectItem(ItemUIComponent choose)
	{
		if (_lastSelected != null)
		{
			if (_lastSelected == choose)
			{
				return;
			}
			_lastSelected.isChosen = false;
		}
		_lastSelected = choose;
		choose.isChosen = true;
		choose.UpdateReduceBtn(active: true);
		ItemUIComponentBase.InitType itemType = choose.ItemType;
		if ((uint)(itemType - 1) <= 1u)
		{
			deleteView.deleteCount = (curSelectItemCount = 1);
		}
		else
		{
			deleteView.deleteCount = choose.item.Count;
		}
		ReSetDeleteViewUIComponent(OpenDeleteRoot: true);
		bool flag = _lastSelected.ItemType == ItemUIComponentBase.InitType.BagWeapon || _lastSelected.ItemType == ItemUIComponentBase.InitType.BagChip;
		deleteView.maxAdd.gameObject.SetActive(!flag);
		deleteView.ForibidAdd(flag || _lastSelected.item.Count == curSelectItemCount);
		deleteView.ForibidReduse(flag);
	}

	private void ReListenDeleteBtnEvent()
	{
		deleteView.add.onClick.RemoveAllListeners();
		deleteView.add.onClick.AddListener(() =>
		{
			if (!(_lastSelected == null))
			{
				deleteView.deleteCount++;
				UpdateDatas(deleteView.deleteCount);
				_lastSelected.itemCount.text = deleteView.deleteCount.FastToString();
				if (deleteView.deleteCount == curSelectItemCount)
				{
					deleteView.ForibidAdd(forbiden: true);
				}
			}
		});
		deleteView.reduse.onClick.RemoveAllListeners();
		deleteView.reduse.onClick.AddListener(() =>
		{
			if (!(_lastSelected == null))
			{
				deleteView.deleteCount--;
				UpdateDatas(deleteView.deleteCount);
				_lastSelected.itemCount.text = deleteView.deleteCount.FastToString();
				if (deleteView.deleteCount != 0 && deleteView.deleteCount < curSelectItemCount)
				{
					deleteView.ForibidAdd(forbiden: false);
				}
			}
		});
		deleteView.maxAdd.onClick.RemoveAllListeners();
		deleteView.maxAdd.onClick.AddListener(() =>
		{
			if (deleteView.deleteCount < curSelectItemCount && !(_lastSelected == null))
			{
				deleteView.deleteCount = curSelectItemCount;
				UpdateDatas(deleteView.deleteCount);
				deleteView.ForibidAdd(forbiden: true);
				_lastSelected.itemCount.text = deleteView.deleteCount.FastToString();
			}
		});
	}

	private void UpdateDatas(int changeValue)
	{
	}

	private void ReSetDeleteViewUIComponent(bool OpenDeleteRoot)
	{
		deleteView.tipsTitle.SetActive(!OpenDeleteRoot);
		deleteView.deleteOptionsRoot.SetActive(OpenDeleteRoot);
	}
}
