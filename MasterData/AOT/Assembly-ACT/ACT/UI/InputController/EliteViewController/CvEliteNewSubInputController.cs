using ACT.Battle;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI.InputController.EliteViewController;

public class CvEliteNewSubInputController : SubUIViewInputController<CvEliteNew>
{
	private bool _ignoreNextBackRelease;

	private const float LeftStickDeadZone = 0.35f;

	private const float LeftStickReleaseZone = 0.15f;

	private const float LeftStickNavCooldown = 0.12f;

	private int _lastLeftStickXDirection;

	private int _lastLeftStickYDirection;

	private float _nextLeftStickXConsumeTime;

	private float _nextLeftStickYConsumeTime;

	private ContinuousNavigateData navData;

	public CvEliteNewControllerType ControllerType { get; private set; }

	private bool IsSelectingTopMaterial => ControllerType == CvEliteNewControllerType.SelectTopMaterial;

	protected override void OnActivate()
	{
		base.OnActivate();
		ResetLeftStickConsumeState();
		if (IsSelectingTopMaterial)
		{
			View.subViewLayer.UnFocus();
			View.costLayer.Focus();
		}
		else
		{
			View.subViewLayer.Focus();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		if (IsSelectingTopMaterial)
		{
			View?.costLayer?.UnFocus();
			ControllerType = CvEliteNewControllerType.Main;
		}
		_ignoreNextBackRelease = false;
		ResetLeftStickConsumeState();
		navData?.Reset();
	}

	public void ShowCostExpDetail()
	{
		if (!IsSelectingTopMaterial && !(View == null) && View.CanEnterTopMaterialSelection)
		{
			View.subViewLayer.UnFocus();
			View.costLayer.Focus();
			SetControllerType(CvEliteNewControllerType.SelectTopMaterial);
		}
	}

	public void HideCostExpDetail()
	{
		if (IsSelectingTopMaterial && !(View == null))
		{
			View.costLayer.UnFocus();
			View.subViewLayer.ReFocus();
			SetControllerType(CvEliteNewControllerType.Main);
		}
	}

	private void SetControllerType(CvEliteNewControllerType controllerType)
	{
		if (ControllerType != controllerType)
		{
			ControllerType = controllerType;
			navData?.Reset();
			View?.RefreshMainEliteGamepadTips();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnGamePadSelect(bool value)
	{
		if (!value || !CanHandleInput())
		{
			return;
		}
		if (IsSelectingTopMaterial)
		{
			GameObject currentSelected = EventSystemHelper.CurrentSelected;
			if (!(currentSelected == null))
			{
				EventSystemHelper.Click(currentSelected);
			}
		}
		else
		{
			View.EliteDiscComponent?.HandleGamePadSelectAButtonInput(EliteViewSubControllerType.Main);
		}
	}

	[GameInputBindingBool("LargeMapView/Return")]
	private void OnGamePadReturn(bool value)
	{
		if (value && CanHandleInput())
		{
			StopActionPropagation("LargeMapView/Return");
			StopActionPropagation("UI/Back");
			if (IsSelectingTopMaterial && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				HideCostExpDetail();
				_ignoreNextBackRelease = true;
			}
			else
			{
				View.CharacterView?.Close();
			}
		}
	}

	[GameInputBindingBool("UI/View")]
	private void OnGamePadView(bool value)
	{
		if (value && CanHandleInput() && !IsSelectingTopMaterial)
		{
			View.EliteDiscComponent?.HandleGamePadSelectViewBtnInput(EliteViewSubControllerType.Main);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			View.costLayer.Root?.SelectUp();
			break;
		case MoveDirection.Down:
			View.costLayer.Root?.SelectDown();
			break;
		case MoveDirection.Left:
			View.costLayer.Root?.SelectLeft();
			break;
		case MoveDirection.Right:
			View.costLayer.Root?.SelectRight();
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	private void OnGamePadNavigate(Vector2 value)
	{
		if (!CanHandleInput())
		{
			return;
		}
		if (IsSelectingTopMaterial)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
			return;
		}
		if (TryConsumeLeftStickX(value.x, out var filteredValue))
		{
			View.EliteDiscComponent?.HandleGamePadSelectLeftStickXBtnInput(EliteViewSubControllerType.Main, filteredValue);
		}
		if (TryConsumeLeftStickY(value.y, out var filteredValue2))
		{
			View.EliteDiscComponent?.HandleGamePadSelectLeftStickYBtnInput(EliteViewSubControllerType.Main, filteredValue2);
		}
	}

	[GameInputBindingBool("UI/Back")]
	protected void OnBackPressed(bool value)
	{
		if (!CanHandleInput())
		{
			return;
		}
		StopActionPropagation("UI/Back");
		StopActionPropagation("LargeMapView/Return");
		if (value)
		{
			return;
		}
		if (_ignoreNextBackRelease)
		{
			_ignoreNextBackRelease = false;
			return;
		}
		if (IsSelectingTopMaterial && MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			HideCostExpDetail();
			return;
		}
		if (IsSelectingTopMaterial)
		{
			View?.costLayer?.UnFocus();
		}
		ControllerType = CvEliteNewControllerType.Main;
		View.CharacterView?.Close();
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void ShowCostExpDetail(bool value)
	{
		if (value && CanHandleInput())
		{
			ShowCostExpDetail();
		}
	}

	private bool CanHandleInput()
	{
		if (!IsActive || View == null || !View.isActiveAndEnabled)
		{
			return false;
		}
		IBaseUIController baseUIController = View.CharacterView?.UIController;
		if (baseUIController != null && baseUIController.State == UIState.Opened)
		{
			return !baseUIController.IsInHideRoot;
		}
		return false;
	}

	private bool TryConsumeLeftStickX(float value, out float filteredValue)
	{
		filteredValue = 0f;
		return TryConsumeLeftStickAxis(value, ref _lastLeftStickXDirection, ref _nextLeftStickXConsumeTime, out filteredValue);
	}

	private bool TryConsumeLeftStickY(float value, out float filteredValue)
	{
		filteredValue = 0f;
		return TryConsumeLeftStickAxis(value, ref _lastLeftStickYDirection, ref _nextLeftStickYConsumeTime, out filteredValue);
	}

	private void ResetLeftStickConsumeState()
	{
		_lastLeftStickXDirection = 0;
		_lastLeftStickYDirection = 0;
		_nextLeftStickXConsumeTime = 0f;
		_nextLeftStickYConsumeTime = 0f;
	}

	private static bool TryConsumeLeftStickAxis(float value, ref int lastDirection, ref float nextConsumeTime, out float filteredValue)
	{
		filteredValue = 0f;
		float num = Mathf.Abs(value);
		if (num < 0.15f)
		{
			lastDirection = 0;
			return false;
		}
		if (num < 0.35f)
		{
			return false;
		}
		int num2 = ((value > 0f) ? 1 : (-1));
		if (num2 == lastDirection)
		{
			return false;
		}
		float unscaledTime = Time.unscaledTime;
		if (unscaledTime < nextConsumeTime)
		{
			return false;
		}
		lastDirection = num2;
		nextConsumeTime = unscaledTime + 0.12f;
		filteredValue = num2;
		return true;
	}

	private static void StopActionPropagation(string action)
	{
		Singleton<GameInputActionManager>.instance.StopActionPropagation(action);
	}
}
