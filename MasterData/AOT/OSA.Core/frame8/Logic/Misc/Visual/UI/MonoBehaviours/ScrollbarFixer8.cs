using System;
using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;
using frame8.Logic.Misc.Other.Extensions;

namespace frame8.Logic.Misc.Visual.UI.MonoBehaviours;

[RequireComponent(typeof(Scrollbar))]
public class ScrollbarFixer8 : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IInitializePotentialDragHandler, IBeginDragHandler, IDragHandler, IPointerUpHandler, IEndDragHandler, IScrollRectProxy
{
	private enum StateEnum
	{
		NONE,
		PRE_DRAGGING,
		DRAGGING
	}

	public bool hideWhenNotNeeded = true;

	public bool autoHide = true;

	[Tooltip("A CanvasGroup will be added to the Scrollbar, if not already present, and the fade effect will be achieved by changing its alpha property")]
	public bool autoHideFadeEffect = true;

	[Tooltip("The collapsing effect will change the localScale of the Scrollbar, so the pivot's position decides in what direction it'll grow/shrink.\n Note that sometimes a really nice effect is achieved by placing the pivot slightly outside the rect (the minimized scrollbar will move outside while collapsing)")]
	public bool autoHideCollapseEffect;

	[Tooltip("Used if autoHide is on. Duration in seconds")]
	public float autoHideTime = 1f;

	public float autoHideFadeEffectMinAlpha = 0.8f;

	public float autoHideCollapseEffectMinScale = 0.2f;

	[Range(0.01f, 1f)]
	public float minSize = 0.1f;

	[Range(0.01f, 1f)]
	[Tooltip("When using elasticity in the ScrollView and pulling the content outside bounds, this value determines how small can the scrollbar get")]
	public float minCompressedSize = 0.01f;

	[Range(0.01f, 1f)]
	public float maxSize = 1f;

	[Range(0.005f, 2f)]
	public float sizeUpdateInterval = 0.01f;

	[Tooltip("Used to prevent updates to be processed too often, in case this is a concern")]
	public int skippedFramesBetweenPositionChanges;

	[Tooltip("Enable this if the Scrollbar has any interractable children objects (Button, Image etc.), \nbecause they'll 'consume' some of the events that this script needs to function properly. \n\nHowever, sometimes you might want to keep this disabled even in the above case, but be \nwarned that we'll be in a slightly invalid state: 'pre-dragging' will start, but will \nnot end on 'pointer up' because the Scrollbar won't ever receive 'on pointer up' in the \nfirst place, it'll be 'consumed' by the respective child. Do your testing as this will \ncan be a problem in some cases")]
	public bool ignoreDragWithoutPointerDown;

	[Tooltip("If not assigned, will try to find a ScrollRect or an IScrollRectProxy in the parent. If viewport is assigned, the search starts from there")]
	public ScrollRect scrollRect;

	[Tooltip("If not assigned, will use the resolved scrollRect")]
	public RectTransform viewport;

	public UnityEvent OnScrollbarSizeChanged;

	private IScrollRectProxy _ExternalScrollRectProxy;

	private const float HIDE_EFFECT_START_DELAY_01 = 0.4f;

	private RectTransform _ScrollViewRT;

	private Scrollbar _Scrollbar;

	private CanvasGroup _CanvasGroupForFadeEffect;

	private bool _HorizontalScrollBar;

	private Vector3 _InitialScale = Vector3.one;

	private bool _Hidden;

	private bool _AutoHidden;

	private bool _HiddenNotNeeded;

	private double _LastValue;

	private float _TimeOnLastValueChange;

	private StateEnum _State;

	private IEnumerator _SlowUpdateCoroutine;

	private float _TransversalScaleOnLastDrag;

	private float _AlphaOnLastDrag;

	private bool _FullyInitialized;

	private int _FrameCountOnLastPositionUpdate;

	private bool _TriedToCallOnScrollbarSizeChangedAtLeastOnce;

	private int? _PrimaryEventID;

	private bool? _PointerDownReceivedForCurrentDrag;

	public IScrollRectProxy externalScrollRectProxy
	{
		get
		{
			return _ExternalScrollRectProxy;
		}
		set
		{
			_ExternalScrollRectProxy = value;
			if (_ExternalScrollRectProxy != null && (bool)scrollRect)
			{
				scrollRect.onValueChanged.RemoveListener(ScrollRect_OnValueChangedCalled);
				scrollRect = null;
			}
		}
	}

