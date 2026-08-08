using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;

namespace P08.Gamepad;

internal class HIDButton : MonoBehaviour
{
	private struct ClickInfo
	{
		public PointerEventData pointerEventData;

		public EventSystem eventSystem;

		public bool isBattleBtnSlient;

		public bool isValid;

		public EInputActionPhase phase;

		public bool isBattleBtnDown;

		public void Reset()
		{
			isBattleBtnSlient = false;
			isValid = false;
			phase = EInputActionPhase.Disabled;
			isBattleBtnDown = false;
		}
	}

	private string _pageName;

	private string _actionName;

	private static List<Vector2> _simClickPosList = new List<Vector2>();

	private static int _simClickFrame;

	private ClickInfo _clickInfo;

	private static List<RaycastResult> _raycastResultTmp = new List<RaycastResult>();

	private bool _isRegistered;

	public string pageName
	{
		set
		{
			_pageName = value;
		}
	}

	public string actionName
	{
		set
		{
			_actionName = value;
		}
	}

	private InputAction _inputAction
	{
		get
		{
			if (string.IsNullOrEmpty(_pageName) || string.IsNullOrEmpty(_actionName))
			{
				return null;
			}
			return InputManager.system.GetInputAction(_pageName, _actionName);
		}
	}

	public static bool GetSimClickPosList(List<Vector2> posList)
	{
		if (_simClickFrame != Time.frameCount)
		{
			return false;
		}
		foreach (Vector2 simClickPos in _simClickPosList)
		{
			posList.Add(simClickPos);
		}
		return true;
	}

	private static void AddSimClickPos(Vector2 pos)
	{
		int frameCount = Time.frameCount;
		if (_simClickFrame != frameCount)
		{
			_simClickFrame = frameCount;
			_simClickPosList.Clear();
		}
		_simClickPosList.Add(pos);
	}

	private void OnEnable()
	{
		Register();
	}

	private void OnDisable()
	{
		UnRegister();
	}

	public void Rebind()
	{
		if (_isRegistered)
		{
			Debug.LogWarning("HIDButton: " + base.gameObject.name + " 已经被绑定! 但被" + _pageName + "." + _actionName + "再次绑定!");
			UnRegister();
		}
		Register();
	}

	private void Register()
	{
		InputAction inputAction = _inputAction;
		if (!_isRegistered && inputAction != null && base.isActiveAndEnabled)
		{
			_isRegistered = true;
			inputAction.started += PerformedHandler;
			inputAction.performed += PerformedHandler;
			inputAction.canceled += PerformedHandler;
			inputAction.EnableIfNeed();
			InputManager.system.IncPagesVersion();
		}
	}

	public void UnRegister()
	{
		InputAction inputAction = _inputAction;
		if (_isRegistered && inputAction != null)
		{
			inputAction.started -= PerformedHandler;
			inputAction.performed -= PerformedHandler;
			inputAction.canceled -= PerformedHandler;
			inputAction.DisableIfNeed();
			_isRegistered = false;
			InputManager.system.IncPagesVersion();
		}
	}

	private void PerformedHandler(InputActionCallbackContext context)
	{
		EInputActionPhase phase = context.state.phase;
		switch (phase)
		{
		case EInputActionPhase.Started:
			_clickInfo.phase = phase;
			CollectClickInfo();
			SimulateClick();
			break;
		case EInputActionPhase.Performed:
			if (_clickInfo.phase == EInputActionPhase.Started)
			{
				_clickInfo.phase = phase;
				CollectClickInfo(isPerformed: true);
				SimulateClick();
			}
			break;
		case EInputActionPhase.Canceled:
			_clickInfo.phase = phase;
			SimulateClick();
			_clickInfo.Reset();
			break;
		}
	}

	private Vector2 GetClickPoint()
	{
		Camera uiCamera = CanvasManager.Instance.uiCamera;
		Vector2 result;
		if (base.transform is RectTransform { rect: var rect } rectTransform)
		{
			result = RectTransformUtility.WorldToScreenPoint(uiCamera, base.transform.position);
			result -= rectTransform.pivot * rect.size;
			result += rect.size / 2f;
		}
		else
		{
			result = RectTransformUtility.WorldToScreenPoint(uiCamera, base.transform.position);
		}
		result.x = Mathf.Clamp(result.x, 1f, Screen.width - 1);
		result.y = Mathf.Clamp(result.y, 1f, Screen.height - 1);
		return result;
	}

