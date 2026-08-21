using System.Collections.Generic;
using P08.Gamepad;
using UnityEngine;
using UnityEngine.EventSystems;

namespace T0World;

public class T0WorldUICamera : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler, IScrollHandler, IT0WorldUICamera
{
	private readonly Dictionary<En_ButtonType, QWKeyValue> _cameraKeyValues = new Dictionary<En_ButtonType, QWKeyValue>();

	private int retryCount;

	public float scroll;

	public Vector2 dragDelta = Vector2.zero;

	private bool inited;

	private T0CameraCtrlGameLogic updateGameLogic;

	public Transform pointerDownTarget;

	public float speed = 1f;

	public float speedHeight = -6f;

	public float speedDistance = 6f;

	public float mouseCameraSensitivity = 1f;

	public float pointerInteractCd = 0.5f;

	private float _lastPointerDownTime = -99f;

	private Camera _mainCamera;

	private PhysicsRaycaster _physicsRaycaster;

	private int _effectLayerMask;

	private RaycastHit[] _raycastHits = new RaycastHit[32];

	public Vector3 Dir => updateGameLogic.CurDir;

	private void Awake()
	{
		_mainCamera = Camera.main;
		if (_mainCamera != null)
		{
			_physicsRaycaster = _mainCamera.GetComponent<PhysicsRaycaster>();
		}
		_effectLayerMask = LayerMask.GetMask("Effect");
		HIDInputPage component = base.gameObject.GetComponent<HIDInputPage>();
		_cameraKeyValues[En_ButtonType.CameraUp] = new QWKeyValue(component, En_ButtonType.CameraUp);
		_cameraKeyValues[En_ButtonType.CameraDown] = new QWKeyValue(component, En_ButtonType.CameraDown);
		_cameraKeyValues[En_ButtonType.CameraLeft] = new QWKeyValue(component, En_ButtonType.CameraLeft);
		_cameraKeyValues[En_ButtonType.CameraRight] = new QWKeyValue(component, En_ButtonType.CameraRight);
		_cameraKeyValues[En_ButtonType.MouseScrollWheelUp] = new QWKeyValue(component, En_ButtonType.MouseScrollWheelUp);
		_cameraKeyValues[En_ButtonType.MouseScrollWheelDown] = new QWKeyValue(component, En_ButtonType.MouseScrollWheelDown);
	}

	private void OnEnable()
	{
		InputManager.bottomBar.isShowBottomBar = false;
		foreach (QWKeyValue value in _cameraKeyValues.Values)
		{
			value.OnEnable();
		}
	}

	private void OnDisable()
	{
		InputManager.bottomBar.isShowBottomBar = true;
		Disable();
		foreach (QWKeyValue value in _cameraKeyValues.Values)
		{
			value.OnDisable();
		}
	}

	private void Disable()
	{
	}

	private void CheckCameraCache()
	{
		if (_mainCamera == null)
		{
			_mainCamera = Camera.main;
			if (_mainCamera != null)
			{
				_physicsRaycaster = _mainCamera.GetComponent<PhysicsRaycaster>();
			}
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		dragDelta = eventData.delta;
	}

	public void OnScroll(PointerEventData eventData)
	{
		scroll = eventData.scrollDelta.y;
	}

	private Transform GetNearPoint(Vector2 screenPos)
	{
		CheckCameraCache();
		if (_mainCamera == null)
		{
			return null;
		}
		int num = Physics.RaycastNonAlloc(_mainCamera.ScreenPointToRay(screenPos), _raycastHits, float.PositiveInfinity, _effectLayerMask);
		Transform result = null;
		float num2 = float.MaxValue;
		for (int i = 0; i < num; i++)
		{
			float distance = _raycastHits[i].distance;
			if (distance < num2 && _raycastHits[i].collider.gameObject.TryGetComponent<EventTrigger>(out var _))
			{
				num2 = distance;
				result = _raycastHits[i].collider.transform;
			}
		}
		return result;
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (eventData == null || (eventData.pointerId != -1 && eventData.pointerId != 0) || Time.unscaledTime - _lastPointerDownTime < pointerInteractCd)
		{
			return;
		}
		_lastPointerDownTime = Time.unscaledTime;
		pointerDownTarget = null;
		CheckCameraCache();
		if (!(_physicsRaycaster != null))
		{
			return;
		}
		Transform nearPoint = GetNearPoint(eventData.position);
		if ((bool)nearPoint)
		{
			EventTrigger component = nearPoint.GetComponent<EventTrigger>();
			if ((bool)component)
			{
				component.OnPointerDown(eventData);
				pointerDownTarget = nearPoint;
			}
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (eventData == null || (eventData.pointerId != -1 && eventData.pointerId != 0))
		{
			return;
		}
		CheckCameraCache();
		if (!(_physicsRaycaster != null))
		{
			return;
		}
		Transform nearPoint = GetNearPoint(eventData.position);
		if ((bool)nearPoint && nearPoint == pointerDownTarget)
		{
			EventTrigger component = nearPoint.GetComponent<EventTrigger>();
			if ((bool)component)
			{
				component.OnPointerUp(eventData);
			}
			pointerDownTarget = null;
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

	public void Init()
	{
		updateGameLogic = new T0CameraCtrlGameLogic();
		inited = true;
	}

	public void RegisterCamera()
	{
		T0WorldCameraManager.Instance.RegisterCamera(this, T0WorldCameraFlag.Player);
	}

	public void Tick()
	{
		if (!inited)
		{
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
			updateGameLogic.UpdateLogic(dragDelta.x * speed * Time.deltaTime * 5f, dragDelta.y * speedHeight * Time.deltaTime * 0.01f, scroll * speedDistance);
			if (GamepadManager.Instance.GetKeyDown(En_ButtonType.CameraReset))
			{
				updateGameLogic.ResetCamera();
			}
		}
		dragDelta = Vector2.zero;
		scroll = 0f;
	}

	public void SetDir(Vector3 dir)
	{
		updateGameLogic.SetDir(dir);
	}
}
