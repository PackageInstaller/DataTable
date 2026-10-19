using System.Collections.Generic;
using ACT.UI.AOT;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AnnouncementViewHCLR : BaseUIView<AnnouncementInputViewInputController>
{
	public AnnouncementView View;

	public AnnouncementTab Tab;

	public ViewControlLayer ListViewLayer;

	public ViewControlLayer TimelineViewLayer;

	public RightStickScrollSupport RightStickScrollSupport;

	public GamePadTipsComp gamePadGroup;

	private bool m_canRightStickScroll = true;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt = new Dictionary<string, GamePadTipsAction>();

	private List<GamePadTipsAction> _tipsActions;

	public override async UniTask PreInit()
	{
		View.Init();
		View.OnCloseButtonClicked = Close;
		View.IsHCLR = true;
		await base.PreInit();
	}

	public async void SwitchOnStart()
	{
		if (View.AnnouncementPanel is AnnouncementContentView announcementContentView)
		{
			announcementContentView.Category = 3;
		}
		Tab.SwitchToImmediately(0);
		View.SwitchToAnnouncementPanel();
		await View.Clear();
		await View.Refresh();
		View.ReportOpen();
	}

	public async void SwitchToGameAnnouncement()
	{
		if (View.AnnouncementPanel is AnnouncementContentView announcementContentView)
		{
			announcementContentView.Category = 3;
		}
		if (Tab.TrySwitchTo(0))
		{
			View.SwitchToAnnouncementPanel();
			await PostSwitch();
		}
		TimelineViewLayer.UnFocus();
		ListViewLayer.ReFocus();
	}

	public async void SwitchToActivityAnnouncement()
	{
		if (View.AnnouncementPanel is AnnouncementContentView announcementContentView)
		{
			announcementContentView.Category = 4;
		}
		if (Tab.TrySwitchTo(1))
		{
			View.SwitchToAnnouncementPanel();
			await PostSwitch();
		}
		TimelineViewLayer.UnFocus();
		ListViewLayer.ReFocus();
	}

	public async void SwitchToTimeline()
	{
		if (Tab.TrySwitchTo(2))
		{
			View.SwitchToTimelinePanel();
			await PostSwitch();
		}
		TimelineViewLayer.UnFocus();
		TimelineViewLayer.ReFocus();
	}

	private async UniTask PostSwitch()
	{
		await View.Clear();
		await View.Refresh();
		RefreshRightStickScrollForbid();
		ReBindBtnPrompt();
		View.ReportOpen();
	}

	protected override async void Init()
	{
		if (View.AnnouncementPanel is AnnouncementContentView announcementContentView)
		{
			announcementContentView.Category = 3;
		}
		Tab.SwitchToImmediately(0);
		View.SwitchToAnnouncementPanel();
		await View.Clear();
		await LuminApplication.GmApi.GetAnnouncements(1);
		await LuminApplication.GmApi.GetAnnouncements(1, 4);
		await LuminApplication.GmApi.GetAnnouncements(1, 5);
		Tab.RefreshRedDot();
		SwitchOnStart();
		RefreshRightStickScrollForbid();
		OnGamePadInit();
		ReBindBtnPrompt();
		base.Init();
	}

	protected override void UnInit()
	{
		base.UnInit();
		Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.Announcement, !AnnouncementRedDot.IsAllRead(includeGame: true, includeActivity: true, includeTimeline: true, AnnouncementPlace.HCLR));
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window");
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	public void RefreshRightStickScrollForbid()
	{
		ScrollRect activeScrollRect = GetActiveScrollRect();
		RightStickScrollSupport rightStickScrollSupport = RightStickScrollSupport;
		rightStickScrollSupport.SetTargetScrollRect(activeScrollRect);
		if (rightStickScrollSupport == null || activeScrollRect == null)
		{
			m_canRightStickScroll = activeScrollRect != null && activeScrollRect.content != null && activeScrollRect.viewport != null && activeScrollRect.content.rect.height > activeScrollRect.viewport.rect.height;
			return;
		}
		Canvas.ForceUpdateCanvases();
		if (activeScrollRect.content != null)
		{
			LayoutRebuilder.ForceRebuildLayoutImmediate(activeScrollRect.content);
		}
		bool flag = activeScrollRect.content != null && activeScrollRect.viewport != null && activeScrollRect.content.rect.height > activeScrollRect.viewport.rect.height;
		rightStickScrollSupport.SetForbidScroll(!flag);
		m_canRightStickScroll = flag;
	}

	private ScrollRect GetActiveScrollRect()
	{
		int num = Tab?.CurrentIndex ?? (-1);
		if ((num == 0 || num == 1) && View?.AnnouncementPanel is AnnouncementContentView announcementContentView)
		{
			return announcementContentView.ContentScrollRect;
		}
		if (num == 2 && View?.TimelinePanel is AnnouncementTimeline announcementTimeline)
		{
			return announcementTimeline.scrollRect;
		}
		return null;
	}

	public void Scroll(Vector2 value)
	{
		if (m_canRightStickScroll)
		{
			ScrollRect activeScrollRect = GetActiveScrollRect();
			if (!(activeScrollRect == null))
			{
				activeScrollRect.velocity = new Vector2(0f, value.y * activeScrollRect.scrollSensitivity);
			}
		}
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/RSUpDownSelect"] = new GamePadTipsAction
			{
				inputAction = "UI/RSUpDownSelect",
				localizeKey = 2165,
				localizeTable = "Common"
			},
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 774,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			}
		};
	}

	public void ReBindBtnPrompt()
	{
		List<GamePadTipsAction> tipsActions = _tipsActions;
		if (tipsActions == null || tipsActions.Count <= 0)
		{
			_tipsActions = new List<GamePadTipsAction>();
		}
		gamePadGroup.ClearAllPrompts();
		_tipsActions.Clear();
		if (Tab.CurrentIndex == 2)
		{
			_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
		}
		_tipsActions.Add(_allInputPrompt["UI/Back"]);
		if (m_canRightStickScroll)
		{
			_tipsActions.Add(_allInputPrompt["UI/RSUpDownSelect"]);
		}
		gamePadGroup.RegisterInputActions(_tipsActions);
	}
}
