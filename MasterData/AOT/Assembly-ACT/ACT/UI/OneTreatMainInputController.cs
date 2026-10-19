using ACT.Battle;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class OneTreatMainInputController : BaseUIViewInputController<OneTreatMainView>
{
	private ContinuousNavigateData _curNavigateData;

	public OneTreatMainControllerType ControllerType { get; private set; }

	public void SetControllerType(OneTreatMainControllerType controllerType)
	{
		if (ControllerType != controllerType)
		{
			ControllerType = controllerType;
			_curNavigateData?.Reset();
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnControllerActivate();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControllerType == OneTreatMainControllerType.OneTreatTop)
			{
				View.ChangeToGamePadInputState(OneTreatMainControllerType.OneTreatMain, needReFocusLayer: true);
			}
			else
			{
				View.HandleBack();
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		if (ControllerType == OneTreatMainControllerType.OneTreatTop)
		{
			View.ExecuteTopControlNavigate(dir);
		}
		else
		{
			View.ExecuteNavigate(dir);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			if (ControllerType == OneTreatMainControllerType.OneTreatTop)
			{
				View.SubmitTopControlSelection();
			}
			else if (ControllerType == OneTreatMainControllerType.OneTreatMain)
			{
				View.HandleConfirm();
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void OpenTask(bool value)
	{
		if (!value && ControllerType == OneTreatMainControllerType.OneTreatMain)
		{
			View.OpenTaskByInput();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void Draw(bool value)
	{
		if (!value && ControllerType == OneTreatMainControllerType.OneTreatMain)
		{
			View.DrawByInput();
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void OpenActivityDesc(bool value)
	{
		if (!value && ControllerType == OneTreatMainControllerType.OneTreatMain)
		{
			View.OpenActivityDescByInput();
		}
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void EnterTopControl(bool value)
	{
		if (!value && ControllerType == OneTreatMainControllerType.OneTreatMain)
		{
			View.EnterTopControlByInput();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void SelectItemCell(bool value)
	{
		if (!value && ControllerType == OneTreatMainControllerType.OneTreatMain)
		{
			View.HandleConfirm();
		}
	}
}
