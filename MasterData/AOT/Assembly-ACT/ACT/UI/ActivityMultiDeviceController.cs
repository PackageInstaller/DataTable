using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class ActivityMultiDeviceController : SubUIViewInputController<ActivityMultiDevice>
{
	private ContinuousNavigateData _navigateData;

	protected override void OnActivate()
	{
		base.OnActivate();
		View.OnActivate();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_navigateData?.Reset();
	}

	[GameInputBindingBool("UI/Back")]
	protected void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.Close();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _navigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/OpenTIps")]
	public void OpenActivityDetail(bool value)
	{
		if (!value)
		{
			View.OpenActivityDetail();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void LeftStickPress(bool value)
	{
		if (value)
		{
			View.OpenSelectedRewardDetail();
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			View.OnConfirm();
		}
	}
}
