using System;
using UnityEngine;
using UnityEngine.UI;
using frame8.Logic.Misc.Visual.UI;
using frame8.Logic.Misc.Visual.UI.MonoBehaviours;

namespace Com.ForbiddenByte.OSA.Core;

public class Snapper8 : MonoBehaviour
{
	public float snapWhenSpeedFallsBelow = 50f;

	public float viewportSnapPivot01 = 0.5f;

	public float itemSnapPivot01 = 0.5f;

	public float snapDuration = 0.3f;

	public float snapAllowedError = 1f;

	public Scrollbar scrollbar;

	[Tooltip("If the current drag distance is not enough to change the currently centered item, snapping to the next item will still occur if the current speed is bigger than this. Set to a negative value to disable (default). This was initially useful for things like page views")]
	public float minSpeedToAllowSnapToNext = -1f;

	public bool skipIfReachedExtremity = true;

	private int _lastPassedCellIndex = -1;

	private double CurrnetSelectdouble;

	private IOSA _Adapter;

	private ScrollbarFixer8 _ScrollbarFixer;

	private bool _SnappingDoneAndEndSnappingEventPending;

	private bool _SnapNeeded;

	private bool _SnappingCancelled;

	private Func<float> _GetSignedAbstractSpeed;

	private int _LastSnappedItemIndex = -1;

	private bool _SnapToNextOnlyEnabled;

	private bool _StartCalled;

	private Canvas _Canvas;

	private RectTransform _CanvasRT;

	private bool _TriedToGetCanvasAtLeastOnce;

	private int _LastItemIndexUnFinishedSnap = -1;

	public IOSA Adapter
	{
		set
		{
			if (_Adapter != value)
			{
				if (_Adapter != null)
				{
					_Adapter.ScrollPositionChanged -= OnScrolled;
					_Adapter.ItemsRefreshed -= OnItemsRefreshed;
				}
				_Adapter = value;
				if (_Adapter != null)
				{
					_Adapter.ScrollPositionChanged += OnScrolled;
					_Adapter.ItemsRefreshed += OnItemsRefreshed;
				}
			}
		}
	}

	public bool SnappingInProgress { get; private set; }

	private bool IsAdapterDragInProgress
	{
		get
		{
			if (_Adapter != null)
			{
				return _Adapter.IsDragging;
			}
			return false;
		}
	}

	private bool IsScrollbarDragInProgress
	{
		get
		{
			if (_ScrollbarFixer != null)
			{
				return _ScrollbarFixer.IsDraggingOrPreDragging;
			}
			return false;
		}
	}

	public event Action SnappingStarted;

	public event Action SnappingEndedOrCancelled;

	public event Action<int> OnPassingCell;

	public event Action<int> OnDrag;

	private void Start()
	{
		if (minSpeedToAllowSnapToNext < 0f)
		{
			minSpeedToAllowSnapToNext = float.MaxValue;
		}
		_SnapToNextOnlyEnabled = minSpeedToAllowSnapToNext != float.MaxValue;
		if ((bool)scrollbar)
		{
			_ScrollbarFixer = scrollbar.GetComponent<ScrollbarFixer8>();
			if (!_ScrollbarFixer)
			{
				throw new OSAException("ScrollbarFixer8 should be attached to Scrollbar");
			}
		}
		if ((bool)scrollbar)
		{
			scrollbar.onValueChanged.AddListener(OnScrollbarValueChanged);
		}
		_StartCalled = true;
	}

	private void OnDisable()
	{
		CancelSnappingIfInProgress();
	}

	private void OnDestroy()
	{
		if ((bool)scrollbar)
		{
			scrollbar.onValueChanged.RemoveListener(OnScrollbarValueChanged);
		}
		Adapter = null;
		SnappingStarted = null;
		SnappingEndedOrCancelled = null;
	}

	internal void CancelSnappingIfInProgress()
	{
		_SnappingDoneAndEndSnappingEventPending = false;
		_SnapNeeded = false;
		if (SnappingInProgress)
		{
			_SnappingCancelled = true;
			SnappingInProgress = false;
		}
	}

