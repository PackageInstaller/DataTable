using System;
using System.Collections.Generic;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;
using UnityEngine.Serialization;
using UnityEngine.UI;
using UnityEngine.UIElements;

namespace UnityEngine.InputSystem.UI;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.inputsystem@1.7/manual/UISupport.html#setting-up-ui-input")]
public class InputSystemUIInputModule : BaseInputModule
{
	private struct InputActionReferenceState
	{
		public int refCount;

		public bool enabledByInputModule;
	}

	public enum CursorLockBehavior
	{
		OutsideScreen,
		ScreenCenter
	}

	private const float kClickSpeed = 0.3f;

	[FormerlySerializedAs("m_RepeatDelay")]
	[Tooltip("The Initial delay (in seconds) between an initial move action and a repeated move action.")]
	[SerializeField]
	private float m_MoveRepeatDelay = 0.5f;

	[Tooltip("The speed (in seconds) that the move action repeats itself once repeating (max 1 per frame).")]
	[FormerlySerializedAs("m_RepeatRate")]
	[SerializeField]
	private float m_MoveRepeatRate = 0.1f;

	[Tooltip("Scales the Eventsystem.DragThreshold, for tracked devices, to make selection easier.")]
	private float m_TrackedDeviceDragThresholdMultiplier = 2f;

	[Tooltip("Transform representing the real world origin for tracking devices. When using the XR Interaction Toolkit, this should be pointing to the XR Rig's Transform.")]
	[SerializeField]
	private Transform m_XRTrackingOrigin;

	internal const float kPixelPerLine = 20f;

	[SerializeField]
	[HideInInspector]
	private InputActionAsset m_ActionsAsset;

	[HideInInspector]
	[SerializeField]
	private InputActionReference m_PointAction;

	[HideInInspector]
	[SerializeField]
	private InputActionReference m_MoveAction;

	[HideInInspector]
	[SerializeField]
	private InputActionReference m_SubmitAction;

	[SerializeField]
	[HideInInspector]
	private InputActionReference m_CancelAction;

	[HideInInspector]
	[SerializeField]
	private InputActionReference m_LeftClickAction;

	[HideInInspector]
	[SerializeField]
	private InputActionReference m_MiddleClickAction;

	[HideInInspector]
	[SerializeField]
	private InputActionReference m_RightClickAction;

	[SerializeField]
	[HideInInspector]
	private InputActionReference m_ScrollWheelAction;

	[HideInInspector]
	[SerializeField]
	private InputActionReference m_TrackedDevicePositionAction;

	[HideInInspector]
	[SerializeField]
	private InputActionReference m_TrackedDeviceOrientationAction;

	[SerializeField]
	private bool m_DeselectOnBackgroundClick = true;

	[SerializeField]
	private UIPointerBehavior m_PointerBehavior;

	[SerializeField]
	[HideInInspector]
	internal CursorLockBehavior m_CursorLockBehavior;

	private static Dictionary<InputAction, InputActionReferenceState> s_InputActionReferenceCounts = new Dictionary<InputAction, InputActionReferenceState>();

	[NonSerialized]
	private bool m_ActionsHooked;

	[NonSerialized]
	private bool m_NeedToPurgeStalePointers;

	private Action<InputAction.CallbackContext> m_OnPointDelegate;

	private Action<InputAction.CallbackContext> m_OnMoveDelegate;

	private Action<InputAction.CallbackContext> m_OnLeftClickDelegate;

	private Action<InputAction.CallbackContext> m_OnRightClickDelegate;

	private Action<InputAction.CallbackContext> m_OnMiddleClickDelegate;

	private Action<InputAction.CallbackContext> m_OnScrollWheelDelegate;

	private Action<InputAction.CallbackContext> m_OnTrackedDevicePositionDelegate;

	private Action<InputAction.CallbackContext> m_OnTrackedDeviceOrientationDelegate;

	private Action<object> m_OnControlsChangedDelegate;

	[NonSerialized]
	private int m_CurrentPointerId = -1;

	[NonSerialized]
	private int m_CurrentPointerIndex = -1;

	[NonSerialized]
	internal UIPointerType m_CurrentPointerType;

	internal InlinedArray<int> m_PointerIds;

	internal InlinedArray<InputControl> m_PointerTouchControls;

	internal InlinedArray<PointerModel> m_PointerStates;

	private NavigationModel m_NavigationState;

	[NonSerialized]
	private GameObject m_LocalMultiPlayerRoot;

	public bool deselectOnBackgroundClick
	{
		get
		{
			return m_DeselectOnBackgroundClick;
		}
		set
		{
			m_DeselectOnBackgroundClick = value;
		}
	}

	public UIPointerBehavior pointerBehavior
	{
		get
		{
			return m_PointerBehavior;
		}
		set
		{
			m_PointerBehavior = value;
		}
	}

	public CursorLockBehavior cursorLockBehavior
	{
		get
		{
			return m_CursorLockBehavior;
		}
		set
		{
			m_CursorLockBehavior = value;
		}
	}

	internal GameObject localMultiPlayerRoot
	{
		get
		{
			return m_LocalMultiPlayerRoot;
		}
		set
		{
			m_LocalMultiPlayerRoot = value;
		}
	}

	public float moveRepeatDelay
	{
		get
		{
			return m_MoveRepeatDelay;
		}
		set
		{
			m_MoveRepeatDelay = value;
		}
	}

	public float moveRepeatRate
	{
		get
		{
			return m_MoveRepeatRate;
		}
		set
		{
			m_MoveRepeatRate = value;
		}
	}

	private bool explictlyIgnoreFocus => InputSystem.settings.backgroundBehavior == InputSettings.BackgroundBehavior.IgnoreFocus;

	private bool shouldIgnoreFocus
	{
		get
		{
			if (!explictlyIgnoreFocus)
			{
				return InputRuntime.s_Instance.runInBackground;
			}
			return true;
		}
	}

	[Obsolete("'repeatRate' has been obsoleted; use 'moveRepeatRate' instead. (UnityUpgradable) -> moveRepeatRate", false)]
	public float repeatRate
	{
		get
		{
			return moveRepeatRate;
		}
		set
		{
			moveRepeatRate = value;
		}
	}

	[Obsolete("'repeatDelay' has been obsoleted; use 'moveRepeatDelay' instead. (UnityUpgradable) -> moveRepeatDelay", false)]
	public float repeatDelay
	{
		get
		{
			return moveRepeatDelay;
		}
		set
		{
			moveRepeatDelay = value;
		}
	}

	public Transform xrTrackingOrigin
	{
		get
		{
			return m_XRTrackingOrigin;
		}
		set
		{
			m_XRTrackingOrigin = value;
		}
	}

	public float trackedDeviceDragThresholdMultiplier
	{
		get
		{
			return m_TrackedDeviceDragThresholdMultiplier;
		}
		set
		{
			m_TrackedDeviceDragThresholdMultiplier = value;
		}
	}

