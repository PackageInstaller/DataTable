using System;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI.CommonComponent.FancyScrollView.Scroller;

public class Scroller : UIBehaviour, IPointerUpHandler, IEventSystemHandler, IPointerDownHandler, IBeginDragHandler, IEndDragHandler, IDragHandler, IScrollHandler
{
	[Serializable]
	private class Snap
	{
		public bool Enable;

		public float VelocityThreshold;

		public float Duration;

		public Ease Easing;
	}

	private class AutoScrollState
	{
		public bool Enable;

		public bool Elastic;

		public float Duration;

		public EasingFunction EasingFunction;

		public float StartTime;

		public float EndPosition;

		public Action OnComplete;

		public void Reset()
		{
			Enable = false;
			Elastic = false;
			Duration = 0f;
			StartTime = 0f;
			EasingFunction = DefaultEasingFunction;
			EndPosition = 0f;
			OnComplete = null;
		}

		public void Complete()
		{
			OnComplete?.Invoke();
			Reset();
		}
	}

	[SerializeField]
	private RectTransform viewport;

	[SerializeField]
	private ScrollDirection scrollDirection;

	[SerializeField]
	private MovementType movementType = MovementType.Elastic;

	[SerializeField]
	private float elasticity = 0.1f;

	[SerializeField]
	private float scrollSensitivity = 1f;

	[SerializeField]
	private bool inertia = true;

	[SerializeField]
	private float decelerationRate = 0.03f;

	[SerializeField]
	private Snap snap = new Snap
	{
		Enable = true,
		VelocityThreshold = 0.5f,
		Duration = 0.3f,
		Easing = Ease.InOutCubic
	};

	[SerializeField]
	private bool draggable = true;

	[SerializeField]
	private Scrollbar scrollbar;

	private readonly AutoScrollState autoScrollState = new AutoScrollState();

	private Action onBeginDrag;

	private Action<float> onValueChanged;

	private Action<int> onSelectionChanged;

	private Action onComplete;

	private Vector2 beginDragPointerPosition;

	private float scrollStartPosition;

	private float prevPosition;

	private float currentPosition;

	protected int minIndex;

	protected int totalCount;

	private bool hold;

	private bool scrolling;

	private bool dragging;

	private float velocity;

	private static readonly EasingFunction DefaultEasingFunction = Easing.Get(Ease.OutCubic);

	public float ViewportSize
	{
		get
		{
			if (scrollDirection != ScrollDirection.Horizontal)
			{
				return viewport.rect.size.y;
			}
			return viewport.rect.size.x;
		}
	}

	public ScrollDirection ScrollDirection => scrollDirection;

	public MovementType MovementType
	{
		get
		{
			return movementType;
		}
		set
		{
			movementType = value;
		}
	}

	public float Elasticity
	{
		get
		{
			return elasticity;
		}
		set
		{
			elasticity = value;
		}
	}

	public float ScrollSensitivity
	{
		get
		{
			return scrollSensitivity;
		}
		set
		{
			scrollSensitivity = value;
		}
	}

	public bool Inertia
	{
		get
		{
			return inertia;
		}
		set
		{
			inertia = value;
		}
	}

	public float DecelerationRate
	{
		get
		{
			return decelerationRate;
		}
		set
		{
			decelerationRate = value;
		}
	}

	public bool SnapEnabled
	{
		get
		{
			return snap.Enable;
		}
		set
		{
			snap.Enable = value;
		}
	}

	public bool Draggable
	{
		get
		{
			return draggable;
		}
		set
		{
			draggable = value;
		}
	}

	public Scrollbar Scrollbar => scrollbar;

	public float Position
	{
		get
		{
			return currentPosition;
		}
		set
		{
			autoScrollState.Reset();
			velocity = 0f;
			dragging = false;
			UpdatePosition(value);
		}
	}

	protected override void Start()
	{
		base.Start();
		if ((bool)scrollbar)
		{
			scrollbar.onValueChanged.AddListener((float x) =>
			{
				UpdatePosition(x * ((float)totalCount - 1f), updateScrollbar: false);
			});
		}
	}

	public void OnValueChanged(Action<float> callback)
	{
		onValueChanged = callback;
	}

	public void OnSelectionChanged(Action<int> callback)
	{
		onSelectionChanged = callback;
	}

	public void OnBeginDrag(Action callback)
	{
		onBeginDrag = callback;
	}

	public void OnComplete(Action callback)
	{
		onComplete = callback;
	}

	public void SetTotalCount(int totalCount)
	{
		this.totalCount = totalCount;
	}

	public void SetMinIndex(int minIndex)
	{
		this.minIndex = ((minIndex == totalCount) ? (totalCount - 1) : minIndex);
	}

	public void ScrollTo(float position, float duration, Ease easing)
	{
		ScrollTo(position, duration, Easing.Get(easing), onComplete);
	}