	internal void StartSnappingIfNeeded()
	{
		if (!_StartCalled || !enabled)
		{
			return;
		}
		if (_SnappingDoneAndEndSnappingEventPending)
		{
			OnSnappingEndedOrCancelled();
		}
		else
		{
			if (_Adapter == null || !_Adapter.IsInitialized)
			{
				return;
			}
			if (_GetSignedAbstractSpeed == null)
			{
				if (_Adapter.BaseParameters.IsHorizontal)
				{
					_GetSignedAbstractSpeed = () => _Adapter.Velocity[0];
				}
				else
				{
					_GetSignedAbstractSpeed = () => 0f - _Adapter.Velocity[1];
				}
			}
			float num = _GetSignedAbstractSpeed();
			float num2 = Mathf.Abs(num);
			if (SnappingInProgress || !_SnapNeeded || num2 >= snapWhenSpeedFallsBelow || IsAdapterDragInProgress || IsScrollbarDragInProgress)
			{
				return;
			}
			if (skipIfReachedExtremity)
			{
				double num3 = Mathf.Clamp(snapAllowedError, 1f, 20f);
				if (Math.Abs(Math.Max(_Adapter.ContentVirtualInsetFromViewportStart, _Adapter.ContentVirtualInsetFromViewportEnd)) <= num3)
				{
					return;
				}
			}
			AbstractViewsHolder middleVH = GetMiddleVH(out var distanceToTarget);
			if (middleVH == null)
			{
				return;
			}
			_SnapNeeded = false;
			if (distanceToTarget <= snapAllowedError)
			{
				return;
			}
			int indexToSnapTo = middleVH.ItemIndex;
			if (num2 >= minSpeedToAllowSnapToNext && (indexToSnapTo == _LastSnappedItemIndex || _LastSnappedItemIndex == -1 || _LastItemIndexUnFinishedSnap == indexToSnapTo))
			{
				bool flag = _Adapter.BaseParameters.effects.LoopItems && _Adapter.GetContentSizeToViewportRatio() > 1.0;
				int itemsCount = _Adapter.GetItemsCount();
				if (num < 0f)
				{
					if (indexToSnapTo == itemsCount - 1 && !flag)
					{
						return;
					}
					indexToSnapTo = (indexToSnapTo + 1) % itemsCount;
				}
				else
				{
					if (indexToSnapTo == 0 && !flag)
					{
						return;
					}
					indexToSnapTo = (indexToSnapTo + itemsCount - 1) % itemsCount;
				}
			}
			else
			{
				indexToSnapTo = middleVH.ItemIndex;
			}
			_SnappingCancelled = false;
			bool cancelledOrEnded = false;
			bool doneNaturally = false;
			_LastItemIndexUnFinishedSnap = indexToSnapTo;
			bool continuteAnimation;
			_Adapter.SmoothScrollTo(indexToSnapTo, snapDuration, viewportSnapPivot01, itemSnapPivot01, (float progress) =>
			{
				continuteAnimation = true;
				doneNaturally = progress == 1f;
				if (doneNaturally || _SnappingCancelled || IsAdapterDragInProgress || IsScrollbarDragInProgress)
				{
					cancelledOrEnded = true;
					continuteAnimation = false;
					if (SnappingInProgress)
					{
						_LastSnappedItemIndex = indexToSnapTo;
						SnappingInProgress = false;
						_SnappingDoneAndEndSnappingEventPending = true;
						if (doneNaturally)
						{
							_LastItemIndexUnFinishedSnap = -1;
						}
					}
				}
				return continuteAnimation;
			}, null, overrideCurrentScrollingAnimation: true);
			if (cancelledOrEnded)
			{
				if (doneNaturally)
				{
					_LastItemIndexUnFinishedSnap = -1;
				}
				return;
			}
			SnappingInProgress = true;
			if (SnappingInProgress)
			{
				OnSnappingStarted();
			}
		}
	}

	private Canvas FindOrGetCanvas()
	{
		if (_TriedToGetCanvasAtLeastOnce)
		{
			return _Canvas;
		}
		_TriedToGetCanvasAtLeastOnce = true;
		return _Canvas = GetComponentInParent<Canvas>();
	}

	private RectTransform FindOrGetCanvasRT()
	{
		if (_TriedToGetCanvasAtLeastOnce)
		{
			return _CanvasRT;
		}
		_TriedToGetCanvasAtLeastOnce = true;
		return _CanvasRT = FindOrGetCanvas().transform as RectTransform;
	}

	public AbstractViewsHolder GetMiddleVH(out float distanceToTarget)
	{
		return _Adapter.GetViewsHolderClosestToViewportLongitudinalNormalizedAbstractPoint(FindOrGetCanvas(), FindOrGetCanvasRT(), viewportSnapPivot01, itemSnapPivot01, out distanceToTarget);
	}

	private void OnScrolled(double scrollPos)
	{
		if (!SnappingInProgress)
		{
			_SnapNeeded = true;
			if (_SnapToNextOnlyEnabled && !IsScrollbarDragInProgress && !IsAdapterDragInProgress)
			{
				UpdateLastSnappedIndexFromMiddleVH();
			}
		}
		AbstractViewsHolder middleVH = GetMiddleVH(out var _);
		if (middleVH == null)
		{
			return;
		}
		int itemIndex = middleVH.ItemIndex;
		if (_lastPassedCellIndex < 0)
		{
			_lastPassedCellIndex = itemIndex;
			CurrnetSelectdouble = scrollPos;
		}
		if (OnDrag != null && _lastPassedCellIndex >= 0)
		{
			int num = ((scrollPos > CurrnetSelectdouble) ? (_lastPassedCellIndex - 1) : (_lastPassedCellIndex + 1));
			int itemsCount = _Adapter.GetItemsCount();
			if (num >= 0 && num < itemsCount)
			{
				OnDrag(num);
			}
		}
		if (OnPassingCell != null && itemIndex != _lastPassedCellIndex)
		{
			CurrnetSelectdouble = scrollPos;
			_lastPassedCellIndex = itemIndex;
			OnPassingCell(itemIndex);
		}
	}

	private void OnScrollbarValueChanged(float _)
	{
		if (IsScrollbarDragInProgress)
		{
			CancelSnappingIfInProgress();
		}
	}

	private void OnItemsRefreshed(int newCount, int prevCount)
	{
		if (newCount != prevCount && _SnapToNextOnlyEnabled)
		{
			UpdateLastSnappedIndexFromMiddleVH();
		}
	}

	private void UpdateLastSnappedIndexFromMiddleVH()
	{
		_LastSnappedItemIndex = GetMiddleVH(out var _)?.ItemIndex ?? (-1);
		_LastItemIndexUnFinishedSnap = -1;
	}

	private void OnSnappingStarted()
	{
		if (SnappingStarted != null)
		{
			SnappingStarted();
		}
	}

	private void OnSnappingEndedOrCancelled()
	{
		_SnappingDoneAndEndSnappingEventPending = false;
		if (SnappingEndedOrCancelled != null)
		{
			SnappingEndedOrCancelled();
		}
	}
}
