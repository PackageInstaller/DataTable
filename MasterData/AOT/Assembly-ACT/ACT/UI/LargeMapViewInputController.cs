using ACT.Battle;
using ACT.MissionSystem;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class LargeMapViewInputController : BaseUIViewInputController<LargeMapView>
{
	private ViewControlRoot m_ViewControlRoot;

	[Header("手柄缩放配置")]
	private float gamepadZoomSpeed = 1f;

	private float gamepadZoomDeadZone = 0.1f;

	private const float GamepadZoomRepeatInterval = 0.03f;

	private float lastRTValue;

	private float lastLTValue;

	private SubControllerType subControllerType;

	private GameObject curSelectItem;

	private ContinuousNavigateData _curNavigateData;

	public SubControllerType ControllerType
	{
		get
		{
			return subControllerType;
		}
		set
		{
			if (subControllerType != value)
			{
				_curNavigateData?.Reset();
				subControllerType = value;
			}
		}
	}

	public bool ControllerIsInit => View != null;

	protected override void OnInitView(LargeMapView view)
	{
		base.OnInitView(view);
		m_ViewControlRoot = view.GetComponentInChildren<ViewControlRoot>();
		subControllerType = SubControllerType.main;
		curSelectItem = null;
	}

	protected override void OnActivate()
	{
		base.OnActivate();
		View?.SetGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
	}

	protected override void OnBackPressed(bool value)
	{
		if (!value)
		{
			View?.HandleGamePadReturnButtonInput(subControllerType);
		}
	}

	[GameInputBindingBool("UI/RightTrigger")]
	private void OnGamepadRightTriggerV2(bool value)
	{
		if (value && (subControllerType == SubControllerType.main || subControllerType == SubControllerType.worldMap))
		{
			lastLTValue = 0f;
			lastRTValue = 1f;
			HandleGamepadTriggerZoom();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/RightTrigger", HandleGamepadTriggerZoom, 0.1f, -1, 0.03f);
		}
	}

	[GameInputBindingBool("UI/LeftTrigger")]
	private void OnGamepadLeftTriggerV2(bool value)
	{
		if (value && (subControllerType == SubControllerType.main || subControllerType == SubControllerType.worldMap))
		{
			lastRTValue = 0f;
			lastLTValue = 1f;
			HandleGamepadTriggerZoom();
			Singleton<GameInputActionManager>.instance.GetLongPressInputHandle("UI/LeftTrigger", HandleGamepadTriggerZoom, 0.1f, -1, 0.03f);
		}
	}

	[GameInputBindingBool("UI/SwitchPageUp")]
	private void OnGamepadWorldMap(bool value)
	{
		if (value && subControllerType == SubControllerType.main)
		{
			View.BackToWorldMap();
		}
	}

	[GameInputBindingBool("UI/RightStickPress")]
	private void OnGamepadOpenBossRewardView(bool value)
	{
		if (!value && subControllerType == SubControllerType.sideBar && View.iconSidebar.worldBossRoot.activeSelf)
		{
			View.iconSidebar.rewardTipsButton.OnClick?.Invoke();
		}
		else if (!value && subControllerType == SubControllerType.main && View.mapPlayerIcon.gameObject.activeSelf)
		{
			View.SetRectTransformToCenter(View.mapPlayerIcon.transform as RectTransform);
		}
	}

	[GameInputBindingBool("UI/SwitchPageDown")]
	private void OnGamepadBackToTarget(bool value)
	{
		if (value && subControllerType == SubControllerType.main && Singleton<MissionManager>.instance.GetTracingMission() != 0)
		{
			if (View.missionIconRoot.transform.childCount > 0)
			{
				View.SetRectTransformToCenter(View.missionIconRoot.transform.GetChild(0) as RectTransform);
			}
			else if (View.backToWorldMapBtn.missionInOtherArea.activeSelf)
			{
				View.BackToWorldMap();
			}
		}
	}

	[GameInputBindingVector2("UI/MoveMap")]
	private void OnGamepadMapMove(Vector2 dir)
	{
		if (MonoECS.instance.InputMode != DeviceInputMode.Gamepad && subControllerType == SubControllerType.main && View != null)
		{
			if (View.IsKeyboardControlEnabled())
			{
				View.HandleKeyboardMapMove(dir, isControl: true);
			}
		}
		else if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad && subControllerType == SubControllerType.main && View != null)
		{
			View.LeftStick = dir;
		}
	}

	public void RefreshMapMoveInput()
	{
		if (!(View == null))
		{
			GameInputActionManager instance = Singleton<GameInputActionManager>.instance;
			if (!Application.isFocused || !IsActive || !IsEnabled || instance == null || !instance.IsActive || subControllerType != SubControllerType.main || MonoECS.instance.InputMode != DeviceInputMode.Gamepad || ((IGameInputBindingHandle)this).ActionDisableList.Contains("UI/MoveMap") || !instance.GetHandleCallbackIsActive(this, "UI/MoveMap"))
			{
				View.LeftStick = Vector2.zero;
				return;
			}
			View.HandleKeyboardMapMove(Vector2.zero, isControl: false);
			View.LeftStick = instance.ReadActionValue<Vector2>("UI/MoveMap", out var _);
		}
	}

	[GameInputBindingVector2("UI/Navigate")]
	public void OnSelectionNavigate(Vector2 value)
	{
		if (subControllerType == SubControllerType.main)
		{
			_curNavigateData?.Reset();
		}
		else if (View != null && subControllerType != SubControllerType.main)
		{
			ContinuousNavigateUtility.StartContinuousNavigate(value, ref _curNavigateData, ExecuteNavigate);
		}
	}

	private void ExecuteNavigate(MoveDirection dir)
	{
		if (!IsActive || !IsEnabled || subControllerType == SubControllerType.main)
		{
			return;
		}
		switch (dir)
		{
		case MoveDirection.Down:
			if (subControllerType == SubControllerType.rewardWindow)
			{
				View.CloseRewardPreviewWindow();
			}
			m_ViewControlRoot.SelectDown();
			break;
		case MoveDirection.Up:
			m_ViewControlRoot.SelectUp();
			break;
		}
		switch (dir)
		{
		case MoveDirection.Left:
			m_ViewControlRoot.SelectLeft();
			break;
		case MoveDirection.Right:
			m_ViewControlRoot.SelectRight();
			break;
		}
		SideBarGamePadClick();
	}

	[GameInputBindingBool("UI/Confirm")]
	private void OnGamepadMapSelectClick(bool value)
	{
		if ((View != null) & value)
		{
			if (Model<GuideModel>.Interface.IsInStrongGuide())
			{
				View.HandleGuideSelectButtonInput(ControllerType);
			}
			else
			{
				View.HandleGamePadSelectButtonInput(ControllerType);
			}
		}
	}

	[GameInputBindingBool("UI/UISpecial1")]
	private void OnGamepadMapItemClick(bool value)
	{
		if ((View != null) & value)
		{
			View.HandleGamePadMapItemInput(ControllerType);
		}
	}

	[GameInputBindingBool("UI/UISpecial2")]
	private void OnGamepadMapDeleteClick(bool value)
	{
		if (((View != null) & value) && subControllerType == SubControllerType.sideBar)
		{
			if (View.iconSidebar.selfNodeRoot.activeSelf)
			{
				View.iconSidebar.selfNodeDeleteBtn.OnClick?.Invoke();
			}
		}
		else if (((View != null) & value) && subControllerType == SubControllerType.mapCollection)
		{
			if (!View.exploreRatioSidebar.areaExploreGroup.gameObject.activeSelf)
			{
				View.exploreRatioSidebar.ToShowArea();
			}
		}
		else if (!((View != null) & value) || subControllerType != SubControllerType.main)
		{
			if (((View != null) & value) && subControllerType == SubControllerType.worldMap)
			{
				View.worldAreaSide.Show();
			}
			else if (((View != null) & value) && subControllerType == SubControllerType.templeMap)
			{
				View?.templeMapScrollRect.btnStartReward.OnClick?.Invoke();
			}
		}
	}

	[GameInputBindingBool("UI/OpenSubAreaExplore")]
	public void OnSelectionUp(bool value)
	{
		if (value && subControllerType == SubControllerType.main)
		{
			View.ShowExploreRatioSideBar();
		}
	}

	[GameInputBindingBool("UI/OpenAreaExplore")]
	public void OnSelectionDown(bool value)
	{
		if (value && subControllerType == SubControllerType.main && View.areaExploreInfo.subExploreInfoRoot.activeSelf)
		{
			View.ShowSubAreaExploreRatioSideBar();
		}
	}

	[GameInputBindingBool("UI/SelectItemCell")]
	public void OnSelectionChangeToSelectItem(bool value)
	{
		if (value)
		{
			View?.ChangeToSideBarSelectType();
		}
	}

	public void SideBarGamePadClick()
	{
		if (subControllerType == SubControllerType.sideBar)
		{
			if (View.iconSidebar.selfNodeRoot.activeSelf)
			{
				CommonSelect();
			}
		}
		else if (subControllerType == SubControllerType.rewardWindow)
		{
			CommonSelect();
		}
	}

	private void HandleGamepadTriggerZoom()
	{
		ScrollRect scrollRect = ((subControllerType == SubControllerType.main) ? ((ScrollRect)View.areaMapScrollRect) : ((ScrollRect)View.worldMapScrollRect));
		if (scrollRect == null || scrollRect.content == null)
		{
			return;
		}
		float num = ((Mathf.Abs(lastRTValue) > gamepadZoomDeadZone) ? lastRTValue : 0f);
		float num2 = ((Mathf.Abs(lastLTValue) > gamepadZoomDeadZone) ? lastLTValue : 0f);
		float num3 = (num - num2) * gamepadZoomSpeed * 0.03f;
		if (!(Mathf.Abs(num3) <= 0.001f))
		{
			float x = scrollRect.content.localScale.x;
			float targetScale;
			if (subControllerType == SubControllerType.main)
			{
				(float, float) areaScrollRectMinMaxScale = View.mapConfig.GetAreaScrollRectMinMaxScale(View.CurShowArea);
				targetScale = Mathf.Clamp(x + num3, areaScrollRectMinMaxScale.Item1, areaScrollRectMinMaxScale.Item2);
			}
			else
			{
				targetScale = Mathf.Clamp(x + num3, View.worldMapScrollRect.minScale, View.worldMapScrollRect.maxScale);
			}
			ApplyGamepadZoom(scrollRect, targetScale, x);
		}
	}

	private void ApplyGamepadZoom(ScrollRect targetScrollRect, float targetScale, float currentScale)
	{
		if (targetScrollRect == null)
		{
			return;
		}
		if (targetScrollRect is AreaMapScrollRect)
		{
			View.areaMapScrollRect.UpdateTargetScale(UIUtility.screenCenter, targetScale * 1f, force: true);
		}
		else if (targetScrollRect is WorldMapScrollRect)
		{
			View.worldMapScrollRect.UpdateTargetScale(UIUtility.screenCenter, targetScale * 1f);
		}
		if (subControllerType == SubControllerType.main)
		{
			if (View.areaMapScaleSlider != null && View.areaMapScaleSlider.gameObject.activeSelf)
			{
				View.areaMapScaleSlider.SetValueWithoutNotify(targetScale);
			}
			View.OnScaleUpdate(currentScale, targetScale);
		}
	}

	public void CommonSelect()
	{
		if ((bool)EventSystemHelper.CurrentSelected)
		{
			EventSystemHelper.ClickCurrent();
		}
	}

	protected override void OnDeactivate()
	{
		base.OnDeactivate();
		_curNavigateData?.Reset();
		View.LeftStick = Vector2.zero;
		View.virtualCursor?.HandleGamepadInput(Vector2.zero);
		lastRTValue = 0f;
		lastLTValue = 0f;
	}
}
