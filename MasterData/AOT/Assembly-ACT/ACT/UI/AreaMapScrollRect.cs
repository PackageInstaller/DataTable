using System;
using System.Collections.Generic;
using ACT.UI.InputController;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Controls;
using UnityEngine.UI;

namespace ACT.UI;

public class AreaMapScrollRect : ScrollRect, IPointerClickHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
{
	public LargeMapView view;

	public LargeMapScaleSlider scaleSlider;

	private RectTransform scaleTarget;

	private float canvasScale;

	private Vector2 lastCenter;

	private float preSlideScale;

	private float maxScale;

	private float minScale;

	private float scaleDelta;

	private bool isSlide;

	private Vector4 offset = Vector4.zero;

	private Vector2 lastTouchVector;

	private float lastTouchDistance;

	private Vector2 lastTouchCenter;

	private bool _isTwoFingerDragging;

	private bool _hasCalledBaseBeginDrag;

	private int _beginDragPointerId = -1;

	private List<TouchControl> touchControlList = new List<TouchControl>(2);

	private Dictionary<int, Vector2> _pointerDownPositions = new Dictionary<int, Vector2>();

	private Dictionary<int, Vector2> _pendingClickDownPositions = new Dictionary<int, Vector2>();

	private bool _wasTwoFingerOperation;

	private const float ClickThreshold = 10f;

	private Dictionary<string, Action<GameObject, PointerEventData>> _layerClickHandlers = new Dictionary<string, Action<GameObject, PointerEventData>>();

	private Dictionary<Type, Action<Component, PointerEventData>> _componentClickHandlers = new Dictionary<Type, Action<Component, PointerEventData>>();

	private List<RaycastResult> _raycastResults = new List<RaycastResult>();

	private float curScale => scaleTarget.localScale.x;

	public event Action<Vector2> OnScreenClicked;

	public event Action<PointerEventData> OnScreenClickedWithEventData;

	public void SetIsSlide(bool val)
	{
		isSlide = val;
	}

	public void Init()
	{
		(float, float) areaScrollRectMinMaxScale = view.mapConfig.GetAreaScrollRectMinMaxScale(view.CurShowArea);
		minScale = areaScrollRectMinMaxScale.Item1;
		maxScale = areaScrollRectMinMaxScale.Item2;
		scaleDelta = view.mapConfig.GetAreaScrollRectScaleDelta(view.CurShowArea);
		view.areaMapRoot.SetActive(value: true);
		scaleTarget = content;
		canvasScale = GameUtility.uiCanvas.GetComponent<RectTransform>().localScale.x;
		onValueChanged.AddListener(UpdateFogCorner);
		OnScreenClicked += view.EnterPlaceMarkerMode;
		AddSetContourLineOnValueChanged();
	}

	public void UnInit(bool parentUnInit = false)
	{
		if (!parentUnInit)
		{
			view.areaMapRoot.SetActive(value: false);
		}
		RemoveSetPlayerNavBtnOnValueChanged();
		RemoveSetMissionNavBtnOnValueChanged();
		RemoveSetContourLineOnValueChanged();
		OnScreenClicked -= view.EnterPlaceMarkerMode;
		onValueChanged.RemoveListener(UpdateFogCorner);
	}

	private void UpdateFogCorner(Vector2 arg = default(Vector2))
	{
		MapUtility.SetLargeMapRoomMaterialCorner(view.AreaGrid.transform as RectTransform);
		MapUtility.SetLargeMapDetailMaterialCorner(view.AreaGrid.transform as RectTransform);
	}

	public void UpdateTargetScale(Vector2 center, float targetScale, bool force = false)
	{
		if (scaleTarget == null)
		{
			return;
		}
		targetScale = Mathf.Clamp(targetScale, minScale, maxScale);
		if (!Mathf.Approximately(targetScale, curScale))
		{
			if ((lastCenter != center) | force)
			{
				SetPivot(center);
				lastCenter = center;
			}
			movementType = MovementType.Clamped;
			float beforeVal = curScale;
			scaleTarget.localScale = Vector3.one * targetScale;
			scaleSlider.value = targetScale;
			UpdateFogCorner();
			UpdateBounds();
			OnScaleUpdate(beforeVal, curScale);
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Map/Slider");
		}
	}

