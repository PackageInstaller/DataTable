using System;
using System.Collections.Generic;
using ThirdParties.LoopScrollTools.Runtime;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

[DisallowMultipleComponent]
[AddComponentMenu("UI/Loop Scroll Billboard")]
public class LoopScrollBillboard : MonoBehaviour, IInitializePotentialDragHandler, IEventSystemHandler, IBeginDragHandler, IDragHandler, IEndDragHandler
{
	public enum AutoPlayDirection
	{
		Next = 1,
		Previous = -1
	}

	public enum LoopWrapMode
	{
		Instant,
		Scroll
	}

	[SerializeField]
	private LoopScrollRectBase loopScrollRect;

	[SerializeField]
	private ActIndexGroup indexGroup;

	[SerializeField]
	private bool snapEnabled = true;

	[SerializeField]
	[Min(0.01f)]
	private float snapDuration = 0.35f;

	[SerializeField]
	private float snapVelocityThreshold = 500f;

	[SerializeField]
	private bool autoPlay = true;

	[SerializeField]
	[Min(0.1f)]
	private float autoPlayInterval = 3f;

	[SerializeField]
	[Min(0.01f)]
	private float autoPlayDuration = 0.45f;

	[SerializeField]
	private AutoPlayDirection autoPlayDirection = AutoPlayDirection.Next;

	[SerializeField]
	private bool loop = true;

	[SerializeField]
	[Tooltip("无限列表(totalCount < 0)时必填，用于取模和页码点。有限列表可留 0，默认用 totalCount。")]
	private int logicalCount;

	[SerializeField]
	private LoopWrapMode loopWrapMode;

	[SerializeField]
	private UnityEvent<int> onPageChanged = new UnityEvent<int>();

	private readonly Vector3[] _viewportCorners = new Vector3[4];

	private readonly Vector3[] _itemCorners = new Vector3[4];

	private LoopScrollBillboardDragHook _dragHook;

	private LoopScrollAsyncOperation _pendingScroll;

	private bool _shouldForwardDrag;

	private bool _dragging;

	private bool _scrolling;

	private bool _bound;

	private int _currentIndex;

	private int _dragStartIndex;

	private int _lastNotifiedLogicalIndex = int.MinValue;

	private int _indexGroupCount = -1;

	private float _autoPlayTimer;

	public LoopScrollRectBase LoopScrollRect => loopScrollRect;

	public int CurrentIndex => _currentIndex;

	public int LogicalIndex => ToLogicalIndex(_currentIndex);

	public int LogicalCount => GetLogicalCount();

	public bool IsDragging => _dragging;

	public bool IsScrolling => _scrolling;

	public UnityEvent<int> OnPageChanged => onPageChanged;

	private void Awake()
	{
		ResolveLoopScrollRect();
	}

	private void OnEnable()
	{
		ResolveLoopScrollRect();
		BindLoopScrollRect();
		_autoPlayTimer = 0f;
		RefreshCurrentIndexFromView(forceNotify: true);
	}

	private void OnDisable()
	{
		CancelPendingScroll();
		_dragging = false;
		UnbindLoopScrollRect();
	}

	private void OnDestroy()
	{
		UnbindLoopScrollRect();
		ReleaseDragHook();
	}

	private void Update()
	{
		TickAutoPlay();
	}

	public void SetLoopScrollRect(LoopScrollRectBase target)
	{
		if (!(loopScrollRect == target))
		{
			UnbindLoopScrollRect();
			loopScrollRect = target;
			if (isActiveAndEnabled)
			{
				BindLoopScrollRect();
			}
		}
	}

	public void SetLogicalCount(int count)
	{
		logicalCount = Mathf.Max(0, count);
		EnsureIndexGroup();
		NotifyPageChanged(force: true);
	}

	public void SetAutoPlay(bool enabled)
	{
		autoPlay = enabled;
		_autoPlayTimer = 0f;
	}

	public void NotifyDataReady()
	{
		_autoPlayTimer = 0f;
		EnsureIndexGroup();
		RefreshCurrentIndexFromView(forceNotify: true);
	}

	public void PlayNext()
	{
		ScrollBy(1, autoPlayDuration);
	}

	public void PlayPrevious()
	{
		ScrollBy(-1, autoPlayDuration);
	}

