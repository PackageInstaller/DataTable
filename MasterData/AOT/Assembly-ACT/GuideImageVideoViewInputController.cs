using ACT.Battle;
using ACT.UI;
using UnityEngine;

public class GuideImageVideoViewInputController : BaseUIViewInputController<GuideImageVideoView>
{
	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void SwitchPageLeft(bool value)
	{
		if (!(View == null) && value)
		{
			View.ShowLastPage();
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void SwitchPageRight(bool value)
	{
		if (!(View == null) && value)
		{
			View.ShowNextPage();
		}
	}

	[GameInputBindingVector2("UI/RightStickNavigate")]
	public void RightNavigate(Vector2 value)
	{
		if (!(View == null))
		{
			View.OnRightStickScroll(value);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
	}

	protected override void OnBackPressed(bool value)
	{
		if (!(View == null) && View.ReachLastPage && !value)
		{
			View.Close();
		}
	}

	protected override void OnEscPressed(bool value)
	{
	}
}
