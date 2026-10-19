using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Runtime.UI.CommonComponent;
using UnityEngine;

namespace ACT.UI;

public class MonoEscViewInputController : BaseUIViewInputController<MonoEscView>
{
	public EscViewControlType EscViewControlType;

	private float lastPressTime;

	private ContinuousNavigateData _curNavigateData;

	public ViewControlLayer CurrentViewControlLayer => EscViewControlType switch
	{
		EscViewControlType.Main => View.ViewControlLayer, 
		EscViewControlType.MoreDropdown => View.MoreDropdownViewControlLayer, 
		EscViewControlType.Exit => View.ExitViewControlLayer, 
		_ => null, 
	};

	protected override void OnInitView(MonoEscView view)
	{
		base.OnInitView(view);
		EscViewControlType = EscViewControlType.Main;
		View.ChangeEscViewControlType(EscViewControlType);
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (EscViewControlType == EscViewControlType.MoreDropdown)
			{
				EventSystemHelper.Click(View.btn_more_dropdown_mask);
			}
			else if (EscViewControlType == EscViewControlType.Exit)
			{
				EventSystemHelper.Click(View.ContinueGame);
			}
			else if (EscViewControlType == EscViewControlType.Resource)
			{
				View.ChangeEscViewControlType(EscViewControlType.Main);
			}
			else
			{
				View.Close();
			}
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void RightStickPress(bool value)
	{
		if (value && EscViewControlType == EscViewControlType.Main)
		{
			View.ChangeEscViewControlType(EscViewControlType.Resource);
		}
	}

	[GameInputBindingBool("UI/LeftStackPress")]
	public void LeftStickPress(bool value)
	{
		if (value && EscViewControlType == EscViewControlType.Main)
		{
			View.OnClickCopyUIDButtonHandle();
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	public void LeftTrigger(bool value)
	{
		if (value && EscViewControlType == EscViewControlType.Main && Time.unscaledTime - lastPressTime > 0.5f)
		{
			lastPressTime = Time.unscaledTime;
			View.OpenFeedback();
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	public void RightTrigger(bool value)
	{
		if (value && EscViewControlType == EscViewControlType.Main && Time.unscaledTime - lastPressTime > 0.5f)
		{
			lastPressTime = Time.unscaledTime;
			View.OnClickMoreRenameButtonHandle();
		}
	}

	[GameInputBindingBool("UI/View")]
	public void Select(bool value)
	{
		if (value && EscViewControlType == EscViewControlType.Main)
		{
			View.OpenAnnouncement();
		}
	}

	[GameInputBindingBool("LargeMapView/MapTemple")]
	public void ButtonWest(bool value)
	{
		if (value && EscViewControlType == EscViewControlType.Main)
		{
			View.OpenMailBox();
		}
	}

	[GameInputBindingBool("LargeMapView/BackToTarget")]
	public void ButtonNorth(bool value)
	{
		if (value && EscViewControlType == EscViewControlType.Main)
		{
			View.OpenSettingUI();
		}
	}

	[GameInputBindingBool("UI/Start")]
	public void Start(bool value)
	{
		if (value && EscViewControlType == EscViewControlType.Main)
		{
			View.OnClickExitButtonHandle();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			return;
		}
		if (EscViewControlType == EscViewControlType.Resource && EventSystemHelper.CurrentSelected != null)
		{
			CommonCoinComponent component2;
			if (EventSystemHelper.CurrentSelected.TryGetComponent<PowerBar>(out var component))
			{
				EventSystemHelper.Click(component.addPowerBtn);
			}
			else if (EventSystemHelper.CurrentSelected.TryGetComponent<CommonCoinComponent>(out component2))
			{
				EventSystemHelper.Click(component2.supplementBtn);
			}
		}
		else
		{
			EventSystemHelper.ClickCurrent();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
		{
			View.ChangeEscViewControlType(EscViewControlType);
		}
	}
}