	public bool IsInitialized => scrollRect != null;

	public Vector2 Velocity { get; set; }

	public bool IsHorizontal => scrollRect.horizontal;

	public bool IsVertical => scrollRect.vertical;

	public RectTransform Content => scrollRect.content;

	public RectTransform Viewport
	{
		get
		{
			if (!(scrollRect.viewport != null))
			{
				return scrollRect.transform as RectTransform;
			}
			return scrollRect.viewport;
		}
	}

	double IScrollRectProxy.ContentInsetFromViewportStart => Content.GetInsetFromParentEdge(Viewport, ScrollRectProxy.GetStartEdge());

	double IScrollRectProxy.ContentInsetFromViewportEnd => Content.GetInsetFromParentEdge(Viewport, ScrollRectProxy.GetEndEdge());

	public bool IsPreDragging => State == StateEnum.PRE_DRAGGING;

	public bool IsDragging => State == StateEnum.DRAGGING;

	public bool IsDraggingOrPreDragging
	{
		get
		{
			if (!IsDragging)
			{
				return IsPreDragging;
			}
			return true;
		}
	}

	private float Time => UnityEngine.Time.unscaledTime;

	private IScrollRectProxy ScrollRectProxy
	{
		get
		{
			if (externalScrollRectProxy != null)
			{
				return externalScrollRectProxy;
			}
			return this;
		}
	}

	private StateEnum State
	{
		get
		{
			return _State;
		}
		set
		{
			_State = value;
		}
	}

	event Action<double> IScrollRectProxy.ScrollPositionChanged
	{
		add
		{
		}
		remove
		{
		}
	}

	private void Awake()
	{
		if (autoHideTime == 0f)
		{
			autoHideTime = 1f;
		}
		_Scrollbar = GetComponent<Scrollbar>();
		_InitialScale = _Scrollbar.transform.localScale;
		_LastValue = _Scrollbar.value;
		_TimeOnLastValueChange = Time;
		_HorizontalScrollBar = _Scrollbar.direction == Scrollbar.Direction.LeftToRight || _Scrollbar.direction == Scrollbar.Direction.RightToLeft;
		Transform transform = ((viewport == null) ? base.transform.parent : viewport);
		if (externalScrollRectProxy == null && scrollRect == null)
		{
			Transform transform2 = transform;
			while (transform2 != null)
			{
				if (transform2.GetComponent(typeof(IScrollRectProxy)) is IScrollRectProxy scrollRectProxy)
				{
					externalScrollRectProxy = scrollRectProxy;
					break;
				}
				ScrollRect component = transform2.GetComponent<ScrollRect>();
				if (component != null)
				{
					scrollRect = component;
					break;
				}
				transform2 = transform2.parent;
			}
		}
		if ((bool)scrollRect)
		{
			_ScrollViewRT = scrollRect.transform as RectTransform;
			if (_HorizontalScrollBar)
			{
				if (!scrollRect.horizontal)
				{
					throw new UnityException("ScrollbarFixer8: Can't use horizontal scrollbar with non-horizontal scrollRect");
				}
				if ((bool)scrollRect.horizontalScrollbar)
				{
					Debug.Log("ScrollbarFixer8: setting scrollRect.horizontalScrollbar to null (the whole point of using ScrollbarFixer8 is to NOT have any scrollbars assigned)");
					scrollRect.horizontalScrollbar = null;
				}
				if (scrollRect.verticalScrollbar == _Scrollbar)
				{
					Debug.Log("ScrollbarFixer8: Can't use the same scrollbar for both vert and hor");
					scrollRect.verticalScrollbar = null;
				}
			}
			else
			{
				if (!scrollRect.vertical)
				{
					throw new UnityException("Can't use vertical scrollbar with non-vertical scrollRect");
				}
				if ((bool)scrollRect.verticalScrollbar)
				{
					Debug.Log("ScrollbarFixer8: setting scrollRect.verticalScrollbar to null (the whole point of using ScrollbarFixer8 is to NOT have any scrollbars assigned)");
					scrollRect.verticalScrollbar = null;
				}
				if (scrollRect.horizontalScrollbar == _Scrollbar)
				{
					Debug.Log("ScrollbarFixer8: Can't use the same scrollbar for both vert and hor");
					scrollRect.horizontalScrollbar = null;
				}
			}
		}
		if ((bool)scrollRect)
		{
			scrollRect.onValueChanged.AddListener(ScrollRect_OnValueChangedCalled);
			externalScrollRectProxy = scrollRect.GetComponent(typeof(IScrollRectProxy)) as IScrollRectProxy;
		}
		else
		{
			if (externalScrollRectProxy == null)
			{
				externalScrollRectProxy = transform.GetComponentInParent(typeof(IScrollRectProxy)) as IScrollRectProxy;
				if (externalScrollRectProxy == null && (bool)viewport && !(transform == viewport))
				{
					externalScrollRectProxy = viewport.GetComponentInParent(typeof(IScrollRectProxy)) as IScrollRectProxy;
				}
			}
			if (externalScrollRectProxy == null)
			{
				if (enabled)
				{
					Debug.Log(GetType().Name + ": no scrollRect provided and found no " + typeof(IScrollRectProxy).Name + " component among ancestors. Disabling...");
					enabled = false;
				}
				return;
			}
			_ScrollViewRT = externalScrollRectProxy.gameObject.transform as RectTransform;
		}
		if (!viewport)
		{
			viewport = _ScrollViewRT;
		}
		if (autoHide)
		{
			UpdateStartingValuesForAutoHideEffect();
		}
	}

