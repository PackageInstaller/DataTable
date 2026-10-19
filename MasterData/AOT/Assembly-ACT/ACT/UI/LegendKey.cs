using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI.DataProxy;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class LegendKey : MonoBehaviour, IUIFrameElement
{
	public TMP_Text count;

	private int m_LegendKeyId;

	public void Initialize()
	{
		m_LegendKeyId = RuntimeConfigs.data.game.CharacterMissionCostItem[0].id;
		UpdateCount();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BagItemChange, OnLegendKeyChanged);
	}

	public void UnInitialize()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BagItemChange, OnLegendKeyChanged);
	}

	private void OnLegendKeyChanged(BaseEventContent e)
	{
		if (e is ItemChangeEvt itemChangeEvt && itemChangeEvt.ItemProxies.Exists((ItemUnifierProxy x) => x.Id == m_LegendKeyId))
		{
			UpdateCount();
		}
	}

	private void UpdateCount()
	{
		int itemCount = G.localPlayer.Inventory.GetItemCount(m_LegendKeyId);
		count.SetText(itemCount.ToString());
	}

	public void ShowDetailPanel()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, new Item
		{
			Id = RuntimeConfigs.data.game.CharacterMissionCostItem[0].id,
			Count = 0
		});
	}
}
