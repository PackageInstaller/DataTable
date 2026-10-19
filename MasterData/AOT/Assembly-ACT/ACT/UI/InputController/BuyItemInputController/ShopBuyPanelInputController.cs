using ACT.Battle;
using Fundamental;
using UnityEngine.UI;

namespace ACT.UI.InputController.BuyItemInputController;

public class ShopBuyPanelInputController : BaseUIViewInputController<ShopBuyPanel>
{
	[GameInputBindingBool("UI/SwitchPageUp")]
	public void Reduce(bool isPress)
	{
		if (isPress)
		{
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/SwitchPageUp", SubmitMinusButton, 0.01f, -1, 0.15f);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	public void Add(bool isPress)
	{
		if (isPress)
		{
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/SwitchPageDown", SubmitAddButton, 0.01f, -1, 0.15f);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	public void Max(bool isPress)
	{
		if (!isPress)
		{
			SubmitSelectable(View?.maxBtn);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool isPress)
	{
		if (!isPress)
		{
			SubmitSelectable(View?.confirmBtn);
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void OpenItemCell(bool isPress)
	{
		if (!isPress && !(View?.itemUI == null))
		{
			SubmitSelectable(View.itemUI);
		}
	}

	protected override void OnEscPressed(bool isPress)
	{
		base.OnEscPressed(isPress);
		if (!isPress)
		{
			CancelInternal();
		}
	}

	protected override void OnBackPressed(bool isPress)
	{
		if (!isPress)
		{
			CancelInternal();
		}
	}

	private void CancelInternal()
	{
		SubmitSelectable(View?.cancelBtn);
	}

	private void SubmitMinusButton()
	{
		SubmitSelectable(View?.minusBtn);
	}

	private void SubmitAddButton()
	{
		SubmitSelectable(View?.addBtn);
	}

	private static void SubmitSelectable(Selectable selectable)
	{
		if (!(selectable == null) && selectable.IsInteractable() && EventSystemHelper.Available)
		{
			EventSystemHelper.Click(selectable);
		}
	}
}
