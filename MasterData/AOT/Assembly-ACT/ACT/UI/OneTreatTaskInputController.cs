using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class OneTreatTaskInputController : BaseUIViewInputController<OneTreatTaskView>
{
	private ContinuousNavigateData _curNavigateData;

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
			View.HandleBack();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			View.HandleConfirm();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void SelectItemCell(bool value)
	{
		if (!value)
		{
			View.OpenSelectedRewardDetail();
		}
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void HandleCoinClick(bool value)
	{
		if (!value)
		{
			View.OpenTaskCurrencyDetail();
		}
	}
}
