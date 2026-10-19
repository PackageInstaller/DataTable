using System.Linq;
using ACT.Battle;
using ACT.UI.CommonComponent.CoinComponent;
using ACT.ViewControl;
using Fundamental;
using Runtime.UI.CommonComponent;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI.InputController.CoinComponentInputController;

public class CoinComponentInputController : SubUIViewInputController<CommonCoinGroup>
{
	private ContinuousNavigateData _curNavigateState;

	public ViewControlRoot ViewControlRoot { get; private set; }

	public ViewControlLayer ViewControlLayer { get; private set; }

	protected override void OnInitView(CommonCoinGroup view)
	{
		base.OnInitView(view);
		if (!(View == null))
		{
			ViewControlRoot = View.GetComponentInParent<ViewControlRoot>();
			ViewControlLayer = View.GetComponentInChildren<ViewControlLayer>();
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		UpdateInputActionEnable();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateState?.Reset();
		UpdateInputActionEnable();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool isPressed)
	{
		if (isPressed || !ViewControlLayer.IsFocused)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if ((bool)currentSelected)
		{
			CommonCoinComponent component = currentSelected.GetComponent<CommonCoinComponent>();
			if ((bool)component)
			{
				SubmitCoinComponent(component);
			}
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnNavigate(Vector2 value)
	{
		if (ViewControlLayer.IsFocused)
		{
			if (!EventSystemHelper.CurrentSelected)
			{
				EventSystemHelper.SetSelectedGameObject(View.CoinComponents.FirstOrDefault()?.gameObject);
			}
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateState, ExecuteNavigate);
		}
	}

	[GameInputBindingBool("UI/UISpecial6")]
	public void FocusLayer(bool isPressed)
	{
		if (!isPressed)
		{
			CommonCoinComponent singleActiveCoinComponent = GetSingleActiveCoinComponent();
			if ((bool)singleActiveCoinComponent)
			{
				SubmitCoinComponent(singleActiveCoinComponent);
				return;
			}
			View.FocusIn();
			View.prompt.SetVisible(vis: false);
			ViewControlLayer.Focus();
			UpdateInputActionEnable();
			View.IsOperating = true;
		}
	}

	[GameInputBindingBool("UI/Back")]
	public void UnFocusLayer(bool isPressed)
	{
		if (!isPressed)
		{
			View.prompt.SetVisible(vis: true);
			if ((bool)ViewControlRoot?.PreviousFocusLayer && ViewControlRoot.PreviousFocusLayer != ViewControlLayer)
			{
				ViewControlRoot?.PreviousFocusLayer?.ReFocus();
			}
			else
			{
				ViewControlLayer.UnFocus();
			}
			UpdateInputActionEnable();
			View.IsOperating = false;
		}
	}

	private void ExecuteNavigate(MoveDirection direction)
	{
		switch (direction)
		{
		case MoveDirection.Left:
			ViewControlRoot?.SelectLeft();
			break;
		case MoveDirection.Right:
			ViewControlRoot?.SelectRight();
			break;
		}
	}

	private CommonCoinComponent GetSingleActiveCoinComponent()
	{
		CommonCoinComponent commonCoinComponent = null;
		foreach (CommonCoinComponent coinComponent in View.CoinComponents)
		{
			if ((bool)coinComponent && coinComponent.gameObject.activeInHierarchy)
			{
				if ((bool)commonCoinComponent)
				{
					return null;
				}
				commonCoinComponent = coinComponent;
			}
		}
		return commonCoinComponent;
	}

	private void SubmitCoinComponent(CommonCoinComponent commonCoinComponent)
	{
		if ((bool)commonCoinComponent.supplementBtn && commonCoinComponent.supplementBtn.gameObject.activeInHierarchy)
		{
			EventSystemHelper.Click(commonCoinComponent.supplementBtn);
		}
		else
		{
			EventSystemHelper.Click(commonCoinComponent);
		}
	}

	private void UpdateInputActionEnable()
	{
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/Confirm", !ViewControlLayer.IsFocused);
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/Back", !ViewControlLayer.IsFocused);
		Singleton<GameInputActionManager>.instance.SetActionBlacklist(this, "UI/Navigate", !ViewControlLayer.IsFocused);
	}
}
