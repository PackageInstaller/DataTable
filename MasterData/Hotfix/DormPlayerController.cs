using System;
using System.Collections.Generic;
using System.Diagnostics;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Controls;
using UnityEngine.InputSystem.Utilities;

public class DormPlayerController : MonoSingleton<DormPlayerController>
{
	private DormPlayer player;

	protected LogManager.Logger _logger;

	private bool _movementHasInput;

	private Vector2 _movementInputVector;

	private Vector2 _movementInputDirection;

	private Vector2 _lastInputDirection = Vector2.zero;

	private Vector2 _lastDirection = Vector2.zero;

	private const int MoveRatio = 10000;

	private const float MoveRatioRev = 0.0001f;

	internal bool _movementHasInputBuffer;

	internal Vector2 _movementInputDirectionBuffer;

	internal float _zoomInput;

	internal float _zoomInputBuffer;

	internal bool _zoomHasInput;

	internal bool _zoomHasInputBuffer;

	[Range(0.2f, 5f)]
	public float pinchZoomSensitivity = 1.5f;

	private float _lastPinchDistance = -1f;

	private int _activeTouchCount;

	private int _lastActiveTouchCount;

	private Vector2 _touch0Pos;

	private Vector2 _touch1Pos;

	private bool[] _touchOverUI;

	private int[] _touchIds;

	private int _nonUITouchCount;

	private int _dragTouchId;

	private int _lastDragTouchId;

	private Vector2 _dragTouchPos;

	private Vector2 startDrag0;

	private Vector2 endDrag0;

	private bool _panRebase;

	private bool finger1HasInput;

	private Vector2 finger1InputDirection;

	private bool finger1HasInputBuffer;

	private Vector2 finger1InputDirectionBuffer;

	private bool _pressDownHasInput;

	private Vector2 _pressDownPos;

	private bool _pressDownHasInputBuffer;

	private Vector2 _pressDownPosBuffer;

	private bool _pressHasInput;

	private Vector2 _pressPos;

	private bool _pressHasInputBuffer;

	private Vector2 _pressPosBuffer;

	private bool _pressUpHasInput;

	private Vector2 _pressUpPos;

	private bool _pressUpHasInputBuffer;

	private Vector2 _pressUpPosBuffer;

	private bool _clickHasInput;

	private Vector2 _clickPos;

	private bool _clickHasInputBuffer;

	private Vector2 _clickPosBuffer;

	private bool _moveHasInput;

	private Vector2 _movePos;

	private bool _moveHasInputBuffer;

	private Vector2 _movePosBuffer;

	public Action<Vector2> onPress;

	public Action<Vector2> onPressDown;

	public Action<Vector2> onPressUp;

	public Action<Vector2> onMove;

	public Action<Vector2> onClick;

	public Action<bool, Vector2> onInputLogicUpdate;

	public Action<bool, float> onZoomInput;

	public Action<bool, Vector2> onFinger1Input;

	private ClickableVariableJoystick clickableVariableJoystick;

	private GameObject joystick;

	private DefaultInputActions controls;

	private InputAction pointAction;

	private InputAction clickAction;

	private PointerEventData pointerEventData;

	private bool pointerClickOnUI;

	private List<RaycastResult> raycastResults = new List<RaycastResult>();

	private Vector2 curPointerPosition;

	private Vector2 prePointerPosition;

	private Vector2 pressDownPosition;

	private Ray ray;

	private RaycastHit[] hits;

	public DormPlayer Player => player;

	public bool IsMultiTouch => _activeTouchCount >= 2;

	protected override void Awake()
	{
		base.Awake();
		_logger = Singleton<LogManager>.Instance.get_Item("DormPlaterController");
	}

	public void InitDormPlayer(DormPlayer dormPlayer)
	{
		player = dormPlayer;
	}

	private void Update()
	{
		float unscaledDeltaTime = Time.unscaledDeltaTime;
		_ = Time.deltaTime;
		InputUpdate(unscaledDeltaTime);
		InputLogicUpdate();
	}

