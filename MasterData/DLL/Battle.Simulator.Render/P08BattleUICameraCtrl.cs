using System;
using System.Collections.Generic;
using P08.Gamepad;
using UnityEngine;
using UnityEngine.EventSystems;

public class P08BattleUICameraCtrl : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler, IPointerMoveHandler
{
	private ICameraCtrlGameLogic updateGameLogic;

	private bool inited;

	private Vector2 dragDelta = Vector2.zero;

	private float scroll;

	public float speed = 1f;

	public float speedHeight = -6f;

	public float speedDistance = 6f;

	public float cameraRadiusLerpFactor = 0.25f;

	private bool _block = true;

	private List<CanvasGroup> _parentCanvasGroups = new List<CanvasGroup>(3);

	private List<PointerEventData> _pointerData = new List<PointerEventData>(4);

	private float _accumulateScroll;

	private float orgDis;

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
		ShowInputNotice(_block && base.isActiveAndEnabled);
	}

	public void Init(ICameraCtrlGameLogic updateGameLogic)
	{
		this.updateGameLogic = updateGameLogic;
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
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (_pointerData.Count <= 1)
		{
			dragDelta = eventData.delta;
		}
	}

	private void Update()
	{
		if (!inited)
		{
			return;
		}
		if (!_block)
		{
			OnDisable();
			return;
		}
		if (GamepadManager.Instance.GetGamepadType() == En_GamepadType.KeyMouse)
		{
			_accumulateScroll += Input.GetAxis("Mouse ScrollWheel");
			if (Mathf.Abs(_accumulateScroll) > 0.001f)
			{
				scroll = Mathf.Lerp(scroll, _accumulateScroll, cameraRadiusLerpFactor);
				_accumulateScroll -= scroll;
			}
		}
		if (dragDelta == Vector2.zero)
		{
			UpdateGamepad();
		}
		if (updateGameLogic != null)
		{
			updateGameLogic.UpdateLogic(dragDelta.x * speed / Time.deltaTime / (float)Application.targetFrameRate * 0.2f, dragDelta.y * speedHeight / (float)Screen.height, scroll * speedDistance);
		}
		dragDelta = Vector2.zero;
		scroll = 0f;
	}

	private void OnEnable()
	{
		ShowInputNotice(visible: true);
	}

	private void OnDisable()
	{
		if (updateGameLogic != null)
		{
			updateGameLogic.UpdateLogic(0f, 0f, 0f);
		}
		if (_pointerData != null)
		{
			_pointerData.Clear();
		}
		ShowInputNotice(visible: false);
	}

	public void UpdateGamepad()
	{
		float num = 0f - GamepadManager.Instance.GetKeyValue(En_ButtonType.CameraLeft);
		num += GamepadManager.Instance.GetKeyValue(En_ButtonType.CameraRight);
		float num2 = (float)GamepadManager.Instance.GetCameraSensitivity() / 10f;
		dragDelta = new Vector2(num * num2, 0f);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		_pointerData.Add(eventData);
		if (_pointerData.Count == 2)
		{
			orgDis = (_pointerData[0].position - _pointerData[1].position).sqrMagnitude;
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		_pointerData.Remove(eventData);
	}

	public void OnPointerMove(PointerEventData eventData)
	{
		if (_pointerData.Count >= 2 && (eventData == _pointerData[0] || _pointerData[1] == eventData))
		{
			float sqrMagnitude = (_pointerData[0].position - _pointerData[1].position).sqrMagnitude;
			scroll = (orgDis - sqrMagnitude) / (float)(Screen.height * Screen.height);
			orgDis = sqrMagnitude;
		}
	}

	public void ShowInputNotice(bool visible)
	{
		try
		{
			if (!InputManager.system.TryGetPageInputActionMap("BattlePanel", out var map))
			{
				return;
			}
			InputAction inputAction = map.GetInputAction("CameraLeft");
			if (inputAction.enabled != visible)
			{
				InputAction inputAction2 = map.GetInputAction("CameraRight");
				if (visible)
				{
					inputAction.Enable();
					inputAction2.Enable();
				}
				else
				{
					inputAction.Disable();
					inputAction2.Disable();
				}
				InputManager.system.IncPagesVersion();
			}
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}
}
