using System;
using System.Collections.Generic;
using P08.Gamepad;
using UnityEngine;
using UnityEngine.EventSystems;

public class AimCameraCtrl : MonoBehaviour, IDragHandler, IEventSystemHandler
{
	private bool inited;

	private Vector2 dragDelta = Vector2.zero;

	private float scroll;

	public float speed = 1f;

	public float speedHeight = -12f;

	public Transform controllerLeftRightGameObject;

	public Transform controllerUpDownGameObject;

	private Vector3 initRotate;

	private float InitLeftRightAngle;

	private float InitUpDownAngle;

	private float curLRAngle;

	private float curUDAngle;

	private bool lefeRightReverse;

	private bool upDownReverse;

	private Transform targetCamera;

	private float LeftRightAngleLimit = 30f;

	private float UpDownAngleLimit = 60f;

	private int leftRightAxis;

	private int upDownAxis;

	private bool _block = true;

	private bool banInput;

	private List<CanvasGroup> _parentCanvasGroups = new List<CanvasGroup>(3);

	private NAgent playerAgent;

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

	public void Init(Transform target, float LRLimit, float UDLimit, Transform LeftRightGo, Transform UpDownGo, int leftAxis, int upAxis, bool leftReverse, bool upReverse)
	{
		inited = true;
		_block = true;
		banInput = false;
		_parentCanvasGroups.Clear();
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
		targetCamera = target;
		initRotate = target.eulerAngles;
		LeftRightAngleLimit = LRLimit;
		UpDownAngleLimit = UDLimit;
		controllerLeftRightGameObject = LeftRightGo;
		controllerUpDownGameObject = UpDownGo;
		if (controllerLeftRightGameObject != null)
		{
			switch (leftAxis)
			{
			case 0:
				InitLeftRightAngle = controllerLeftRightGameObject.localEulerAngles.x;
				break;
			case 1:
				InitLeftRightAngle = controllerLeftRightGameObject.localEulerAngles.y;
				break;
			case 2:
				InitLeftRightAngle = controllerLeftRightGameObject.localEulerAngles.z;
				break;
			}
		}
		if (controllerUpDownGameObject != null)
		{
			switch (upAxis)
			{
			case 0:
				InitUpDownAngle = controllerUpDownGameObject.localEulerAngles.x;
				break;
			case 1:
				InitUpDownAngle = controllerUpDownGameObject.localEulerAngles.y;
				break;
			case 2:
				InitUpDownAngle = controllerUpDownGameObject.localEulerAngles.z;
				break;
			}
		}
		curLRAngle = InitLeftRightAngle;
		curUDAngle = InitUpDownAngle;
		leftRightAxis = leftAxis;
		upDownAxis = upAxis;
		lefeRightReverse = leftReverse;
		upDownReverse = upReverse;
		playerAgent = AgentManager.GetAgentManager().GetPlayerAgent();
	}

	public void OnDrag(PointerEventData eventData)
	{
		dragDelta = eventData.delta;
	}

	public void SetDragDelta(Vector2 delta)
	{
		dragDelta = delta;
	}

	public void SetBanInput(bool banInput)
	{
		this.banInput = banInput;
	}