	private void OnEnable()
	{
		ResetPointerEvent();
		_SlowUpdateCoroutine = SlowUpdate();
		StartCoroutine(_SlowUpdateCoroutine);
	}

	private void Update()
	{
		if (!_FullyInitialized)
		{
			InitializeInFirstUpdate();
		}
		if ((bool)scrollRect || (externalScrollRectProxy != null && externalScrollRectProxy.IsInitialized))
		{
			if (State == StateEnum.NONE)
			{
				UpdateOnNoDragging();
			}
			else if (State == StateEnum.PRE_DRAGGING)
			{
				UpdateOnPreDragging();
			}
		}
	}

	private void UpdateOnNoDragging()
	{
		double normalizedPosition = ScrollRectProxy.GetNormalizedPosition();
		_Scrollbar.value = (float)normalizedPosition;
		if (autoHide)
		{
			if (normalizedPosition == _LastValue)
			{
				if (_Hidden)
				{
					return;
				}
				float num = Mathf.Clamp01((Time - _TimeOnLastValueChange) / autoHideTime);
				if (num >= 0.4f)
				{
					float num2 = (num - 0.4f) / 0.6f;
					num2 = num2 * num2 * num2;
					if (CheckForAudoHideFadeEffectAndInitIfNeeded())
					{
						_CanvasGroupForFadeEffect.alpha = Mathf.Lerp(_AlphaOnLastDrag, autoHideFadeEffectMinAlpha, num2);
					}
					if (autoHideCollapseEffect)
					{
						Vector3 localScale = transform.localScale;
						localScale[ScrollRectProxy.IsHorizontal ? 1 : 0] = Mathf.Lerp(_TransversalScaleOnLastDrag, autoHideCollapseEffectMinScale, num2);
						transform.localScale = localScale;
					}
				}
				if (num == 1f)
				{
					_AutoHidden = true;
					Hide();
				}
			}
			else
			{
				_TimeOnLastValueChange = Time;
				_LastValue = normalizedPosition;
				if (_Hidden && !_HiddenNotNeeded)
				{
					Show();
				}
			}
		}
		else if (!hideWhenNotNeeded && _Hidden)
		{
			Show();
		}
	}

	private void UpdateOnPreDragging()
	{
		_ = _PointerDownReceivedForCurrentDrag.Value;
		OnScrollRectValueChanged(fromScrollRect: false);
	}

	private void OnDisable()
	{
		if (_SlowUpdateCoroutine != null)
		{
			StopCoroutine(_SlowUpdateCoroutine);
		}
	}

	private void OnDestroy()
	{
		if ((bool)scrollRect)
		{
			scrollRect.onValueChanged.RemoveListener(ScrollRect_OnValueChangedCalled);
		}
		if (externalScrollRectProxy != null)
		{
			externalScrollRectProxy.ScrollPositionChanged -= ExternalScrollRectProxy_OnScrollPositionChanged;
		}
	}

