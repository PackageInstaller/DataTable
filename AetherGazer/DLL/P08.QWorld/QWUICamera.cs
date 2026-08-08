using System;
using System.Collections.Generic;
using P08.Gamepad;
using UnityEngine;
using UnityEngine.EventSystems;

public class QWUICamera : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler, IPointerMoveHandler, IScrollHandler
{
	public QWCameraFlag flag;

	private IQWCameraCtrlGameLogic updateGameLogic;

	private bool inited;

	private Vector2 dragDelta = Vector2.zero;

	private float scroll;

	private int retryCount;

	public float speed = 1f;

	public float speedHeight = -6f;

	public float speedDistance = 6f;

	public float mouseCameraSensitivity = 1f;

	private bool _block = true;

	private List<CanvasGroup> _parentCanvasGroups = new List<CanvasGroup>(3);

	private List<PointerEventData> _pointerData = new List<PointerEventData>(4);

	private Dictionary<En_ButtonType, QWKeyValue> _cameraKeyValues = new Dictionary<En_ButtonType, QWKeyValue>();

	private float orgDis;

	private void Awake()
	{
		if (flag == QWCameraFlag.Story || flag == QWCameraFlag.Furniture)
		{
			Init();
		}
		HIDInputPage component = base.gameObject.GetComponent<HIDInputPage>();
		_cameraKeyValues[En_ButtonType.CameraUp] = new QWKeyValue(component, En_ButtonType.CameraUp);
		_cameraKeyValues[En_ButtonType.CameraDown] = new QWKeyValue(component, En_ButtonType.CameraDown);
		_cameraKeyValues[En_ButtonType.CameraLeft] = new QWKeyValue(component, En_ButtonType.CameraLeft);
		_cameraKeyValues[En_ButtonType.CameraRight] = new QWKeyValue(component, En_ButtonType.CameraRight);
		_cameraKeyValues[En_ButtonType.MouseScrollWheelUp] = new QWKeyValue(component, En_ButtonType.MouseScrollWheelUp);
		_cameraKeyValues[En_ButtonType.MouseScrollWheelDown] = new QWKeyValue(component, En_ButtonType.MouseScrollWheelDown);
	}

	private void OnCanvasGroupChanged()
	{
		if (!inited)
		{
			return;
		}
		_block = true;
		foreach (CanvasGroup parentCanvasGroup in _parentCanvasGroups)
		{
			if (!parentCanvasGroup.blocksRaycasts)
			{
				_block = false;
				break;
			}
		}
	}

	public void Init()
	{
		updateGameLogic = new QWCameraCtrlGameLogic();
		updateGameLogic.Init(flag);
		inited = true;
		_block = true;
		_parentCanvasGroups.Clear();
		_pointerData?.Clear();
		Transform parent = base.transform;
		while (parent != null)
		{
			CanvasGroup component = parent.GetComponent<CanvasGroup>();
			if (component != null)
			{
				_parentCanvasGroups.Add(component);
				if (component.ignoreParentGroups)
				{
					break;
				}
			}
			parent = parent.parent;
		}
		QWorldCameraManager.Instance.RegisterCamera(this, flag);
	}

	public void Update()
	{
		ShowInputNotice(!PlatformHelper.IsPC() || GamepadManager.Instance.GetGamepadType() != En_GamepadType.KeyMouse || !Cursor.visible);
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (_pointerData.Count > 1)
		{
			if (Input.touchCount < 2)
			{
				retryCount++;
				if (retryCount > 10)
				{
					retryCount = 0;
					_pointerData.Clear();
				}
			}
		}
		else
		{
			dragDelta = eventData.delta;
		}
	}

	public void Tick()
	{
		if (!inited)
		{
			return;
		}
		if (!_block)
		{
			Disable();
			return;
		}
		if (scroll == 0f)
		{
			float keyValue = _cameraKeyValues[En_ButtonType.MouseScrollWheelDown].GetKeyValue();
			float keyValue2 = _cameraKeyValues[En_ButtonType.MouseScrollWheelUp].GetKeyValue();
			GamepadManager.Instance.GetKeyValue(En_ButtonType.MouseScrollWheelUp);
			if (keyValue != 0f)
			{
				scroll = keyValue * -1f / 10f;
			}
			else if (keyValue2 != 0f)
			{
				scroll = keyValue2 / 10f;
			}
		}
		if (dragDelta == Vector2.zero)
		{
			UpdateGamepad();
		}
		if (updateGameLogic != null)
		{
			updateGameLogic.UpdateLogic(dragDelta.x * speed * Time.deltaTime * 5f, dragDelta.y * speedHeight * Time.deltaTime / 100f, scroll * speedDistance);
			if (GamepadManager.Instance.GetKeyDown(En_ButtonType.CameraReset))
			{
				updateGameLogic.ResetCamera();
			}
		}
		dragDelta = Vector2.zero;
		scroll = 0f;
	}

	private void OnEnable()
	{
		foreach (QWKeyValue value in _cameraKeyValues.Values)
		{
			value.OnEnable();
		}
	}

	private void Disable()
	{
		if (_pointerData != null)
		{
			_pointerData.Clear();
		}
	}

	private void OnDisable()
	{
		Disable();
		foreach (QWKeyValue value in _cameraKeyValues.Values)
		{
			value.OnDisable();
		}
	}

	public void UpdateGamepad()
	{
		float num = 0f - _cameraKeyValues[En_ButtonType.CameraLeft].GetKeyValue();
		num += _cameraKeyValues[En_ButtonType.CameraRight].GetKeyValue();
		float num2 = 0f - _cameraKeyValues[En_ButtonType.CameraDown].GetKeyValue();
		num2 += _cameraKeyValues[En_ButtonType.CameraUp].GetKeyValue();
		float num3 = GamepadManager.Instance.GetCameraSensitivity();
		if (GamepadManager.Instance.GetGamepadType() == En_GamepadType.KeyMouse)
		{
			num3 *= mouseCameraSensitivity;
		}
		if (Cursor.visible && PlatformHelper.IsPC() && GamepadManager.Instance.GetGamepadType() == En_GamepadType.KeyMouse)
		{
			dragDelta = Vector2.zero;
		}
		else
		{
			dragDelta = new Vector2(num, num2) * num3;
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
	}

	public void OnPointerUp(PointerEventData eventData)
	{
	}

	public void OnPointerMove(PointerEventData eventData)
	{
	}

	private void ShowInputNotice(bool visible)
	{
		try
		{
			if (!InputManager.system.TryGetPageInputActionMap("SandPlay_InScenes_HUDUI", out var map))
			{
				return;
			}
			InputAction inputAction = map.GetInputAction("CameraLeft");
			if (inputAction.enabled != visible)
			{
				InputAction inputAction2 = map.GetInputAction("CameraRight");
				InputAction inputAction3 = map.GetInputAction("CameraUp");
				InputAction inputAction4 = map.GetInputAction("CameraDown");
				if (visible)
				{
					inputAction.Enable();
					inputAction2.Enable();
					inputAction3.Enable();
					inputAction4.Enable();
				}
				else
				{
					inputAction.Disable();
					inputAction2.Disable();
					inputAction3.Disable();
					inputAction4.Disable();
				}
				InputManager.system.IncPagesVersion();
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	public void OnScroll(PointerEventData eventData)
	{
	}
}