	public InputActionReference point
	{
		get
		{
			return m_PointAction;
		}
		set
		{
			SwapAction(ref m_PointAction, value, m_ActionsHooked, m_OnPointDelegate);
		}
	}

	public InputActionReference scrollWheel
	{
		get
		{
			return m_ScrollWheelAction;
		}
		set
		{
			SwapAction(ref m_ScrollWheelAction, value, m_ActionsHooked, m_OnScrollWheelDelegate);
		}
	}

	public InputActionReference leftClick
	{
		get
		{
			return m_LeftClickAction;
		}
		set
		{
			SwapAction(ref m_LeftClickAction, value, m_ActionsHooked, m_OnLeftClickDelegate);
		}
	}

	public InputActionReference middleClick
	{
		get
		{
			return m_MiddleClickAction;
		}
		set
		{
			SwapAction(ref m_MiddleClickAction, value, m_ActionsHooked, m_OnMiddleClickDelegate);
		}
	}

	public InputActionReference rightClick
	{
		get
		{
			return m_RightClickAction;
		}
		set
		{
			SwapAction(ref m_RightClickAction, value, m_ActionsHooked, m_OnRightClickDelegate);
		}
	}

	public InputActionReference move
	{
		get
		{
			return m_MoveAction;
		}
		set
		{
			SwapAction(ref m_MoveAction, value, m_ActionsHooked, m_OnMoveDelegate);
		}
	}

	public InputActionReference submit
	{
		get
		{
			return m_SubmitAction;
		}
		set
		{
			SwapAction(ref m_SubmitAction, value, m_ActionsHooked, null);
		}
	}

	public InputActionReference cancel
	{
		get
		{
			return m_CancelAction;
		}
		set
		{
			SwapAction(ref m_CancelAction, value, m_ActionsHooked, null);
		}
	}

	public InputActionReference trackedDeviceOrientation
	{
		get
		{
			return m_TrackedDeviceOrientationAction;
		}
		set
		{
			SwapAction(ref m_TrackedDeviceOrientationAction, value, m_ActionsHooked, m_OnTrackedDeviceOrientationDelegate);
		}
	}

	public InputActionReference trackedDevicePosition
	{
		get
		{
			return m_TrackedDevicePositionAction;
		}
		set
		{
			SwapAction(ref m_TrackedDevicePositionAction, value, m_ActionsHooked, m_OnTrackedDevicePositionDelegate);
		}
	}

	[Obsolete("'trackedDeviceSelect' has been obsoleted; use 'leftClick' instead.", true)]
	public InputActionReference trackedDeviceSelect
	{
		get
		{
			throw new InvalidOperationException();
		}
		set
		{
			throw new InvalidOperationException();
		}
	}

	public InputActionAsset actionsAsset
	{
		get
		{
			return m_ActionsAsset;
		}
		set
		{
			if (value != m_ActionsAsset)
			{
				UnhookActions();
				m_ActionsAsset = value;
				point = UpdateReferenceForNewAsset(point);
				move = UpdateReferenceForNewAsset(move);
				leftClick = UpdateReferenceForNewAsset(leftClick);
				rightClick = UpdateReferenceForNewAsset(rightClick);
				middleClick = UpdateReferenceForNewAsset(middleClick);
				scrollWheel = UpdateReferenceForNewAsset(scrollWheel);
				submit = UpdateReferenceForNewAsset(submit);
				cancel = UpdateReferenceForNewAsset(cancel);
				trackedDeviceOrientation = UpdateReferenceForNewAsset(trackedDeviceOrientation);
				trackedDevicePosition = UpdateReferenceForNewAsset(trackedDevicePosition);
				HookActions();
			}
		}
	}

	public override void ActivateModule()
	{
		base.ActivateModule();
		GameObject gameObject = base.eventSystem.currentSelectedGameObject;
		if (gameObject == null)
		{
			gameObject = base.eventSystem.firstSelectedGameObject;
		}
		base.eventSystem.SetSelectedGameObject(gameObject, GetBaseEventData());
	}

	public override bool IsPointerOverGameObject(int pointerOrTouchId)
	{
		if (InputSystem.isProcessingEvents)
		{
			Debug.LogWarning("Calling IsPointerOverGameObject() from within event processing (such as from InputAction callbacks) will not work as expected; it will query UI state from the last frame");
		}
		int num = -1;
		if (pointerOrTouchId < 0)
		{
			if (m_CurrentPointerId != -1)
			{
				num = m_CurrentPointerIndex;
			}
			else if (m_PointerStates.length > 0)
			{
				num = 0;
			}
		}
		else
		{
			num = GetPointerStateIndexFor(pointerOrTouchId);
		}
		if (num == -1)
		{
			return false;
		}
		return m_PointerStates[num].eventData.pointerEnter != null;
	}

	public RaycastResult GetLastRaycastResult(int pointerOrTouchId)
	{
		int pointerStateIndexFor = GetPointerStateIndexFor(pointerOrTouchId);
		if (pointerStateIndexFor == -1)
		{
			return default(RaycastResult);
		}
		return m_PointerStates[pointerStateIndexFor].eventData.pointerCurrentRaycast;
	}

	private RaycastResult PerformRaycast(ExtendedPointerEventData eventData)
	{
		if (eventData == null)
		{
			throw new ArgumentNullException("eventData");
		}
		if (eventData.pointerType == UIPointerType.Tracked && TrackedDeviceRaycaster.s_Instances.length > 0)
		{
			for (int i = 0; i < TrackedDeviceRaycaster.s_Instances.length; i++)
			{
				TrackedDeviceRaycaster trackedDeviceRaycaster = TrackedDeviceRaycaster.s_Instances[i];
				m_RaycastResultCache.Clear();
				trackedDeviceRaycaster.PerformRaycast(eventData, m_RaycastResultCache);
				if (m_RaycastResultCache.Count > 0)
				{
					RaycastResult result = m_RaycastResultCache[0];
					m_RaycastResultCache.Clear();
					return result;
				}
			}
			return default(RaycastResult);
		}
		base.eventSystem.RaycastAll(eventData, m_RaycastResultCache);
		RaycastResult result2 = BaseInputModule.FindFirstRaycast(m_RaycastResultCache);
		m_RaycastResultCache.Clear();
		return result2;
	}