	private void CollectClickInfo(bool isPerformed = false)
	{
		Vector2 clickPoint = GetClickPoint();
		EventSystem current = EventSystem.current;
		PointerEventData pointerEventData = ((!(_clickInfo.eventSystem == current) || _clickInfo.pointerEventData == null) ? new PointerEventData(EventSystem.current)
		{
			pointerId = 0,
			delta = Vector2.zero,
			button = PointerEventData.InputButton.Left,
			pressure = 1f,
			eligibleForClick = true
		} : _clickInfo.pointerEventData);
		if (current == null)
		{
			Debug.LogWarning("HIDButton: EventSystem empty");
			_clickInfo.Reset();
			return;
		}
		pointerEventData.position = clickPoint;
		if (!isPerformed)
		{
			pointerEventData.pressPosition = clickPoint;
		}
		List<RaycastResult> raycastResultTmp = _raycastResultTmp;
		current.RaycastAll(pointerEventData, raycastResultTmp);
		RaycastResult raycastResult = raycastResultTmp.Find((RaycastResult result) => result.gameObject != null);
		GameObject gameObject = raycastResult.gameObject;
		_ = gameObject == null;
		raycastResult.gameObject = gameObject;
		pointerEventData.pointerCurrentRaycast = raycastResult;
		if (isPerformed)
		{
			pointerEventData.pointerClick = gameObject;
		}
		else
		{
			pointerEventData.pointerPressRaycast = raycastResult;
			pointerEventData.pointerPress = gameObject;
			pointerEventData.pointerEnter = gameObject;
			pointerEventData.pointerDrag = gameObject;
		}
		_clickInfo.pointerEventData = pointerEventData;
		_clickInfo.eventSystem = current;
		_clickInfo.isBattleBtnSlient = !GamepadManager.Instance.IsRuntime();
		_clickInfo.isValid = true;
	}

	private void SimulateClick()
	{
		if (_clickInfo.isValid)
		{
			PointerEventData pointerEventData = _clickInfo.pointerEventData;
			GameObject pointerPress = pointerEventData.pointerPress;
			bool num = _clickInfo.phase == EInputActionPhase.Started;
			bool flag = _clickInfo.phase == EInputActionPhase.Canceled;
			if (num)
			{
				ExecuteEvents.Execute<IPointerDownHandler>(ExecuteEvents.GetEventHandler<IPointerDownHandler>(pointerPress), pointerEventData, ExecutePointerDown);
				AddSimClickPos(pointerEventData.position);
			}
			else if (flag)
			{
				ExecuteEvents.Execute<IPointerUpHandler>(ExecuteEvents.GetEventHandler<IPointerUpHandler>(pointerPress), pointerEventData, ExecutePointerUp);
			}
			else if (pointerEventData.pointerClick == pointerPress)
			{
				ExecuteEvents.Execute(ExecuteEvents.GetEventHandler<IPointerClickHandler>(pointerPress), pointerEventData, ExecuteEvents.pointerClickHandler);
			}
		}
	}

	private static bool IsBattleButton(IEventSystemHandler handler)
	{
		if (!(handler is IBattleUIElement) && !(handler is P08JoystickController))
		{
			return handler is P08EXButton;
		}
		return true;
	}

	private bool ShouldInvokeUp(IEventSystemHandler handler)
	{
		if (IsBattleButton(handler))
		{
			if (!_clickInfo.isBattleBtnSlient)
			{
				return _clickInfo.isBattleBtnDown;
			}
			return true;
		}
		return true;
	}

	private bool ShouldInvokeDown(IEventSystemHandler handler)
	{
		if (IsBattleButton(handler))
		{
			return _clickInfo.isBattleBtnSlient;
		}
		return true;
	}

	private void ExecutePointerDown(IPointerDownHandler handler, BaseEventData eventData)
	{
		if (ShouldInvokeDown(handler))
		{
			ExecuteEvents.pointerDownHandler(handler, eventData);
			if (IsBattleButton(handler))
			{
				_clickInfo.isBattleBtnDown = true;
			}
		}
	}

	private void ExecutePointerUp(IPointerUpHandler handler, BaseEventData eventData)
	{
		if (ShouldInvokeUp(handler))
		{
			ExecuteEvents.pointerUpHandler(handler, eventData);
		}
	}
}