	public void ScrollTo(int logicalIndex, bool immediate = false)
	{
		if (CanOperate())
		{
			int num = GetLogicalCount();
			if (num > 0)
			{
				logicalIndex = (loop ? WrapIndex(logicalIndex, num) : Mathf.Clamp(logicalIndex, 0, num - 1));
			}
			int rawIndex = ToRawIndex(logicalIndex);
			ScrollToRawIndex(rawIndex, immediate ? 0f : snapDuration);
		}
	}

	public int WrapLogicalIndex(int rawIndex)
	{
		return ToLogicalIndex(rawIndex);
	}

	public void OnInitializePotentialDrag(PointerEventData eventData)
	{
		if (_shouldForwardDrag && loopScrollRect != null)
		{
			loopScrollRect.OnInitializePotentialDrag(eventData);
		}
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (_shouldForwardDrag && loopScrollRect != null)
		{
			loopScrollRect.OnBeginDrag(eventData);
		}
		NotifyBeginDrag();
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (_shouldForwardDrag && loopScrollRect != null)
		{
			loopScrollRect.OnDrag(eventData);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (_shouldForwardDrag && loopScrollRect != null)
		{
			loopScrollRect.OnEndDrag(eventData);
		}
		NotifyEndDrag();
	}

	internal void NotifyBeginDrag()
	{
		if (CanOperate() && !_dragging && snapEnabled)
		{
			_dragging = true;
			_autoPlayTimer = 0f;
			CancelPendingScroll();
			RefreshCurrentIndexFromView(forceNotify: false);
			_dragStartIndex = _currentIndex;
		}
	}

	internal void NotifyEndDrag()
	{
		if (_dragging)
		{
			_dragging = false;
			_autoPlayTimer = 0f;
			if (snapEnabled)
			{
				SnapAfterDrag();
			}
			else
			{
				RefreshCurrentIndexFromView(forceNotify: false);
			}
		}
	}

	private void SnapAfterDrag()
	{
		if (!CanOperate())
		{
			return;
		}
		Vector2 velocity = loopScrollRect.velocity;
		loopScrollRect.StopMovement();
		if (TryGetNearestIndex(out var index))
		{
			int rawIndex = index;
			float velocityTowardNext = GetVelocityTowardNext(velocity);
			if (Mathf.Abs(velocityTowardNext) >= snapVelocityThreshold && index == _dragStartIndex)
			{
				rawIndex = _dragStartIndex + ((velocityTowardNext > 0f) ? 1 : (-1));
			}
			ScrollToRawIndex(rawIndex, snapDuration);
		}
	}

	private void TickAutoPlay()
	{
		if (autoPlay && !_dragging && !_scrolling && CanOperate() && CanPageTurn())
		{
			_autoPlayTimer += Time.unscaledDeltaTime;
			if (!(_autoPlayTimer < autoPlayInterval))
			{
				_autoPlayTimer = 0f;
				ScrollBy((autoPlayDirection == AutoPlayDirection.Next) ? 1 : (-1), autoPlayDuration);
			}
		}
	}

	private void ScrollBy(int step, float duration)
	{
		if (CanOperate() && step != 0)
		{
			int num = _currentIndex + step;
			if (loop || loopScrollRect.totalCount < 0 || (num >= 0 && num < loopScrollRect.totalCount))
			{
				ScrollToRawIndex(num, duration);
			}
		}
	}

	private void ScrollToRawIndex(int rawIndex, float duration)
	{
		if (!CanOperate())
		{
			return;
		}
		int scrollItemCount = GetScrollItemCount();
		bool flag = loopScrollRect.totalCount < 0;
		bool flag2 = false;
		if (!flag)
		{
			if (scrollItemCount <= 0)
			{
				return;
			}
			if (loop && scrollItemCount > 1)
			{
				int num = WrapIndex(rawIndex, scrollItemCount);
				flag2 = num != rawIndex;
				rawIndex = num;
			}
			else
			{
				rawIndex = Mathf.Clamp(rawIndex, 0, scrollItemCount - 1);
			}
		}
		CancelPendingScroll();
		if ((!flag & flag2) && loopWrapMode == LoopWrapMode.Instant)
		{
			loopScrollRect.StopMovement();
			loopScrollRect.RefillCells(rawIndex);
			_currentIndex = rawIndex;
			_scrolling = false;
			NotifyPageChanged(force: false);
			return;
		}
		if (duration <= 0f)
		{
			loopScrollRect.StopMovement();
			loopScrollRect.RefillCells(rawIndex);
			_currentIndex = rawIndex;
			_scrolling = false;
			NotifyPageChanged(force: false);
			return;
		}
		_scrolling = true;
		_currentIndex = rawIndex;
		NotifyPageChanged(force: false);
		_pendingScroll = loopScrollRect.ScrollToCellWithinTime(rawIndex, duration);
		if (_pendingScroll == null)
		{
			_scrolling = false;
			RefreshCurrentIndexFromView(forceNotify: false);
		}
		else
		{
			LoopScrollAsyncOperation pendingScroll = _pendingScroll;
			pendingScroll.Complete = (Action<LoopScrollAsyncOperation>)Delegate.Combine(pendingScroll.Complete, new Action<LoopScrollAsyncOperation>(OnScrollComplete));
		}
	}

	private void OnScrollComplete(LoopScrollAsyncOperation operation)
	{
		if (_pendingScroll == operation)
		{
			_pendingScroll = null;
		}
		if (operation != null)
		{
			operation.Complete = (Action<LoopScrollAsyncOperation>)Delegate.Remove(operation.Complete, new Action<LoopScrollAsyncOperation>(OnScrollComplete));
		}
		_scrolling = false;
		_autoPlayTimer = 0f;
		RefreshCurrentIndexFromView(forceNotify: false);
	}

	private void CancelPendingScroll()
	{
		if (_pendingScroll != null)
		{
			LoopScrollAsyncOperation pendingScroll = _pendingScroll;
			pendingScroll.Complete = (Action<LoopScrollAsyncOperation>)Delegate.Remove(pendingScroll.Complete, new Action<LoopScrollAsyncOperation>(OnScrollComplete));
			_pendingScroll = null;
		}
		_scrolling = false;
		if (loopScrollRect != null)
		{
			loopScrollRect.StopAllCoroutines();
			loopScrollRect.StopMovement();
		}
	}

	private void RefreshCurrentIndexFromView(bool forceNotify)
	{
		if (TryGetNearestIndex(out var index))
		{
			_currentIndex = index;
		}
		NotifyPageChanged(forceNotify);
	}

	private bool TryGetNearestIndex(out int index)
	{
		index = _currentIndex;
		if (loopScrollRect == null)
		{
			return false;
		}
		IReadOnlyList<RectTransform> children = loopScrollRect.Children;
		if (children == null || children.Count == 0)
		{
			return false;
		}
		RectTransform viewport = GetViewport();
		if (viewport == null)
		{
			return false;
		}
		viewport.GetWorldCorners(_viewportCorners);
		Vector3 vector = (_viewportCorners[0] + _viewportCorners[2]) * 0.5f;
		bool flag = loopScrollRect.Direction == LoopScrollRectBase.LoopScrollRectDirection.Horizontal;
		float num = float.MaxValue;
		bool result = false;
		for (int i = 0; i < children.Count; i++)
		{
			RectTransform rectTransform = children[i];
			if (!(rectTransform == null) && rectTransform.gameObject.activeInHierarchy)
			{
				rectTransform.GetWorldCorners(_itemCorners);
				Vector3 vector2 = (_itemCorners[0] + _itemCorners[2]) * 0.5f;
				float num2 = (flag ? (vector2.x - vector.x) : (vector2.y - vector.y));
				float num3 = num2 * num2;
				if (!(num3 >= num))
				{
					num = num3;
					index = rectTransform.GetComponent<ILoopScrollDataSource>()?.GetIndex() ?? (loopScrollRect.ItemIndexStart + i);
					result = true;
				}
			}
		}
		return result;
	}

	private float GetVelocityTowardNext(Vector2 velocity)
	{
		float num = ((loopScrollRect.Direction == LoopScrollRectBase.LoopScrollRectDirection.Horizontal) ? (0f - velocity.x) : velocity.y);
		if (loopScrollRect.reverseDirection)
		{
			num = 0f - num;
		}
		return num;
	}

	private int ToLogicalIndex(int rawIndex)
	{
		int num = GetLogicalCount();
		if (num <= 0)
		{
			return rawIndex;
		}
		return WrapIndex(rawIndex, num);
	}

	private int ToRawIndex(int logicalIndex)
	{
		int num = GetLogicalCount();
		if (num <= 0)
		{
			return logicalIndex;
		}
		int num2 = ToLogicalIndex(_currentIndex);
		int num3 = logicalIndex - num2;
		if (loop && num > 1)
		{
			if (num3 > num / 2)
			{
				num3 -= num;
			}
			else if (num3 < -num / 2)
			{
				num3 += num;
			}
		}
		return _currentIndex + num3;
	}

	private int GetLogicalCount()
	{
		if (logicalCount > 0)
		{
			return logicalCount;
		}
		if (loopScrollRect != null && loopScrollRect.totalCount > 0)
		{
			return loopScrollRect.totalCount;
		}
		return 0;
	}

	private int GetScrollItemCount()
	{
		if (loopScrollRect == null)
		{
			return 0;
		}
		if (loopScrollRect.totalCount >= 0)
		{
			return loopScrollRect.totalCount;
		}
		return GetLogicalCount();
	}

	private static int WrapIndex(int index, int count)
	{
		if (count <= 0)
		{
			return 0;
		}
		int num = index % count;
		if (num >= 0)
		{
			return num;
		}
		return num + count;
	}

	private RectTransform GetViewport()
	{
		if (loopScrollRect == null)
		{
			return null;
		}
		if (loopScrollRect.viewport != null)
		{
			return loopScrollRect.viewport;
		}
		return loopScrollRect.transform as RectTransform;
	}

	private bool CanOperate()
	{
		if (isActiveAndEnabled && loopScrollRect != null)
		{
			return loopScrollRect.IsActive();
		}
		return false;
	}

	private bool CanPageTurn()
	{
		if (GetLogicalCount() > 1)
		{
			return true;
		}
		if (loop && loopScrollRect != null)
		{
			return loopScrollRect.totalCount < 0;
		}
		return false;
	}

	private void EnsureIndexGroup()
	{
		if (!(indexGroup == null))
		{
			int num = GetLogicalCount();
			if (num > 0 && num != _indexGroupCount)
			{
				indexGroup.Init(num);
				_indexGroupCount = num;
			}
		}
	}

	private void NotifyPageChanged(bool force)
	{
		EnsureIndexGroup();
		int num = ToLogicalIndex(_currentIndex);
		if (force || num != _lastNotifiedLogicalIndex)
		{
			_lastNotifiedLogicalIndex = num;
			if (indexGroup != null && GetLogicalCount() > 0)
			{
				indexGroup.SetToIndex(num);
			}
			onPageChanged?.Invoke(num);
		}
	}

	private void ResolveLoopScrollRect()
	{
		if (!(loopScrollRect != null))
		{
			loopScrollRect = GetComponent<LoopScrollRectBase>();
			if (loopScrollRect == null)
			{
				loopScrollRect = GetComponentInChildren<LoopScrollRectBase>(includeInactive: true);
			}
			if (loopScrollRect == null)
			{
				loopScrollRect = GetComponentInParent<LoopScrollRectBase>();
			}
		}
	}

	private void BindLoopScrollRect()
	{
		if (!(loopScrollRect == null) && !_bound)
		{
			loopScrollRect.onValueChanged.AddListener(OnScrollValueChanged);
			_bound = true;
			SetupDragRoute();
			EnsureIndexGroup();
		}
	}

	private void UnbindLoopScrollRect()
	{
		if (_bound)
		{
			if (loopScrollRect != null)
			{
				loopScrollRect.onValueChanged.RemoveListener(OnScrollValueChanged);
			}
			_bound = false;
		}
	}

	private void OnScrollValueChanged(Vector2 _)
	{
		if (!_scrolling)
		{
			RefreshCurrentIndexFromView(forceNotify: false);
		}
	}

	private void SetupDragRoute()
	{
		bool flag = loopScrollRect.gameObject == gameObject;
		if (flag | (_shouldForwardDrag = !flag && transform.IsChildOf(loopScrollRect.transform)))
		{
			ReleaseDragHook();
		}
		else
		{
			EnsureDragHook();
		}
	}

	private void EnsureDragHook()
	{
		if (!(loopScrollRect == null))
		{
			_dragHook = loopScrollRect.GetComponent<LoopScrollBillboardDragHook>();
			if (_dragHook == null)
			{
				_dragHook = loopScrollRect.gameObject.AddComponent<LoopScrollBillboardDragHook>();
			}
			_dragHook.Bind(this);
		}
	}

	private void ReleaseDragHook()
	{
		if (!(_dragHook == null))
		{
			_dragHook.Bind(null);
			if (_dragHook != null)
			{
				UnityEngine.Object.Destroy(_dragHook);
			}
			_dragHook = null;
		}
	}
}
