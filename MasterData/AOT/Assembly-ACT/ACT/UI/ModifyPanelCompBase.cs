using System;
using System.Collections.Generic;
using ACT.Utility;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public abstract class ModifyPanelCompBase : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IDragHandler, IEndDragHandler
{
	[SerializeReference]
	private GameObject normalStateGo;

	[SerializeReference]
	private GameObject selectStateGo;

	[SerializeReference]
	private GameObject conflictStateGo;

	protected Action<ModifyPanelCompBase> _selectAction;

	protected Func<ModifyPanelCompBase, bool> _checkOverlapFunc;

	protected Action<ModifyPanelCompBase> _resetTransformAction;

	protected ModifyPanelCompState _state;

	protected bool _validModify;

	protected float _originalSize;

	protected float _curDiameter;

	protected Vector2 _curPos;

	private Vector2 _lastPointerPos;

	protected Vector2 _pointerDelta;

	public RectTransform RT => transform as RectTransform;

	public RectTransform OverLapCheckRT => RT;

	public abstract CustomUICompShapeType ShapeType { get; }

	public abstract bool UseDiameter { get; }

	public float Radius => _curDiameter / 2f;

	public virtual void Init(ModifyPanelCompInitData initData)
	{
		_originalSize = RT.sizeDelta.x;
	}

	public abstract void SetTransform(List<ModifyPanelCompData> compDatas);

	public abstract void GetTypes(out List<CustomUICompType> types);

	public void ChangeState(ModifyPanelCompState toState)
	{
		if (_state != toState)
		{
			_state = toState;
			normalStateGo.SetActive(value: false);
			selectStateGo.SetActive(value: false);
			conflictStateGo.SetActive(value: false);
			switch (_state)
			{
			case ModifyPanelCompState.Normal:
				normalStateGo.SetActive(value: true);
				break;
			case ModifyPanelCompState.Select:
				selectStateGo.SetActive(value: true);
				break;
			case ModifyPanelCompState.Conflict:
				conflictStateGo.SetActive(value: true);
				break;
			}
		}
	}

	public bool CheckOverLap(ModifyPanelCompBase other)
	{
		if (ShapeType == CustomUICompShapeType.Rectangle && other.ShapeType == CustomUICompShapeType.Rectangle)
		{
			return OverLapCheckRT.OverLaps(other.OverLapCheckRT);
		}
		if (ShapeType == CustomUICompShapeType.Circle && other.ShapeType == CustomUICompShapeType.Circle)
		{
			return (OverLapCheckRT.localPosition - other.OverLapCheckRT.localPosition).magnitude <= Radius + other.Radius;
		}
		if (ShapeType == CustomUICompShapeType.Circle && other.ShapeType == CustomUICompShapeType.Rectangle)
		{
			float radius = Radius;
			float x = OverLapCheckRT.localPosition.x;
			float y = OverLapCheckRT.localPosition.y;
			float x2 = other.OverLapCheckRT.localPosition.x - other.OverLapCheckRT.rect.width / 2f;
			float x3 = other.OverLapCheckRT.localPosition.x + other.OverLapCheckRT.rect.width / 2f;
			float y2 = other.OverLapCheckRT.localPosition.y - other.OverLapCheckRT.rect.height / 2f;
			float y3 = other.OverLapCheckRT.localPosition.y + other.OverLapCheckRT.rect.height / 2f;
			return RectangleCircleCheckOverlap(radius, x, y, x2, y2, x3, y3);
		}
		if (ShapeType == CustomUICompShapeType.Rectangle && other.ShapeType == CustomUICompShapeType.Circle)
		{
			float radius2 = other.Radius;
			float x4 = other.OverLapCheckRT.localPosition.x;
			float y4 = other.OverLapCheckRT.localPosition.y;
			float x5 = OverLapCheckRT.localPosition.x - OverLapCheckRT.rect.width / 2f;
			float x6 = OverLapCheckRT.localPosition.x + OverLapCheckRT.rect.width / 2f;
			float y5 = OverLapCheckRT.localPosition.y - OverLapCheckRT.rect.height / 2f;
			float y6 = OverLapCheckRT.localPosition.y + OverLapCheckRT.rect.height / 2f;
			return RectangleCircleCheckOverlap(radius2, x4, y4, x5, y5, x6, y6);
		}
		return false;
	}

	private bool RectangleCircleCheckOverlap(float radius, float xCenter, float yCenter, float x1, float y1, float x2, float y2)
	{
		float num = Mathf.Clamp(xCenter, x1, x2) - xCenter;
		float num2 = Mathf.Clamp(yCenter, y1, y2) - yCenter;
		return num * num + num2 * num2 <= radius * radius;
	}

	public void SetAnchor(float anchorX, float anchorY)
	{
		RectTransform rT = RT;
		Vector2 anchorMin = (RT.anchorMax = new Vector2(anchorX, anchorY));
		rT.anchorMin = anchorMin;
	}

	public virtual void SetDiameter(float newDiameter)
	{
		if (UseDiameter)
		{
			RT.localScale = newDiameter / RT.sizeDelta.x * Vector3.one;
			_curDiameter = newDiameter;
		}
	}

	public void SetPos(Vector2 newPos)
	{
		RT.anchoredPosition = newPos;
		_curPos = newPos;
	}

	public virtual void SetPosDelta(Vector2 posDelta)
	{
		SetPos(_curPos + posDelta);
	}

	public virtual void RecordPos()
	{
	}

	public virtual void RecordPosDelta(Vector2 posDelta)
	{
	}

	public virtual void RecordDiameter()
	{
	}

	public abstract void OnPosModifyBtnLongClick(Vector2 posDelta);

	public abstract void OnPosModifyBtnUp();

	public abstract void OnDiameterSliderValChange(float newDiameter);

	public abstract void OnDiameterSliderUp();

	public abstract void OnEdgeOffsetChange(Vector2 compPosDelta);

	protected void SetLastPointerPos(PointerEventData eventData)
	{
		GetPointerLocalPos(eventData, out var pointerLocalPos);
		_pointerDelta = pointerLocalPos - _lastPointerPos;
		_lastPointerPos = pointerLocalPos;
	}

	private void GetPointerLocalPos(PointerEventData eventData, out Vector2 pointerLocalPos)
	{
		RectTransformUtility.ScreenPointToLocalPointInRectangle(transform.parent as RectTransform, eventData.position, eventData.pressEventCamera, out var localPoint);
		pointerLocalPos = localPoint;
	}

	protected void CheckOverlap()
	{
		bool flag = _checkOverlapFunc?.Invoke(this) ?? false;
		_validModify = !flag;
		ChangeState(flag ? ModifyPanelCompState.Conflict : ModifyPanelCompState.Select);
	}

	public virtual void OnDrag(PointerEventData eventData)
	{
	}

	public virtual void OnEndDrag(PointerEventData eventData)
	{
	}

	public virtual void OnPointerDown(PointerEventData eventData)
	{
		_selectAction?.Invoke(this);
		GetPointerLocalPos(eventData, out _lastPointerPos);
	}
}
