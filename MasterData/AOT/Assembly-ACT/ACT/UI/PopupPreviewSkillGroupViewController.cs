using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class PopupPreviewSkillGroupViewController : BaseUIViewInputController<PopupPreviewSkillGroupBaseView>
{
	private ContinuousNavigateData _curNavigateData;

	private ViewControlRoot m_ViewControlRoot;

	private GameObject curSelectItem;

	private Vector2 dir = Vector2.zero;

	protected override void OnInitView(PopupPreviewSkillGroupBaseView view)
	{
		base.OnInitView(view);
		m_ViewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
		curSelectItem = null;
		dir = Vector2.zero;
	}

	protected override void OnBackPressed(bool value)
	{
		if (View != null && !value)
		{
			View.Close();
		}
	}

	[GameInputBindingBool("LargeMapView/mapScaleAdd")]
	private void OnGamepadRightTrigger(bool value)
	{
		dir = Vector2.down;
		HandleGamepadTriggerZoomButton();
		Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("LargeMapView/mapScaleAdd", HandleGamepadTriggerZoomButton, 0.4f, -1, 0.5f, null, EndGamepadTriggerZoomButton);
	}

	[GameInputBindingBool("LargeMapView/mapScaleReduce")]
	private void OnGamepadLeftTrigger(bool value)
	{
		dir = Vector2.up;
		HandleGamepadTriggerZoomButton();
		Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("LargeMapView/mapScaleReduce", HandleGamepadTriggerZoomButton, 0.4f, -1, 0.5f, null, EndGamepadTriggerZoomButton);
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		switch (dir)
		{
		case MoveDirection.Down:
			m_ViewControlRoot.SelectDown();
			CommonSelect();
			break;
		case MoveDirection.Up:
			m_ViewControlRoot.SelectUp();
			CommonSelect();
			break;
		}
	}

	[GameInputBindingBool("LargeMapView/Delete")]
	private void OnGamepadToMax(bool value)
	{
		if ((View != null) & value)
		{
			View.ScrollToMax();
		}
	}

	private void CommonSelect()
	{
		if ((bool)EventSystemHelper.CurrentSelected)
		{
			EventSystemHelper.ClickCurrent();
		}
	}

	private void HandleGamepadTriggerZoomButton()
	{
		ContinuousNavigateUtility.StartContinuousNavigate(dir, ref _curNavigateData, ExecuteNavigate);
	}

	private void EndGamepadTriggerZoomButton()
	{
		dir = Vector2.zero;
		ContinuousNavigateUtility.StartContinuousNavigate(Vector2.zero, ref _curNavigateData, ExecuteNavigate);
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		curSelectItem = null;
		dir = Vector2.zero;
		_curNavigateData?.Reset();
	}
}
