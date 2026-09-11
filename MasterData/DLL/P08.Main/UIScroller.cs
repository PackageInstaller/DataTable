using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

[ExecuteAlways]
[RequireComponent(typeof(ScrollRect))]
public class UIScroller : UIBehaviour
{
	public static Vector3 OUT_OF_BOUND_POSITION = new Vector3(99999f, 99999f, 0f);

	[SerializeField]
	public GameObject ItemPrefab;

	[SerializeField]
	public RectTransform content;

	[SerializeField]
	public RectTransform _viewport;

	[HideInInspector]
	[SerializeField]
	public UIScrollerOrientation Orientation;

	[HideInInspector]
	[SerializeField]
	public UIScrollerAppearType AppearType;

	[HideInInspector]
	private bool _dirty = true;

	[HideInInspector]
	public int _itemNum;

	[HideInInspector]
	[SerializeField]
	public float SplitTime = 0.01f;

	private float _startPercent;

	private float _endPercent = 1f;

	private UIScrollerPool _pool;

	private bool _awaken;

	public ScrollRect scrollRect;

	public Dictionary<int, GameObject> _itemDic;

	private Vector2 _initScrolledPosition;

	private Vector3 _initVerticalScrollBarPosition;

	private Vector3 _initHorizontalScrollBarPosition;

	public Action<int, GameObject> _itemRenderer;

	public Action<int, GameObject> _itemRecycleHandler;

	public Action<int, int> _headTailChangeHandler;

	public Action<int> _pageChangeHandler;

	private Action _renderCallback;

	private int _timerId;

	private GameObject m_Blocker;

	private List<Canvas> _canvasList;

	private int _curRenderIndex;

	private int _startIndex;

	private int _endIndex;

	private LTDescr tween;

	public List<UIListCommand> _uilistCommands = new List<UIListCommand>();

	protected override void Awake()
	{
		_itemDic = new Dictionary<int, GameObject>();
		scrollRect = GetComponent<ScrollRect>();
		scrollRect.onValueChanged.AddListener(OnScroll);
		_initScrolledPosition = new Vector2(0f, 1f);
		_pool = new UIScrollerPool(this, ItemPrefab);
	}

	protected override void Start()
	{
		if (scrollRect.verticalScrollbar != null)
		{
			_initVerticalScrollBarPosition = scrollRect.verticalScrollbar.transform.localPosition;
		}
		if (scrollRect.horizontalScrollbar != null)
		{
			_initHorizontalScrollBarPosition = scrollRect.horizontalScrollbar.transform.localPosition;
		}
		ExecuteAllCommands();
		_awaken = true;
	}

	public void OnScroll(Vector2 value)
	{
	}