	private void ProcessPointer(ref PointerModel state)
	{
		ExtendedPointerEventData eventData = state.eventData;
		UIPointerType pointerType = eventData.pointerType;
		if (pointerType == UIPointerType.MouseOrPen && Cursor.lockState == CursorLockMode.Locked)
		{
			eventData.position = ((m_CursorLockBehavior == CursorLockBehavior.OutsideScreen) ? new Vector2(-1f, -1f) : new Vector2((float)Screen.width / 2f, (float)Screen.height / 2f));
			eventData.delta = default(Vector2);
		}
		else if (pointerType == UIPointerType.Tracked)
		{
			Vector3 position = state.worldPosition;
			Quaternion quaternion = state.worldOrientation;
			if (m_XRTrackingOrigin != null)
			{
				position = m_XRTrackingOrigin.TransformPoint(position);
				quaternion = m_XRTrackingOrigin.rotation * quaternion;
			}
			eventData.trackedDeviceOrientation = quaternion;
			eventData.trackedDevicePosition = position;
		}
		else
		{
			eventData.delta = state.screenPosition - eventData.position;
			eventData.position = state.screenPosition;
		}
		eventData.Reset();
		eventData.pointerCurrentRaycast = PerformRaycast(eventData);
		if (pointerType == UIPointerType.Tracked && eventData.pointerCurrentRaycast.isValid)
		{
			Vector2 screenPosition = eventData.pointerCurrentRaycast.screenPosition;
			eventData.delta = screenPosition - eventData.position;
			eventData.position = eventData.pointerCurrentRaycast.screenPosition;
		}
		eventData.button = PointerEventData.InputButton.Left;
		state.leftButton.CopyPressStateTo(eventData);
		ProcessPointerMovement(ref state, eventData);
		if (state.changedThisFrame || (!(xrTrackingOrigin == null) && state.pointerType == UIPointerType.Tracked))
		{
			ProcessPointerButton(ref state.leftButton, eventData);
			ProcessPointerButtonDrag(ref state.leftButton, eventData);
			ProcessPointerScroll(ref state, eventData);
			eventData.button = PointerEventData.InputButton.Right;
			state.rightButton.CopyPressStateTo(eventData);
			ProcessPointerButton(ref state.rightButton, eventData);
			ProcessPointerButtonDrag(ref state.rightButton, eventData);
			eventData.button = PointerEventData.InputButton.Middle;
			state.middleButton.CopyPressStateTo(eventData);
			ProcessPointerButton(ref state.middleButton, eventData);
			ProcessPointerButtonDrag(ref state.middleButton, eventData);
		}
	}

	private bool PointerShouldIgnoreTransform(Transform t)
	{
		if (base.eventSystem is MultiplayerEventSystem multiplayerEventSystem && multiplayerEventSystem.playerRoot != null && !t.IsChildOf(multiplayerEventSystem.playerRoot.transform))
		{
			return true;
		}
		return false;
	}

	private void ProcessPointerMovement(ref PointerModel pointer, ExtendedPointerEventData eventData)
	{
		GameObject currentPointerTarget = ((eventData.pointerType == UIPointerType.Touch && !pointer.leftButton.isPressed && !pointer.leftButton.wasReleasedThisFrame) ? null : eventData.pointerCurrentRaycast.gameObject);
		ProcessPointerMovement(eventData, currentPointerTarget);
	}

	private void ProcessPointerMovement(ExtendedPointerEventData eventData, GameObject currentPointerTarget)
	{
		bool flag = eventData.IsPointerMoving();
		if (flag)
		{
			for (int i = 0; i < eventData.hovered.Count; i++)
			{
				ExecuteEvents.Execute(eventData.hovered[i], eventData, ExecuteEvents.pointerMoveHandler);
			}
		}
		if (currentPointerTarget == null || eventData.pointerEnter == null)
		{
			for (int j = 0; j < eventData.hovered.Count; j++)
			{
				ExecuteEvents.Execute(eventData.hovered[j], eventData, ExecuteEvents.pointerExitHandler);
			}
			eventData.hovered.Clear();
			if (currentPointerTarget == null)
			{
				eventData.pointerEnter = null;
				return;
			}
		}
		if (eventData.pointerEnter == currentPointerTarget && (bool)currentPointerTarget)
		{
			return;
		}
		Transform transform = BaseInputModule.FindCommonRoot(eventData.pointerEnter, currentPointerTarget)?.transform;
		if (eventData.pointerEnter != null)
		{
			Transform parent = eventData.pointerEnter.transform;
			while (parent != null && parent != transform)
			{
				ExecuteEvents.Execute(parent.gameObject, eventData, ExecuteEvents.pointerExitHandler);
				eventData.hovered.Remove(parent.gameObject);
				parent = parent.parent;
			}
		}
		eventData.pointerEnter = currentPointerTarget;
		if (!(currentPointerTarget != null))
		{
			return;
		}
		Transform parent2 = currentPointerTarget.transform;
		while (parent2 != null && parent2 != transform && !PointerShouldIgnoreTransform(parent2))
		{
			ExecuteEvents.Execute(parent2.gameObject, eventData, ExecuteEvents.pointerEnterHandler);
			if (flag)
			{
				ExecuteEvents.Execute(parent2.gameObject, eventData, ExecuteEvents.pointerMoveHandler);
			}
			eventData.hovered.Add(parent2.gameObject);
			parent2 = parent2.parent;
		}
	}

	private void ProcessPointerButton(ref PointerModel.ButtonState button, PointerEventData eventData)
	{
		GameObject gameObject = eventData.pointerCurrentRaycast.gameObject;
		if (gameObject != null && PointerShouldIgnoreTransform(gameObject.transform))
		{
			return;
		}
		if (button.wasPressedThisFrame)
		{
			button.pressTime = InputRuntime.s_Instance.unscaledGameTime;
			eventData.delta = Vector2.zero;
			eventData.dragging = false;
			eventData.pressPosition = eventData.position;
			eventData.pointerPressRaycast = eventData.pointerCurrentRaycast;
			eventData.eligibleForClick = true;
			eventData.useDragThreshold = true;
			GameObject eventHandler = ExecuteEvents.GetEventHandler<ISelectHandler>(gameObject);
			if (eventHandler != base.eventSystem.currentSelectedGameObject && (eventHandler != null || m_DeselectOnBackgroundClick))
			{
				base.eventSystem.SetSelectedGameObject(null, eventData);
			}
			GameObject gameObject2 = ExecuteEvents.ExecuteHierarchy(gameObject, eventData, ExecuteEvents.pointerDownHandler);
			if (gameObject2 == null)
			{
				gameObject2 = ExecuteEvents.GetEventHandler<IPointerClickHandler>(gameObject);
			}
			button.clickedOnSameGameObject = gameObject2 == eventData.lastPress && button.pressTime - eventData.clickTime <= 0.3f;
			if (eventData.clickCount > 0 && !button.clickedOnSameGameObject)
			{
				eventData.clickCount = 0;
				eventData.clickTime = 0f;
			}
			eventData.pointerPress = gameObject2;
			eventData.rawPointerPress = gameObject;
			eventData.pointerDrag = ExecuteEvents.GetEventHandler<IDragHandler>(gameObject);
			if (eventData.pointerDrag != null)
			{
				ExecuteEvents.Execute(eventData.pointerDrag, eventData, ExecuteEvents.initializePotentialDrag);
			}
		}
		if (button.wasReleasedThisFrame)
		{
			GameObject eventHandler2 = ExecuteEvents.GetEventHandler<IPointerClickHandler>(gameObject);
			int num;
			if (eventData.pointerPress == eventHandler2)
			{
				num = (eventData.eligibleForClick ? 1 : 0);
				if (num != 0)
				{
					if (button.clickedOnSameGameObject)
					{
						int clickCount = eventData.clickCount + 1;
						eventData.clickCount = clickCount;
					}
					else
					{
						eventData.clickCount = 1;
					}
					eventData.clickTime = InputRuntime.s_Instance.unscaledGameTime;
				}
			}
			else
			{
				num = 0;
			}
			ExecuteEvents.Execute(eventData.pointerPress, eventData, ExecuteEvents.pointerUpHandler);
			if (num != 0)
			{
				ExecuteEvents.Execute(eventData.pointerPress, eventData, ExecuteEvents.pointerClickHandler);
			}
			else if (eventData.dragging && eventData.pointerDrag != null)
			{
				ExecuteEvents.ExecuteHierarchy(gameObject, eventData, ExecuteEvents.dropHandler);
			}
			eventData.eligibleForClick = false;
			eventData.pointerPress = null;
			eventData.rawPointerPress = null;
			if (eventData.dragging && eventData.pointerDrag != null)
			{
				ExecuteEvents.Execute(eventData.pointerDrag, eventData, ExecuteEvents.endDragHandler);
			}
			eventData.dragging = false;
			eventData.pointerDrag = null;
			button.ignoreNextClick = false;
		}
		button.CopyPressStateFrom(eventData);
	}

