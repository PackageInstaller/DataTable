using ACT.Battle;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class ItemTreasureCenterViewInputController : BaseUIViewInputController<ItemTreasureCenterView>
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

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	public void LeftShoulder(bool value)
	{
		if (value)
		{
			View.SwitchPageUp();
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void RightShoulder(bool value)
	{
		if (value)
		{
			View.SwitchPageDown();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void ButtonNorth(bool value)
	{
		if (value)
		{
			View.OnLookTutorial();
		}
	}

	[GameInputBindingBool("UI/View")]
	public void ViewDiskDetail(bool value)
	{
		if (value && !(View == null) && View.TrySubmitDiskDetail())
		{
			Singleton<GameInputActionManager>.instance.CancelAllActionProcessAtThisFrame();
		}
	}
}