	public virtual void ScrollTo(float position, float duration, EasingFunction easingFunction, Action onComplete = null)
	{
		if (duration <= 0f)
		{
			Position = CircularPosition(position, totalCount);
			onComplete?.Invoke();
			return;
		}
		autoScrollState.Reset();
		autoScrollState.Enable = true;
		autoScrollState.Duration = duration;
		autoScrollState.EasingFunction = easingFunction ?? DefaultEasingFunction;
		autoScrollState.StartTime = Time.unscaledTime;
		autoScrollState.EndPosition = currentPosition + CalculateMovementAmount(currentPosition, position);
		autoScrollState.OnComplete = onComplete;
		velocity = 0f;
		scrollStartPosition = currentPosition;
		UpdateSelection(Mathf.RoundToInt(CircularPosition(autoScrollState.EndPosition, totalCount)));
	}

	public void JumpTo(int index)
	{
		if (index < 0 || index > totalCount - 1)
		{
			throw new ArgumentOutOfRangeException("index");
		}
		UpdateSelection(index);
		Position = index;
	}

	public MovementDirection GetMovementDirection(int sourceIndex, int destIndex)
	{
		float num = CalculateMovementAmount(sourceIndex, destIndex);
		if (scrollDirection != ScrollDirection.Horizontal)
		{
			if (!(num > 0f))
			{
				return MovementDirection.Down;
			}
			return MovementDirection.Up;
		}
		if (!(num > 0f))
		{
			return MovementDirection.Right;
		}
		return MovementDirection.Left;
	}

	void IPointerDownHandler.OnPointerDown(PointerEventData eventData)
	{
		if (draggable && eventData.button == PointerEventData.InputButton.Left)
		{
			hold = true;
			velocity = 0f;
			autoScrollState.Reset();
		}
	}

	void IPointerUpHandler.OnPointerUp(PointerEventData eventData)
	{
		if (draggable && eventData.button == PointerEventData.InputButton.Left)
		{
			if (hold && snap.Enable)
			{
				UpdateSelection(Mathf.RoundToInt(CircularPosition(currentPosition, totalCount)));
				ScrollTo(Mathf.RoundToInt(currentPosition), snap.Duration, snap.Easing);
			}
			hold = false;
		}
	}

	void IScrollHandler.OnScroll(PointerEventData eventData)
	{
		if (draggable)
		{
			Vector2 scrollDelta = eventData.scrollDelta;
			scrollDelta.y *= -1f;
			float num;
			if (scrollDirection != ScrollDirection.Horizontal)
			{
				num = ((Mathf.Abs(scrollDelta.x) > Mathf.Abs(scrollDelta.y)) ? scrollDelta.x : scrollDelta.y);
			}
			else
			{
				num = ((Mathf.Abs(scrollDelta.y) > Mathf.Abs(scrollDelta.x)) ? scrollDelta.y : scrollDelta.x);
			}
			if (eventData.IsScrolling())
			{
				scrolling = true;
			}
			float num2 = currentPosition + num / ViewportSize * scrollSensitivity;
			if (movementType == MovementType.Clamped)
			{
				num2 += CalculateOffset(num2);
			}
			if (autoScrollState.Enable)
			{
				autoScrollState.Reset();
			}
			UpdatePosition(num2);
		}
	}

	void IBeginDragHandler.OnBeginDrag(PointerEventData eventData)
	{
		if (draggable && eventData.button == PointerEventData.InputButton.Left)
		{
			hold = false;
			RectTransformUtility.ScreenPointToLocalPointInRectangle(viewport, eventData.position, eventData.pressEventCamera, out beginDragPointerPosition);
			scrollStartPosition = currentPosition;
			dragging = true;
			autoScrollState.Reset();
			onBeginDrag?.Invoke();
		}
	}

	void IDragHandler.OnDrag(PointerEventData eventData)
	{
		if (draggable && eventData.button == PointerEventData.InputButton.Left && dragging && RectTransformUtility.ScreenPointToLocalPointInRectangle(viewport, eventData.position, eventData.pressEventCamera, out var localPoint))
		{
			Vector2 vector = localPoint - beginDragPointerPosition;
			float num = ((scrollDirection == ScrollDirection.Horizontal) ? (0f - vector.x) : vector.y) / ViewportSize * scrollSensitivity + scrollStartPosition;
			float num2 = CalculateOffset(num);
			num += num2;
			if ((movementType == MovementType.Elastic || movementType == MovementType.ElasticInertia) && num2 != 0f)
			{
				num -= RubberDelta(num2, scrollSensitivity);
			}
			UpdatePosition(num);
		}
	}

	void IEndDragHandler.OnEndDrag(PointerEventData eventData)
	{
		if (draggable && eventData.button == PointerEventData.InputButton.Left)
		{
			dragging = false;
		}
	}

	private float CalculateOffset(float position)
	{
		if (movementType == MovementType.Unrestricted)
		{
			return 0f;
		}
		if (position < 0f)
		{
			return 0f - position;
		}
		if (position > (float)(totalCount - 1))
		{
			return (float)(totalCount - 1) - position;
		}
		return 0f;
	}

	private void UpdatePosition(float position, bool updateScrollbar = true)
	{
		onValueChanged?.Invoke(currentPosition = position);
		if ((bool)scrollbar & updateScrollbar)
		{
			scrollbar.value = Mathf.Clamp01(position / Mathf.Max((float)totalCount - 1f, 0.0001f));
		}
	}

