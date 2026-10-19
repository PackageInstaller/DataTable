using System.Collections.Generic;
using ACT.Battle;
using ACT.UI.AOT;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class AnnouncementInputViewInputController : BaseUIViewInputController<AnnouncementViewHCLR>
{
	private ViewControlRoot ViewControlRoot;

	private bool m_TabPrevPressed;

	private bool m_TabNextPressed;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnInitView(AnnouncementViewHCLR view)
	{
		base.OnInitView(view);
		ViewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
	}

	protected override void OnActivate()
	{
		int num = View.Tab?.CurrentIndex ?? (-1);
		if (num == 0 || num == 1)
		{
			View.ListViewLayer.ReFocus();
		}
		else
		{
			View.TimelineViewLayer.ReFocus();
		}
		base.OnActivate();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	[GameInputBindingVector2("UI/ScrollViewRightStickControl")]
	public void Scroll(Vector2 value)
	{
		View.Scroll(value);
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		int num = View?.Tab?.CurrentIndex ?? (-1);
		if (value && num == 2)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (!(currentSelected == null))
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		int num = View?.Tab?.CurrentIndex ?? (-1);
		if ((num == 0 || num == 1) && View?.View?.AnnouncementPanel is AnnouncementContentView contentView)
		{
			NavigateAnnouncementList(contentView, dir);
			return;
		}
		switch (dir)
		{
		case MoveDirection.Up:
			ViewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			ViewControlRoot?.SelectDown();
			break;
		case MoveDirection.Left:
			ViewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot?.SelectRight();
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
		}
	}

	private void NavigateAnnouncementList(AnnouncementContentView contentView, MoveDirection dir)
	{
		if (dir != MoveDirection.Up && dir != MoveDirection.Down)
		{
			return;
		}
		List<AnnouncementItem> announcementComponents = contentView.AnnouncementComponents;
		if (announcementComponents != null && announcementComponents.Count != 0)
		{
			AnnouncementData currentData = contentView.CurrentAnnouncementData;
			int num = ((currentData != null) ? announcementComponents.FindIndex((AnnouncementItem c) => c.DataContext?.Id == currentData.Id) : (-1));
			int num2 = ((dir != MoveDirection.Down) ? ((num >= 0) ? Mathf.Max(num - 1, 0) : 0) : ((num >= 0) ? Mathf.Min(num + 1, announcementComponents.Count - 1) : 0));
			if (num2 != num || num < 0)
			{
				AnnouncementItem announcementItem = announcementComponents[num2];
				EventSystemHelper.ClickPointer(announcementItem);
				announcementItem.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(announcementItem.transform);
				View.RefreshRightStickScrollForbid();
				View.ReBindBtnPrompt();
			}
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void PrevTab(bool value)
	{
		if (m_TabPrevPressed != value)
		{
			m_TabPrevPressed = value;
			if (value)
			{
				CycleTab(next: false);
			}
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void NextTab(bool value)
	{
		if (m_TabNextPressed != value)
		{
			m_TabNextPressed = value;
			if (value)
			{
				CycleTab(next: true);
			}
		}
	}

	private void CycleTab(bool next)
	{
		AnnouncementTab announcementTab = View?.Tab;
		int valueOrDefault = (announcementTab?.tabItems?.Count).GetValueOrDefault();
		if (valueOrDefault > 0)
		{
			int currentIndex = announcementTab.CurrentIndex;
			if (currentIndex < 0 || currentIndex >= valueOrDefault)
			{
				SwitchToTab(0);
				return;
			}
			int index = (next ? ((currentIndex + 1) % valueOrDefault) : ((currentIndex - 1 + valueOrDefault) % valueOrDefault));
			SwitchToTab(index);
		}
	}

	private void SwitchToTab(int index)
	{
		switch (index)
		{
		case 0:
			View.SwitchToGameAnnouncement();
			break;
		case 1:
			View.SwitchToActivityAnnouncement();
			break;
		case 2:
			View.SwitchToTimeline();
			break;
		}
		ViewControlRoot?.ReFocus();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		View.ReBindBtnPrompt();
		base.OnInputDeviceChange(type);
	}
}