	private void ProcessPointerButtonDrag(ref PointerModel.ButtonState button, ExtendedPointerEventData eventData)
	{
		if (!eventData.IsPointerMoving() || (eventData.pointerType == UIPointerType.MouseOrPen && Cursor.lockState == CursorLockMode.Locked) || eventData.pointerDrag == null)
		{
			return;
		}
		if (!eventData.dragging && (!eventData.useDragThreshold || (double)(eventData.pressPosition - eventData.position).sqrMagnitude >= (double)base.eventSystem.pixelDragThreshold * (double)base.eventSystem.pixelDragThreshold * (double)((eventData.pointerType == UIPointerType.Tracked) ? m_TrackedDeviceDragThresholdMultiplier : 1f)))
		{
			ExecuteEvents.Execute(eventData.pointerDrag, eventData, ExecuteEvents.beginDragHandler);
			eventData.dragging = true;
		}
		if (eventData.dragging)
		{
			if (eventData.pointerPress != eventData.pointerDrag)
			{
				ExecuteEvents.Execute(eventData.pointerPress, eventData, ExecuteEvents.pointerUpHandler);
				eventData.eligibleForClick = false;
				eventData.pointerPress = null;
				eventData.rawPointerPress = null;
			}
			ExecuteEvents.Execute(eventData.pointerDrag, eventData, ExecuteEvents.dragHandler);
			button.CopyPressStateFrom(eventData);
		}
	}

	private static void ProcessPointerScroll(ref PointerModel pointer, PointerEventData eventData)
	{
		Vector2 scrollDelta = pointer.scrollDelta;
		if (!Mathf.Approximately(scrollDelta.sqrMagnitude, 0f))
		{
			eventData.scrollDelta = scrollDelta;
			ExecuteEvents.ExecuteHierarchy(ExecuteEvents.GetEventHandler<IScrollHandler>(eventData.pointerEnter), eventData, ExecuteEvents.scrollHandler);
		}
	}

	internal void ProcessNavigation(ref NavigationModel navigationState)
	{
		bool flag = false;
		if (base.eventSystem.currentSelectedGameObject != null)
		{
			BaseEventData baseEventData = GetBaseEventData();
			ExecuteEvents.Execute(base.eventSystem.currentSelectedGameObject, baseEventData, ExecuteEvents.updateSelectedHandler);
			flag = baseEventData.used;
		}
		if (!base.eventSystem.sendNavigationEvents)
		{
			return;
		}
		Vector2 vector = navigationState.move;
		if (!flag && (!Mathf.Approximately(vector.x, 0f) || !Mathf.Approximately(vector.y, 0f)))
		{
			float unscaledGameTime = InputRuntime.s_Instance.unscaledGameTime;
			Vector2 moveVector = navigationState.move;
			MoveDirection moveDirection = MoveDirection.None;
			if (moveVector.sqrMagnitude > 0f)
			{
				moveDirection = ((!(Mathf.Abs(moveVector.x) > Mathf.Abs(moveVector.y))) ? ((moveVector.y > 0f) ? MoveDirection.Up : MoveDirection.Down) : ((moveVector.x > 0f) ? MoveDirection.Right : MoveDirection.Left));
			}
			if (moveDirection != m_NavigationState.lastMoveDirection)
			{
				m_NavigationState.consecutiveMoveCount = 0;
			}
			if (moveDirection != MoveDirection.None)
			{
				bool flag2 = true;
				if (m_NavigationState.consecutiveMoveCount != 0)
				{
					flag2 = ((m_NavigationState.consecutiveMoveCount <= 1) ? (unscaledGameTime > m_NavigationState.lastMoveTime + moveRepeatDelay) : (unscaledGameTime > m_NavigationState.lastMoveTime + moveRepeatRate));
				}
				if (flag2)
				{
					AxisEventData axisEventData = m_NavigationState.eventData;
					if (axisEventData == null)
					{
						axisEventData = new ExtendedAxisEventData(base.eventSystem);
						m_NavigationState.eventData = axisEventData;
					}
					axisEventData.Reset();
					axisEventData.moveVector = moveVector;
					axisEventData.moveDir = moveDirection;
					if (IsMoveAllowed(axisEventData))
					{
						ExecuteEvents.Execute(base.eventSystem.currentSelectedGameObject, axisEventData, ExecuteEvents.moveHandler);
						flag = axisEventData.used;
						m_NavigationState.consecutiveMoveCount++;
						m_NavigationState.lastMoveTime = unscaledGameTime;
						m_NavigationState.lastMoveDirection = moveDirection;
					}
				}
			}
			else
			{
				m_NavigationState.consecutiveMoveCount = 0;
			}
		}
		else
		{
			m_NavigationState.consecutiveMoveCount = 0;
		}
		if (!flag && base.eventSystem.currentSelectedGameObject != null)
		{
			InputAction inputAction = m_SubmitAction?.action;
			InputAction inputAction2 = m_CancelAction?.action;
			BaseEventData baseEventData2 = GetBaseEventData();
			if (inputAction2 != null && inputAction2.WasPressedThisFrame())
			{
				ExecuteEvents.Execute(base.eventSystem.currentSelectedGameObject, baseEventData2, ExecuteEvents.cancelHandler);
			}
			if (!baseEventData2.used && inputAction != null && inputAction.WasPressedThisFrame())
			{
				ExecuteEvents.Execute(base.eventSystem.currentSelectedGameObject, baseEventData2, ExecuteEvents.submitHandler);
			}
		}
	}

