using System.Collections.Generic;
using P08.Gamepad;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;

public class QWJoystickController : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
{
	public RectTransform moveAreaRect;

	public float moveAreaRadius = 50f;

	public float moveAreaDeadRadius;

	public RectTransform joystickCap;

	public bool enableKeyBoard;

	public bool moveable;

	public bool lockJoystickMoveable;

	private Vector2 pointerPosition;

	protected Vector2 joystickForwardVector;

	protected bool inited;

	private Camera mainCamera;

	private Vector2 oriPos;

	private List<CanvasGroup> _parentCanvasGroups = new List<CanvasGroup>(3);

	protected Vector2 PointerPosition => pointerPosition;

	protected IStickControllerGameLogic updateGameLogic { get; private set; }

	protected bool _block { get; private set; } = true;

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

	public void Init(Vector3 pos, float scale, IStickControllerGameLogic updateGameLogic)
	{
		this.updateGameLogic = updateGameLogic;
		if (moveable)
		{
			oriPos = moveAreaRect.anchoredPosition;
		}
		inited = true;
		_block = true;
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
	}

	public void OnDrag(PointerEventData eventData)
	{
		RectTransformUtility.ScreenPointToLocalPointInRectangle(moveAreaRect, eventData.position, eventData.pressEventCamera, out pointerPosition);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		if (moveable)
		{
			RectTransform rectTransform = moveAreaRect.parent as RectTransform;
			RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, eventData.position, eventData.pressEventCamera, out var localPoint);
			float num = moveAreaRect.rect.width / 2f;
			float x = Mathf.Clamp(localPoint.x, num, rectTransform.rect.width - num);
			float num2 = moveAreaRect.rect.height / 2f;
			float y = Mathf.Clamp(localPoint.y, num2, rectTransform.rect.height - num2);
			localPoint = new Vector2(x, y);
			Vector2 vector = new Vector2(0.5f, 0.5f);
			moveAreaRect.localPosition = localPoint;
			Vector2 vector2 = (moveAreaRect.pivot - vector) * moveAreaRect.sizeDelta;
			moveAreaRect.anchoredPosition += vector2;
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(moveAreaRect, eventData.position, eventData.pressEventCamera, out pointerPosition);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		PointerUp();
	}

	private void PointerUp()
	{
		pointerPosition = Vector2.zero;
		if (moveable)
		{
			moveAreaRect.anchoredPosition = oriPos;
		}
	}

	private void OnEnable()
	{
		mainCamera = CanvasManager.Instance.uiCamera;
	}

	protected virtual bool UpdateGamepad()
	{
		if (base.enabled && GamepadManager.Instance != null)
		{
			if (GamepadManager.Instance.IsUsingJoystick() && Cursor.visible && PlatformHelper.IsPC())
			{
				joystickCap.localPosition = Vector2.zero;
				return false;
			}
			float num = 0f - GamepadManager.Instance.GetKeyValue(En_ButtonType.MoveLeft);
			num += GamepadManager.Instance.GetKeyValue(En_ButtonType.MoveRight);
			float keyValue = GamepadManager.Instance.GetKeyValue(En_ButtonType.MoveUp);
			keyValue += 0f - GamepadManager.Instance.GetKeyValue(En_ButtonType.MoveDown);
			if (num != 0f || keyValue != 0f)
			{
				joystickForwardVector = new Vector2(num, keyValue);
				Vector2 vector = default(Vector2);
				vector = ((!GamepadManager.Instance.IsUsingJoystick()) ? (joystickForwardVector.normalized * 50f) : (joystickForwardVector * 50f));
				joystickCap.localPosition = vector;
				return true;
			}
		}
		return false;
	}

	private void Update()
	{
		if (inited)
		{
			bool useGamePad = false;
			if (_block)
			{
				UpdateOperationLogic();
				useGamePad = UpdateGamepad() && !GamepadManager.Instance.IsUsingJoystick();
			}
			if (updateGameLogic != null)
			{
				updateGameLogic.UpdateLogic(joystickForwardVector, joystickCap.localPosition.magnitude * 1f / 50f, useGamePad);
			}
			joystickForwardVector = Vector2.zero;
		}
	}

	protected virtual void UpdateOperationLogic()
	{
		if (!(moveAreaRect == null) && !(joystickCap == null))
		{
			Vector3 vector = pointerPosition;
			vector.z = 0f;
			if (vector.sqrMagnitude >= moveAreaDeadRadius * moveAreaDeadRadius)
			{
				joystickForwardVector = vector;
			}
			if (vector.sqrMagnitude > moveAreaRadius * moveAreaRadius)
			{
				vector = vector.normalized * moveAreaRadius;
			}
			joystickCap.localPosition = vector;
		}
	}

	private void OnDisable()
	{
		PointerUp();
		if (updateGameLogic != null)
		{
			joystickForwardVector = Vector2.zero;
			updateGameLogic.UpdateLogic(joystickForwardVector, joystickCap.localPosition.magnitude * 1f / 50f, useGamePad: false);
		}
	}

	public IStickControllerGameLogic GetControllerGameLogic()
	{
		return updateGameLogic;
	}
}
