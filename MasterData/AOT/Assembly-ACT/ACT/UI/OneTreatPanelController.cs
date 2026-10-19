using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class OneTreatPanelController : SubUIViewInputController<OneTreatPanel>
{
	private ContinuousNavigateData _curNavigateData;

	public OneTreatPanelControlType ControlType { get; set; }

	protected override void OnInitView(OneTreatPanel view)
	{
		base.OnInitView(view);
		ControlType = OneTreatPanelControlType.Main;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnInputModeChange(MonoECS.instance.InputMode);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	[GameInputBindingBool("UI/Back")]
	protected void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == OneTreatPanelControlType.Reward)
			{
				View.ChangeControlType(OneTreatPanelControlType.Main);
			}
			else
			{
				View.OnClose();
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	protected void OnClickXButton(bool value)
	{
		if (!value && ControlType == OneTreatPanelControlType.Main)
		{
			View.OpenTaskView();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	protected void OnClickYButton(bool value)
	{
		if (!value && ControlType == OneTreatPanelControlType.Main)
		{
			View.OpenMainView();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void SelectItemCell(bool value)
	{
		if (!(View == null) && value && ControlType == OneTreatPanelControlType.Main)
		{
			View.ChangeControlType(OneTreatPanelControlType.Reward);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!((View == null) | value))
		{
			View.HandleConfirm();
		}
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void OpenActivityDetail(bool value)
	{
		if (!((View == null) | value) && ControlType == OneTreatPanelControlType.Main)
		{
			View.OpenActivityDetail();
		}
	}
}
