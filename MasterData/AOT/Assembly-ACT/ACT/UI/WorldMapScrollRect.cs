using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.Controls;
using UnityEngine.UI;

namespace ACT.UI;

public class WorldMapScrollRect : ScrollRect, IPointerClickHandler, IEventSystemHandler, IPointerDownHandler, IPointerUpHandler
{
	[Header("缩放配置")]
	[Tooltip("最小缩放比例")]
	public float minScale = 0.5f;

	[Tooltip("最大缩放比例")]
	public float maxScale = 1.2f;

	[Tooltip("最大缩放比例")]
	public float defaultScale = 0.8f;

	[Tooltip("每次滚轮缩放的增量")]
	public float scaleDelta = 0.1f;

	[Tooltip("缩放动画平滑度")]
	public float scaleSmooth = 10f;

	[Header("拖动配置")]
	[Tooltip("拖动边界弹性")]
	public float dragElasticity = 0.1f;

	[Tooltip("拖动惯性减速率")]
	public float dragDecelerationRate = 0.135f;

	public WorldMapScaleSlider worldMapScaleSlider;

	public RedDotItem redDotItem;

	private RectTransform _scaleTarget;

	private float _canvasScale;

	private float _targetScale;

	private bool _isScaling;

	private bool _isSliding;

	private float _preSlideScale;

	private bool _isDrag;

	private bool _baseDragActive;

	private bool _needRebaseDrag;

	private Vector2 _lastTouchVector;

	private float _lastTouchDistance;

	private List<TouchControl> _touchControlList = new List<TouchControl>(2);

	private float CurScale
	{
		get
		{
			if (!(_scaleTarget != null))
			{
				return 1f;
			}
			return _scaleTarget.localScale.x;
		}
	}

	public event Action<float> OnScaleChanged;

	public event Action<Vector2> OnClicked;

	public event Action<PointerEventData> OnClickedWithEventData;

	protected override void Awake()
	{
		base.Awake();
		_scaleTarget = content;
	}

	protected override void Start()
	{
		base.Start();
		elasticity = dragElasticity;
		decelerationRate = dragDecelerationRate;
		if (GameUtility.uiCanvas != null)
		{
			_canvasScale = GameUtility.uiCanvas.GetComponent<RectTransform>().localScale.x;
		}
		else
		{
			_canvasScale = 1f;
		}
		_targetScale = CurScale;
	}

	protected virtual void Update()
	{
		if (_isScaling && !Mathf.Approximately(CurScale, _targetScale))
		{
			float num = Mathf.Lerp(CurScale, _targetScale, Time.deltaTime * scaleSmooth);
			ApplyScaleInternal(num);
			if (Mathf.Approximately(num, _targetScale))
			{
				_isScaling = false;
			}
		}
	}

	public void Init()
	{
		_scaleTarget = content;
		if (GameUtility.uiCanvas != null)
		{
			_canvasScale = GameUtility.uiCanvas.GetComponent<RectTransform>().localScale.x;
		}
		ResetToDefault();
		movementType = MovementType.Clamped;
		worldMapScaleSlider.Init(minScale, maxScale, defaultScale, scaleDelta);
		string text = string.Format(RedDotPathDefine.Map);
		redDotItem.redDotType = RedDotType.Dot;
		redDotItem.fullPath = text.Split("|").ToList();
		redDotItem.displayAction = new WorldMapExploreRewardOnTab();
		redDotItem.BindTrieNode();
		redDotItem.UpdateDisplay();
	}

	public void Init(float minScaleValue, float maxScaleValue, float scaleDeltaValue)
	{
		minScale = minScaleValue;
		maxScale = maxScaleValue;
		scaleDelta = scaleDeltaValue;
		Init();
	}

	public void UnInit()
	{
		ResetDoubleFingerParameter();
		_baseDragActive = false;
		_needRebaseDrag = false;
		worldMapScaleSlider.UnInit();
		_isScaling = false;
	}

	public void SetScale(float scale)
	{
		scale = Mathf.Clamp(scale, minScale, maxScale);
		_targetScale = scale;
		ApplyScaleInternal(scale);
	}

	public void SetScaleSmooth(float scale)
	{
		scale = Mathf.Clamp(scale, minScale, maxScale);
		_targetScale = scale;
		_isScaling = true;
	}

	public float GetCurrentScale()
	{
		return CurScale;
	}

	public void ResetToDefault()
	{
		SetScale(defaultScale);
		normalizedPosition = new Vector2(0.5f, 0.5f);
	}

	public void FocusToPosition(Vector2 normalizedPos)
	{
		normalizedPosition = normalizedPos;
	}

	public void SetIsSliding(bool val)
	{
		_isSliding = val;
	}

	public void UpdatePreSlideScale(float value)
	{
		_preSlideScale = value;
	}

	public void OnSlide(float value)
	{
		UpdateTargetScale(UIUtility.screenCenter, value);
	}

	public void OnSlideBtn(float afterDeltaValue)
	{
		UpdateTargetScale(UIUtility.screenCenter, afterDeltaValue);
	}

	public void OnScaleUpdate(float beforeVal, float afterVal)
	{
	}

