using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class PropsSubmissonViewInputController : BaseUIViewInputController<PropsSubmissonView>
{
	public PropsSubmissonViewInputControlType ControlType;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			if (ControlType == PropsSubmissonViewInputControlType.Item)
			{
				View.ChangeViewControl(PropsSubmissonViewInputControlType.Main);
			}
			else
			{
				View.OnClose();
			}
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnInputControllerActivate();
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

	[GameInputBindingBool("UI/SelectItemCell")]
	public void SelectItemCell(bool value)
	{
		if (value && ControlType == PropsSubmissonViewInputControlType.Main)
		{
			View.ChangeViewControl(PropsSubmissonViewInputControlType.Item);
		}
	}
}