	public void OnScaleUpdate(float beforeVal, float afterVal)
	{
		view.OnScaleUpdate(beforeVal, afterVal);
	}

	public void AddSetPlayerNavBtnOnValueChanged()
	{
		onValueChanged.AddListener(SetPlayerNavButton);
		SetPlayerNavButton(Vector2.zero);
	}

	public void RemoveSetPlayerNavBtnOnValueChanged()
	{
		onValueChanged.RemoveListener(SetPlayerNavButton);
	}

	private void SetPlayerNavButton(Vector2 arg)
	{
		view.SetPlayerNavButton();
	}

	public void AddSetMissionNavBtnOnValueChanged()
	{
		onValueChanged.AddListener(SetMissionNavButton);
		SetMissionNavButton(Vector2.zero);
	}

	public void RemoveSetMissionNavBtnOnValueChanged()
	{
		onValueChanged.RemoveListener(SetMissionNavButton);
	}

	private void SetMissionNavButton(Vector2 arg)
	{
		view.SetMissionNavButton();
	}

	public void AddSetMonsterPointNavBtnOnValueChanged()
	{
		onValueChanged.AddListener(SetMonsterPointNavButton);
		SetMonsterPointNavButton(Vector2.zero);
	}

	public void RemoveSetMonsterPointNavBtnOnValueChanged()
	{
		onValueChanged.RemoveListener(SetMonsterPointNavButton);
	}

	private void SetMonsterPointNavButton(Vector2 arg)
	{
		view.SetSpecialPointNavButton();
	}

	public void AddSetGeneralPointNavBtnOnValueChanged()
	{
		onValueChanged.AddListener(SetGeneralPointNavButton);
		SetGeneralPointNavButton(Vector2.zero);
	}

	public void RemoveSetGeneralPointNavBtnOnValueChanged()
	{
		onValueChanged.RemoveListener(SetGeneralPointNavButton);
	}

	private void SetGeneralPointNavButton(Vector2 arg)
	{
		view.SetGeneralPointNavButton();
	}

	public void AddSetContourLineOnValueChanged()
	{
		offset = view.mapConfig.contourMaterial.GetVector("_Offset");
		onValueChanged.AddListener(SetContourLine);
	}

	public void RemoveSetContourLineOnValueChanged()
	{
		onValueChanged.RemoveListener(SetContourLine);
	}

	private void SetContourLine(Vector2 arg)
	{
		if (velocity.SqrMagnitude() > 1f)
		{
			offset.z -= velocity.x * view.mapConfig.contourMoveRatio.x;
			offset.w -= velocity.y * view.mapConfig.contourMoveRatio.y;
			view.mapConfig.contourMaterial.SetVector("_Offset", offset);
		}
	}

	public override void OnScroll(PointerEventData data)
	{
		if (view.GetCurSubControllerType() == SubControllerType.main && (!(curScale >= maxScale) || !(data.scrollDelta.y > 0f)) && (!(curScale <= minScale) || !(data.scrollDelta.y < 0f)))
		{
			UpdateTargetScale(data.position, curScale + Mathf.Sign(data.scrollDelta.y) * scaleDelta);
		}
	}

	private int GetActiveTouchCount()
	{
		if (Touchscreen.current == null)
		{
			return 0;
		}
		touchControlList.Clear();
		foreach (TouchControl touch in Touchscreen.current.touches)
		{
			if (touch.isInProgress)
			{
				touchControlList.Add(touch);
			}
		}
		return touchControlList.Count;
	}

