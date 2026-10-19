using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class RogueBagViewInputController : BaseUIViewInputController<RogueBagView>
{
	private ContinuousNavigateData navData;

	protected override void OnActivate()
	{
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			View.viewControlLayer.ReFocus();
			if (!EventSystemHelper.CurrentSelected)
			{
				ExecuteNavigate(MoveDirection.Left);
			}
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		if (type == DeviceInputMode.Gamepad)
		{
			View.viewControlLayer.ReFocus();
			if (!EventSystemHelper.CurrentSelected)
			{
				ExecuteNavigate(MoveDirection.Left);
			}
		}
	}

	protected override void OnDisable()
	{
		navData?.Reset();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref navData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Up:
			View.viewControlLayer.Root?.SelectUp();
			break;
		case MoveDirection.Down:
			View.viewControlLayer.Root?.SelectDown();
			break;
		case MoveDirection.Left:
			View.viewControlLayer.Root?.SelectLeft();
			break;
		case MoveDirection.Right:
			View.viewControlLayer.Root?.SelectRight();
			break;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			currentSelected.GetComponent<SelectionUGUI>()?.ScrollTargetToShow(currentSelected.transform);
			EventSystemHelper.Click(currentSelected);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OnDecomposition(bool value)
	{
		if (value && View.btnDecomposition.gameObject.activeInHierarchy && View.btnDecomposition.interactable)
		{
			View.btnDecomposition.OnClick?.Invoke();
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void OnRightStickPress(bool value)
	{
		if (value)
		{
			View.BtnCharacterInfo.OnClick?.Invoke();
		}
	}

	[GameInputBindingBool("UI/View")]
	public void OnView(bool value)
	{
		if (value)
		{
			View.ToggleItemInscriptionInfo();
		}
	}
}