	private bool IsMoveAllowed(AxisEventData eventData)
	{
		if (m_LocalMultiPlayerRoot == null)
		{
			return true;
		}
		if (base.eventSystem.currentSelectedGameObject == null)
		{
			return true;
		}
		Selectable component = base.eventSystem.currentSelectedGameObject.GetComponent<Selectable>();
		if (component == null)
		{
			return true;
		}
		Selectable selectable = null;
		switch (eventData.moveDir)
		{
		case MoveDirection.Right:
			selectable = component.FindSelectableOnRight();
			break;
		case MoveDirection.Up:
			selectable = component.FindSelectableOnUp();
			break;
		case MoveDirection.Left:
			selectable = component.FindSelectableOnLeft();
			break;
		case MoveDirection.Down:
			selectable = component.FindSelectableOnDown();
			break;
		}
		if (selectable == null)
		{
			return true;
		}
		return selectable.transform.IsChildOf(m_LocalMultiPlayerRoot.transform);
	}

	private void SwapAction(ref InputActionReference property, InputActionReference newValue, bool actionsHooked, Action<InputAction.CallbackContext> actionCallback)
	{
		if (!(property == newValue) && (!(property != null) || !(newValue != null) || property.action != newValue.action))
		{
			if ((property != null && actionCallback != null) & actionsHooked)
			{
				property.action.performed -= actionCallback;
				property.action.canceled -= actionCallback;
			}
			bool flag = property?.action == null;
			bool flag2 = property?.action != null && property.action.enabled;
			TryDisableInputAction(property);
			property = newValue;
			if ((newValue?.action != null && actionCallback != null) & actionsHooked)
			{
				property.action.performed += actionCallback;
				property.action.canceled += actionCallback;
			}
			if (base.isActiveAndEnabled && newValue?.action != null && (flag2 | flag))
			{
				EnableInputAction(property);
			}
		}
	}

	public void AssignDefaultActions()
	{
		DefaultInputActions defaultInputActions = new DefaultInputActions();
		actionsAsset = defaultInputActions.asset;
		cancel = InputActionReference.Create(defaultInputActions.UI.Cancel);
		submit = InputActionReference.Create(defaultInputActions.UI.Submit);
		move = InputActionReference.Create(defaultInputActions.UI.Navigate);
		leftClick = InputActionReference.Create(defaultInputActions.UI.Click);
		rightClick = InputActionReference.Create(defaultInputActions.UI.RightClick);
		middleClick = InputActionReference.Create(defaultInputActions.UI.MiddleClick);
		point = InputActionReference.Create(defaultInputActions.UI.Point);
		scrollWheel = InputActionReference.Create(defaultInputActions.UI.ScrollWheel);
		trackedDeviceOrientation = InputActionReference.Create(defaultInputActions.UI.TrackedDeviceOrientation);
		trackedDevicePosition = InputActionReference.Create(defaultInputActions.UI.TrackedDevicePosition);
	}

	public void UnassignActions()
	{
		actionsAsset = null;
		cancel = null;
		submit = null;
		move = null;
		leftClick = null;
		rightClick = null;
		middleClick = null;
		point = null;
		scrollWheel = null;
		trackedDeviceOrientation = null;
		trackedDevicePosition = null;
	}

	protected override void Awake()
	{
		base.Awake();
		m_NavigationState.Reset();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
		UnhookActions();
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (m_OnControlsChangedDelegate == null)
		{
			m_OnControlsChangedDelegate = OnControlsChanged;
		}
		InputActionState.s_GlobalState.onActionControlsChanged.AddCallback(m_OnControlsChangedDelegate);
		if (HasNoActions())
		{
			AssignDefaultActions();
		}
		ResetPointers();
		HookActions();
		EnableAllActions();
	}

	protected override void OnDisable()
	{
		ResetPointers();
		InputActionState.s_GlobalState.onActionControlsChanged.RemoveCallback(m_OnControlsChangedDelegate);
		DisableAllActions();
		UnhookActions();
		base.OnDisable();
	}

	private void ResetPointers()
	{
		int length = m_PointerStates.length;
		for (int i = 0; i < length; i++)
		{
			SendPointerExitEventsAndRemovePointer(0);
		}
		m_CurrentPointerId = -1;
		m_CurrentPointerIndex = -1;
		m_CurrentPointerType = UIPointerType.None;
	}

	private bool HasNoActions()
	{
		if (m_ActionsAsset != null)
		{
			return false;
		}
		if (m_PointAction?.action == null && m_LeftClickAction?.action == null && m_RightClickAction?.action == null && m_MiddleClickAction?.action == null && m_SubmitAction?.action == null && m_CancelAction?.action == null && m_ScrollWheelAction?.action == null && m_TrackedDeviceOrientationAction?.action == null)
		{
			return m_TrackedDevicePositionAction?.action == null;
		}
		return false;
	}

	private void EnableAllActions()
	{
		EnableInputAction(m_PointAction);
		EnableInputAction(m_LeftClickAction);
		EnableInputAction(m_RightClickAction);
		EnableInputAction(m_MiddleClickAction);
		EnableInputAction(m_MoveAction);
		EnableInputAction(m_SubmitAction);
		EnableInputAction(m_CancelAction);
		EnableInputAction(m_ScrollWheelAction);
		EnableInputAction(m_TrackedDeviceOrientationAction);
		EnableInputAction(m_TrackedDevicePositionAction);
	}

	private void DisableAllActions()
	{
		TryDisableInputAction(m_PointAction, isComponentDisabling: true);
		TryDisableInputAction(m_LeftClickAction, isComponentDisabling: true);
		TryDisableInputAction(m_RightClickAction, isComponentDisabling: true);
		TryDisableInputAction(m_MiddleClickAction, isComponentDisabling: true);
		TryDisableInputAction(m_MoveAction, isComponentDisabling: true);
		TryDisableInputAction(m_SubmitAction, isComponentDisabling: true);
		TryDisableInputAction(m_CancelAction, isComponentDisabling: true);
		TryDisableInputAction(m_ScrollWheelAction, isComponentDisabling: true);
		TryDisableInputAction(m_TrackedDeviceOrientationAction, isComponentDisabling: true);
		TryDisableInputAction(m_TrackedDevicePositionAction, isComponentDisabling: true);
	}

	private void EnableInputAction(InputActionReference inputActionReference)
	{
		InputAction inputAction = inputActionReference?.action;
		if (inputAction != null)
		{
			if (s_InputActionReferenceCounts.TryGetValue(inputAction, out var value))
			{
				value.refCount++;
				s_InputActionReferenceCounts[inputAction] = value;
			}
			else
			{
				value = new InputActionReferenceState
				{
					refCount = 1,
					enabledByInputModule = !inputAction.enabled
				};
				s_InputActionReferenceCounts.Add(inputAction, value);
			}
			inputAction.Enable();
		}
	}

	private void TryDisableInputAction(InputActionReference inputActionReference, bool isComponentDisabling = false)
	{
		InputAction inputAction = inputActionReference?.action;
		if (inputAction != null && (base.isActiveAndEnabled || isComponentDisabling) && s_InputActionReferenceCounts.TryGetValue(inputAction, out var value))
		{
			if (value.refCount - 1 == 0 && value.enabledByInputModule)
			{
				inputAction.Disable();
				s_InputActionReferenceCounts.Remove(inputAction);
			}
			else
			{
				value.refCount--;
				s_InputActionReferenceCounts[inputAction] = value;
			}
		}
	}