	private void UpdateSelection(int index)
	{
		onSelectionChanged?.Invoke(index);
	}

	private float RubberDelta(float overStretching, float viewSize)
	{
		return (1f - 1f / (Mathf.Abs(overStretching) * 0.55f / viewSize + 1f)) * viewSize * Mathf.Sign(overStretching);
	}

	private void Update()
	{
		UpdateScroller();
	}

	protected virtual void UpdateScroller()
	{
		float unscaledDeltaTime = Time.unscaledDeltaTime;
		float num = CalculateOffset(currentPosition);
		if (autoScrollState.Enable)
		{
			float num2 = 0f;
			if (autoScrollState.Elastic)
			{
				num2 = Mathf.SmoothDamp(currentPosition, currentPosition + num, ref velocity, elasticity, float.PositiveInfinity, unscaledDeltaTime);
				if (Mathf.Abs(velocity) < 0.01f)
				{
					num2 = Mathf.Clamp(Mathf.RoundToInt(num2), minIndex, totalCount - 1);
					velocity = 0f;
					autoScrollState.Complete();
				}
			}
			else
			{
				float num3 = Mathf.Clamp01((Time.unscaledTime - autoScrollState.StartTime) / Mathf.Max(autoScrollState.Duration, float.Epsilon));
				num2 = Mathf.LerpUnclamped(scrollStartPosition, autoScrollState.EndPosition, autoScrollState.EasingFunction(num3));
				if (Mathf.Approximately(num3, 1f))
				{
					autoScrollState.Complete();
				}
			}
			UpdatePosition(num2);
		}
		else if (!dragging && !scrolling && (!Mathf.Approximately(num, 0f) || !Mathf.Approximately(velocity, 0f)))
		{
			float num4 = currentPosition;
			if (movementType == MovementType.Elastic && !Mathf.Approximately(num, 0f))
			{
				autoScrollState.Reset();
				autoScrollState.Enable = true;
				autoScrollState.Elastic = true;
				autoScrollState.OnComplete = onComplete;
				UpdateSelection(Mathf.Clamp(Mathf.RoundToInt(num4), minIndex, totalCount - 1));
			}
			else if (movementType == MovementType.ElasticInertia && !Mathf.Approximately(num, 0f))
			{
				Mathf.SmoothDamp(currentPosition, currentPosition + num, ref velocity, elasticity, float.PositiveInfinity, unscaledDeltaTime);
				if (Mathf.Abs(velocity) < 0.001f)
				{
					velocity = 0f;
				}
				num4 += velocity * unscaledDeltaTime;
				if (snap.Enable && Mathf.Abs(velocity) < snap.VelocityThreshold)
				{
					ScrollTo((num4 < 0f) ? minIndex : (totalCount - 1), snap.Duration, snap.Easing);
				}
			}
			else if (inertia)
			{
				velocity *= Mathf.Pow(decelerationRate, unscaledDeltaTime);
				if (Mathf.Abs(velocity) < 0.001f)
				{
					velocity = 0f;
				}
				num4 += velocity * unscaledDeltaTime;
				if (snap.Enable && Mathf.Abs(velocity) < snap.VelocityThreshold)
				{
					ScrollTo(Mathf.RoundToInt(currentPosition), snap.Duration, snap.Easing);
				}
			}
			else
			{
				velocity = 0f;
			}
			if (!Mathf.Approximately(velocity, 0f))
			{
				if (movementType == MovementType.Clamped)
				{
					num = CalculateOffset(num4);
					num4 += num;
					if (Mathf.Approximately(num4, 0f) || Mathf.Approximately(num4, (float)totalCount - 1f))
					{
						velocity = 0f;
						UpdateSelection(Mathf.RoundToInt(num4));
					}
				}
				UpdatePosition(num4);
			}
		}
		if (!autoScrollState.Enable && (dragging || scrolling) && inertia)
		{
			float b = (currentPosition - prevPosition) / unscaledDeltaTime;
			velocity = Mathf.Lerp(velocity, b, unscaledDeltaTime * 10f);
		}
		prevPosition = currentPosition;
		scrolling = false;
	}

	private float CalculateMovementAmount(float sourcePosition, float destPosition)
	{
		if (movementType != MovementType.Unrestricted)
		{
			return Mathf.Clamp(destPosition, 0f, totalCount - 1) - sourcePosition;
		}
		float num = CircularPosition(destPosition, totalCount) - CircularPosition(sourcePosition, totalCount);
		if (Mathf.Abs(num) > (float)totalCount * 0.5f)
		{
			num = Mathf.Sign(0f - num) * ((float)totalCount - Mathf.Abs(num));
		}
		return num;
	}

	private float CircularPosition(float p, int size)
	{
		if (size >= 1)
		{
			if (!(p < 0f))
			{
				return p % (float)size;
			}
			return (float)(size - 1) + (p + 1f) % (float)size;
		}
		return 0f;
	}
}
