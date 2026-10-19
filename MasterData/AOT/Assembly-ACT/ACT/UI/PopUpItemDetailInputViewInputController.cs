using ACT.UI.ItemDetail;

namespace ACT.UI;

public class PopUpItemDetailInputViewInputController : BaseUIViewInputController<MonoPopUpItemDetailPanel>
{
	protected override void OnEscPressed(bool value)
	{
		base.OnEscPressed(value);
		OnBackPressed(value);
	}

	protected override void OnBackPressed(bool value)
	{
		base.OnBackPressed(value);
		if (!value && !(View == null) && View.commonItemDetail.InputState == ItemDetailGamePadInputState.Item_NoFocus)
		{
			View.Close();
		}
	}
}