	private double GetOutsideBoundsAmountRaw()
	{
		if (ScrollRectProxy == null)
		{
			return 0.0;
		}
		double num = 0.0;
		double contentInsetFromViewportStart = ScrollRectProxy.ContentInsetFromViewportStart;
		if (contentInsetFromViewportStart > 0.0)
		{
			num += contentInsetFromViewportStart;
		}
		contentInsetFromViewportStart = ScrollRectProxy.ContentInsetFromViewportEnd;
		if (contentInsetFromViewportStart > 0.0)
		{
			num += contentInsetFromViewportStart;
		}
		return num;
	}

	public void SetNormalizedPosition(double normalizedPosition)
	{
		Debug.Log("SetNormalizedPosition: " + normalizedPosition);
		if (_HorizontalScrollBar)
		{
			scrollRect.horizontalNormalizedPosition = (float)normalizedPosition;
		}
		else
		{
			scrollRect.verticalNormalizedPosition = (float)normalizedPosition;
		}
	}

	public double GetNormalizedPosition()
	{
		return _HorizontalScrollBar ? scrollRect.horizontalNormalizedPosition : scrollRect.verticalNormalizedPosition;
	}

	public double GetContentSize()
	{
		return IsHorizontal ? Content.rect.width : Content.rect.height;
	}

	public double GetViewportSize()
	{
		return IsHorizontal ? Viewport.rect.width : Viewport.rect.height;
	}

	public void StopMovement()
	{
		scrollRect.StopMovement();
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		_PointerDownReceivedForCurrentDrag = true;
	}

