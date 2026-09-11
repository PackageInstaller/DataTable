using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class GuildActivityInputManager : MonoBehaviour
{
	public static readonly int ZOOM_BEGIN = 0;

	public static readonly int ZOOM_MOVE = 1;

	private float lastTouchDis;

	[SerializeField]
	private float scaleRate = 0.005f;

	[SerializeField]
	private float moveRate = 0.015f;

	[SerializeField]
	private float touchMoveMagnitude = 10f;

	[SerializeField]
	private bool useEditor = true;

	public Action<int, float> onZoomChange;

	public Action<Vector2> onSingleFingerMove;

	private bool _touchForDrag;

	private Vector2 _touchBeginPos;

	private bool _thisTouchOnUI;

	private void Update()
	{
		if (!GuildActivityManager.GetInstance().IsOnWarField())
		{
			return;
		}
		if (Input.touchCount == 2)
		{
			if (!_thisTouchOnUI)
			{
				bool flag = Input.touches[0].phase == TouchPhase.Began || Input.touches[1].phase == TouchPhase.Began;
				float num = Vector2.Distance(Input.touches[0].position, Input.touches[1].position);
				if (Math.Abs(-1f - lastTouchDis) < 1E-05f)
				{
					lastTouchDis = num;
				}
				float num2 = num - lastTouchDis;
				num2 *= scaleRate;
				onZoomChange?.Invoke(flag ? ZOOM_BEGIN : ZOOM_MOVE, num2);
			}
			return;
		}
		lastTouchDis = -1f;
		if (Input.touchCount != 1)
		{
			return;
		}
		_thisTouchOnUI = IsClickOnUI();
		if (_thisTouchOnUI)
		{
			return;
		}
		if (Input.touches[0].phase == TouchPhase.Began)
		{
			_touchBeginPos = Input.GetTouch(0).position;
			_touchForDrag = false;
		}
		else if (Input.touches[0].phase == TouchPhase.Moved)
		{
			if (onSingleFingerMove != null)
			{
				if ((Input.GetTouch(0).position - _touchBeginPos).magnitude < touchMoveMagnitude)
				{
					return;
				}
				Vector2 obj = new Vector2(Input.touches[0].deltaPosition.x, 0f - Input.touches[0].deltaPosition.y) * moveRate;
				onSingleFingerMove(obj);
			}
			_touchForDrag = true;
		}
		else if (Input.touches[0].phase == TouchPhase.Ended)
		{
			if (!_touchForDrag)
			{
				CheckClick();
			}
			_touchForDrag = false;
		}
	}

	private void CheckClick()
	{
		Vector3 pos = Input.GetTouch(0).position;
		Ray ray = Camera.main.ScreenPointToRay(pos);
		RaycastHit2D[] array = Physics2D.RaycastAll(ray.origin, ray.direction);
		GuildActivityWarFieldNode guildActivityWarFieldNode = null;
		GuildActivityWarFieldNode guildActivityWarFieldNode2 = null;
		for (int i = 0; i < array.Length; i++)
		{
			RaycastHit2D raycastHit2D = array[i];
			GuildActivityWarFieldNode component = raycastHit2D.transform.GetComponent<GuildActivityWarFieldNode>();
			if (component != null)
			{
				guildActivityWarFieldNode = component;
				break;
			}
			component = raycastHit2D.transform.GetComponentInParent<GuildActivityWarFieldNode>();
			if (component != null)
			{
				guildActivityWarFieldNode2 = component;
				break;
			}
		}
		if (guildActivityWarFieldNode != null)
		{
			GuildActivityManager.GetInstance().ClickNode(guildActivityWarFieldNode);
		}
		else if (guildActivityWarFieldNode2 != null)
		{
			GuildActivityManager.GetInstance().ClickBonusNode(guildActivityWarFieldNode2);
		}
		else
		{
			GuildActivityManager.GetInstance().ClickBg();
		}
	}

	public bool IsPointerOverUIObject(Vector2 screenPosition)
	{
		PointerEventData pointerEventData = new PointerEventData(EventSystem.current);
		pointerEventData.position = new Vector2(screenPosition.x, screenPosition.y);
		List<RaycastResult> list = new List<RaycastResult>();
		EventSystem.current.RaycastAll(pointerEventData, list);
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i].gameObject.GetComponent<RectTransform>() != null)
			{
				return true;
			}
		}
		return false;
	}

	public bool IsClickOnUI()
	{
		Vector3 position = Camera.main.ScreenToWorldPoint(Input.mousePosition);
		Vector3 vector = Camera.main.WorldToScreenPoint(position);
		return IsPointerOverUIObject(vector);
	}

	private void OnDestroy()
	{
		onZoomChange = null;
	}
}
