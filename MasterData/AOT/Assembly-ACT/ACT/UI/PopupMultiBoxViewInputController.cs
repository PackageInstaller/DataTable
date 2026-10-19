using ACT.Battle;
using ACT.UI.InputController;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class PopupMultiBoxViewInputController : BaseUIViewInputController<PopupMultiBoxView>
{
	private ContinuousNavigateData _curNavigateData;

	private float lastPressTime;

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

	[GameInputBindingBool("UI/Confirm")]
	public void Confirm(bool value)
	{
		if (value)
		{
			View.OnConfirm();
		}
	}

	[GameInputBindingBool("UI/SwitchPageLeft")]
	public void LeftTrigger(bool value)
	{
		if (value && Time.unscaledTime - lastPressTime > 0.1f)
		{
			lastPressTime = Time.unscaledTime;
			View.OnReduce();
		}
	}

	[GameInputBindingBool("UI/SwitchPageRight")]
	public void RightTrigger(bool value)
	{
		if (value && Time.unscaledTime - lastPressTime > 0.1f)
		{
			lastPressTime = Time.unscaledTime;
			View.OnAdd();
		}
	}

	[GameInputBindingBool("UI/LeftStackPress")]
	public void ShowRewardDetail(bool value)
	{
		if (value && View.curSelectItemData != null && !(EventSystemHelper.CurrentSelected == null))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, View.curSelectItemData);
		}
	}
}