	public void OnInitializePotentialDrag(PointerEventData eventData)
	{
		if (State == StateEnum.PRE_DRAGGING)
		{
			if (_PointerDownReceivedForCurrentDrag.Value)
			{
				return;
			}
			if (ignoreDragWithoutPointerDown)
			{
				ResetPointerEvent();
				return;
			}
			ResetPointerEvent();
		}
		if (_PrimaryEventID.HasValue)
		{
			return;
		}
		if (!_PointerDownReceivedForCurrentDrag.HasValue)
		{
			_PointerDownReceivedForCurrentDrag = false;
		}
		if (_PointerDownReceivedForCurrentDrag.Value || !ignoreDragWithoutPointerDown)
		{
			_PrimaryEventID = eventData.pointerId;
			if (externalScrollRectProxy != null && externalScrollRectProxy.IsInitialized)
			{
				externalScrollRectProxy.StopMovement();
			}
			State = StateEnum.PRE_DRAGGING;
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (eventData.pointerId == _PrimaryEventID)
		{
			State = StateEnum.DRAGGING;
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (eventData.pointerId == _PrimaryEventID)
		{
			OnScrollRectValueChanged(fromScrollRect: false);
		}
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		if (eventData.pointerId == _PrimaryEventID)
		{
			FinishDrag();
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (eventData.pointerId == _PrimaryEventID)
		{
			FinishDrag();
		}
	}

	private void FinishDrag()
	{
		if (externalScrollRectProxy != null && externalScrollRectProxy.IsInitialized)
		{
			externalScrollRectProxy.StopMovement();
		}
		ResetPointerEvent();
	}

	private void ResetPointerEvent()
	{
		_PointerDownReceivedForCurrentDrag = null;
		_PrimaryEventID = null;
		State = StateEnum.NONE;
	}

	private void InitializeInFirstUpdate()
	{
		if (externalScrollRectProxy != null)
		{
			externalScrollRectProxy.ScrollPositionChanged += ExternalScrollRectProxy_OnScrollPositionChanged;
		}
		_FullyInitialized = true;
	}

	private IEnumerator SlowUpdate()
	{
		WaitForSecondsRealtime waitAmount = new WaitForSecondsRealtime(sizeUpdateInterval);
		while (true)
		{
			yield return waitAmount;
			if (!enabled)
			{
				break;
			}
			if (!_ScrollViewRT || ((!scrollRect || !scrollRect.content) && (externalScrollRectProxy == null || !externalScrollRectProxy.IsInitialized)))
			{
				continue;
			}
			double contentSize = ScrollRectProxy.GetContentSize();
			double num = ((!_HorizontalScrollBar) ? ((double)viewport.rect.height) : ((double)viewport.rect.width));
			double num2;
			double num3;
			if (contentSize <= 0.0 || contentSize == double.NaN || contentSize == double.Epsilon || contentSize == double.NegativeInfinity || contentSize == double.PositiveInfinity)
			{
				num2 = (num3 = 1.0);
			}
			else
			{
				num2 = num / contentSize;
				double num4 = ClampDouble(num2, minSize, maxSize);
				double num5 = GetOutsideBoundsAmountRaw();
				if (num5 < 0.0)
				{
					num5 = 0.0;
				}
				double t = num5 / num;
				num3 = ((!(minCompressedSize >= minSize)) ? LerpDouble(num4, minCompressedSize, t) : num4);
			}
			float size = _Scrollbar.size;
			_Scrollbar.size = (float)num3;
			float size2 = _Scrollbar.size;
			if (hideWhenNotNeeded)
			{
				if (num2 > 0.99)
				{
					if (!_Hidden)
					{
						_HiddenNotNeeded = true;
						Hide();
					}
				}
				else if (_Hidden && !_AutoHidden)
				{
					Show();
				}
			}
			else if (!autoHide && _Hidden)
			{
				Show();
			}
			if (!_TriedToCallOnScrollbarSizeChangedAtLeastOnce || size != size2)
			{
				_TriedToCallOnScrollbarSizeChangedAtLeastOnce = true;
				if (OnScrollbarSizeChanged != null)
				{
					OnScrollbarSizeChanged.Invoke();
				}
			}
		}
	}

	private void Hide()
	{
		_Hidden = true;
		if (!autoHide || _HiddenNotNeeded)
		{
			gameObject.transform.localScale = Vector3.zero;
		}
	}

	private void Show()
	{
		gameObject.transform.localScale = _InitialScale;
		_HiddenNotNeeded = (_AutoHidden = (_Hidden = false));
		if (CheckForAudoHideFadeEffectAndInitIfNeeded())
		{
			_CanvasGroupForFadeEffect.alpha = 1f;
		}
		UpdateStartingValuesForAutoHideEffect();
	}

	private void UpdateStartingValuesForAutoHideEffect()
	{
		if (CheckForAudoHideFadeEffectAndInitIfNeeded())
		{
			_AlphaOnLastDrag = _CanvasGroupForFadeEffect.alpha;
		}
		if (autoHideCollapseEffect)
		{
			_TransversalScaleOnLastDrag = transform.localScale[ScrollRectProxy.IsHorizontal ? 1 : 0];
		}
	}

	private bool CheckForAudoHideFadeEffectAndInitIfNeeded()
	{
		if (autoHideFadeEffect && !_CanvasGroupForFadeEffect)
		{
			_CanvasGroupForFadeEffect = GetComponent<CanvasGroup>();
			if (!_CanvasGroupForFadeEffect)
			{
				_CanvasGroupForFadeEffect = gameObject.AddComponent<CanvasGroup>();
			}
		}
		return autoHideFadeEffect;
	}

	private void ScrollRect_OnValueChangedCalled(Vector2 _)
	{
		if (externalScrollRectProxy == null)
		{
			OnScrollRectValueChanged(fromScrollRect: true);
		}
	}

	private void ExternalScrollRectProxy_OnScrollPositionChanged(double _)
	{
		OnScrollRectValueChanged(fromScrollRect: true);
	}

	private void OnScrollRectValueChanged(bool fromScrollRect)
	{
		if (!fromScrollRect)
		{
			ScrollRectProxy.StopMovement();
			if (_FrameCountOnLastPositionUpdate + skippedFramesBetweenPositionChanges < UnityEngine.Time.frameCount)
			{
				ScrollRectProxy.SetNormalizedPosition(_Scrollbar.value);
				_FrameCountOnLastPositionUpdate = UnityEngine.Time.frameCount;
			}
		}
		_TimeOnLastValueChange = Time;
		if (autoHide)
		{
			UpdateStartingValuesForAutoHideEffect();
		}
		if (!_HiddenNotNeeded && _Scrollbar.size < 1f)
		{
			Show();
		}
	}

	private double ClampDouble(double t, double min, double max)
	{
		if (t < min)
		{
			return min;
		}
		if (t > max)
		{
			return max;
		}
		return t;
	}

	private double LerpDouble(double a, double b, double t)
	{
		return a * (1.0 - t) + b * t;
	}
}
