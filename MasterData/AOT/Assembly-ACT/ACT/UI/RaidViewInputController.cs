using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class RaidViewInputController : BaseUIViewInputController<MonoRaidView>
{
	private RaidViewControlType _controlType;

	private ContinuousNavigateData _curNavigateData;

	public RaidViewControlType ControlType
	{
		get
		{
			return _controlType;
		}
		set
		{
			_controlType = value;
		}
	}

	protected override void OnInitView(MonoRaidView view)
	{
		base.OnInitView(view);
		_controlType = RaidViewControlType.Main;
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (_controlType == RaidViewControlType.Main)
			{
				View.OnClose();
			}
			else if (_controlType == RaidViewControlType.Reward)
			{
				View.ChangeControlType(RaidViewControlType.Main);
			}
			else if (_controlType == RaidViewControlType.Multiple)
			{
				View.RateDropdown.Hide();
				View.ChangeControlType(RaidViewControlType.Main);
			}
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

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			View.OnConfirm();
		}
	}

	[GameInputBindingBool("LargeMapView/MapTemple")]
	public void ButtonWest(bool value)
	{
		if (value)
		{
			View.OnButtonWest();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value && ControlType == RaidViewControlType.Main)
		{
			View.ChangeControlType(RaidViewControlType.Reward);
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	public void RightStickPress(bool value)
	{
		if (value)
		{
			View.OnRightStickPress();
		}
	}

	[GameInputBindingBool("UI/Start")]
	public void Start(bool value)
	{
		if (value)
		{
			View.OnStart();
		}
	}
}