	public override void OnBeginDrag(PointerEventData eventData)
	{
		if (!view.HasSelectIcon() && view.GetCurSubControllerType() == SubControllerType.main)
		{
			if (GetActiveTouchCount() >= 2)
			{
				_isTwoFingerDragging = true;
				return;
			}
			movementType = MovementType.Elastic;
			base.OnBeginDrag(eventData);
			_hasCalledBaseBeginDrag = true;
			_beginDragPointerId = eventData.pointerId;
		}
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if (view.HasSelectIcon() || view.GetCurSubControllerType() != SubControllerType.main)
		{
			return;
		}
		if (Touchscreen.current == null)
		{
			base.OnDrag(eventData);
		}
		else if (GetActiveTouchCount() >= 2)
		{
			_isTwoFingerDragging = true;
			if (touchControlList.Count >= 2)
			{
				TouchControl touchControl = touchControlList[0];
				TouchControl touchControl2 = touchControlList[1];
				Vector2 vector = touchControl.position.ReadValue();
				Vector2 vector2 = touchControl2.position.ReadValue();
				float num = Vector2.Distance(vector, vector2);
				Vector2 vector3 = vector - vector2;
				Vector2 center = (vector + vector2) / 2f;
				if (lastTouchVector != Vector2.zero)
				{
					float num2 = num / lastTouchDistance;
					UpdateTargetScale(center, curScale * num2);
				}
				lastTouchDistance = num;
				lastTouchVector = vector3;
			}
		}
		else if (_isTwoFingerDragging)
		{
			ResetDoubleFingerParameter();
			_isTwoFingerDragging = false;
			if (!_hasCalledBaseBeginDrag)
			{
				movementType = MovementType.Elastic;
				base.OnBeginDrag(eventData);
				_hasCalledBaseBeginDrag = true;
				_beginDragPointerId = eventData.pointerId;
			}
		}
		else
		{
			base.OnDrag(eventData);
		}
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		if (view.HasSelectIcon())
		{
			view.UnSelectCurAccurateSelectIcon();
			view.ForceUnSelectCurVagueSelectIcon();
			ResetDoubleFingerParameter();
			if (_hasCalledBaseBeginDrag)
			{
				base.OnEndDrag(eventData);
				_hasCalledBaseBeginDrag = false;
			}
			_beginDragPointerId = -1;
		}
		else
		{
			ResetDoubleFingerParameter();
			if (_hasCalledBaseBeginDrag && eventData.pointerId == _beginDragPointerId)
			{
				base.OnEndDrag(eventData);
				_hasCalledBaseBeginDrag = false;
				_beginDragPointerId = -1;
			}
		}
	}

	public void UpdatePreSlideScale(float value)
	{
		preSlideScale = value;
	}

	public void OnSlide(float value)
	{
		UpdateTargetScale(UIUtility.screenCenter, value);
	}

