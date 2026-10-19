using ACT.Battle;
using ACT.Model;
using ACT.UI.InputController;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class PopUpWildBossGetRewardViewInputController : BaseUIViewInputController<PopUpWildBossGetRewardView>
{
	private ViewControlRoot _viewControlRoot;

	private ViewControlLayer _viewControlLayer;

	private ContinuousNavigateData _curNavigateData;

	protected override void OnInitView(PopUpWildBossGetRewardView view)
	{
		base.OnInitView(view);
		_viewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
		_viewControlLayer = view.GetComponentInChildren<ViewControlLayer>();
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		_curNavigateData?.Reset();
		RefreshDefaultSelect();
	}

	public override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshDefaultSelect();
	}

	private void RefreshDefaultSelect()
	{
		ACT.ViewControl.SelectableEx defaultSelect = ((Model<WildBossModel>.Interface.CanTakeRewardCount > 0) ? View.ConfirmSelectableEx : View.CancelSelectableEx);
		_viewControlLayer.SetDefaultSelect(defaultSelect);
		_viewControlLayer.Focus();
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnConfirm(bool value)
	{
		if (!value && !(View == null) && EventSystemHelper.CurrentSelected != null)
		{
			EventSystemHelper.ClickCurrent();
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	public void OnSpecial1(bool value)
	{
		if (value && !(View == null))
		{
			View.BuyRewardByGamePad();
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		if (!(View == null))
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
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
		}
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View.CloseByGamePad();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}
}
