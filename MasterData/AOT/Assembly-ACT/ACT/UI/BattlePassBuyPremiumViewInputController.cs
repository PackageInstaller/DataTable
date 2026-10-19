using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class BattlePassBuyPremiumViewInputController : BaseUIViewInputController<BattlePassBuyPremiumView>
{
	private ViewControlRoot _viewControlRoot;

	private ContinuousNavigateData _curNavigateData;

	private BattlePassBuyPremiumSubController _subControllerType;

	protected override void OnInitView(BattlePassBuyPremiumView view)
	{
		base.OnInitView(view);
		_subControllerType = BattlePassBuyPremiumSubController.PayLowHigh;
	}

	public void SetSubControllerType(BattlePassBuyPremiumSubController type)
	{
		if (_subControllerType != type)
		{
			_subControllerType = type;
			_curNavigateData?.Reset();
		}
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		_curNavigateData?.Reset();
		EnsureViewControlRoot();
		_viewControlRoot?.ReFocus();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null))
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
		}
	}

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (!value || View == null)
		{
			return;
		}
		if (_subControllerType == BattlePassBuyPremiumSubController.PayLowHigh)
		{
			if (View.IsPayTierFocused())
			{
				View.OnConfirmBuyBtn();
			}
		}
		else if (EventSystemHelper.CurrentSelected != null)
		{
			EventSystemHelper.ClickCurrent();
		}
		else
		{
			EnsureViewControlRoot();
			_viewControlRoot?.ReFocus();
		}
	}

	[GameInputBindingBool("UI/UISpecial5")]
	public void OnSpecial5(bool value)
	{
		if (value && !(View == null) && _subControllerType == BattlePassBuyPremiumSubController.PayLowHigh && View.IsPayTierFocused())
		{
			View.EnterRewardForCurrentFocus();
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!View.isEmpty && !value)
		{
			if (_subControllerType != BattlePassBuyPremiumSubController.PayLowHigh)
			{
				View.ChangeSubControllerType(BattlePassBuyPremiumSubController.PayLowHigh);
			}
			else
			{
				View.Close();
			}
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void OnSelectItemCell(bool value)
	{
		if (value && !(View == null) && _subControllerType == BattlePassBuyPremiumSubController.PayLowHigh)
		{
			View.TryEnterDiskLayer();
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		if (TryHandlePayChainNavigate(dir))
		{
			return;
		}
		if (_subControllerType == BattlePassBuyPremiumSubController.Disk)
		{
			if (dir == MoveDirection.Up || dir == MoveDirection.Down)
			{
				View.TryMoveDiskFocus(dir);
			}
			return;
		}
		EnsureViewControlRoot();
		if (!(_viewControlRoot == null))
		{
			switch (dir)
			{
			case MoveDirection.Up:
				_viewControlRoot.SelectUp();
				break;
			case MoveDirection.Down:
				_viewControlRoot.SelectDown();
				break;
			case MoveDirection.Left:
				_viewControlRoot.SelectLeft();
				break;
			case MoveDirection.Right:
				_viewControlRoot.SelectRight();
				break;
			}
			View.OnPayLayerFocusChanged();
		}
	}

	private bool TryHandlePayChainNavigate(MoveDirection dir)
	{
		if (View == null || MonoECS.instance.InputMode == DeviceInputMode.TouchScreen)
		{
			return false;
		}
		if (_subControllerType != BattlePassBuyPremiumSubController.PayLowHigh)
		{
			return false;
		}
		if (dir != MoveDirection.Left && dir != MoveDirection.Right)
		{
			return false;
		}
		return View.TryMovePayFocus(dir);
	}

	private void EnsureViewControlRoot()
	{
		if (_viewControlRoot == null)
		{
			_viewControlRoot = View?.GetComponentInChildren<ViewControlRoot>();
		}
	}
}
