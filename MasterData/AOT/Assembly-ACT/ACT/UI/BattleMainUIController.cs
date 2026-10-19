using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Bamboo.NumberString;
using Fundamental;
using UI.ViewComponent.BattlemainView.ActComponent;

namespace ACT.UI;

[UIPreload(DeviceMemoryTier.Always)]
public class BattleMainUIController : BaseUIController
{
	public override UIPanelType PanelType => UIPanelType.Panel;

	public override bool IsConnectSystem => false;

	public override int SystemId => 0;

	public override bool RequirePauseGame => false;

	public override bool RequireCatchScreen => false;

	public override UITransitionStrategy TransitionStrategy => UITransitionStrategy.Sequence;

	public override UILifetimePolicy LifetimePolicy => UILifetimePolicy.Never;

	public void HideCanvas()
	{
		if (_uiView is MonoBattleMainBaseView monoBattleMainBaseView)
		{
			monoBattleMainBaseView.SetCanvasGroup(active: false);
			monoBattleMainBaseView.PublishContentCanvasLayerChanged(Singleton<NewUIManager>.instance.HideLayer);
		}
	}

	public void ShowCanvas()
	{
		if (_uiView is MonoBattleMainBaseView monoBattleMainBaseView)
		{
			monoBattleMainBaseView.SetCanvasGroup(active: true);
			monoBattleMainBaseView.PublishContentCanvasLayerChanged(Singleton<NewUIManager>.instance.UILayer);
		}
	}

	protected override void OnInit()
	{
		base.OnInit();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_RefreshHUDSystemOpenRedDot, OnSystemRedDotStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.HudPotionCpUpdate, OnHudPotionCpUpdate);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnSystemUnlock);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Game_Logout, LogOut);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_HUDUIForceClose, OnUIHudForceClose);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UnlockOnAvgPopTip, OnUnlockOnAvgPopTip);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_AfterShowAni, OnUIAfterShowAni);
	}

	protected override void OnUnInit()
	{
		base.OnUnInit();
		if (Singleton<EntityUIManager>.HasInstance())
		{
			Singleton<EntityUIManager>.GetInstance().Release();
		}
		if (_uiView is MonoBattleMainBaseView monoBattleMainBaseView)
		{
			monoBattleMainBaseView.PublishContentCanvasReleased();
		}
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_RefreshHUDSystemOpenRedDot, OnSystemRedDotStateChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.HudPotionCpUpdate, OnHudPotionCpUpdate);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemUnlock);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_BlockStatusChanged, OnSystemBlockStatusChanged);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Game_Logout, LogOut);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_HUDUIForceClose, OnUIHudForceClose);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UnlockOnAvgPopTip, OnUnlockOnAvgPopTip);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_AfterShowAni, OnUIAfterShowAni);
	}

	private void OnUIHudForceClose(BaseEventContent obj)
	{
		if (obj is OnHudForceClose onHudForceClose && _uiView is MonoBattleMainBaseView monoBattleMainBaseView && onHudForceClose.type == HudComponentType.RegionNameTip)
		{
			monoBattleMainBaseView.regionNameTip.UnInit();
		}
	}

	protected override void OnPopStack()
	{
		base.OnPopStack();
		if (_uiView is MonoBattleMainBaseView monoBattleMainBaseView)
		{
			monoBattleMainBaseView.RefreshMenuListActive(MonoECS.instance.InputMode);
			monoBattleMainBaseView.UpdateRedDotDisplayOnViewOpen();
			if (!Singleton<LoadManager>.instance.InLoading)
			{
				monoBattleMainBaseView.ShowHudComponentUIFromQueue();
			}
		}
	}

	private void OnUnlockOnAvgPopTip(BaseEventContent obj)
	{
		if (obj is PopUpTextLibraryTip)
		{
			Model<BattleMainModel>.Interface.needPopUpTextLibraryUnLockNumTip = true;
			IBaseUIController topActiveUI = Singleton<NewUIManager>.instance.GetTopActiveUI();
			if (topActiveUI != null && topActiveUI.UIType == UI_TYPE.UI_BATTLEMAIN && topActiveUI.State == UIState.Opened)
			{
				TryPopUpTextLibraryUnlockNumTip();
			}
		}
	}

	private void OnUIAfterShowAni(BaseEventContent obj)
	{
		if (obj is UIEvent { UIType: UI_TYPE.UI_BATTLEMAIN })
		{
			TryPopUpTextLibraryUnlockNumTip();
		}
	}

	private void TryPopUpTextLibraryUnlockNumTip()
	{
		if (Model<BattleMainModel>.Interface.needPopUpTextLibraryUnLockNumTip)
		{
			List<TextLibraryContent> unlockTextLibraryInOneAvg = Model<TextLibraryModel>.Interface.unlockTextLibraryInOneAvg;
			if (unlockTextLibraryInOneAvg != null && unlockTextLibraryInOneAvg.Count > 0)
			{
				GameUtility.OpenToolTip(2430, "Common", new List<string> { Model<TextLibraryModel>.Interface.unlockTextLibraryInOneAvg.Count.FastToString() });
				Model<TextLibraryModel>.Interface.unlockTextLibraryInOneAvg.Clear();
				Model<BattleMainModel>.Interface.needPopUpTextLibraryUnLockNumTip = false;
			}
		}
	}

	private void OnSystemRedDotStateChange(BaseEventContent obj)
	{
		if (_uiView is MonoBattleMainBaseView monoBattleMainBaseView && obj is RefreshSystemUnlockRedDot refreshSystemUnlockRedDot)
		{
			monoBattleMainBaseView.RefreshSystemEntryRedDot(refreshSystemUnlockRedDot.systemId, refreshSystemUnlockRedDot.isActive);
		}
	}

	private void OnHudPotionCpUpdate(BaseEventContent obj)
	{
		if (!(_uiView is MonoBattleMainBaseView monoBattleMainBaseView))
		{
			return;
		}
		foreach (ActComponent uiComponent in monoBattleMainBaseView.uiComponents)
		{
			if (uiComponent is LittleItemComponent littleItemComponent)
			{
				littleItemComponent.Init();
				break;
			}
		}
	}

	private void OnSystemUnlock(BaseEventContent obj)
	{
		if (obj is SystemOpenEvt systemOpenEvt && _uiView is MonoBattleMainBaseView monoBattleMainBaseView && monoBattleMainBaseView.WheelDisc.UnLockSystemHaveWheelEntry(systemOpenEvt.systemId))
		{
			monoBattleMainBaseView.WheelDisc.RefreshSystemEntryState(systemOpenEvt.systemId);
			monoBattleMainBaseView.RefreshMenuListActive(MonoECS.instance.InputMode);
		}
	}

	private void OnSystemBlockStatusChanged(BaseEventContent obj)
	{
		if (obj is SystemBlockStatusChangedEvt systemBlockStatusChangedEvt && _uiView is MonoBattleMainBaseView monoBattleMainBaseView && monoBattleMainBaseView.WheelDisc.UnLockSystemHaveWheelEntry(systemBlockStatusChangedEvt.status.MainID))
		{
			monoBattleMainBaseView.WheelDisc.RefreshSystemEntryState(systemBlockStatusChangedEvt.status.MainID);
			monoBattleMainBaseView.RefreshMenuListActive(MonoECS.instance.InputMode);
		}
	}

	private void LogOut(BaseEventContent obj)
	{
		if (_uiView is MonoBattleMainBaseView monoBattleMainBaseView)
		{
			monoBattleMainBaseView.operateBtnComp.DestroyAllGroup();
		}
	}
}