	private void LateUpdate()
	{
		FixCameraLateUpdate();
	}

	public void FixCameraLateUpdate()
	{
	}

	public void OnMovementInput(bool movmentHasInput, Vector2 movmentInputDirection, bool bWalk = false)
	{
		player?.OnMovementInput(movmentHasInput, movmentInputDirection, bWalk);
	}

	[DebuggerHidden]
	internal void Log(string message)
	{
		_logger.LogInfo("[" + gameObject.name + "] " + message);
	}

	[DebuggerHidden]
	internal void LogWarning(string message)
	{
		_logger.LogWarning("[" + gameObject.name + "] " + message);
	}

	[DebuggerHidden]
	internal void LogError(string message)
	{
		_logger.LogError("[" + gameObject.name + "] " + message);
	}

	public void InitInputControl()
	{
		GameObject gameObject = GameObject.Find("==== UI ROOT ====");
		if (!(null == gameObject))
		{
			clickableVariableJoystick = gameObject.GetComponentInChildren<ClickableVariableJoystick>(includeInactive: true);
			if (!(null == clickableVariableJoystick))
			{
				joystick = clickableVariableJoystick.gameObject;
				CrossPlatformInputManager.SetTouchScreenSupport(val: true);
				CrossPlatformInputManager.SetNormalSupport(val: true);
				pointerEventData = new PointerEventData(EventSystem.current);
			}
		}
	}

	private void OnEnable()
	{
		if (controls == null)
		{
			controls = new DefaultInputActions();
		}
		clickAction = controls.TouchEffect.Click;
		pointAction = controls.TouchEffect.Point;
		controls.TouchEffect.Enable();
	}

	private void OnDisable()
	{
		controls.TouchEffect.Disable();
		clickAction = null;
		pointAction = null;
	}

	private void InputUpdate(float dt)
	{
		CrossPlatformInputManager.Update(dt);
		UpdateTouchState();
		_movementInputDirection = (_movementInputVector = Vector2.zero);
		float axis = CrossPlatformInputManager.GetAxis("Horizontal");
		float axis2 = CrossPlatformInputManager.GetAxis("Vertical");
		if (Mathf.Abs(axis) > float.Epsilon || Mathf.Abs(axis2) > float.Epsilon)
		{
			_movementHasInput = true;
			_movementInputVector = new Vector2(axis, axis2);
			_movementInputDirection = _movementInputVector.normalized;
			if (_lastInputDirection != _movementInputDirection)
			{
				if (_lastDirection == Vector2.zero)
				{
					_lastDirection = _movementInputDirection;
				}
				if (Vector2.Angle(_lastDirection, _movementInputDirection) > 120f)
				{
					_lastDirection = _movementInputDirection;
				}
				_lastInputDirection = _movementInputDirection;
			}
		}
		if (_movementHasInput)
		{
			_movementInputDirection = TransformInputDirectionToWorldDirection(_movementInputDirection);
			int num = (int)(_movementInputDirection.x * 10000f);
			int num2 = (int)(_movementInputDirection.y * 10000f);
			_movementInputDirection = new Vector2((float)num * 0.0001f, (float)num2 * 0.0001f);
		}
		curPointerPosition = pointAction.ReadValue<Vector2>();
		if (clickAction.WasPressedThisFrame())
		{
			if (IsPointerOverUI())
			{
				pointerClickOnUI = true;
			}
			_pressDownHasInput = true;
			_pressDownPos = curPointerPosition;
			pressDownPosition = curPointerPosition;
		}
		if (clickAction.IsPressed())
		{
			_pressHasInput = true;
			_pressPos = curPointerPosition;
		}
		if (clickAction.WasReleasedThisFrame())
		{
			_pressUpHasInput = true;
			_pressUpPos = curPointerPosition;
			pointerClickOnUI = false;
			if (pressDownPosition.Equals(curPointerPosition))
			{
				_clickHasInput = true;
				_clickPos = curPointerPosition;
			}
			pressDownPosition = Vector2.zero;
		}
		if (!prePointerPosition.Equals(curPointerPosition))
		{
			_moveHasInput = true;
			_movePos = curPointerPosition;
		}
		prePointerPosition = curPointerPosition;
		UpdatePinchInput();
		if (_activeTouchCount != _lastActiveTouchCount)
		{
			_panRebase = true;
		}
		_lastActiveTouchCount = _activeTouchCount;
		if (_dragTouchId != _lastDragTouchId)
		{
			_panRebase = true;
		}
		_lastDragTouchId = _dragTouchId;
		if (_activeTouchCount > 0)
		{
			if (1 == _nonUITouchCount)
			{
				if (_panRebase)
				{
					endDrag0 = _dragTouchPos;
					_panRebase = false;
				}
				else
				{
					finger1HasInput = true;
					finger1InputDirection = _dragTouchPos - endDrag0;
					endDrag0 = _dragTouchPos;
				}
			}
			else
			{
				endDrag0 = Vector2.zero;
			}
		}
		else if (clickAction.IsPressed() && !pointerClickOnUI)
		{
			if (clickAction.WasPressedThisFrame() || _panRebase)
			{
				endDrag0 = curPointerPosition;
				_panRebase = false;
			}
			else
			{
				finger1HasInput = true;
				finger1InputDirection = curPointerPosition - endDrag0;
				endDrag0 = curPointerPosition;
			}
		}
		else
		{
			endDrag0 = Vector2.zero;
		}
		SubmitInputBuffer();
		ClearInput();
	}

