using System.Collections.Generic;
using ACT.Battle;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Model;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class GamePadMenuList : MonoBehaviour
{
	public List<EscItem> gamePadSystemEntries;

	private void Awake()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, RefreshEntryActive);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_RefreshActivityCenter, OnRefreshActivityCenter);
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, RefreshEntryActive);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_RefreshActivityCenter, OnRefreshActivityCenter);
	}

	public void OnEnable()
	{
		if (MonoECS.instance.IsGamePadMode())
		{
			RefreshDisplay();
		}
	}

	public void RefreshDisplay()
	{
		RefreshEntryActive(null);
		UpdateRedDotDisplayOnViewOpen();
	}

	private void UpdateRedDotDisplayOnViewOpen()
	{
		List<EscItem> list = gamePadSystemEntries;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (KeyValuePair<int, bool> system in G.localPlayer.redPoints.Systems)
		{
			if (RuntimeConfigs.data.systemOpens.TryGetValue(system.Key, out var value) && value.systemUnlockPrompts)
			{
				RefreshRedDot(system.Key, system.Value);
			}
		}
	}

	public void RefreshRedDot(int systemId, bool systemOpenDotActive)
	{
		List<EscItem> list = gamePadSystemEntries;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		foreach (EscItem gamePadSystemEntry in gamePadSystemEntries)
		{
			if (!(gamePadSystemEntry == null) && gamePadSystemEntry.systemId == systemId)
			{
				gamePadSystemEntry.RefreshRedDot(systemId, systemOpenDotActive);
			}
		}
	}

	private void RefreshEntryActive(BaseEventContent obj)
	{
		List<EscItem> list = gamePadSystemEntries;
		if (list == null || list.Count <= 0 || !(Singleton<NewUIManager>.instance.GetTopActivePanel() is BattleMainUIController battleMainUIController) || !(battleMainUIController.GetUIView() is MonoBattleMainBaseView))
		{
			return;
		}
		foreach (EscItem gamePadSystemEntry in gamePadSystemEntries)
		{
			if (!(gamePadSystemEntry == null))
			{
				if (Model<BattleMainModel>.Interface.hudType != HudType.MainWorldType)
				{
					gamePadSystemEntry.gameObject.SetActive(Singleton<SystemUnlockManager>.instance.IsSystemUnlock(gamePadSystemEntry.systemId) && Model<BattleMainModel>.Interface.curSubWorldHudTypeOpenSystems.Contains(gamePadSystemEntry.systemId));
				}
				else
				{
					gamePadSystemEntry.gameObject.SetActive(Singleton<SystemUnlockManager>.instance.IsSystemUnlock(gamePadSystemEntry.systemId));
				}
				if (gamePadSystemEntry.systemId == 3001 && !Model<ActivityCenterModel>.Interface.CheckIsHasOpeningActivity())
				{
					gamePadSystemEntry.gameObject.SetActive(value: false);
				}
			}
		}
	}

	private void OnSystemBlockStatusChanged(BaseEventContent obj)
	{
		if (obj is SystemBlockStatusChangedEvt)
		{
			RefreshEntryActive(null);
		}
	}

	private void OnRefreshActivityCenter(BaseEventContent obj)
	{
		RefreshEntryActive(null);
	}
}