	public void OnSlideBtn(float afterDeltaValue)
	{
		if (!(afterDeltaValue < minScale) && !(afterDeltaValue > maxScale))
		{
			UpdateTargetScale(UIUtility.screenCenter, afterDeltaValue);
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		try
		{
			if (!_wasTwoFingerOperation)
			{
				GameObject hitObject;
				Vector2 value;
				if (!eventData.dragging && !_wasTwoFingerOperation && view.HasAccurateSelectIcon())
				{
					view.UnSelectCurVagueSelectIcon();
					view.UnSelectCurAccurateSelectIcon();
					view.HideExploreRatioSideBar();
				}
				else if (TryDetectObjectByTag(eventData.position, "Mask", out hitObject) && _pendingClickDownPositions.TryGetValue(eventData.pointerId, out value) && Vector2.Distance(value, eventData.position) <= 10f && !eventData.dragging)
				{
					OnScreenClicked?.Invoke(eventData.position);
					OnScreenClickedWithEventData?.Invoke(eventData);
				}
			}
		}
		finally
		{
			_pendingClickDownPositions.Remove(eventData.pointerId);
			TryResetTwoFingerOperationFlag();
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		_pointerDownPositions[eventData.pointerId] = eventData.position;
		_pendingClickDownPositions.Remove(eventData.pointerId);
		if (GetActiveTouchCount() <= 1)
		{
			ResetDoubleFingerParameter();
			_wasTwoFingerOperation = false;
		}
		else
		{
			_wasTwoFingerOperation = true;
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (_pointerDownPositions.TryGetValue(eventData.pointerId, out var value))
		{
			if (!eventData.dragging)
			{
				_pendingClickDownPositions[eventData.pointerId] = value;
			}
			else
			{
				_pendingClickDownPositions.Remove(eventData.pointerId);
			}
			_pointerDownPositions.Remove(eventData.pointerId);
		}
		if (GetActiveTouchCount() <= 0)
		{
			ResetDoubleFingerParameter();
			TryResetTwoFingerOperationFlag();
		}
	}

	private void SetPivot(Vector2 screenPos)
	{
		Vector3 position = scaleTarget.position;
		Vector2 pivot = scaleTarget.pivot;
		Vector3 vector = default;
		Vector2 vector2 = default;
		Vector2 vector3 = GameUtility.uiCamera.WorldToScreenPoint(scaleTarget.position);
		Vector2 vector4 = screenPos - vector3;
		float num = pivot.x * scaleTarget.rect.width * curScale * -1f;
		float num2 = (1f - pivot.x) * scaleTarget.rect.width * curScale;
		vector4.x = Mathf.Clamp(vector4.x, num, num2);
		vector2.x = Remap(vector4.x, num, num2, 0f, 1f);
		num = pivot.y * scaleTarget.rect.height * curScale * -1f;
		num2 = (1f - pivot.y) * scaleTarget.rect.height * curScale;
		vector4.y = Mathf.Clamp(vector4.y, num, num2);
		vector2.y = Remap(vector4.y, num, num2, 0f, 1f);
		scaleTarget.pivot = vector2;
		vector = position + new Vector3((vector2 - pivot).x * scaleTarget.rect.width * canvasScale * curScale, (vector2 - pivot).y * scaleTarget.rect.height * canvasScale * curScale, 0f);
		scaleTarget.position = vector;
	}

	private float Remap(float x, float t1, float t2, float s1, float s2)
	{
		return (x - t1) / (t2 - t1) * (s2 - s1) + s1;
	}

	private void ResetDoubleFingerParameter()
	{
		lastTouchDistance = 0f;
		lastTouchVector = Vector2.zero;
		lastCenter = Vector2.zero;
		_isTwoFingerDragging = false;
	}

	private void TryResetTwoFingerOperationFlag()
	{
		if (_pointerDownPositions.Count == 0 && _pendingClickDownPositions.Count == 0)
		{
			_wasTwoFingerOperation = false;
		}
	}

	public void RegisterLayerClickHandler(string layerName, Action<GameObject, PointerEventData> handler)
	{
		_layerClickHandlers[layerName] = handler;
	}

	public void RegisterLayerClickHandler(int layerIndex, Action<GameObject, PointerEventData> handler)
	{
		string text = LayerMask.LayerToName(layerIndex);
		if (!string.IsNullOrEmpty(text))
		{
			_layerClickHandlers[text] = handler;
		}
	}

	public void RegisterComponentClickHandler<T>(Action<T, PointerEventData> handler) where T : Component
	{
		_componentClickHandlers[typeof(T)] = (Component component, PointerEventData eventData) =>
		{
			handler((T)component, eventData);
		};
	}

	public void UnregisterLayerClickHandler(string layerName)
	{
		_layerClickHandlers.Remove(layerName);
	}

	public void UnregisterComponentClickHandler<T>() where T : Component
	{
		_componentClickHandlers.Remove(typeof(T));
	}

	public void ClearAllClickHandlers()
	{
		_layerClickHandlers.Clear();
		_componentClickHandlers.Clear();
	}

	public bool DetectClickAndTriggerHandlers(PointerEventData eventData)
	{
		if (_layerClickHandlers.Count == 0 && _componentClickHandlers.Count == 0)
		{
			return false;
		}
		_raycastResults.Clear();
		EventSystemHelper.Shared.RaycastAll(eventData, _raycastResults);
		foreach (RaycastResult raycastResult in _raycastResults)
		{
			GameObject gameObject = raycastResult.gameObject;
			string key = LayerMask.LayerToName(gameObject.layer);
			if (_layerClickHandlers.TryGetValue(key, out var value))
			{
				value?.Invoke(gameObject, eventData);
				return true;
			}
			foreach (KeyValuePair<Type, Action<Component, PointerEventData>> componentClickHandler in _componentClickHandlers)
			{
				Component component = gameObject.GetComponent(componentClickHandler.Key);
				if (component != null)
				{
					componentClickHandler.Value?.Invoke(component, eventData);
					return true;
				}
			}
		}
		return false;
	}

	public List<GameObject> DetectUIAtPosition(Vector2 screenPosition, LayerMask layerMask)
	{
		List<GameObject> list = new List<GameObject>();
		PointerEventData eventData = new PointerEventData(EventSystemHelper.Shared)
		{
			position = screenPosition
		};
		_raycastResults.Clear();
		EventSystemHelper.Shared.RaycastAll(eventData, _raycastResults);
		foreach (RaycastResult raycastResult in _raycastResults)
		{
			if (((1 << raycastResult.gameObject.layer) & (int)layerMask) != 0)
			{
				list.Add(raycastResult.gameObject);
			}
		}
		return list;
	}

	public List<T> DetectComponentAtPosition<T>(Vector2 screenPosition) where T : Component
	{
		List<T> list = new List<T>();
		PointerEventData eventData = new PointerEventData(EventSystemHelper.Shared)
		{
			position = screenPosition
		};
		_raycastResults.Clear();
		EventSystemHelper.Shared.RaycastAll(eventData, _raycastResults);
		foreach (RaycastResult raycastResult in _raycastResults)
		{
			T component = raycastResult.gameObject.GetComponent<T>();
			if (component != null)
			{
				list.Add(component);
			}
		}
		return list;
	}

	public T DetectFirstComponentAtPosition<T>(Vector2 screenPosition) where T : Component
	{
		PointerEventData eventData = new PointerEventData(EventSystemHelper.Shared)
		{
			position = screenPosition
		};
		_raycastResults.Clear();
		EventSystemHelper.Shared.RaycastAll(eventData, _raycastResults);
		foreach (RaycastResult raycastResult in _raycastResults)
		{
			T component = raycastResult.gameObject.GetComponent<T>();
			if (component != null)
			{
				return component;
			}
		}
		return null;
	}

	public bool TryDetectObjectByName(Vector2 screenPosition, string targetName, out GameObject hitObject)
	{
		hitObject = null;
		PointerEventData eventData = new PointerEventData(EventSystemHelper.Shared)
		{
			position = screenPosition
		};
		_raycastResults.Clear();
		EventSystemHelper.Shared.RaycastAll(eventData, _raycastResults);
		foreach (RaycastResult raycastResult in _raycastResults)
		{
			if (raycastResult.gameObject.name == targetName)
			{
				hitObject = raycastResult.gameObject;
				return true;
			}
		}
		return false;
	}

	public bool TryDetectObjectByTag(Vector2 screenPosition, string tag, out GameObject hitObject)
	{
		hitObject = null;
		PointerEventData eventData = new PointerEventData(EventSystemHelper.Shared)
		{
			position = screenPosition
		};
		_raycastResults.Clear();
		EventSystemHelper.Shared.RaycastAll(eventData, _raycastResults);
		foreach (RaycastResult raycastResult in _raycastResults)
		{
			if (raycastResult.gameObject.CompareTag(tag))
			{
				hitObject = raycastResult.gameObject;
				return true;
			}
		}
		return false;
	}
}