	private int GetPointerStateIndexFor(int pointerOrTouchId)
	{
		if (pointerOrTouchId == m_CurrentPointerId)
		{
			return m_CurrentPointerIndex;
		}
		for (int i = 0; i < m_PointerIds.length; i++)
		{
			if (m_PointerIds[i] == pointerOrTouchId)
			{
				return i;
			}
		}
		for (int j = 0; j < m_PointerStates.length; j++)
		{
			ExtendedPointerEventData eventData = m_PointerStates[j].eventData;
			if (eventData.touchId == pointerOrTouchId || (eventData.touchId != 0 && eventData.device.deviceId == pointerOrTouchId))
			{
				return j;
			}
		}
		return -1;
	}

	private ref PointerModel GetPointerStateForIndex(int index)
	{
		if (index == 0)
		{
			return ref m_PointerStates.firstValue;
		}
		return ref m_PointerStates.additionalValues[index - 1];
	}

	private int GetDisplayIndexFor(InputControl control)
	{
		int result = 0;
		if (control.device is Pointer pointer)
		{
			result = pointer.displayIndex.ReadValue();
		}
		return result;
	}

	private int GetPointerStateIndexFor(ref InputAction.CallbackContext context)
	{
		if (CheckForRemovedDevice(ref context))
		{
			return -1;
		}
		InputActionPhase phase = context.phase;
		return GetPointerStateIndexFor(context.control, phase != InputActionPhase.Canceled);
	}

	private int GetPointerStateIndexFor(InputControl control, bool createIfNotExists = true)
	{
		InputDevice device = control.device;
		InputControl parent = control.parent;
		int num = m_PointerTouchControls.IndexOfReference(parent);
		if (num != -1)
		{
			m_CurrentPointerId = m_PointerIds[num];
			m_CurrentPointerIndex = num;
			m_CurrentPointerType = UIPointerType.Touch;
			return num;
		}
		int num2 = device.deviceId;
		int num3 = 0;
		Vector2 screenPosition = Vector2.zero;
		if (parent is TouchControl touchControl)
		{
			num3 = touchControl.touchId.value;
			screenPosition = touchControl.position.value;
		}
		else if (parent is Touchscreen touchscreen)
		{
			num3 = touchscreen.primaryTouch.touchId.value;
			screenPosition = touchscreen.primaryTouch.position.value;
		}
		int displayIndexFor = GetDisplayIndexFor(control);
		if (num3 != 0)
		{
			num2 = ExtendedPointerEventData.MakePointerIdForTouch(num2, num3);
		}
		if (m_CurrentPointerId == num2)
		{
			return m_CurrentPointerIndex;
		}
		if (num3 == 0)
		{
			for (int i = 0; i < m_PointerIds.length; i++)
			{
				if (m_PointerIds[i] == num2)
				{
					m_CurrentPointerId = num2;
					m_CurrentPointerIndex = i;
					m_CurrentPointerType = m_PointerStates[i].pointerType;
					return i;
				}
			}
		}
		if (!createIfNotExists)
		{
			return -1;
		}
		UIPointerType uIPointerType = UIPointerType.None;
		if (num3 != 0)
		{
			uIPointerType = UIPointerType.Touch;
		}
		else if (HaveControlForDevice(device, point))
		{
			uIPointerType = UIPointerType.MouseOrPen;
		}
		else if (HaveControlForDevice(device, trackedDevicePosition))
		{
			uIPointerType = UIPointerType.Tracked;
		}
		if ((m_PointerBehavior == UIPointerBehavior.SingleUnifiedPointer && uIPointerType != UIPointerType.None) || (m_PointerBehavior == UIPointerBehavior.SingleMouseOrPenButMultiTouchAndTrack && uIPointerType == UIPointerType.MouseOrPen))
		{
			if (m_CurrentPointerIndex == -1)
			{
				m_CurrentPointerIndex = AllocatePointer(num2, displayIndexFor, num3, uIPointerType, control, device, (num3 != 0) ? parent : null);
			}
			else
			{
				ExtendedPointerEventData eventData = GetPointerStateForIndex(m_CurrentPointerIndex).eventData;
				eventData.control = control;
				eventData.device = device;
				eventData.pointerType = uIPointerType;
				eventData.pointerId = num2;
				eventData.touchId = num3;
				eventData.trackedDeviceOrientation = default(Quaternion);
				eventData.trackedDevicePosition = default(Vector3);
			}
			if (uIPointerType == UIPointerType.Touch)
			{
				GetPointerStateForIndex(m_CurrentPointerIndex).screenPosition = screenPosition;
			}
			m_CurrentPointerId = num2;
			m_CurrentPointerType = uIPointerType;
			return m_CurrentPointerIndex;
		}
		int num4 = -1;
		if (uIPointerType != UIPointerType.None)
		{
			num4 = AllocatePointer(num2, displayIndexFor, num3, uIPointerType, control, device, (num3 != 0) ? parent : null);
		}
		else
		{
			if (m_CurrentPointerId != -1)
			{
				return m_CurrentPointerIndex;
			}
			ReadOnlyArray<InputControl>? readOnlyArray = point?.action?.controls;
			InputDevice inputDevice = ((readOnlyArray.HasValue && readOnlyArray.Value.Count > 0) ? readOnlyArray.Value[0].device : null);
			if (inputDevice != null && !(inputDevice is Touchscreen))
			{
				num4 = AllocatePointer(inputDevice.deviceId, displayIndexFor, 0, UIPointerType.MouseOrPen, readOnlyArray.Value[0], inputDevice);
			}
			else
			{
				ReadOnlyArray<InputControl>? readOnlyArray2 = trackedDevicePosition?.action?.controls;
				InputDevice inputDevice2 = ((readOnlyArray2.HasValue && readOnlyArray2.Value.Count > 0) ? readOnlyArray2.Value[0].device : null);
				num4 = ((inputDevice2 == null) ? AllocatePointer(num2, displayIndexFor, 0, UIPointerType.None, control, device) : AllocatePointer(inputDevice2.deviceId, displayIndexFor, 0, UIPointerType.Tracked, readOnlyArray2.Value[0], inputDevice2));
			}
		}
		if (uIPointerType == UIPointerType.Touch)
		{
			GetPointerStateForIndex(num4).screenPosition = screenPosition;
		}
		m_CurrentPointerId = num2;
		m_CurrentPointerIndex = num4;
		m_CurrentPointerType = uIPointerType;
		return num4;
	}