	public void SetNumItems(int value, bool quite = false)
	{
		_dirty = !quite;
		AddOrExecuteCommand(delegate
		{
			_itemNum = value;
			UpdateProp();
			Vector2 contentSize = UIScrollerCalculator.GetContentSize(this, _itemNum);
			content.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, contentSize.x);
			content.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, contentSize.y);
			scrollRect.normalizedPosition = _initScrolledPosition;
			scrollRect.Rebuild(CanvasUpdate.PostLayout);
			UpdateList();
			UpdateProgressBar();
		});
	}

	public void ScrollToIndex(int index, bool atCenter = false, bool anim = false, float time = 0.2f)
	{
		AddOrExecuteCommand(delegate
		{
			if (anim)
			{
				float startPosition = UIScrollerCalculator.GetStartPosition(this, index, atCenter);
				if (IsVertical())
				{
					tween = LeanTween.value(scrollRect.verticalNormalizedPosition, startPosition, time).setOnUpdate(delegate(float f)
					{
						scrollRect.verticalNormalizedPosition = f;
						UpdateList();
					});
				}
				else
				{
					tween = LeanTween.value(scrollRect.horizontalNormalizedPosition, startPosition, time).setOnUpdate(delegate(float f)
					{
						scrollRect.horizontalNormalizedPosition = f;
						UpdateList();
					});
				}
			}
			else
			{
				if (IsVertical())
				{
					scrollRect.verticalNormalizedPosition = UIScrollerCalculator.GetStartPosition(this, index, atCenter);
				}
				else
				{
					scrollRect.horizontalNormalizedPosition = UIScrollerCalculator.GetStartPosition(this, index, atCenter);
				}
				UpdateList();
			}
		});
	}

	public void SetScrolledPosition(Vector2 value)
	{
		AddOrExecuteCommand(delegate
		{
			scrollRect.normalizedPosition = value;
			UpdateList();
		});
	}

	public Vector2 GetScrolledPosition()
	{
		Vector2 normalizedPosition = scrollRect.normalizedPosition;
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

	public void UpdateList()
	{
		_startPercent = 0f;
		_endPercent = 1f;
		_startIndex = 0;
		_endIndex = _itemNum - 1;
		int startIndex = _startIndex;
		int endIndex = _endIndex;
		if (startIndex > -1 && endIndex > -1)
		{
			_startIndex = startIndex;
			_endIndex = endIndex;
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
		Vector2 contentSize = UIScrollerCalculator.GetContentSize(this, _itemNum);
		content.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, contentSize.x);
		content.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, contentSize.y);
		scrollRect.Rebuild(CanvasUpdate.PostLayout);
		content.GetComponent<ContentSizeFitter>().horizontalFit = ContentSizeFitter.FitMode.Unconstrained;
		content.GetComponent<ContentSizeFitter>().verticalFit = ContentSizeFitter.FitMode.Unconstrained;
		RenderItems(delegate
		{
			if (Orientation == UIScrollerOrientation.SingleHorizontal)
			{
				content.GetComponent<ContentSizeFitter>().horizontalFit = ContentSizeFitter.FitMode.PreferredSize;
			}
			else
			{
				content.GetComponent<ContentSizeFitter>().verticalFit = ContentSizeFitter.FitMode.PreferredSize;
			}
			if (_dirty)
			{
				_pool.SetPoolItemsInActive();
			}
			_dirty = false;
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
			else
			{
				for (int j = _startIndex; j <= _endIndex; j++)
				{
					RenderItem(j);
				}
				_renderCallback?.Invoke();
				_renderCallback = null;
			}
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
		if (_itemRenderer != null)
		{
			_itemRenderer(index, gameObject);
		}
		return gameObject;
	}

	public void SetItemRenderer(Action<int, GameObject> renderer)
	{
		_itemRenderer = renderer;
	}

	public Vector2 GetHeadAndTail()
	{
		if (_itemNum == 0)
		{
			return new Vector2(-1f, -1f);
		}
		return new Vector2(_startIndex, Mathf.Min(_endIndex, _itemNum));
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
		GameObject obj = new GameObject("UIScrollerBlocker");
		RectTransform rectTransform = obj.AddComponent<RectTransform>();
		rectTransform.SetParent(rootCanvas.transform, worldPositionStays: false);
		rectTransform.anchorMin = Vector3.zero;
		rectTransform.anchorMax = Vector3.one;
		rectTransform.sizeDelta = Vector2.zero;
		Canvas canvas = obj.AddComponent<Canvas>();
		canvas.overrideSorting = true;
		canvas.sortingLayerID = 1;
		canvas.sortingOrder = 30002;
		obj.AddComponent<GraphicRaycaster>();
		obj.AddComponent<Image>().color = Color.clear;
		return obj;
	}

	protected virtual void DestroyBlocker(GameObject blocker)
	{
		UnityEngine.Object.Destroy(blocker);
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

	private void RenderCurrentIndexItem()
	{
		int num = 1;
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

	public void UpdateProp(bool playing = true)
	{
		if (!scrollRect)
		{
			scrollRect = GetComponent<ScrollRect>();
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
	}

	public void UpdateProgressBar()
	{
		if (IsVertical() && scrollRect.verticalScrollbar != null)
		{
			UIPanel component = scrollRect.verticalScrollbar.GetComponent<UIPanel>();
			if (_viewport.rect.height < GetContentRect().height * content.localScale.y - 1f)
			{
				if ((bool)component)
				{
					component.SetActive(value: true);
				}
				else
				{
					scrollRect.verticalScrollbar.gameObject.SetActive(value: true);
					scrollRect.verticalScrollbar.transform.localPosition = _initVerticalScrollBarPosition;
				}
			}
			else if ((bool)component)
			{
				component.SetActive(value: false);
			}
			else
			{
				scrollRect.verticalScrollbar.gameObject.SetActive(value: false);
				scrollRect.verticalScrollbar.transform.localPosition = OUT_OF_BOUND_POSITION;
			}
		}
		if (!IsHorizontal() || !(scrollRect.horizontalScrollbar != null))
		{
			return;
		}
		UIPanel component2 = scrollRect.verticalScrollbar.GetComponent<UIPanel>();
		if (_viewport.rect.width < GetContentRect().width * content.localScale.x - 1f)
		{
			if ((bool)component2)
			{
				component2.SetActive(value: true);
				return;
			}
			scrollRect.verticalScrollbar.gameObject.SetActive(value: true);
			scrollRect.horizontalScrollbar.transform.localPosition = _initHorizontalScrollBarPosition;
		}
		else if ((bool)component2)
		{
			component2.SetActive(value: false);
		}
		else
		{
			scrollRect.verticalScrollbar.gameObject.SetActive(value: false);
			scrollRect.horizontalScrollbar.transform.localPosition = OUT_OF_BOUND_POSITION;
		}
	}

	public void SetItemActive(GameObject go, bool value)
	{
		go.SetActive(value);
	}

	private bool IsAsync()
	{
		return AppearType == UIScrollerAppearType.One;
	}

	public bool IsVertical()
	{
		return Orientation == UIScrollerOrientation.SingleVertical;
	}

	public bool IsHorizontal()
	{
		return Orientation == UIScrollerOrientation.SingleHorizontal;
	}

	public Rect GetContentRect()
	{
		return content.rect;
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
}