	private void UpdateTouchState()
	{
		_activeTouchCount = 0;
		_nonUITouchCount = 0;
		_dragTouchId = 0;
		Touchscreen current = Touchscreen.current;
		if (current == null)
		{
			_lastPinchDistance = -1f;
			return;
		}
		ReadOnlyArray<TouchControl> touches = current.touches;
		if (_touchOverUI == null || _touchOverUI.Length < touches.Count)
		{
			_touchOverUI = new bool[touches.Count];
			_touchIds = new int[touches.Count];
		}
		TouchControl touchControl = null;
		TouchControl touchControl2 = null;
		for (int i = 0; i < touches.Count; i++)
		{
			TouchControl touchControl3 = touches.get_Item(i);
			UnityEngine.InputSystem.TouchPhase touchPhase = touchControl3.phase.ReadValue();
			if (touchPhase != UnityEngine.InputSystem.TouchPhase.Began && touchPhase != UnityEngine.InputSystem.TouchPhase.Moved && touchPhase != UnityEngine.InputSystem.TouchPhase.Stationary)
			{
				_touchIds[i] = 0;
				continue;
			}
			int num = touchControl3.touchId.ReadValue();
			Vector2 vector = touchControl3.position.ReadValue();
			if (touchPhase == UnityEngine.InputSystem.TouchPhase.Began || _touchIds[i] != num)
			{
				_touchIds[i] = num;
				_touchOverUI[i] = IsPositionOverUI(vector);
			}
			if (touchControl == null)
			{
				touchControl = touchControl3;
			}
			else if (touchControl2 == null)
			{
				touchControl2 = touchControl3;
			}
			_activeTouchCount++;
			if (!_touchOverUI[i])
			{
				_nonUITouchCount++;
				if (1 == _nonUITouchCount)
				{
					_dragTouchId = num;
					_dragTouchPos = vector;
				}
			}
		}
		if (touchControl != null)
		{
			_touch0Pos = touchControl.position.ReadValue();
		}
		if (touchControl2 != null)
		{
			_touch1Pos = touchControl2.position.ReadValue();
		}
		if (_activeTouchCount < 2)
		{
			_lastPinchDistance = -1f;
		}
	}