	private int AllocatePointer(int pointerId, int displayIndex, int touchId, UIPointerType pointerType, InputControl control, InputDevice device, InputControl touchControl = null)
	{
		ExtendedPointerEventData extendedPointerEventData = null;
		if (m_PointerStates.Capacity > m_PointerStates.length)
		{
			extendedPointerEventData = ((m_PointerStates.length != 0) ? m_PointerStates.additionalValues[m_PointerStates.length - 1].eventData : m_PointerStates.firstValue.eventData);
		}
		if (extendedPointerEventData == null)
		{
			extendedPointerEventData = new ExtendedPointerEventData(base.eventSystem);
		}
		extendedPointerEventData.pointerId = pointerId;
		extendedPointerEventData.touchId = touchId;
		extendedPointerEventData.pointerType = pointerType;
		extendedPointerEventData.control = control;
		extendedPointerEventData.device = device;
		m_PointerIds.AppendWithCapacity(pointerId);
		m_PointerTouchControls.AppendWithCapacity(touchControl);
		return m_PointerStates.AppendWithCapacity(new PointerModel(extendedPointerEventData));
	}

	private void SendPointerExitEventsAndRemovePointer(int index)
	{
		ExtendedPointerEventData eventData = m_PointerStates[index].eventData;
		if (eventData.pointerEnter != null)
		{
			ProcessPointerMovement(eventData, null);
		}
		RemovePointerAtIndex(index);
	}

	private void RemovePointerAtIndex(int index)
	{
		ExtendedPointerEventData eventData = m_PointerStates[index].eventData;
		if (index == m_CurrentPointerIndex)
		{
			m_CurrentPointerId = -1;
			m_CurrentPointerIndex = -1;
			m_CurrentPointerType = UIPointerType.None;
		}
		else if (m_CurrentPointerIndex == m_PointerIds.length - 1)
		{
			m_CurrentPointerIndex = index;
		}
		m_PointerIds.RemoveAtByMovingTailWithCapacity(index);
		m_PointerTouchControls.RemoveAtByMovingTailWithCapacity(index);
		m_PointerStates.RemoveAtByMovingTailWithCapacity(index);
		eventData.hovered.Clear();
		eventData.device = null;
		eventData.pointerCurrentRaycast = default(RaycastResult);
		eventData.pointerPressRaycast = default(RaycastResult);
		eventData.pointerPress = null;
		eventData.pointerPress = null;
		eventData.pointerDrag = null;
		eventData.pointerEnter = null;
		eventData.rawPointerPress = null;
		if (m_PointerStates.length == 0)
		{
			m_PointerStates.firstValue.eventData = eventData;
		}
		else
		{
			m_PointerStates.additionalValues[m_PointerStates.length - 1].eventData = eventData;
		}
	}

	private void PurgeStalePointers()
	{
		for (int i = 0; i < m_PointerStates.length; i++)
		{
			InputDevice device = GetPointerStateForIndex(i).eventData.device;
			if (!device.added || (!HaveControlForDevice(device, point) && !HaveControlForDevice(device, trackedDevicePosition) && !HaveControlForDevice(device, trackedDeviceOrientation)))
			{
				SendPointerExitEventsAndRemovePointer(i);
				i--;
			}
		}
		m_NeedToPurgeStalePointers = false;
	}

	private static bool HaveControlForDevice(InputDevice device, InputActionReference actionReference)
	{
		InputAction inputAction = actionReference?.action;
		if (inputAction == null)
		{
			return false;
		}
		ReadOnlyArray<InputControl> controls = inputAction.controls;
		for (int i = 0; i < controls.Count; i++)
		{
			if (controls[i].device == device)
			{
				return true;
			}
		}
		return false;
	}

	private void OnPointCallback(InputAction.CallbackContext context)
	{
		if (!CheckForRemovedDevice(ref context) && !context.canceled)
		{
			int pointerStateIndexFor = GetPointerStateIndexFor(context.control);
			if (pointerStateIndexFor != -1)
			{
				GetPointerStateForIndex(pointerStateIndexFor).screenPosition = context.ReadValue<Vector2>();
			}
		}
	}

	private bool IgnoreNextClick(ref InputAction.CallbackContext context, bool wasPressed)
	{
		if (explictlyIgnoreFocus)
		{
			return false;
		}
		return (context.canceled && !InputRuntime.s_Instance.isPlayerFocused && !context.control.device.canRunInBackground) & wasPressed;
	}

	private void OnLeftClickCallback(InputAction.CallbackContext context)
	{
		int pointerStateIndexFor = GetPointerStateIndexFor(ref context);
		if (pointerStateIndexFor != -1)
		{
			ref PointerModel pointerStateForIndex = ref GetPointerStateForIndex(pointerStateIndexFor);
			bool isPressed = pointerStateForIndex.leftButton.isPressed;
			pointerStateForIndex.leftButton.isPressed = context.ReadValueAsButton();
			pointerStateForIndex.changedThisFrame = true;
			if (IgnoreNextClick(ref context, isPressed))
			{
				pointerStateForIndex.leftButton.ignoreNextClick = true;
			}
		}
	}

	private void OnRightClickCallback(InputAction.CallbackContext context)
	{
		int pointerStateIndexFor = GetPointerStateIndexFor(ref context);
		if (pointerStateIndexFor != -1)
		{
			ref PointerModel pointerStateForIndex = ref GetPointerStateForIndex(pointerStateIndexFor);
			bool isPressed = pointerStateForIndex.rightButton.isPressed;
			pointerStateForIndex.rightButton.isPressed = context.ReadValueAsButton();
			pointerStateForIndex.changedThisFrame = true;
			if (IgnoreNextClick(ref context, isPressed))
			{
				pointerStateForIndex.rightButton.ignoreNextClick = true;
			}
		}
	}

	private void OnMiddleClickCallback(InputAction.CallbackContext context)
	{
		int pointerStateIndexFor = GetPointerStateIndexFor(ref context);
		if (pointerStateIndexFor != -1)
		{
			ref PointerModel pointerStateForIndex = ref GetPointerStateForIndex(pointerStateIndexFor);
			bool isPressed = pointerStateForIndex.middleButton.isPressed;
			pointerStateForIndex.middleButton.isPressed = context.ReadValueAsButton();
			pointerStateForIndex.changedThisFrame = true;
			if (IgnoreNextClick(ref context, isPressed))
			{
				pointerStateForIndex.middleButton.ignoreNextClick = true;
			}
		}
	}

	private bool CheckForRemovedDevice(ref InputAction.CallbackContext context)
	{
		if (context.canceled && !context.control.device.added)
		{
			m_NeedToPurgeStalePointers = true;
			return true;
		}
		return false;
	}

	private void OnScrollCallback(InputAction.CallbackContext context)
	{
		int pointerStateIndexFor = GetPointerStateIndexFor(ref context);
		if (pointerStateIndexFor != -1)
		{
			GetPointerStateForIndex(pointerStateIndexFor).scrollDelta = context.ReadValue<Vector2>() * 0.05f;
		}
	}

	private void OnMoveCallback(InputAction.CallbackContext context)
	{
		m_NavigationState.move = context.ReadValue<Vector2>();
	}

