using System.Collections.Generic;
using P08.Gamepad;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Pipelines.SimPipeline;

public class P08JoystickController : MonoBehaviour, IDragHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
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

	protected Vector2 LastVector = Vector2.zero;

	protected bool inited;

	private Camera mainCamera;

	private Vector2 oriPos;

	private bool banInput;

	private List<PointerEventData> _pressPoints;

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

	public void SetBanInput(bool value)
	{
		banInput = value;
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
		Vector2 screenPoint = eventData.position;
		bool flag = false;
		if (!GamepadManager.Instance.IsRuntime())
		{
			if (_pressPoints == null)
			{
				_pressPoints = new List<PointerEventData>(1);
			}
			flag = _pressPoints.Count > 0;
			_pressPoints.Remove(eventData);
			_pressPoints.Add(eventData);
			screenPoint = Vector2.zero;
			Vector2 vector = RectTransformUtility.WorldToScreenPoint(eventData.pressEventCamera, moveAreaRect.position);
			foreach (PointerEventData pressPoint in _pressPoints)
			{
				screenPoint += pressPoint.position - vector;
			}
			screenPoint += vector;
		}
		if (moveable && !flag)
		{
			RectTransform rectTransform = moveAreaRect.parent as RectTransform;
			RectTransformUtility.ScreenPointToLocalPointInRectangle(rectTransform, screenPoint, eventData.pressEventCamera, out var localPoint);
			float num = moveAreaRect.rect.width / 2f;
			float x = Mathf.Clamp(localPoint.x, num, rectTransform.rect.width - num);
			float num2 = moveAreaRect.rect.height / 2f;
			float y = Mathf.Clamp(localPoint.y, num2, rectTransform.rect.height - num2);
			localPoint = new Vector2(x, y);
			Vector2 vector2 = new Vector2(0.5f, 0.5f);
			moveAreaRect.localPosition = localPoint;
			Vector2 vector3 = (moveAreaRect.pivot - vector2) * moveAreaRect.sizeDelta;
			moveAreaRect.anchoredPosition += vector3;
		}
		RectTransformUtility.ScreenPointToLocalPointInRectangle(moveAreaRect, screenPoint, eventData.pressEventCamera, out pointerPosition);
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (GamepadManager.Instance.IsRuntime())
		{
			_pressPoints?.Clear();
		}
		else
		{
			_pressPoints?.Remove(eventData);
		}
		if (_pressPoints == null || _pressPoints.Count == 0)
		{
			PointerUp();
		}
		else
		{
			OnPointerDown(_pressPoints[0]);
		}
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

	protected virtual void UpdateGamepad()
	{
		if (base.enabled && GamepadManager.Instance != null)
		{
			float num = 0f - GamepadManager.Instance.GetKeyValue(En_ButtonType.MoveLeft);
			num += GamepadManager.Instance.GetKeyValue(En_ButtonType.MoveRight);
			float keyValue = GamepadManager.Instance.GetKeyValue(En_ButtonType.MoveUp);
			keyValue += 0f - GamepadManager.Instance.GetKeyValue(En_ButtonType.MoveDown);
			if (num != 0f || keyValue != 0f)
			{
				joystickForwardVector = new Vector2(num, keyValue).normalized;
			}
		}
	}

	private void Update()
	{
		if (inited && !banInput)
		{
			if (_block)
			{
				UpdateOperationLogic();
				UpdateGamepad();
			}
			if (updateGameLogic != null)
			{
				updateGameLogic.UpdateLogic(joystickForwardVector);
				LastVector = joystickForwardVector;
			}
			joystickForwardVector = Vector2.zero;
		}
	}

	protected virtual void UpdateOperationLogic()
	{
		if (!(moveAreaRect == null) && !(joystickCap == null))
		{
			Vector3 localPosition = pointerPosition;
			localPosition.z = 0f;
			if (localPosition.sqrMagnitude >= moveAreaDeadRadius * moveAreaDeadRadius)
			{
				joystickForwardVector = localPosition.normalized;
			}
			if (localPosition.sqrMagnitude > moveAreaRadius * moveAreaRadius)
			{
				localPosition = joystickForwardVector * moveAreaRadius;
			}
			joystickCap.localPosition = localPosition;
		}
	}

	private void OnDisable()
	{
		PointerUp();
		if (updateGameLogic != null)
		{
			joystickForwardVector = Vector2.zero;
			LastVector = joystickForwardVector;
			updateGameLogic.UpdateLogic(joystickForwardVector);
		}
	}

	public IStickControllerGameLogic GetControllerGameLogic()
	{
		return updateGameLogic;
	}

	public Vector2 GetjoystickLastForwardVector()
	{
		return LastVector;
	}
}