	public void SetCameraForward(Vector3 forward)
	{
		if (!(targetCamera == null))
		{
			Vector3 eulerAngles = Quaternion.LookRotation(forward.normalized).eulerAngles;
			float num = eulerAngles.y - targetCamera.transform.eulerAngles.y;
			float deltaHeight = eulerAngles.x - targetCamera.transform.eulerAngles.x;
			UpdateLogic(num, deltaHeight, 0f);
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
		if (dragDelta == Vector2.zero)
		{
			UpdateGamepad();
		}
		scroll = 0f;
	}

	private void LateUpdate()
	{
		if (!banInput)
		{
			UpdateLogic(dragDelta.x * speed / Time.deltaTime / (float)Application.targetFrameRate * 0.2f, dragDelta.y * speedHeight / (float)Screen.height, scroll);
		}
		KeepAngle();
		dragDelta = Vector2.zero;
	}

	private void OnEnable()
	{
		ShowInputNotice(visible: true);
	}

	private void OnDisable()
	{
		UpdateLogic(0f, 0f, 0f);
		ShowInputNotice(visible: false);
	}

	public void UpdateGamepad()
	{
		float num = 0f - GamepadManager.Instance.GetKeyValue(En_ButtonType.CameraLeft);
		num += GamepadManager.Instance.GetKeyValue(En_ButtonType.CameraRight);
		float num2 = (float)GamepadManager.Instance.GetCameraSensitivity() / 10f;
		dragDelta = new Vector2(num * num2, 0f);
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

	public void KeepAngle()
	{
		if (controllerLeftRightGameObject != null)
		{
			Vector3 localEulerAngles = controllerLeftRightGameObject.transform.localEulerAngles;
			float num = 0f;
			Vector3 axis = Vector3.zero;
			switch (leftRightAxis)
			{
			case 0:
				axis = controllerLeftRightGameObject.transform.right;
				num = localEulerAngles.x;
				break;
			case 1:
				axis = controllerLeftRightGameObject.transform.up;
				num = localEulerAngles.y;
				break;
			case 2:
				axis = controllerLeftRightGameObject.transform.forward;
				num = localEulerAngles.z;
				break;
			}
			float angle = curLRAngle - num;
			SafeRotateAroundAxis(controllerLeftRightGameObject.transform, axis, angle);
		}
		if (controllerUpDownGameObject != null)
		{
			Vector3 localEulerAngles2 = controllerUpDownGameObject.localEulerAngles;
			float num2 = 0f;
			Vector3 axis2 = Vector3.zero;
			switch (upDownAxis)
			{
			case 0:
				axis2 = controllerUpDownGameObject.transform.right;
				num2 = localEulerAngles2.x;
				break;
			case 1:
				axis2 = controllerUpDownGameObject.transform.up;
				num2 = localEulerAngles2.y;
				break;
			case 2:
				axis2 = controllerUpDownGameObject.transform.forward;
				num2 = localEulerAngles2.z;
				break;
			}
			float angle2 = curUDAngle - num2;
			SafeRotateAroundAxis(controllerUpDownGameObject.transform, axis2, angle2);
		}
	}

	public void UpdateLogic(float dragDelta, float deltaHeight, float scroll)
	{
		if (targetCamera == null || BattleScene.isPause || ((bool)playerAgent && (playerAgent.Blackboard as BBHumanoid).HP <= 0))
		{
			return;
		}
		if (Mathf.Abs(dragDelta) >= 0.01f)
		{
			Vector3 eulerAngles = targetCamera.eulerAngles;
			float angle = targetCamera.eulerAngles.y + dragDelta;
			float y = ClampAngle(angle, initRotate.y, LeftRightAngleLimit);
			targetCamera.rotation = Quaternion.Euler(eulerAngles.x, y, eulerAngles.z);
			if (controllerLeftRightGameObject != null)
			{
				_ = Vector3.zero;
				float num = curLRAngle;
				num += (lefeRightReverse ? (0f - dragDelta) : dragDelta);
				num = ClampAngle(num, InitLeftRightAngle, LeftRightAngleLimit);
				float angle2 = num - curLRAngle;
				Vector3 axis = Vector3.zero;
				switch (leftRightAxis)
				{
				case 0:
					axis = controllerLeftRightGameObject.transform.right;
					break;
				case 1:
					axis = controllerLeftRightGameObject.transform.up;
					break;
				case 2:
					axis = controllerLeftRightGameObject.transform.forward;
					break;
				}
				SafeRotateAroundAxis(controllerLeftRightGameObject.transform, axis, angle2);
				curLRAngle = num;
			}
		}
		if (!(Mathf.Abs(deltaHeight) >= 0.01f))
		{
			return;
		}
		Vector3 eulerAngles2 = targetCamera.eulerAngles;
		float angle3 = targetCamera.eulerAngles.x + deltaHeight;
		float x = ClampAngle(angle3, initRotate.x, UpDownAngleLimit);
		targetCamera.rotation = Quaternion.Euler(x, eulerAngles2.y, eulerAngles2.z);
		if (controllerUpDownGameObject != null)
		{
			_ = controllerUpDownGameObject.localEulerAngles;
			float num2 = curUDAngle;
			num2 += (upDownReverse ? (0f - deltaHeight) : deltaHeight);
			num2 = ClampAngle(num2, InitUpDownAngle, UpDownAngleLimit);
			float angle4 = num2 - curUDAngle;
			Vector3 axis2 = Vector3.zero;
			switch (upDownAxis)
			{
			case 0:
				axis2 = controllerUpDownGameObject.transform.right;
				break;
			case 1:
				axis2 = controllerUpDownGameObject.transform.up;
				break;
			case 2:
				axis2 = controllerUpDownGameObject.transform.forward;
				break;
			}
			SafeRotateAroundAxis(controllerUpDownGameObject.transform, axis2, angle4);
			curUDAngle = num2;
		}
	}

	public void SafeRotateAroundAxis(Transform target, Vector3 axis, float angle)
	{
		Quaternion quaternion = Quaternion.AngleAxis(angle, axis);
		target.rotation = quaternion * target.rotation;
	}

	private float ClampAngle(float angle, float centerAngle, float range)
	{
		angle = Mathf.Repeat(angle, 360f);
		centerAngle = Mathf.Repeat(centerAngle, 360f);
		float value = Mathf.Repeat(angle - centerAngle + 180f, 360f) - 180f;
		value = Mathf.Clamp(value, 0f - range, range);
		return Mathf.Repeat(centerAngle + value, 360f);
	}
}
