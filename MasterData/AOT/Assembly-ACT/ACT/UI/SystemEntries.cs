using System.Collections.Generic;
using ACT.Event;
using ACT.Model;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class SystemEntries : MonoBehaviour, IUIFrameElement
{
	private MonoBattleMainBaseView view;

	public void Initialize()
	{
		for (int i = 0; i < transform.childCount; i++)
		{
			Transform child = transform.GetChild(i);
			EscItem componentInChildren = child.GetComponentInChildren<EscItem>(includeInactive: true);
			if (!componentInChildren)
			{
				continue;
			}
			bool flag = Singleton<SystemUnlockManager>.instance.IsUnlock(componentInChildren.systemId);
			child.gameObject.SetActive(flag && Model<BattleMainModel>.Interface.hudType == HudType.MainWorldType);
			if (Model<ActivityCenterModel>.Interface != null && componentInChildren.systemId == 3001 && !Model<ActivityCenterModel>.Interface.CheckIsHasOpeningActivity())
			{
				child.gameObject.SetActive(value: false);
			}
			if (componentInChildren.systemId == 1044 && Model<BattlePassModel>.Interface != null && !Model<BattlePassModel>.Interface.AvailAble)
			{
				child.gameObject.SetActive(value: false);
			}
			view = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BATTLEMAIN) as MonoBattleMainBaseView;
			if (view != null)
			{
				if (view.AllEscItem.TryGetValue(componentInChildren.systemId, out var value))
				{
					value = componentInChildren;
				}
				else
				{
					view.AllEscItem.Add(componentInChildren.systemId, componentInChildren);
				}
			}
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, RefreshSystems);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TempleInstance, ShowInTemple);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EnterTrainingGround, ShowInTrainingGround);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EnterRaid, ShowInRaid);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EnterAbyss, ShowInAbyss);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.EnterRogue, ShowInRouge);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RefreshEscitem, RefreshSystemsItems);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_RefreshActivityCenter, OnRefreshActivityCenter);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RefreshSystemEntriesInBossChaseBattle, OnRefreshSystemEntriesInBossChaseBattle);
		Model<BattlePassModel>.Interface.TimeUpdateAction += UpdateBattlePassTime;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
	}

	private void UpdateBattlePassTime()
	{
		OpenNeedActiveEscItems(null);
	}

	private void ShowInRouge(BaseEventContent obj)
	{
		if (obj is InRogueInfo inRogueInfo)
		{
			OpenNeedActiveEscItems(inRogueInfo.showsEscItemSystemIds);
		}
	}

	private void RefreshSystems(BaseEventContent obj)
	{
		if (Model<BattleMainModel>.Interface.hudType != HudType.MainWorldType || !(obj is SystemOpenEvt systemOpenEvt))
		{
			return;
		}
		for (int i = 0; i < transform.childCount; i++)
		{
			Transform child = transform.GetChild(i);
			EscItem component = child.GetComponent<EscItem>();
			if ((bool)component)
			{
				if (systemOpenEvt.systemId == component.systemId)
				{
					child.gameObject.SetActive(systemOpenEvt.unLock && Singleton<SystemUnlockManager>.instance.IsSystemUnlock(component.systemId));
				}
				if (systemOpenEvt.systemId == 3001 && component.systemId == 3001 && Model<ActivityCenterModel>.Interface != null && Model<ActivityCenterModel>.Interface.GetOpeningActivitys().Count <= 0)
				{
					child.gameObject.SetActive(value: false);
				}
				if (component.systemId == 1044 && Model<BattlePassModel>.Interface != null && !Model<BattlePassModel>.Interface.AvailAble)
				{
					child.gameObject.SetActive(value: false);
				}
			}
		}
	}

	public void UnInitialize()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, RefreshSystems);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TempleInstance, ShowInTemple);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EnterTrainingGround, ShowInTrainingGround);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EnterRaid, ShowInRaid);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EnterAbyss, ShowInAbyss);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EnterRogue, ShowInRouge);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RefreshEscitem, RefreshSystemsItems);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_RefreshActivityCenter, OnRefreshActivityCenter);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RefreshSystemEntriesInBossChaseBattle, OnRefreshSystemEntriesInBossChaseBattle);
		Model<BattlePassModel>.Interface.TimeUpdateAction -= UpdateBattlePassTime;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
	}

	private void ShowInRaid(BaseEventContent obj)
	{
		if (obj is InRaidInfo inRaidInfo)
		{
			OpenNeedActiveEscItems(inRaidInfo.showsEscItemSystemIds);
		}
	}

	private void ShowInAbyss(BaseEventContent obj)
	{
		if (obj is InAbyssInfo inAbyssInfo)
		{
			OpenNeedActiveEscItems(inAbyssInfo.showsEscItemSystemIds);
		}
	}

	public void ShowInTrainingGround(BaseEventContent obj)
	{
		if (obj is InTrainingGroundInfo inTrainingGroundInfo)
		{
			OpenNeedActiveEscItems(inTrainingGroundInfo.showsEscItemSystemIds);
		}
	}

	public void ShowInTemple(BaseEventContent obj)
	{
		if (obj is InTempleInfo inTempleInfo)
		{
			OpenNeedActiveEscItems(inTempleInfo.showsEscItemSystemIds);
		}
	}

	private void RefreshSystemsItems(BaseEventContent obj)
	{
		OpenNeedActiveEscItems(null);
	}

	private void OpenNeedActiveEscItems(List<int> systemIds)
	{
		for (int i = 0; i < transform.childCount; i++)
		{
			Transform child = transform.GetChild(i);
			EscItem component = child.GetComponent<EscItem>();
			if (!component)
			{
				continue;
			}
			if (Model<BattleMainModel>.Interface.hudType == HudType.MainWorldType || systemIds == null)
			{
				child.gameObject.SetActive(Singleton<SystemUnlockManager>.instance.IsSystemUnlock(component.systemId));
				if (component.systemId == 3001 && component.systemId == 3001 && Model<ActivityCenterModel>.Interface != null && Model<ActivityCenterModel>.Interface.GetOpeningActivitys().Count <= 0)
				{
					child.gameObject.SetActive(value: false);
				}
				if (component.systemId == 1044 && Model<BattlePassModel>.Interface != null && !Model<BattlePassModel>.Interface.AvailAble)
				{
					child.gameObject.SetActive(value: false);
				}
			}
			else
			{
				child.gameObject.SetActive(systemIds.Contains(component.systemId) && Singleton<SystemUnlockManager>.instance.IsSystemUnlock(component.systemId));
			}
		}
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, RefreshSystems);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TempleInstance, ShowInTemple);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EnterTrainingGround, ShowInTrainingGround);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EnterRaid, ShowInRaid);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.EnterAbyss, ShowInAbyss);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_RefreshActivityCenter, OnRefreshActivityCenter);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
	}

	private void OnRefreshActivityCenter(BaseEventContent obj)
	{
		for (int i = 0; i < transform.childCount; i++)
		{
			Transform child = transform.GetChild(i);
			EscItem component = child.GetComponent<EscItem>();
			if ((bool)component && Model<ActivityCenterModel>.Interface != null && component.systemId == 3001 && !Model<ActivityCenterModel>.Interface.CheckIsHasOpeningActivity())
			{
				child.gameObject.SetActive(value: false);
			}
		}
	}

	private void OnSystemBlockStatusChanged(BaseEventContent obj)
	{
		if (obj is SystemBlockStatusChangedEvt)
		{
			OpenNeedActiveEscItems((Model<BattleMainModel>.Interface.hudType == HudType.MainWorldType) ? null : Model<BattleMainModel>.Interface.curSubWorldHudTypeOpenSystems);
		}
	}

	private void OnRefreshSystemEntriesInBossChaseBattle(BaseEventContent obj)
	{
		if (!(obj is RefreshSystemEntriesInBossChaseBattle refreshSystemEntriesInBossChaseBattle))
		{
			return;
		}
		for (int i = 0; i < transform.childCount; i++)
		{
			Transform child = transform.GetChild(i);
			EscItem component = child.GetComponent<EscItem>();
			if ((bool)component)
			{
				bool active = refreshSystemEntriesInBossChaseBattle.isActive && Singleton<SystemUnlockManager>.instance.IsSystemUnlock(component.systemId);
				if (component.systemId == 3001 && Model<ActivityCenterModel>.Interface != null && Model<ActivityCenterModel>.Interface.GetOpeningActivitys().Count <= 0)
				{
					active = false;
				}
				child.gameObject.SetActive(active);
			}
		}
	}
}
