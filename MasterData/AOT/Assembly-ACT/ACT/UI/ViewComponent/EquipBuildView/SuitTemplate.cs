using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model.EquipSuit;
using ACT.UI.DataProxy;
using Fundamental;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI.ViewComponent.EquipBuildView;

public class SuitTemplate : LoopScrollBaseItem
{
	public CanvasGroup canvasGroup;

	public LayoutElement layoutElement;

	public BetterAnimation betterAnimation;

	[SerializeField]
	private List<LiteItemUIComponent> m_Suits;

	private List<Selectable> m_SuitSelectables;

	[SerializeField]
	private LocalizeStringEvent m_SuitName;

	private void Awake()
	{
		m_SuitSelectables = ListPool<Selectable>.Get();
		foreach (LiteItemUIComponent suit in m_Suits)
		{
			m_SuitSelectables.Add(suit.GetComponent<Selectable>());
			suit.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(suit.OnItemClick, new UnityAction<ItemUIComponentBase>(OnItemClick));
		}
	}

	protected override void OnUnityDestroy()
	{
		base.OnUnityDestroy();
		foreach (LiteItemUIComponent suit in m_Suits)
		{
			suit.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Remove(suit.OnItemClick, new UnityAction<ItemUIComponentBase>(OnItemClick));
		}
		m_SuitSelectables.Clear();
		ListPool<Selectable>.Release(m_SuitSelectables);
		m_SuitSelectables = null;
	}

	public void Init(int suitId)
	{
		Init(CoreUtils.GetData(suitId, RuntimeConfigs.data.equipSuitDatas));
	}

	public void Init(EquipSuitData suitData)
	{
		if (suitData == null)
		{
			return;
		}
		int[] equipList = suitData.equipList;
		int num = equipList?.Length ?? 0;
		for (int i = 0; i < m_Suits.Count; i++)
		{
			LiteItemUIComponent liteItemUIComponent = m_Suits[i];
			if (!(liteItemUIComponent == null))
			{
				ReleaseSuitItemData(liteItemUIComponent);
				if (i >= num)
				{
					liteItemUIComponent.gameObject.SetActive(value: false);
					continue;
				}
				ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Equip>(equipList[i], 0L);
				liteItemUIComponent.Station = Station;
				liteItemUIComponent.IsChosen = false;
				liteItemUIComponent.IsHighLight = false;
				liteItemUIComponent.gameObject.SetActive(value: true);
				liteItemUIComponent.SetData(item, long.MinValue, ItemUIComponentBase.InitType.BagEquip);
				liteItemUIComponent.UpdatePerformance();
			}
		}
		m_SuitName.StringReference.TableEntryReference = EquipSuit.GetLocalizationName(suitData.id);
		SubscribeChosenChanged();
		UpdateItemUIChosenState();
	}

	private void ReleaseSuitItemData(LiteItemUIComponent suitItem)
	{
		ItemUnifierProxy item = suitItem.ItemUnifier;
		if (item != null)
		{
			suitItem.SetData((ItemUnifierProxy)null, long.MinValue, ItemUIComponentBase.InitType.BagEquip, ItemUIComponentBase.ItemCountShowType.Hide, false);
			ItemUnifierProxy.ItemUnifierPool.Release(ref item);
		}
	}

	public override void OnUnLoad()
	{
		UnbindChosenChanged();
		base.OnUnLoad();
	}

	public override void Hide()
	{
		UnbindChosenChanged();
		base.Hide();
	}

	public void UnbindChosenChanged()
	{
		if (Context is PopUpEquipMakeShowView popUpEquipMakeShowView)
		{
			popUpEquipMakeShowView.OnChosenEquipChanged = (Action)Delegate.Remove(popUpEquipMakeShowView.OnChosenEquipChanged, new Action(UpdateItemUIChosenState));
		}
	}

	private void SubscribeChosenChanged()
	{
		if (Context is PopUpEquipMakeShowView popUpEquipMakeShowView)
		{
			popUpEquipMakeShowView.OnChosenEquipChanged = (Action)Delegate.Remove(popUpEquipMakeShowView.OnChosenEquipChanged, new Action(UpdateItemUIChosenState));
			popUpEquipMakeShowView.OnChosenEquipChanged = (Action)Delegate.Combine(popUpEquipMakeShowView.OnChosenEquipChanged, new Action(UpdateItemUIChosenState));
		}
	}

	public void SetItemSelectableInteractable(bool interactable)
	{
		foreach (Selectable suitSelectable in m_SuitSelectables)
		{
			if (suitSelectable != null)
			{
				suitSelectable.interactable = interactable;
			}
		}
	}

	private void OnItemClick(ItemUIComponentBase itemUIComponentBase)
	{
		if (itemUIComponentBase != null && itemUIComponentBase.ItemUnifier != null)
		{
			((PopUpEquipMakeShowView)Context).CurrentChosenEquipId = itemUIComponentBase.ItemUnifier.Id;
		}
	}

	private void UpdateItemUIChosenState()
	{
		if (!(Context is PopUpEquipMakeShowView popUpEquipMakeShowView))
		{
			return;
		}
		foreach (LiteItemUIComponent suit in m_Suits)
		{
			if (!(suit == null) && suit.ItemUnifier != null)
			{
				if (suit.ItemUnifier.Id == popUpEquipMakeShowView.CurrentChosenEquipId && !suit.IsChosen)
				{
					suit.IsChosen = true;
					suit.UpdatePerformance();
				}
				else if (suit.ItemUnifier.Id == popUpEquipMakeShowView.LastChosenEquipId && suit.IsChosen)
				{
					suit.IsChosen = false;
					suit.UpdatePerformance();
				}
			}
		}
	}
}
