using ACT.Battle;
using ACT.EventTrack;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class TrainingGroundViewInputController : BaseUIViewInputController<TrainingGroundView>
{
	private ContinuousNavigateData _curNavigateState;

	private ViewControlRoot _viewControlRoot;

	private bool _isFocusInputFiled;

	private ACT.ViewControl.SelectableEx _lastSelectBeforeInputField;

	public bool IsFocusInputFiled => _isFocusInputFiled;

	protected override void OnActivate()
	{
		if (_viewControlRoot == null)
		{
			_viewControlRoot = View.GetComponentInChildren<ViewControlRoot>();
		}
	}

	protected override void OnDeactivate()
	{
		_curNavigateState?.Reset();
		View.sideBarControlLayer?.UnFocus();
		UnFocusInputFiled(restoreSelection: false);
	}

	public void RefreshSelection()
	{
		View.sideBarControlLayer?.ReFocus();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null) && !_isFocusInputFiled)
		{
			if (!EventSystemHelper.CurrentSelected || View.sideBarControlLayer.LastSelect == null)
			{
				RefreshSelection();
			}
			else
			{
				ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
			}
		}
	}

	private void ExecuteNavigate(MoveDirection duration)
	{
		switch (duration)
		{
		case MoveDirection.Up:
			_viewControlRoot?.SelectUp();
			break;
		case MoveDirection.Down:
			_viewControlRoot?.SelectDown();
			break;
		}
		if (MonoECS.instance.IsGamePadMode())
		{
			View.RefreshGamepadPrompts();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnSpecial1(bool value)
	{
		if (!_isFocusInputFiled && value && !(View == null))
		{
			View.HandleGamePadSpecial1();
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnSpecial2(bool value)
	{
		if (!_isFocusInputFiled && value && !(View == null))
		{
			View.HandleGamePadSpecial2();
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void OnReduceLevel(bool value)
	{
		if (!_isFocusInputFiled && value && EventSystemHelper.CurrentSelected == View.enemyLevelSelectable.gameObject)
		{
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/SwitchPageLeft", View.EnemyLevelReduce, 0.1f, -1, 0.15f);
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void OnAddLevel(bool value)
	{
		if (!_isFocusInputFiled && value && EventSystemHelper.CurrentSelected == View.enemyLevelSelectable.gameObject)
		{
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/SwitchPageRight", View.EnemyLevelAdd, 0.1f, -1, 0.15f);
		}
	}

	[GameInputBindingBool("UI/TriggerSearchInPutField")]
	public void TriggerInputField(bool value)
	{
		if (!value && EventSystemHelper.CurrentSelected == View.enemyLevelSelectable.gameObject)
		{
			FocusInputFiled();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			return;
		}
		if (_isFocusInputFiled)
		{
			UnFocusInputFiled();
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if ((bool)currentSelected && View.sideBarControlLayer.LastSelect != null)
		{
			EventSystemHelper.Click(currentSelected);
		}
	}

	protected override void OnBackPressed(bool value)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Return_Click");
		if (!value && !_isFocusInputFiled)
		{
			IsActive = false;
			SystemOpen evt = EventTrackSolver.Instance.GetEvt<SystemOpen>();
			evt.id = 10351;
			evt.type = 3;
			EventTrackSolver.Instance.Dispatch(evt);
			View.Close();
		}
	}

	private void FocusInputFiled()
	{
		if (!_isFocusInputFiled)
		{
			_isFocusInputFiled = true;
			_lastSelectBeforeInputField = View.sideBarControlLayer?.LastSelect;
			if (_lastSelectBeforeInputField == null || !_lastSelectBeforeInputField.IsValid())
			{
				_lastSelectBeforeInputField = View.enemyLevelSelectable;
			}
			View.enemyLevel.ActivateInputField();
			View.enemyLevel.Select();
			View.enemyLevel.MoveTextEnd(shift: false);
			View.RefreshGamepadPrompts();
			View.createEnemyPrompt?.SetVisible(vis: false);
			View.killEnemyPrompt?.SetVisible(vis: false);
		}
	}

	private void UnFocusInputFiled(bool restoreSelection = true)
	{
		if (_isFocusInputFiled)
		{
			_isFocusInputFiled = false;
			View.enemyLevel.DeactivateInputField();
			if (restoreSelection)
			{
				RestoreSelectionBeforeInputField();
				View.RefreshGamepadPrompts();
			}
			View.createEnemyPrompt?.SetVisible(vis: true);
			View.killEnemyPrompt?.SetVisible(vis: true);
		}
	}

	private void RestoreSelectionBeforeInputField()
	{
		if (_lastSelectBeforeInputField == null || !_lastSelectBeforeInputField.IsValid())
		{
			_lastSelectBeforeInputField = View.enemyLevelSelectable;
		}
		View.sideBarControlLayer?.SetDefaultSelect(_lastSelectBeforeInputField);
		View.sideBarControlLayer?.Focus();
	}
}
