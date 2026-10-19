using ACT.Battle;
using ACT.ViewControl;
using UnityEngine;

namespace ACT.UI.InputController.RewardView;

public class RewardViewInputController : BaseUIViewInputController<BaseRewardView>
{
	private ViewControlRoot m_ViewControlRoot;

	private ViewControlLayer m_ViewControlLayer;

	private ContinuousNavigateData _curNavigateData;

	private RewardSubController subControllerType;

	public RewardSubController ControllerType
	{
		get
		{
			return subControllerType;
		}
		set
		{
			subControllerType = value;
		}
	}

	protected override void OnInitView(BaseRewardView view)
	{
		base.OnInitView(view);
		subControllerType = RewardSubController.Main;
		m_ViewControlRoot = view?.GetComponentInChildren<ViewControlRoot>();
		m_ViewControlLayer = view?.GetComponentInChildren<ViewControlLayer>();
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.HandleGamePadReturnButtonInput(ControllerType);
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void Navigate(Vector2 value)
	{
		ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, View.ExecuteNavigate);
	}

	[GameInputBindingBool("UI/Confirm")]
	public void OnLeftStickConfirm(bool value)
	{
		if (value && View.CanCloseByConfirm())
		{
			View.Close();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void OnClickStartBtn(bool value)
	{
		if (value)
		{
			View.OnClickStartBtn();
			if (View.IsGamepadItemSelectMode())
			{
				m_ViewControlRoot?.SelectDefault();
				m_ViewControlLayer.Focus();
			}
		}
	}

	[GameInputBindingBool("LargeMapView/Select")]
	public void OnClickSelectABtn(bool value)
	{
		if (value)
		{
			View.OnClickSelectABtn();
		}
	}

	[GameInputBindingBool("LargeMapView/Return")]
	public void OnClickSelectBBtn(bool value)
	{
		if (value)
		{
			View.OnClickSelectBBtn();
			m_ViewControlLayer.UnFocus();
		}
	}
}