	private void UpdatePinchInput()
	{
		if (_activeTouchCount < 2)
		{
			return;
		}
		float num = Vector2.Distance(_touch0Pos, _touch1Pos);
		if (_lastPinchDistance < 0f)
		{
			_lastPinchDistance = num;
			return;
		}
		float num2 = num - _lastPinchDistance;
		_lastPinchDistance = num;
		if (!(Mathf.Abs(num2) <= float.Epsilon) && (!IsPositionOverUI(_touch0Pos) || !IsPositionOverUI(_touch1Pos)))
		{
			_zoomHasInput = true;
			_zoomInput = num2 / (float)Mathf.Max(1, Screen.height) * pinchZoomSensitivity;
		}
	}

	private bool IsPointerOverUI()
	{
		return IsPositionOverUI((pointAction != null) ? pointAction.ReadValue<Vector2>() : curPointerPosition);
	}

	private bool IsPositionOverUI(Vector2 screenPosition)
	{
		if (pointerEventData == null || null == EventSystem.current)
		{
			return false;
		}
		pointerEventData.position = screenPosition;
		EventSystem.current.RaycastAll(pointerEventData, raycastResults);
		return raycastResults.Count > 0;
	}

	private void InputLogicUpdate()
	{
		onInputLogicUpdate?.Invoke(_movementHasInputBuffer, _movementInputDirectionBuffer);
		onZoomInput?.Invoke(_zoomHasInputBuffer, _zoomInputBuffer);
		onFinger1Input?.Invoke(finger1HasInputBuffer, finger1InputDirectionBuffer);
		if (_pressDownHasInputBuffer)
		{
			onPressDown?.Invoke(_pressDownPosBuffer);
		}
		if (_pressHasInputBuffer)
		{
			onPress?.Invoke(_pressPosBuffer);
		}
		if (_pressUpHasInputBuffer)
		{
			onPressUp?.Invoke(_pressUpPosBuffer);
		}
		if (_clickHasInputBuffer)
		{
			onClick?.Invoke(_clickPosBuffer);
		}
		if (_moveHasInputBuffer)
		{
			onMove?.Invoke(_movePosBuffer);
		}
	}

	protected Vector2 TransformInputDirectionToWorldDirection(Vector2 inputDirection)
	{
		float num = Vector2.SignedAngle(inputDirection, Vector2.up);
		Vector3 forward = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.transform.forward;
		Vector2 v = new Vector2(forward.x, forward.z);
		v.Normalize();
		inputDirection = MathMisc.Rotate(v, 0f - num);
		return inputDirection;
	}

	protected void SubmitInputBuffer()
	{
		_movementHasInputBuffer = _movementHasInput;
		_movementInputDirectionBuffer = _movementInputDirection;
		finger1HasInputBuffer = finger1HasInput;
		finger1InputDirectionBuffer = finger1InputDirection;
		_zoomHasInputBuffer = _zoomHasInput;
		_zoomInputBuffer = _zoomInput;
		_pressDownHasInputBuffer = _pressDownHasInput;
		_pressDownPosBuffer = _pressDownPos;
		_pressHasInputBuffer = _pressHasInput;
		_pressPosBuffer = _pressPos;
		_pressUpHasInputBuffer = _pressUpHasInput;
		_pressUpPosBuffer = _pressUpPos;
		_clickHasInputBuffer = _clickHasInput;
		_clickPosBuffer = _clickPos;
		_moveHasInputBuffer = _moveHasInput;
		_movePosBuffer = _movePos;
	}

	protected void ClearInput()
	{
		_movementHasInput = false;
		_movementInputDirection = (_movementInputVector = Vector2.zero);
		finger1HasInput = false;
		finger1InputDirection = Vector2.zero;
		_zoomHasInput = false;
		_zoomInput = 0f;
		_pressDownHasInput = false;
		_pressDownPos = Vector2.zero;
		_pressHasInput = false;
		_pressPos = Vector2.zero;
		_pressUpHasInput = false;
		_pressUpPos = Vector2.zero;
		_clickHasInput = false;
		_clickPos = Vector2.zero;
		_moveHasInput = false;
		_movePos = Vector2.zero;
	}
}
