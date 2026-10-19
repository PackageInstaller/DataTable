using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class NPCRaidViewInputController : BaseUIViewInputController<NPCRaidView>
{
	private ContinuousNavigateData _curNavigateData;

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.Close();
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
			View.HandleConfirm();
		}
	}
}