	public void UpdateTargetScale(Vector2 center, float targetScale, bool immediate = true)
	{
		targetScale = Mathf.Clamp(targetScale, minScale, maxScale);
		if (!Mathf.Approximately(targetScale, CurScale))
		{
			if (immediate)
			{
				ApplyScaleAtPoint(center, targetScale);
			}
			else
			{
				_targetScale = targetScale;
				_isScaling = true;
			}
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Map/Slider");
		}
	}

	private void ApplyScaleAtPoint(Vector2 screenPoint, float newScale)
	{
		if (!(_scaleTarget == null) && !(viewRect == null) && !Mathf.Approximately(CurScale, 0f))
		{
			Camera cam = null;
			Canvas componentInParent = GetComponentInParent<Canvas>();
			if (componentInParent != null && componentInParent.renderMode != RenderMode.ScreenSpaceOverlay)
			{
				cam = componentInParent.worldCamera ?? GameUtility.uiCamera;
			}
			if (RectTransformUtility.ScreenPointToLocalPointInRectangle(_scaleTarget, screenPoint, cam, out var localPoint))
			{
				Vector3 vector = _scaleTarget.TransformPoint(localPoint);
				_scaleTarget.localScale = Vector3.one * newScale;
				Vector3 vector2 = _scaleTarget.TransformPoint(localPoint);
				_scaleTarget.position += vector - vector2;
				UpdateBounds();
				ClampContentToBounds();
				OnScaleChanged?.Invoke(newScale);
			}
		}
	}

	private void ApplyScaleInternal(float newScale)
	{
		if (!(_scaleTarget == null))
		{
			_scaleTarget.localScale = Vector3.one * newScale;
			UpdateBounds();
			ClampContentToBounds();
			OnScaleChanged?.Invoke(newScale);
		}
	}

	private void ClampContentToBounds()
	{
		if (!(content == null))
		{
			UpdateBounds();
			Vector2 vector = normalizedPosition;
			if (horizontal)
			{
				vector.x = Mathf.Clamp01(vector.x);
			}
			if (vertical)
			{
				vector.y = Mathf.Clamp01(vector.y);
			}
			normalizedPosition = vector;
			UpdateBounds();
		}
	}

	public override void OnScroll(PointerEventData data)
	{
		if ((!(CurScale >= maxScale) || !(data.scrollDelta.y > 0f)) && (!(CurScale <= minScale) || !(data.scrollDelta.y < 0f)))
		{
			if (_isDrag && _baseDragActive)
			{
				base.OnEndDrag(data);
				_baseDragActive = false;
				_needRebaseDrag = true;
				velocity = Vector2.zero;
			}
			float targetScale = CurScale + Mathf.Sign(data.scrollDelta.y) * scaleDelta;
			UpdateTargetScale(data.position, targetScale);
		}
	}

	public override void OnBeginDrag(PointerEventData eventData)
	{
		base.OnBeginDrag(eventData);
		_isDrag = true;
		_baseDragActive = true;
		_needRebaseDrag = false;
	}

	public override void OnDrag(PointerEventData eventData)
	{
		if (_needRebaseDrag)
		{
			base.OnBeginDrag(eventData);
			_baseDragActive = true;
			_needRebaseDrag = false;
		}
		if (Touchscreen.current == null)
		{
			base.OnDrag(eventData);
			return;
		}
		_touchControlList.Clear();
		foreach (TouchControl touch in Touchscreen.current.touches)
		{
			if (touch.isInProgress)
			{
				_touchControlList.Add(touch);
			}
		}
		if (_touchControlList.Count <= 1)
		{
			base.OnDrag(eventData);
		}
		else if (_touchControlList.Count == 2)
		{
			HandlePinchZoom();
		}
	}

	private void HandlePinchZoom()
	{
		TouchControl touchControl = _touchControlList[0];
		TouchControl touchControl2 = _touchControlList[1];
		Vector2 vector = touchControl.position.ReadValue();
		Vector2 vector2 = touchControl2.position.ReadValue();
		float num = Vector2.Distance(vector, vector2);
		Vector2 lastTouchVector = vector - vector2;
		_ = (vector + vector2) / 2f;
		if (_lastTouchVector != Vector2.zero && _lastTouchDistance > 0f)
		{
			float num2 = num / _lastTouchDistance;
			UpdateTargetScale(UIUtility.screenCenter, CurScale * num2);
		}
		_lastTouchDistance = num;
		_lastTouchVector = lastTouchVector;
	}

	public override void OnEndDrag(PointerEventData eventData)
	{
		ResetDoubleFingerParameter();
		if (_baseDragActive)
		{
			base.OnEndDrag(eventData);
		}
		_baseDragActive = false;
		_needRebaseDrag = false;
	}

	private void ResetDoubleFingerParameter()
	{
		_lastTouchDistance = 0f;
		_isDrag = false;
		_lastTouchVector = Vector2.zero;
	}

	public void OnPointerClick(PointerEventData eventData)
	{
	}

	public void OnPointerDown(PointerEventData eventData)
	{
	}

	public void OnPointerUp(PointerEventData eventData)
	{
	}
}