	private void OnTrackedDeviceOrientationCallback(InputAction.CallbackContext context)
	{
		int pointerStateIndexFor = GetPointerStateIndexFor(ref context);
		if (pointerStateIndexFor != -1)
		{
			GetPointerStateForIndex(pointerStateIndexFor).worldOrientation = context.ReadValue<Quaternion>();
		}
	}

	private void OnTrackedDevicePositionCallback(InputAction.CallbackContext context)
	{
		int pointerStateIndexFor = GetPointerStateIndexFor(ref context);
		if (pointerStateIndexFor != -1)
		{
			GetPointerStateForIndex(pointerStateIndexFor).worldPosition = context.ReadValue<Vector3>();
		}
	}

	private void OnControlsChanged(object obj)
	{
		m_NeedToPurgeStalePointers = true;
	}

	private void FilterPointerStatesByType()
	{
		UIPointerType uIPointerType = UIPointerType.None;
		for (int i = 0; i < m_PointerStates.length; i++)
		{
			ref PointerModel pointerStateForIndex = ref GetPointerStateForIndex(i);
			pointerStateForIndex.eventData.ReadDeviceState();
			pointerStateForIndex.CopyTouchOrPenStateFrom(pointerStateForIndex.eventData);
			if (pointerStateForIndex.changedThisFrame && uIPointerType == UIPointerType.None)
			{
				uIPointerType = pointerStateForIndex.pointerType;
			}
		}
		if (m_PointerBehavior != UIPointerBehavior.SingleMouseOrPenButMultiTouchAndTrack)
		{
			return;
		}
		switch (uIPointerType)
		{
		case UIPointerType.MouseOrPen:
		{
			for (int j = 0; j < m_PointerStates.length; j++)
			{
				if (m_PointerStates[j].pointerType != UIPointerType.MouseOrPen)
				{
					SendPointerExitEventsAndRemovePointer(j);
					j--;
				}
			}
			return;
		}
		case UIPointerType.None:
			return;
		}
		for (int k = 0; k < m_PointerStates.length; k++)
		{
			if (m_PointerStates[k].pointerType == UIPointerType.MouseOrPen)
			{
				SendPointerExitEventsAndRemovePointer(k);
				k--;
			}
		}
	}

	public override void Process()
	{
		if (m_NeedToPurgeStalePointers)
		{
			PurgeStalePointers();
		}
		if (!base.eventSystem.isFocused && !shouldIgnoreFocus)
		{
			for (int i = 0; i < m_PointerStates.length; i++)
			{
				m_PointerStates[i].OnFrameFinished();
			}
			return;
		}
		ProcessNavigation(ref m_NavigationState);
		FilterPointerStatesByType();
		for (int j = 0; j < m_PointerStates.length; j++)
		{
			ref PointerModel pointerStateForIndex = ref GetPointerStateForIndex(j);
			ProcessPointer(ref pointerStateForIndex);
			if (pointerStateForIndex.pointerType == UIPointerType.Touch && !pointerStateForIndex.leftButton.isPressed && !pointerStateForIndex.leftButton.wasReleasedThisFrame)
			{
				RemovePointerAtIndex(j);
				j--;
			}
			else
			{
				pointerStateForIndex.OnFrameFinished();
			}
		}
	}

	public override int ConvertUIToolkitPointerId(PointerEventData sourcePointerData)
	{
		if (m_PointerBehavior == UIPointerBehavior.SingleUnifiedPointer)
		{
			return PointerId.mousePointerId;
		}
		if (!(sourcePointerData is ExtendedPointerEventData extendedPointerEventData))
		{
			return base.ConvertUIToolkitPointerId(sourcePointerData);
		}
		return extendedPointerEventData.uiToolkitPointerId;
	}

	private void HookActions()
	{
		if (!m_ActionsHooked)
		{
			if (m_OnPointDelegate == null)
			{
				m_OnPointDelegate = OnPointCallback;
			}
			if (m_OnLeftClickDelegate == null)
			{
				m_OnLeftClickDelegate = OnLeftClickCallback;
			}
			if (m_OnRightClickDelegate == null)
			{
				m_OnRightClickDelegate = OnRightClickCallback;
			}
			if (m_OnMiddleClickDelegate == null)
			{
				m_OnMiddleClickDelegate = OnMiddleClickCallback;
			}
			if (m_OnScrollWheelDelegate == null)
			{
				m_OnScrollWheelDelegate = OnScrollCallback;
			}
			if (m_OnMoveDelegate == null)
			{
				m_OnMoveDelegate = OnMoveCallback;
			}
			if (m_OnTrackedDeviceOrientationDelegate == null)
			{
				m_OnTrackedDeviceOrientationDelegate = OnTrackedDeviceOrientationCallback;
			}
			if (m_OnTrackedDevicePositionDelegate == null)
			{
				m_OnTrackedDevicePositionDelegate = OnTrackedDevicePositionCallback;
			}
			SetActionCallbacks(install: true);
		}
	}

	private void UnhookActions()
	{
		if (m_ActionsHooked)
		{
			SetActionCallbacks(install: false);
		}
	}

	private void SetActionCallbacks(bool install)
	{
		m_ActionsHooked = install;
		SetActionCallback(m_PointAction, m_OnPointDelegate, install);
		SetActionCallback(m_MoveAction, m_OnMoveDelegate, install);
		SetActionCallback(m_LeftClickAction, m_OnLeftClickDelegate, install);
		SetActionCallback(m_RightClickAction, m_OnRightClickDelegate, install);
		SetActionCallback(m_MiddleClickAction, m_OnMiddleClickDelegate, install);
		SetActionCallback(m_ScrollWheelAction, m_OnScrollWheelDelegate, install);
		SetActionCallback(m_TrackedDeviceOrientationAction, m_OnTrackedDeviceOrientationDelegate, install);
		SetActionCallback(m_TrackedDevicePositionAction, m_OnTrackedDevicePositionDelegate, install);
	}

	private static void SetActionCallback(InputActionReference actionReference, Action<InputAction.CallbackContext> callback, bool install)
	{
		if ((!install && callback == null) || actionReference == null)
		{
			return;
		}
		InputAction action = actionReference.action;
		if (action != null)
		{
			if (install)
			{
				action.performed += callback;
				action.canceled += callback;
			}
			else
			{
				action.performed -= callback;
				action.canceled -= callback;
			}
		}
	}

	private InputActionReference UpdateReferenceForNewAsset(InputActionReference actionReference)
	{
		InputAction inputAction = actionReference?.action;
		if (inputAction == null)
		{
			return null;
		}
		InputActionMap actionMap = inputAction.actionMap;
		InputActionMap inputActionMap = m_ActionsAsset?.FindActionMap(actionMap.name);
		if (inputActionMap == null)
		{
			return null;
		}
		InputAction inputAction2 = inputActionMap.FindAction(inputAction.name);
		if (inputAction2 == null)
		{
			return null;
		}
		return InputActionReference.Create(inputAction2);
	}
}
