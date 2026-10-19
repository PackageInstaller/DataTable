using System.Collections.Generic;
using ACT.Battle;
using ACT.UI.InputController;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class TaskViewV3InputController : BaseUIViewInputController<TaskViewV3>
{
	private readonly List<GamePadTipsAction> _activeInputPrompts = new List<GamePadTipsAction>(2);

	private TaskViewV3InputBinding _binding;

	private ContinuousNavigateData _navigateData;

	private ContinuousNavigateData _navigateDataDetail;

	private int _missionIdBeforeDetail;

	private bool _canRightStickScroll;

	public bool InDetail { get; set; }

	protected override void OnInitView(TaskViewV3 view)
	{
		base.OnInitView(view);
		_binding = view.InputBinding;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		if (InDetail)
		{
			_binding.DetailControlLayer.ReFocus();
		}
		else
		{
			_binding.ListControlLayer.ReFocus();
		}
		RefreshViewState();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_binding.DetailControlLayer.UnFocus();
	}

	protected override void OnDisable()
	{
		_navigateData.Reset();
		_navigateDataDetail.Reset();
	}

	protected override void OnBackPressed(bool value)
	{
		if (value)
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
			if (InDetail)
			{
				ExitDetailToList();
			}
			else
			{
				View.Close();
			}
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void EnterDetail(bool value)
	{
		if (value && !InDetail && !View.IsTabTransitioning)
		{
			int selectedMissionId = View.SelectedMissionId;
			_binding.DetailControlLayer.Focus();
			if (View.TrySelectFirstReward())
			{
				_missionIdBeforeDetail = selectedMissionId;
				InDetail = true;
				RefreshViewState();
			}
			else
			{
				_missionIdBeforeDetail = 0;
				_binding.ListControlLayer.ReFocus();
			}
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void TrackMission(bool value)
	{
		if (value)
		{
			View.TrackSelectedMission();
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void PreviousTab(bool value)
	{
		if (value)
		{
			ExitDetailToList();
			View.TaskList.CycleTab(forward: false);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void NextTab(bool value)
	{
		if (value)
		{
			ExitDetailToList();
			View.TaskList.CycleTab(forward: true);
		}
	}

	[GameInputBindingVector2("UI/ScrollViewRightStickControl")]
	public void ScrollDetail(Vector2 value)
	{
		if (!View.IsTabTransitioning && _canRightStickScroll)
		{
			ScrollRect detailScrollRect = _binding.DetailScrollRect;
			detailScrollRect.velocity = new Vector2(0f, value.y * detailScrollRect.scrollSensitivity);
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (InDetail)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _navigateDataDetail, ExecuteNavigate);
		}
		else
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _navigateData, ExecuteNavigate);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value && InDetail)
		{
			SubmitCurrentSelection();
		}
	}

	public void RefreshViewState()
	{
		RefreshRightStickScrollState();
		RefreshGamePadPrompts();
	}

	private void RefreshRightStickScrollState()
	{
		ScrollRect detailScrollRect = _binding.DetailScrollRect;
		Canvas.ForceUpdateCanvases();
		LayoutRebuilder.ForceRebuildLayoutImmediate(detailScrollRect.content);
		_canRightStickScroll = detailScrollRect.content.rect.height > detailScrollRect.viewport.rect.height;
		_binding.RightStickScrollSupport.SetForbidScroll(!_canRightStickScroll);
	}

	private void RefreshGamePadPrompts()
	{
		_activeInputPrompts.Clear();
		_activeInputPrompts.Add(GamePadTipHelper.BackAction);
		if (_canRightStickScroll)
		{
			_activeInputPrompts.Add(GamePadTipHelper.ScrollAction);
		}
		_binding.GamePadTips.ClearAllPrompts();
		_binding.GamePadTips.RegisterInputActions(_activeInputPrompts);
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		if (InDetail)
		{
			ExecuteRewardNavigate(direction);
		}
		else if (View.TaskList.TrySelectMission(direction))
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Mission/Click");
			RefreshViewState();
		}
	}

	private void ExecuteRewardNavigate(MoveDirection direction)
	{
		if (View.TryNavigateReward(direction))
		{
			RefreshViewState();
		}
	}

	private void ExitDetailToList()
	{
		int missionId = ((_missionIdBeforeDetail > 0) ? _missionIdBeforeDetail : View.SelectedMissionId);
		_binding.DetailControlLayer.UnFocus();
		ClearCurrentSelection();
		InDetail = false;
		if (!View.TaskList.TryFocusMission(missionId))
		{
			_binding.ListControlLayer.ReFocus();
		}
		_missionIdBeforeDetail = 0;
	}

	internal void ExitDetailForTabChange()
	{
		if (InDetail)
		{
			ExitDetailToList();
		}
	}

	private static void ClearCurrentSelection()
	{
		EventSystemHelper.SetSelectedGameObject(null);
	}

	private static void SubmitCurrentSelection()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if ((bool)currentSelected)
		{
			EventSystemHelper.Click(currentSelected);
		}
	}
}
