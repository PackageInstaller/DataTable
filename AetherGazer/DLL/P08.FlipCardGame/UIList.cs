using System;
using System.Collections.Generic;
using Sirenix.Utilities;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

[ExecuteAlways]
[RequireComponent(typeof(ScrollRect))]
public class UIList : UIBehaviour, IBeginDragHandler, IEventSystemHandler, IEndDragHandler
{
	public static Vector3 OUT_OF_BOUND_POSITION = new Vector3(99999f, 99999f, 0f);

	[SerializeField]
	public GameObject ItemPrefab;

	[SerializeField]
	public Vector2 _spacing;

	[SerializeField]
	public RectOffset _padding;

	[SerializeField]
	public RectTransform content;

	[SerializeField]
	public RectTransform _viewport;

	[SerializeField]
	public float moveSeconds = 0.2f;

	[SerializeField]
	private AnimationCurve curveOfMove = AnimationCurve.Linear(0f, 0f, 1f, 1f);

	[HideInInspector]
	[SerializeField]
	public Orientation Orientation;

	[HideInInspector]
	[SerializeField]
	public UIListAlignment uiListAlignment;

	[HideInInspector]
	[SerializeField]
	public UIListAlignmentWhenLess uiListAlignmentWhenLess;

	[HideInInspector]
	[SerializeField]
	public AdapterType AdapterType;

	[HideInInspector]
	[SerializeField]
	public int FixColOrRowCount = 2;

	[HideInInspector]
	[SerializeField]
	public bool IsVirtual = true;

	[HideInInspector]
	[SerializeField]
	public UIListAppearType AppearType;

	[HideInInspector]
	[SerializeField]
	public float SplitTime = 0.01f;

	[HideInInspector]
	[SerializeField]
	public bool AutoSplit = true;

	[HideInInspector]
	[SerializeField]
	public bool SingleRowColAutoSplit;

	[HideInInspector]
	[SerializeField]
	public bool PageMode;

	[HideInInspector]
	[SerializeField]
	public bool AlwaysPageCenter = true;

	[HideInInspector]
	[SerializeField]
	public bool SingleRowColFitItemSize;

	[HideInInspector]
	[SerializeField]
	public float drag_threshold = 0.3333f;

	public UIListPool _pool;

	public ScrollRect _scrollRect;

	public Dictionary<int, GameObject> _itemDic;

	private int _startIndex;

	private int _endIndex;

	private float _startPercent;

	private float _endPercent = 1f;

	private bool _dirty = true;

	[HideInInspector]
	public int _itemNum;

	private bool _awaken;

	private Vector2 _initScrolledPosition;

	private Vector3 _initVerticalScrollBarPosition;

	private Vector3 _initHorizontalScrollBarPosition;

	private float _lastScrolledPercent = -1f;

	public Action<int, GameObject> _itemRenderer;

	public Action<int, GameObject> _itemRecycleHandler;

	public Action<int, int> _headTailChangeHandler;

	public Action<int> _pageChangeHandler;

	private int _timerId;

	private int _curRenderIndex;

	private Action _renderCallback;

	private LTDescr tween;

	public List<UIListCommand> _uilistCommands = new List<UIListCommand>();

	private int _pageCurrentIndex;

	private Vector2 _pageDragStartPosition = Vector2.zero;

	private int limitMaxDragCount = int.MaxValue;

	[HideInInspector]
	[SerializeField]
	public int _colLimit = -1;

	[HideInInspector]
	[SerializeField]
	public int _rowLimit = -1;

	private GameObject m_Blocker;

	private List<Canvas> _canvasList;

	protected override void Awake()
	{
		_itemDic = new Dictionary<int, GameObject>();
		_scrollRect = GetComponent<ScrollRect>();
		_scrollRect.onValueChanged.AddListener(OnScroll);
		_initScrolledPosition = new Vector2(0f, 1f);
		if (PageMode)
		{
			_scrollRect.inertia = false;
		}
		_pool = new UIListPool(this, ItemPrefab);
	}

