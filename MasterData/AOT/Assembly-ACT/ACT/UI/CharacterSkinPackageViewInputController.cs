using ACT.Battle;
using UnityEngine;

namespace ACT.UI;

public class CharacterSkinPackageViewInputController : BaseUIViewInputController<CharacterSkinPackageView>
{
	private ContinuousNavigateData _curNavigateData;

	protected override void OnActivate()
	{
		base.OnActivate();
		View?.OnActivate();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	protected override void OnBackPressed(bool value)
	{
		base.OnBackPressed(value);
		if (!value)
		{
			View?.Close();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null))
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value)
		{
			View?.OnConfirm();
		}
	}
}