	protected override void Start()
	{
		if (_scrollRect.verticalScrollbar != null)
		{
			_initVerticalScrollBarPosition = _scrollRect.verticalScrollbar.transform.localPosition;
		}
		if (_scrollRect.horizontalScrollbar != null)
		{
			_initHorizontalScrollBarPosition = _scrollRect.horizontalScrollbar.transform.localPosition;
		}
		ExecuteAllCommands();
		_awaken = true;
	}

	public void SetItemRenderer(Action<int, GameObject> renderer)
	{
		_itemRenderer = renderer;
	}

	public void SetItemRecycleHandler(Action<int, GameObject> handler)
	{
		_itemRecycleHandler = handler;
	}

	public void SetHeadTailChangeHandler(Action<int, int> handler)
	{
		_headTailChangeHandler = handler;
	}

	public void SetAppearType(int appearType)
	{
		AppearType = (UIListAppearType)appearType;
	}

	public void SetNumItems(int value, bool quite = false)
	{
		_dirty = !quite;
		AddOrExecuteCommand(delegate
		{
			_itemNum = value;
			_pageCurrentIndex = 0;
			UpdateProp();
			Vector2 contentSize = UIListCalculator.GetContentSize(this, _itemNum);
			content.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, contentSize.x);
			content.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, contentSize.y);
			_scrollRect.normalizedPosition = _initScrolledPosition;
			RecycleAllItems();
			UpdateList();
			UpdateProgressBar();
		});
	}

	public void Refresh()
	{
		AddOrExecuteCommand(delegate
		{
			for (int i = _startIndex; i <= _endIndex; i++)
			{
				if (_itemDic.ContainsKey(i))
				{
					_itemRenderer?.Invoke(i, _itemDic[i]);
				}
			}
		});
	}

	public void SetAlignment(UIListAlignment uiListAlignment)
	{
		if (uiListAlignment == this.uiListAlignment)
		{
			return;
		}
		AddOrExecuteCommand(delegate
		{
			this.uiListAlignment = uiListAlignment;
			if (_itemNum > 0)
			{
				UpdateProp();
				UpdateList();
			}
		});
	}

	public void SetOrientation(Orientation orientation)
	{
		if (orientation == Orientation)
		{
			return;
		}
		AddOrExecuteCommand(delegate
		{
			Orientation = orientation;
			if (_itemNum > 0)
			{
				UpdateProp();
				Vector2 contentSize = UIListCalculator.GetContentSize(this, _itemNum);
				content.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, contentSize.x);
				content.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, contentSize.y);
				UpdateList();
				UpdateLayout();
			}
		});
	}

	public void OnScroll(Vector2 value)
	{
		if (!IsActive() || !IsVirtual)
		{
			return;
		}
		float num = (IsHorizontal() ? _scrollRect.horizontalNormalizedPosition : _scrollRect.verticalNormalizedPosition);
		if ((double)Math.Abs(_lastScrolledPercent - num.clamp01()) < 0.001 && (num < 0f || num > 1f))
		{
			return;
		}
		Vector2 contentSize = UIListCalculator.GetContentSize(this, _itemNum, autoFitViewport: false);
		if (IsVertical())
		{
			if (contentSize.y <= _viewport.rect.height)
			{
				return;
			}
		}
		else if (contentSize.x <= _viewport.rect.width)
		{
			return;
		}
		float num2 = Math.Min(_startPercent, _endPercent) - 0.001f;
		float num3 = Math.Max(_startPercent, _endPercent) + 0.001f;
		if (num < num2 || num > num3)
		{
			UpdateList();
		}
	}

	public void UpdateList()
	{
		if (!IsVirtual && !_dirty)
		{
			return;
		}
		_lastScrolledPercent = (IsHorizontal() ? _scrollRect.horizontalNormalizedPosition : _scrollRect.verticalNormalizedPosition);
		_lastScrolledPercent = _lastScrolledPercent.clamp01();
		int startIndexByPercent = UIListCalculator.GetStartIndexByPercent(this, _lastScrolledPercent);
		int endIndexByPercent = UIListCalculator.GetEndIndexByPercent(this, _lastScrolledPercent);
		int num = 0;
		num = endIndexByPercent + (IsHorizontal() ? _rowLimit : _colLimit);
		if (IsVirtual)
		{
			_startPercent = UIListCalculator.GetStartPosition(this, startIndexByPercent);
			_endPercent = UIListCalculator.GetEndPosition(this, num);
		}
		else
		{
			_startPercent = 0f;
			_endPercent = 1f;
		}
		int oldStartIndex = _startIndex;
		int oldEndIndex = _endIndex;
		if (startIndexByPercent > -1 && endIndexByPercent > -1)
		{
			_startIndex = startIndexByPercent;
			_endIndex = endIndexByPercent;
			for (int i = 0; i < _itemNum; i++)
			{
				if ((i < _startIndex || i > _endIndex) && _itemDic.ContainsKey(i))
				{
					GameObject arg = _itemDic[i];
					_pool.ReturnToPool(_itemDic[i]);
					_itemDic.Remove(i);
					if (_itemRecycleHandler != null)
					{
						_itemRecycleHandler(i, arg);
					}
				}
			}
		}
		RenderItems(delegate
		{
			if (_dirty)
			{
				_pool.SetPoolItemsInActive();
			}
			_dirty = false;
			if ((_startIndex != oldStartIndex || _endIndex != oldEndIndex) && _headTailChangeHandler != null)
			{
				_headTailChangeHandler(_startIndex, _endIndex);
			}
		});
	}

	private void RenderItems(Action callback = null)
	{
		if (_itemNum == 0)
		{
			if (_timerId != 0)
			{
				FuncTimerManager.inst.StopFuncTimer(_timerId);
			}
			HideBlock();
			callback();
			return;
		}
		_renderCallback = callback;
		if (_dirty)
		{
			if (IsAsync())
			{
				_pool.SetPoolItemsInActive();
				ShowBlock();
				_curRenderIndex = _startIndex;
				for (int i = _startIndex; i <= _endIndex; i++)
				{
					if (_itemDic.ContainsKey(i))
					{
						SetItemActive(_itemDic[i], value: false);
					}
				}
				if (_timerId == 0)
				{
					_timerId = FuncTimerManager.inst.CreateFuncTimer(RenderCurrentIndexItem, SplitTime, -1, autoStart: false);
				}
				FuncTimerManager.inst.StartFuncTimer(_timerId);
			}
			else if (AppearType == UIListAppearType.All)
			{
				for (int j = _startIndex; j <= _endIndex; j++)
				{
					RenderItem(j);
				}
				_renderCallback?.Invoke();
				_renderCallback = null;
			}
			else
			{
				for (int k = _startIndex; k <= _endIndex; k++)
				{
					RenderItem(k);
				}
				_renderCallback?.Invoke();
				_renderCallback = null;
			}
		}
		else
		{
			for (int l = _startIndex; l <= _endIndex; l++)
			{
				RenderItem(l);
			}
			_renderCallback?.Invoke();
			_renderCallback = null;
		}
	}

	private void RenderCurrentIndexItem()
	{
		int num = 1;
		if (AppearType == UIListAppearType.OneRowCol)
		{
			num = (IsVertical() ? _colLimit : _rowLimit);
		}
		for (int i = 0; i < num; i++)
		{
			GameObject go = RenderItem(_curRenderIndex);
			SetItemActive(go, value: true);
			_curRenderIndex++;
			if (_curRenderIndex > _endIndex)
			{
				FuncTimerManager.inst.StopFuncTimer(_timerId);
				HideBlock();
				_renderCallback?.Invoke();
				_renderCallback = null;
				break;
			}
		}
	}

	public GameObject RenderItem(int index)
	{
		GameObject gameObject;
		if (!_itemDic.ContainsKey(index))
		{
			gameObject = _pool.GetFromPool();
			gameObject.transform.SetParent(content, worldPositionStays: false);
			_itemDic.Add(index, gameObject);
		}
		else
		{
			gameObject = _itemDic[index];
		}
		if (AdapterType == AdapterType.FixItemSize)
		{
			RectTransform obj = gameObject.transform as RectTransform;
			Rect itemRect = UIListCalculator.GetItemRect(this);
			obj.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, itemRect.width);
			obj.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, itemRect.height);
		}
		if (_itemRenderer != null)
		{
			_itemRenderer(index, gameObject);
		}
		if (_dirty)
		{
			EnableAnimator(gameObject);
		}
		else
		{
			DisableAnimator(gameObject);
		}
		((RectTransform)gameObject.transform).localPosition = UIListCalculator.GetItemPlacePos(this, index);
		return gameObject;
	}

	private void EnableAnimator(GameObject go, bool replay = false)
	{
		Animator[] componentsInChildren = go.GetComponentsInChildren<Animator>();
		if (replay && componentsInChildren != null && componentsInChildren.Length != 0)
		{
			componentsInChildren.ForEach(delegate(Animator animator)
			{
				animator.Play(animator.GetCurrentAnimatorStateInfo(0).fullPathHash, -1, 0f);
				animator.Update(0f);
			});
		}
	}

	private void DisableAnimator(GameObject go)
	{
		Animator[] componentsInChildren = go.GetComponentsInChildren<Animator>();
		if (componentsInChildren.Length != 0 && !componentsInChildren[0].enabled)
		{
			return;
		}
		componentsInChildren.ForEach(delegate(Animator animator)
		{
			AnimatorClipInfo[] currentAnimatorClipInfo = animator.GetCurrentAnimatorClipInfo(0);
			if (currentAnimatorClipInfo != null && currentAnimatorClipInfo.Length != 0)
			{
				animator.Update(currentAnimatorClipInfo[0].clip.length);
			}
		});
	}

	public void RecycleAllItems()
	{
		foreach (int key in _itemDic.Keys)
		{
			GameObject arg = _itemDic[key];
			_pool.ReturnToPool(_itemDic[key]);
			if (_itemRecycleHandler != null)
			{
				_itemRecycleHandler(key, arg);
			}
		}
		_itemDic.Clear();
	}

	public void UpdateLayout()
	{
		if (_itemDic.Count <= 0)
		{
			return;
		}
		for (int i = _startIndex; i <= _endIndex; i++)
		{
			try
			{
				(_itemDic[i].transform as RectTransform).localPosition = UIListCalculator.GetItemPlacePos(this, i);
			}
			catch (Exception value)
			{
				Console.WriteLine(value);
				throw;
			}
		}
	}

	public void UpdateProgressBar()
	{
		if (IsVertical() && _scrollRect.verticalScrollbar != null)
		{
			UIPanel component = _scrollRect.verticalScrollbar.GetComponent<UIPanel>();
			if (_viewport.rect.height < GetContentRect().height * content.localScale.y - 1f)
			{
				if ((bool)component)
				{
					component.SetActive(value: true);
				}
				else
				{
					_scrollRect.verticalScrollbar.gameObject.SetActive(value: true);
					_scrollRect.verticalScrollbar.transform.localPosition = _initVerticalScrollBarPosition;
				}
			}
			else if ((bool)component)
			{
				component.SetActive(value: false);
			}
			else
			{
				_scrollRect.verticalScrollbar.gameObject.SetActive(value: false);
				_scrollRect.verticalScrollbar.transform.localPosition = OUT_OF_BOUND_POSITION;
			}
		}
		if (!IsHorizontal() || !(_scrollRect.horizontalScrollbar != null))
		{
			return;
		}
		UIPanel component2 = _scrollRect.verticalScrollbar.GetComponent<UIPanel>();
		if (_viewport.rect.width < GetContentRect().width * content.localScale.x - 1f)
		{
			if ((bool)component2)
			{
				component2.SetActive(value: true);
				return;
			}
			_scrollRect.verticalScrollbar.gameObject.SetActive(value: true);
			_scrollRect.horizontalScrollbar.transform.localPosition = _initHorizontalScrollBarPosition;
		}
		else if ((bool)component2)
		{
			component2.SetActive(value: false);
		}
		else
		{
			_scrollRect.verticalScrollbar.gameObject.SetActive(value: false);
			_scrollRect.horizontalScrollbar.transform.localPosition = OUT_OF_BOUND_POSITION;
		}
	}

	public void RemoveTween()
	{
		if (tween != null)
		{
			tween.setOnUpdate((Action<float>)delegate
			{
			});
			LeanTween.cancel(tween.id);
			tween = null;
		}
	}

	public void ScrollToIndex(int index, bool atCenter = false, bool anim = false, float time = -1f)
	{
		if (time < 0f)
		{
			time = moveSeconds;
		}
		AddOrExecuteCommand(delegate
		{
			if (anim)
			{
				float toPercent = UIListCalculator.GetStartPosition(this, index, atCenter);
				if (IsVertical())
				{
					tween = LeanTween.value(0f, 1f, time).setOnUpdate(delegate(float f)
					{
						float verticalNormalizedPosition = Mathf.Lerp(_scrollRect.verticalNormalizedPosition, toPercent, curveOfMove.Evaluate(f));
						_scrollRect.verticalNormalizedPosition = verticalNormalizedPosition;
						UpdateList();
					});
				}
				else
				{
					tween = LeanTween.value(0f, 1f, time).setOnUpdate(delegate(float f)
					{
						float horizontalNormalizedPosition = Mathf.Lerp(_scrollRect.horizontalNormalizedPosition, toPercent, curveOfMove.Evaluate(f));
						_scrollRect.horizontalNormalizedPosition = horizontalNormalizedPosition;
						UpdateList();
					});
				}
			}
			else
			{
				if (IsVertical())
				{
					_scrollRect.verticalNormalizedPosition = UIListCalculator.GetStartPosition(this, index, atCenter);
				}
				else
				{
					_scrollRect.horizontalNormalizedPosition = UIListCalculator.GetStartPosition(this, index, atCenter);
				}
				UpdateList();
			}
			if (PageMode)
			{
				_pageCurrentIndex = index;
			}
		});
	}

	public void SetItemActive(GameObject go, bool value)
	{
		if (value)
		{
			EnableAnimator(go, _dirty);
			return;
		}
		go.transform.localPosition = OUT_OF_BOUND_POSITION;
		DisableAnimator(go);
	}

	public void AddOrExecuteCommand(Action action)
	{
		if (_awaken)
		{
			action();
		}
		else
		{
			_uilistCommands.Add(new UIListCommand(action));
		}
	}

	public void ExecuteAllCommands()
	{
		while (_uilistCommands.Count > 0)
		{
			_uilistCommands[0].Execute();
			_uilistCommands.RemoveAt(0);
		}
	}

	public Vector2 GetHeadAndTail()
	{
		if (_itemNum == 0)
		{
			return new Vector2(-1f, -1f);
		}
		return new Vector2(_startIndex, Mathf.Min(_endIndex, _itemNum));
	}

	public Vector2 GetScrolledPosition()
	{
		Vector2 normalizedPosition = _scrollRect.normalizedPosition;
		if (IsVertical())
		{
			if (_viewport.rect.height > content.rect.height)
			{
				normalizedPosition.y = 1f;
			}
		}
		else if (IsHorizontal() && _viewport.rect.width > content.rect.width)
		{
			normalizedPosition.x = 0f;
		}
		return normalizedPosition;
	}

	public void SetScrolledPosition(Vector2 value)
	{
		AddOrExecuteCommand(delegate
		{
			_scrollRect.normalizedPosition = value;
			UpdateList();
		});
	}

	private bool IsAsync()
	{
		if (AppearType != UIListAppearType.One)
		{
			return AppearType == UIListAppearType.OneRowCol;
		}
		return true;
	}

	public bool IsVertical()
	{
		if (Orientation != Orientation.Vertical)
		{
			return Orientation == Orientation.SingleVertical;
		}
		return true;
	}

	public bool IsHorizontal()
	{
		if (Orientation != Orientation.Horizontal)
		{
			return Orientation == Orientation.SingleHorizontal;
		}
		return true;
	}

	public int GetChildCount()
	{
		return _itemNum;
	}

	public Rect GetContentRect()
	{
		return content.rect;
	}

	public void UpdateProp(bool playing = true)
	{
		if (!_scrollRect)
		{
			_scrollRect = GetComponent<ScrollRect>();
		}
		if (content == null)
		{
			Debug.LogError("请设置content");
			return;
		}
		if (_viewport == null)
		{
			Debug.LogError("请设置viewport");
		}
		if (ItemPrefab == null)
		{
			Debug.LogError("请设置ItemPrefab");
		}
		if (IsVertical())
		{
			content.anchorMin = Vector2.up;
			content.anchorMax = Vector2.one;
		}
		else
		{
			content.anchorMin = Vector2.zero;
			content.anchorMax = Vector2.up;
		}
		if (playing)
		{
			Vector2 contentSize = UIListCalculator.GetContentSize(this, _itemNum);
			content.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, contentSize.x);
			content.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, contentSize.y);
		}
		else
		{
			Vector2 contentSize2 = UIListCalculator.GetContentSize(this, content.transform.childCount);
			content.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, contentSize2.x);
			content.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, contentSize2.y);
		}
		Rect rect = _viewport.rect;
		rect.width /= content.localScale.x;
		rect.height /= content.localScale.y;
		if (Orientation == Orientation.Vertical)
		{
			if (AdapterType == AdapterType.FixItemSize)
			{
				_colLimit = FixColOrRowCount;
			}
			else
			{
				_colLimit = (int)((rect.width - (float)_padding.left - (float)_padding.right + _spacing.x) / (UIListCalculator.GetItemRect(this).width + _spacing.x));
			}
			if (_colLimit < 1)
			{
				_colLimit = 1;
			}
			_rowLimit = -1;
			_scrollRect.vertical = true;
			_scrollRect.horizontal = false;
		}
		else if (Orientation == Orientation.Horizontal)
		{
			_colLimit = -1;
			if (AdapterType == AdapterType.FixItemSize)
			{
				_rowLimit = FixColOrRowCount;
			}
			else
			{
				_rowLimit = (int)((rect.height - (float)_padding.top - (float)_padding.bottom + _spacing.y) / (UIListCalculator.GetItemRect(this).height + _spacing.y));
			}
			if (_rowLimit < 1)
			{
				_rowLimit = 1;
			}
			_scrollRect.vertical = false;
			_scrollRect.horizontal = true;
		}
		else if (Orientation == Orientation.SingleVertical)
		{
			_colLimit = 1;
			_rowLimit = -1;
			_scrollRect.vertical = true;
			_scrollRect.horizontal = false;
		}
		else if (Orientation == Orientation.SingleHorizontal)
		{
			_colLimit = -1;
			_rowLimit = 1;
			_scrollRect.vertical = false;
			_scrollRect.horizontal = true;
		}
		if (PageMode && AlwaysPageCenter)
		{
			Rect rect2 = (base.transform as RectTransform).rect;
			if (IsHorizontal())
			{
				RectOffset padding = _padding;
				int left = (_padding.right = (int)((rect2.width - UIListCalculator.GetItemRect(this).width) / 2f));
				padding.left = left;
			}
			else if (IsVertical())
			{
				RectOffset padding2 = _padding;
				int left = (_padding.bottom = (int)((rect2.height - UIListCalculator.GetItemRect(this).height) / 2f));
				padding2.top = left;
			}
		}
	}

	public void SetPageChangeHandler(Action<int> handler)
	{
		_pageChangeHandler = handler;
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (!(ItemPrefab == null) && PageMode)
		{
			_pageDragStartPosition = eventData.position;
		}
	}

	public void SetLimitMaxDragCount(int count)
	{
		limitMaxDragCount = count;
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (ItemPrefab == null)
		{
			return;
		}
		Rect rect = (ItemPrefab.transform as RectTransform).rect;
		if (!PageMode || _pageCurrentIndex == -1)
		{
			return;
		}
		Vector2 vector = eventData.position - _pageDragStartPosition;
		if (IsHorizontal())
		{
			float num = Mathf.Abs(vector.x);
			bool flag = num % rect.width >= rect.width * drag_threshold;
			int num2 = Mathf.FloorToInt(num / rect.width);
			if (vector.x > 0f)
			{
				int b = num2 * _rowLimit - (flag ? 1 : 0);
				b = Mathf.Min(limitMaxDragCount, b);
				int index = Mathf.Max(0, _pageCurrentIndex - b);
				SwitchToPageIndex(index);
			}
			else
			{
				int b2 = num2 * _rowLimit - (flag ? 1 : 0);
				b2 = Mathf.Min(limitMaxDragCount, b2);
				int index2 = Mathf.Min(_itemNum - 1, _pageCurrentIndex + b2);
				SwitchToPageIndex(index2);
			}
		}
		else if (IsVertical())
		{
			float num3 = Mathf.Abs(vector.y);
			bool flag2 = num3 % rect.height >= rect.height * drag_threshold;
			int num4 = Mathf.FloorToInt(num3 / rect.height);
			if (vector.y < 0f)
			{
				int index3 = Mathf.Max(0, _pageCurrentIndex - num4 * _colLimit - (flag2 ? 1 : 0));
				SwitchToPageIndex(index3);
			}
			else
			{
				int index4 = Mathf.Min(_itemNum - 1, _pageCurrentIndex + num4 * _colLimit + (flag2 ? 1 : 0));
				SwitchToPageIndex(index4);
			}
		}
	}

	public void SwitchToPageIndex(int index)
	{
		ScrollToIndex(index, atCenter: true, anim: true);
		_pageChangeHandler?.Invoke(index);
	}

	public void StopRender()
	{
		if (_timerId != 0)
		{
			if (FuncTimerManager.inst != null)
			{
				FuncTimerManager.inst.RemoveFuncTimer(_timerId);
			}
			_timerId = 0;
		}
	}

	public override bool IsActive()
	{
		if (!base.IsActive())
		{
			return false;
		}
		CanvasGroup component = GetComponent<CanvasGroup>();
		if (component != null && component.alpha <= 0f)
		{
			return false;
		}
		CanvasGroup[] componentsInParent = GetComponentsInParent<CanvasGroup>();
		for (int i = 0; i < componentsInParent.Length; i++)
		{
			if (componentsInParent[i].alpha <= 0f)
			{
				return false;
			}
		}
		return true;
	}

	protected override void OnDestroy()
	{
		_scrollRect.onValueChanged.RemoveListener(OnScroll);
		if (_timerId != 0)
		{
			if (FuncTimerManager.inst != null)
			{
				FuncTimerManager.inst.RemoveFuncTimer(_timerId);
			}
			_timerId = 0;
		}
	}

	public void ShowBlock()
	{
		if (m_Blocker == null)
		{
			if (_canvasList == null)
			{
				_canvasList = new List<Canvas>();
			}
			base.gameObject.GetComponentsInParent(includeInactive: false, _canvasList);
			if (_canvasList.Count != 0)
			{
				Canvas rootCanvas = _canvasList[0];
				m_Blocker = CreateBlocker(rootCanvas);
			}
		}
	}

	public void HideBlock()
	{
		if (m_Blocker != null)
		{
			DestroyBlocker(m_Blocker);
		}
		m_Blocker = null;
	}

	protected GameObject CreateBlocker(Canvas rootCanvas)
	{
		GameObject obj = new GameObject("Blocker");
		RectTransform rectTransform = obj.AddComponent<RectTransform>();
		rectTransform.SetParent(rootCanvas.transform, worldPositionStays: false);
		rectTransform.anchorMin = Vector3.zero;
		rectTransform.anchorMax = Vector3.one;
		rectTransform.sizeDelta = Vector2.zero;
		Canvas canvas = obj.AddComponent<Canvas>();
		canvas.overrideSorting = true;
		canvas.sortingLayerID = 1;
		canvas.sortingOrder = 30001;
		obj.AddComponent<GraphicRaycaster>();
		obj.AddComponent<Image>().color = Color.clear;
		return obj;
	}

	protected virtual void DestroyBlocker(GameObject blocker)
	{
		UnityEngine.Object.Destroy(blocker);
	}

	public GameObject DebugCreateItem()
	{
		return null;
	}

	public bool DebugClearItems()
	{
		return true;
	}

	public void Validate()
	{
	}

	protected override void OnRectTransformDimensionsChange()
	{
		base.OnRectTransformDimensionsChange();
		if (!(_viewport == null) && !(content == null) && !(ItemPrefab == null))
		{
			_ = _viewport.rect;
			if (_viewport.rect.width != 0f && _viewport.rect.height != 0f)
			{
				UpdateProp(Application.isPlaying);
			}
		}
	}
}
