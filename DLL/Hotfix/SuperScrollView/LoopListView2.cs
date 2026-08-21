#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SuperScrollView;

public class LoopListView2 : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IEndDragHandler, IDragHandler
{
	private class SnapData
	{
		public SnapStatus mSnapStatus;

		public int mSnapTargetIndex;

		public float mTargetSnapVal;

		public float mCurSnapVal;

		public bool mIsForceSnapTo;

		public bool mIsTempTarget;

		public int mTempTargetIndex = -1;

		public float mMoveMaxAbsVec = -1f;

		public void Clear()
		{
			mSnapStatus = SnapStatus.NoTargetSet;
			mTempTargetIndex = -1;
			mIsForceSnapTo = false;
			mMoveMaxAbsVec = -1f;
		}
	}

	private Dictionary<string, ItemPool> mItemPoolDict = new Dictionary<string, ItemPool>();

	private List<ItemPool> mItemPoolList = new List<ItemPool>();

	[SerializeField]
	private List<ItemPrefabConfData> mItemPrefabDataList = new List<ItemPrefabConfData>();

	[SerializeField]
	private float mPaddingTop;

	[SerializeField]
	private float mPaddingBottom;

	[SerializeField]
	private float mPaddingLeft;

	[SerializeField]
	private float mPaddingRight;

	[SerializeField]
	private ListItemArrangeType mArrangeType;

	private List<LoopListViewItem2> mItemList = new List<LoopListViewItem2>();

	private RectTransform mContainerTrans;

	private ScrollRect mScrollRect;

	private RectTransform mScrollRectTransform;

	private RectTransform mViewPortRectTransform;

	private float mItemDefaultWithPaddingSize = 20f;

	private int mItemTotalCount;

	private bool mIsVertList;

	private Func<LoopListView2, int, LoopListViewItem2> mOnGetItemByIndex;

	private Vector3[] mItemWorldCorners = new Vector3[4];

	private Vector3[] mViewPortRectLocalCorners = new Vector3[4];

	private int mCurReadyMinItemIndex;

	private int mCurReadyMaxItemIndex;

	private bool mNeedCheckNextMinItem = true;

	private bool mNeedCheckNextMaxItem = true;

	private ItemPosMgr mItemPosMgr;

	private float mDistanceForRecycle0 = 300f;

	private float mDistanceForNew0 = 200f;

	private float mDistanceForRecycle1 = 300f;

	private float mDistanceForNew1 = 200f;

	[SerializeField]
	private bool mSupportScrollBar = true;

	private bool mIsDraging;

	private PointerEventData mPointerEventData;

	public Action mOnBeginDragAction;

	public Action mOnDragingAction;

	public Action mOnEndDragAction;

	private int mLastItemIndex;

	private float mLastItemPadding;

	private float mSmoothDumpVel;

	private float mSmoothDumpRate = 0.3f;

	private float mSnapFinishThreshold = 0.1f;

	private float mSnapVecThreshold = 145f;

	private float mSnapMoveDefaultMaxAbsVec = 3400f;

	[SerializeField]
	private bool mItemSnapEnable;

	private Vector3 mLastFrameContainerPos = Vector3.zero;

	public Action<LoopListView2, LoopListViewItem2> mOnSnapItemFinished;

	public Action<LoopListView2, LoopListViewItem2> mOnSnapNearestChanged;

	private int mCurSnapNearestItemIndex = -1;

	private Vector2 mAdjustedVec;

	private bool mNeedAdjustVec;

	private int mLeftSnapUpdateExtraCount = 1;

	[SerializeField]
	private Vector2 mViewPortSnapPivot = Vector2.zero;

	[SerializeField]
	private Vector2 mItemSnapPivot = Vector2.zero;

	private ClickEventListener mScrollBarClickEventListener;

	private SnapData mCurSnapData = new SnapData();

	private Vector3 mLastSnapCheckPos = Vector3.zero;

	private bool mListViewInited;

	private int mListUpdateCheckFrameCount;

	public Action<LoopListView2> OnListViewStart;

	public Action onChangeContentSize;

	public float PaddingTop => mPaddingTop;

	public float PaddingBottom => mPaddingBottom;

	public float PaddingLeft => mPaddingLeft;

	public float PaddingRight => mPaddingRight;

	public ListItemArrangeType ArrangeType
	{
		get
		{
			return mArrangeType;
		}
		set
		{
			mArrangeType = value;
		}
	}

	public List<ItemPrefabConfData> ItemPrefabDataList => mItemPrefabDataList;

	public List<LoopListViewItem2> ItemList => mItemList;

	public bool IsVertList => mIsVertList;

	public int ItemTotalCount => mItemTotalCount;

	public RectTransform ContainerTrans => mContainerTrans;

	public ScrollRect ScrollRect => mScrollRect;

	public bool IsDraging => mIsDraging;

	public bool IsInited => mListViewInited;

	public bool ItemSnapEnable
	{
		get
		{
			return mItemSnapEnable;
		}
		set
		{
			mItemSnapEnable = value;
		}
	}

	public bool SupportScrollBar
	{
		get
		{
			return mSupportScrollBar;
		}
		set
		{
			mSupportScrollBar = value;
		}
	}

	public float SnapMoveDefaultMaxAbsVec
	{
		get
		{
			return mSnapMoveDefaultMaxAbsVec;
		}
		set
		{
			mSnapMoveDefaultMaxAbsVec = value;
		}
	}

	public int ShownItemCount => mItemList.Count;

	public float ViewPortSize
	{
		get
		{
			if (mIsVertList)
			{
				return mViewPortRectTransform.rect.height;
			}
			return mViewPortRectTransform.rect.width;
		}
	}

	public float ViewPortWidth => mViewPortRectTransform.rect.width;

	public float ViewPortHeight => mViewPortRectTransform.rect.height;

	public int CurSnapNearestItemIndex => mCurSnapNearestItemIndex;

	public ItemPrefabConfData GetItemPrefabConfData(string prefabName)
	{
		foreach (ItemPrefabConfData mItemPrefabData in mItemPrefabDataList)
		{
			if (mItemPrefabData.mItemPrefab == null)
			{
				Log.Error("A item prefab is null ");
			}
			else if (prefabName == mItemPrefabData.mItemPrefab.name)
			{
				return mItemPrefabData;
			}
		}
		return null;
	}

	public void OnItemPrefabChanged(string prefabName)
	{
		ItemPrefabConfData itemPrefabConfData = GetItemPrefabConfData(prefabName);
		if (itemPrefabConfData == null)
		{
			return;
		}
		ItemPool value = null;
		if (mItemPoolDict.TryGetValue(prefabName, out value))
		{
			int num = -1;
			Vector3 pos = Vector3.zero;
			if (mItemList.Count > 0)
			{
				num = mItemList[0].ItemIndex;
				pos = mItemList[0].CachedRectTransform.anchoredPosition3D;
			}
			RecycleAllItem();
			ClearAllTmpRecycledItem();
			value.DestroyAllItem();
			value.Init(itemPrefabConfData.mItemPrefab, itemPrefabConfData.mPadding, itemPrefabConfData.mStartPosOffset, itemPrefabConfData.mInitCreateCount, mContainerTrans);
			if (num >= 0)
			{
				RefreshAllShownItemWithFirstIndexAndPos(num, pos);
			}
		}
	}

	public void InitListView(int itemTotalCount, Func<LoopListView2, int, LoopListViewItem2> onGetItemByIndex, LoopListViewInitParam initParam = null)
	{
		if (initParam != null)
		{
			mDistanceForRecycle0 = initParam.mDistanceForRecycle0;
			mDistanceForNew0 = initParam.mDistanceForNew0;
			mDistanceForRecycle1 = initParam.mDistanceForRecycle1;
			mDistanceForNew1 = initParam.mDistanceForNew1;
			mSmoothDumpRate = initParam.mSmoothDumpRate;
			mSnapFinishThreshold = initParam.mSnapFinishThreshold;
			mSnapVecThreshold = initParam.mSnapVecThreshold;
			mItemDefaultWithPaddingSize = initParam.mItemDefaultWithPaddingSize;
		}
		mScrollRect = base.gameObject.GetComponent<ScrollRect>();
		if (mScrollRect == null)
		{
			Log.Error("ListView Init Failed! ScrollRect component not found!");
			return;
		}
		if (mDistanceForRecycle0 <= mDistanceForNew0)
		{
			Log.Error("mDistanceForRecycle0 should be bigger than mDistanceForNew0");
		}
		if (mDistanceForRecycle1 <= mDistanceForNew1)
		{
			Log.Error("mDistanceForRecycle1 should be bigger than mDistanceForNew1");
		}
		mCurSnapData.Clear();
		mItemPosMgr = new ItemPosMgr(mItemDefaultWithPaddingSize);
		mScrollRectTransform = mScrollRect.GetComponent<RectTransform>();
		mContainerTrans = mScrollRect.content;
		mViewPortRectTransform = mScrollRect.viewport;
		if (mViewPortRectTransform == null)
		{
			mViewPortRectTransform = mScrollRectTransform;
		}
		if (mScrollRect.horizontalScrollbarVisibility == ScrollRect.ScrollbarVisibility.AutoHideAndExpandViewport && mScrollRect.horizontalScrollbar != null)
		{
			Log.Error("ScrollRect.horizontalScrollbarVisibility cannot be set to AutoHideAndExpandViewport");
		}
		if (mScrollRect.verticalScrollbarVisibility == ScrollRect.ScrollbarVisibility.AutoHideAndExpandViewport && mScrollRect.verticalScrollbar != null)
		{
			Log.Error("ScrollRect.verticalScrollbarVisibility cannot be set to AutoHideAndExpandViewport");
		}
		mIsVertList = mArrangeType == ListItemArrangeType.TopToBottom || mArrangeType == ListItemArrangeType.BottomToTop;
		mScrollRect.horizontal = !mIsVertList;
		mScrollRect.vertical = mIsVertList;
		SetScrollbarListener();
		AdjustPivot(mViewPortRectTransform);
		AdjustAnchor(mContainerTrans);
		AdjustContainerPivot(mContainerTrans);
		InitItemPool();
		mOnGetItemByIndex = onGetItemByIndex;
		if (mListViewInited)
		{
			Log.Error("LoopListView2.InitListView method can be called only once.");
		}
		mListViewInited = true;
		ResetListView();
		mCurSnapData.Clear();
		mItemTotalCount = itemTotalCount;
		if (mItemTotalCount < 0)
		{
			mSupportScrollBar = false;
		}
		if (mSupportScrollBar)
		{
			mItemPosMgr.SetItemMaxCount(mItemTotalCount);
		}
		else
		{
			mItemPosMgr.SetItemMaxCount(0);
		}
		mCurReadyMaxItemIndex = 0;
		mCurReadyMinItemIndex = 0;
		mLeftSnapUpdateExtraCount = 1;
		mNeedCheckNextMaxItem = true;
		mNeedCheckNextMinItem = true;
		UpdateContentSize();
	}

	public void InitListView(int itemTotalCount, Func<LoopListView2, int, LoopListViewItem2> onGetItemByIndex, bool checkViewport)
	{
		InitListView(itemTotalCount, onGetItemByIndex);
		if (!checkViewport)
		{
			return;
		}
		RectTransform rectTransform = mViewPortRectTransform;
		ItemPrefabConfData itemPrefabConfData = mItemPrefabDataList[0];
		Rect rect = (itemPrefabConfData.mItemPrefab.transform as RectTransform).rect;
		bool flag;
		if (mIsVertList)
		{
			float num = (float)itemTotalCount * (rect.height + itemPrefabConfData.mPadding) - itemPrefabConfData.mPadding;
			num += mPaddingTop + mPaddingBottom;
			flag = rectTransform.rect.height < num;
		}
		else
		{
			float num2 = (float)itemTotalCount * (rect.width + itemPrefabConfData.mPadding) - itemPrefabConfData.mPadding;
			num2 += mPaddingLeft + mPaddingRight;
			flag = rectTransform.rect.width < num2;
		}
		mScrollRect.enabled = flag;
		RectMask2D component3;
		if (rectTransform.TryGetComponent<Mask>(out var component))
		{
			if (rectTransform.TryGetComponent<Image>(out var component2))
			{
				component2.enabled = flag;
			}
			component.enabled = flag;
		}
		else if (rectTransform.TryGetComponent<RectMask2D>(out component3))
		{
			component3.enabled = flag;
		}
	}

	public void SetItemPadding(float padding)
	{
		foreach (ItemPrefabConfData mItemPrefabData in mItemPrefabDataList)
		{
			mItemPrefabData.mPadding = padding;
		}
		foreach (LoopListViewItem2 mItem in mItemList)
		{
			mItem.Padding = padding;
		}
	}

	private void Start()
	{
		if (OnListViewStart != null)
		{
			OnListViewStart(this);
		}
	}

	public void ChangeArrangeType(ListItemArrangeType arrangeType)
	{
		mArrangeType = arrangeType;
		AdjustPivot(mViewPortRectTransform);
		AdjustAnchor(mContainerTrans);
		AdjustContainerPivot(mContainerTrans);
		ResetListView();
	}

	private void SetScrollbarListener()
	{
		mScrollBarClickEventListener = null;
		Scrollbar scrollbar = null;
		if (mIsVertList && mScrollRect.verticalScrollbar != null)
		{
			scrollbar = mScrollRect.verticalScrollbar;
		}
		if (!mIsVertList && mScrollRect.horizontalScrollbar != null)
		{
			scrollbar = mScrollRect.horizontalScrollbar;
		}
		if (!(scrollbar == null))
		{
			ClickEventListener clickEventListener = (mScrollBarClickEventListener = ClickEventListener.Get(scrollbar.gameObject));
			clickEventListener.SetPointerUpHandler(OnPointerUpInScrollBar);
			clickEventListener.SetPointerDownHandler(OnPointerDownInScrollBar);
		}
	}

	private void OnPointerDownInScrollBar(GameObject obj)
	{
		mCurSnapData.Clear();
	}

	private void OnPointerUpInScrollBar(GameObject obj)
	{
		ForceSnapUpdateCheck();
	}

	public void ResetListView(bool resetPos = true)
	{
		mViewPortRectTransform.GetLocalCorners(mViewPortRectLocalCorners);
		if (resetPos)
		{
			mContainerTrans.anchoredPosition3D = Vector3.zero;
		}
		ForceSnapUpdateCheck();
	}

	public void SetListItemCount(int itemCount, bool resetPos = true)
	{
		if (itemCount == mItemTotalCount)
		{
			return;
		}
		mCurSnapData.Clear();
		mItemTotalCount = itemCount;
		if (mItemTotalCount < 0)
		{
			mSupportScrollBar = false;
		}
		if (mSupportScrollBar)
		{
			mItemPosMgr.SetItemMaxCount(mItemTotalCount);
		}
		else
		{
			mItemPosMgr.SetItemMaxCount(0);
		}
		if (mItemTotalCount == 0)
		{
			mCurReadyMaxItemIndex = 0;
			mCurReadyMinItemIndex = 0;
			mNeedCheckNextMaxItem = false;
			mNeedCheckNextMinItem = false;
			RecycleAllItem();
			ClearAllTmpRecycledItem();
			UpdateContentSize();
			return;
		}
		if (mCurReadyMaxItemIndex >= mItemTotalCount)
		{
			mCurReadyMaxItemIndex = mItemTotalCount - 1;
		}
		mLeftSnapUpdateExtraCount = 1;
		mNeedCheckNextMaxItem = true;
		mNeedCheckNextMinItem = true;
		if (resetPos)
		{
			MovePanelToItemIndex(0, 0f);
			return;
		}
		if (mItemList.Count == 0)
		{
			MovePanelToItemIndex(0, 0f);
			return;
		}
		int num = mItemTotalCount - 1;
		if (mItemList[mItemList.Count - 1].ItemIndex <= num)
		{
			UpdateContentSize();
			UpdateAllShownItemsPos();
		}
		else
		{
			MovePanelToItemIndex(num, 0f);
		}
	}

	public LoopListViewItem2 GetShownItemByItemIndex(int itemIndex)
	{
		int count = mItemList.Count;
		if (count == 0)
		{
			return null;
		}
		if (itemIndex < mItemList[0].ItemIndex || itemIndex > mItemList[count - 1].ItemIndex)
		{
			return null;
		}
		int index = itemIndex - mItemList[0].ItemIndex;
		return mItemList[index];
	}

	public LoopListViewItem2 GetShownItemNearestItemIndex(int itemIndex)
	{
		int count = mItemList.Count;
		if (count == 0)
		{
			return null;
		}
		if (itemIndex < mItemList[0].ItemIndex)
		{
			return mItemList[0];
		}
		if (itemIndex > mItemList[count - 1].ItemIndex)
		{
			return mItemList[count - 1];
		}
		int index = itemIndex - mItemList[0].ItemIndex;
		return mItemList[index];
	}

	public LoopListViewItem2 GetShownItemByIndex(int index)
	{
		int count = mItemList.Count;
		if (index < 0 || index >= count)
		{
			return null;
		}
		return mItemList[index];
	}

	public LoopListViewItem2 GetShownItemByIndexWithoutCheck(int index)
	{
		return mItemList[index];
	}

	public int GetIndexInShownItemList(LoopListViewItem2 item)
	{
		if (item == null)
		{
			return -1;
		}
		int count = mItemList.Count;
		if (count == 0)
		{
			return -1;
		}
		for (int i = 0; i < count; i++)
		{
			if (mItemList[i] == item)
			{
				return i;
			}
		}
		return -1;
	}

	public void DoActionForEachShownItem(Action<LoopListViewItem2, object> action, object param)
	{
		if (action == null)
		{
			return;
		}
		int count = mItemList.Count;
		if (count != 0)
		{
			for (int i = 0; i < count; i++)
			{
				action(mItemList[i], param);
			}
		}
	}

	public LoopListViewItem2 NewListViewItem(string itemPrefabName)
	{
		ItemPool value = null;
		if (!mItemPoolDict.TryGetValue(itemPrefabName, out value))
		{
			return null;
		}
		LoopListViewItem2 item = value.GetItem();
		RectTransform component = item.GetComponent<RectTransform>();
		component.SetParent(mContainerTrans);
		component.anchoredPosition3D = Vector3.zero;
		component.localEulerAngles = Vector3.zero;
		item.ParentListView = this;
		return item;
	}

	public void OnItemSizeChanged(int itemIndex)
	{
		LoopListViewItem2 shownItemByItemIndex = GetShownItemByItemIndex(itemIndex);
		if (shownItemByItemIndex == null)
		{
			return;
		}
		if (mSupportScrollBar)
		{
			if (mIsVertList)
			{
				SetItemSize(itemIndex, shownItemByItemIndex.CachedRectTransform.rect.height, shownItemByItemIndex.Padding);
			}
			else
			{
				SetItemSize(itemIndex, shownItemByItemIndex.CachedRectTransform.rect.width, shownItemByItemIndex.Padding);
			}
		}
		UpdateContentSize();
		UpdateAllShownItemsPos();
	}

	public void RefreshItemByItemIndex(int itemIndex)
	{
		int count = mItemList.Count;
		if (count == 0 || itemIndex < mItemList[0].ItemIndex || itemIndex > mItemList[count - 1].ItemIndex)
		{
			return;
		}
		int itemIndex2 = mItemList[0].ItemIndex;
		int index = itemIndex - itemIndex2;
		LoopListViewItem2 loopListViewItem = mItemList[index];
		Vector3 anchoredPosition3D = loopListViewItem.CachedRectTransform.anchoredPosition3D;
		RecycleItemTmp(loopListViewItem);
		LoopListViewItem2 newItemByIndex = GetNewItemByIndex(itemIndex);
		if (newItemByIndex == null)
		{
			RefreshAllShownItemWithFirstIndex(itemIndex2);
			return;
		}
		mItemList[index] = newItemByIndex;
		if (mIsVertList)
		{
			anchoredPosition3D.x = newItemByIndex.StartPosOffset;
		}
		else
		{
			anchoredPosition3D.y = newItemByIndex.StartPosOffset;
		}
		newItemByIndex.CachedRectTransform.anchoredPosition3D = anchoredPosition3D;
		OnItemSizeChanged(itemIndex);
		ClearAllTmpRecycledItem();
	}

	public void FinishSnapImmediately()
	{
		UpdateSnapMove();
	}

	public void MovePanelToItemIndex(int itemIndex, float offset)
	{
		mScrollRect.StopMovement();
		mCurSnapData.Clear();
		if (mItemTotalCount == 0 || (itemIndex < 0 && mItemTotalCount > 0))
		{
			return;
		}
		if (mItemTotalCount > 0 && itemIndex >= mItemTotalCount)
		{
			itemIndex = mItemTotalCount - 1;
		}
		if (offset < 0f)
		{
			offset = 0f;
		}
		Vector3 zero = Vector3.zero;
		float viewPortSize = ViewPortSize;
		if (offset > viewPortSize)
		{
			offset = viewPortSize;
		}
		if (mArrangeType == ListItemArrangeType.TopToBottom)
		{
			float num = mContainerTrans.anchoredPosition3D.y;
			if (num < 0f)
			{
				num = 0f;
			}
			zero.y = 0f - num - offset;
		}
		else if (mArrangeType == ListItemArrangeType.BottomToTop)
		{
			float num2 = mContainerTrans.anchoredPosition3D.y;
			if (num2 > 0f)
			{
				num2 = 0f;
			}
			zero.y = 0f - num2 + offset;
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight)
		{
			float num3 = mContainerTrans.anchoredPosition3D.x;
			if (num3 > 0f)
			{
				num3 = 0f;
			}
			zero.x = 0f - num3 + offset;
		}
		else if (mArrangeType == ListItemArrangeType.RightToLeft)
		{
			float num4 = mContainerTrans.anchoredPosition3D.x;
			if (num4 < 0f)
			{
				num4 = 0f;
			}
			zero.x = 0f - num4 - offset;
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight_Center)
		{
			float num5 = mContainerTrans.anchoredPosition3D.x;
			if (num5 > 0f)
			{
				num5 = 0f;
			}
			zero.x = 0f - num5 + offset;
		}
		RecycleAllItem();
		LoopListViewItem2 newItemByIndex = GetNewItemByIndex(itemIndex);
		if (newItemByIndex == null)
		{
			ClearAllTmpRecycledItem();
			return;
		}
		if (mIsVertList)
		{
			zero.x = newItemByIndex.StartPosOffset;
		}
		else
		{
			zero.y = newItemByIndex.StartPosOffset;
		}
		newItemByIndex.CachedRectTransform.anchoredPosition3D = zero;
		if (mSupportScrollBar)
		{
			if (mIsVertList)
			{
				SetItemSize(itemIndex, newItemByIndex.CachedRectTransform.rect.height, newItemByIndex.Padding);
			}
			else
			{
				SetItemSize(itemIndex, newItemByIndex.CachedRectTransform.rect.width, newItemByIndex.Padding);
			}
		}
		mItemList.Add(newItemByIndex);
		UpdateContentSize();
		UpdateListView(viewPortSize + 100f, viewPortSize + 100f, viewPortSize, viewPortSize);
		AdjustPanelPos();
		ClearAllTmpRecycledItem();
		ForceSnapUpdateCheck();
		UpdateSnapMove(immediate: false, forceSendEvent: true);
	}

	public void RefreshAllShownItem()
	{
		if (mItemList.Count != 0)
		{
			RefreshAllShownItemWithFirstIndex(mItemList[0].ItemIndex);
		}
	}

	public void RefreshAllShownItemWithFirstIndex(int firstItemIndex)
	{
		int count = mItemList.Count;
		if (count == 0)
		{
			return;
		}
		Vector3 anchoredPosition3D = mItemList[0].CachedRectTransform.anchoredPosition3D;
		RecycleAllItem();
		for (int i = 0; i < count; i++)
		{
			int num = firstItemIndex + i;
			LoopListViewItem2 newItemByIndex = GetNewItemByIndex(num);
			if (newItemByIndex == null)
			{
				break;
			}
			if (mIsVertList)
			{
				anchoredPosition3D.x = newItemByIndex.StartPosOffset;
			}
			else
			{
				anchoredPosition3D.y = newItemByIndex.StartPosOffset;
			}
			newItemByIndex.CachedRectTransform.anchoredPosition3D = anchoredPosition3D;
			if (mSupportScrollBar)
			{
				if (mIsVertList)
				{
					SetItemSize(num, newItemByIndex.CachedRectTransform.rect.height, newItemByIndex.Padding);
				}
				else
				{
					SetItemSize(num, newItemByIndex.CachedRectTransform.rect.width, newItemByIndex.Padding);
				}
			}
			mItemList.Add(newItemByIndex);
		}
		UpdateContentSize();
		UpdateAllShownItemsPos();
		ClearAllTmpRecycledItem();
	}

	public void RefreshAllShownItemWithFirstIndexAndPos(int firstItemIndex, Vector3 pos)
	{
		RecycleAllItem();
		LoopListViewItem2 newItemByIndex = GetNewItemByIndex(firstItemIndex);
		if (newItemByIndex == null)
		{
			return;
		}
		if (mIsVertList)
		{
			pos.x = newItemByIndex.StartPosOffset;
		}
		else
		{
			pos.y = newItemByIndex.StartPosOffset;
		}
		newItemByIndex.CachedRectTransform.anchoredPosition3D = pos;
		if (mSupportScrollBar)
		{
			if (mIsVertList)
			{
				SetItemSize(firstItemIndex, newItemByIndex.CachedRectTransform.rect.height, newItemByIndex.Padding);
			}
			else
			{
				SetItemSize(firstItemIndex, newItemByIndex.CachedRectTransform.rect.width, newItemByIndex.Padding);
			}
		}
		mItemList.Add(newItemByIndex);
		UpdateContentSize();
		UpdateAllShownItemsPos();
		UpdateListView(mDistanceForRecycle0, mDistanceForRecycle1, mDistanceForNew0, mDistanceForNew1);
		ClearAllTmpRecycledItem();
	}

	private void RecycleItemTmp(LoopListViewItem2 item)
	{
		if (!(item == null) && !string.IsNullOrEmpty(item.ItemPrefabName))
		{
			ItemPool value = null;
			if (mItemPoolDict.TryGetValue(item.ItemPrefabName, out value))
			{
				value.RecycleItem(item);
			}
		}
	}

	private void ClearAllTmpRecycledItem()
	{
		int count = mItemPoolList.Count;
		for (int i = 0; i < count; i++)
		{
			mItemPoolList[i].ClearTmpRecycledItem();
		}
	}

	private void RecycleAllItem()
	{
		foreach (LoopListViewItem2 mItem in mItemList)
		{
			RecycleItemTmp(mItem);
		}
		mItemList.Clear();
	}

	private void AdjustContainerPivot(RectTransform rtf)
	{
		Vector2 pivot = rtf.pivot;
		if (mArrangeType == ListItemArrangeType.BottomToTop)
		{
			pivot.y = 0f;
		}
		else if (mArrangeType == ListItemArrangeType.TopToBottom)
		{
			pivot.y = 1f;
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight)
		{
			pivot.x = 0f;
		}
		else if (mArrangeType == ListItemArrangeType.RightToLeft)
		{
			pivot.x = 1f;
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight_Center)
		{
			pivot.x = 0.5f;
		}
		rtf.pivot = pivot;
	}

	private void AdjustPivot(RectTransform rtf)
	{
		Vector2 pivot = rtf.pivot;
		if (mArrangeType == ListItemArrangeType.BottomToTop)
		{
			pivot.y = 0f;
		}
		else if (mArrangeType == ListItemArrangeType.TopToBottom)
		{
			pivot.y = 1f;
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight)
		{
			pivot.x = 0f;
		}
		else if (mArrangeType == ListItemArrangeType.RightToLeft)
		{
			pivot.x = 1f;
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight_Center)
		{
			pivot.x = 0.5f;
		}
		rtf.pivot = pivot;
	}

	private void AdjustContainerAnchor(RectTransform rtf)
	{
		Vector2 anchorMin = rtf.anchorMin;
		Vector2 anchorMax = rtf.anchorMax;
		if (mArrangeType == ListItemArrangeType.BottomToTop)
		{
			anchorMin.y = 0f;
			anchorMax.y = 0f;
		}
		else if (mArrangeType == ListItemArrangeType.TopToBottom)
		{
			anchorMin.y = 1f;
			anchorMax.y = 1f;
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight)
		{
			anchorMin.x = 0f;
			anchorMax.x = 0f;
		}
		else if (mArrangeType == ListItemArrangeType.RightToLeft)
		{
			anchorMin.x = 1f;
			anchorMax.x = 1f;
		}
		rtf.anchorMin = anchorMin;
		rtf.anchorMax = anchorMax;
	}

	private void AdjustAnchor(RectTransform rtf)
	{
		Vector2 anchorMin = rtf.anchorMin;
		Vector2 anchorMax = rtf.anchorMax;
		if (mArrangeType == ListItemArrangeType.BottomToTop)
		{
			anchorMin.y = 0f;
			anchorMax.y = 0f;
		}
		else if (mArrangeType == ListItemArrangeType.TopToBottom)
		{
			anchorMin.y = 1f;
			anchorMax.y = 1f;
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight)
		{
			anchorMin.x = 0f;
			anchorMax.x = 0f;
		}
		else if (mArrangeType == ListItemArrangeType.RightToLeft)
		{
			anchorMin.x = 1f;
			anchorMax.x = 1f;
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight_Center)
		{
			anchorMin.x = 0.5f;
			anchorMax.x = 0.5f;
		}
		rtf.anchorMin = anchorMin;
		rtf.anchorMax = anchorMax;
	}

	private void InitItemPool()
	{
		foreach (ItemPrefabConfData mItemPrefabData in mItemPrefabDataList)
		{
			if (mItemPrefabData.mItemPrefab == null)
			{
				Log.Error("A item prefab is null ");
				continue;
			}
			string text = mItemPrefabData.mItemPrefab.name;
			if (mItemPoolDict.ContainsKey(text))
			{
				Log.Error("A item prefab with name " + text + " has existed!");
				continue;
			}
			RectTransform component = mItemPrefabData.mItemPrefab.GetComponent<RectTransform>();
			if (component == null)
			{
				Log.Error("RectTransform component is not found in the prefab " + text);
				continue;
			}
			AdjustAnchor(component);
			AdjustPivot(component);
			if (mItemPrefabData.mItemPrefab.GetComponent<LoopListViewItem2>() == null)
			{
				mItemPrefabData.mItemPrefab.AddComponent<LoopListViewItem2>();
			}
			ItemPool itemPool = new ItemPool();
			itemPool.Init(mItemPrefabData.mItemPrefab, mItemPrefabData.mPadding, mItemPrefabData.mStartPosOffset, mItemPrefabData.mInitCreateCount, mContainerTrans);
			mItemPoolDict.Add(text, itemPool);
			mItemPoolList.Add(itemPool);
		}
	}

	public virtual void OnBeginDrag(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			mIsDraging = true;
			CacheDragPointerEventData(eventData);
			mCurSnapData.Clear();
			if (mOnBeginDragAction != null)
			{
				mOnBeginDragAction();
			}
		}
	}

	public virtual void OnEndDrag(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			mIsDraging = false;
			mPointerEventData = null;
			if (mOnEndDragAction != null)
			{
				mOnEndDragAction();
			}
			ForceSnapUpdateCheck();
		}
	}

	public virtual void OnDrag(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			CacheDragPointerEventData(eventData);
			if (mOnDragingAction != null)
			{
				mOnDragingAction();
			}
		}
	}

	private void CacheDragPointerEventData(PointerEventData eventData)
	{
		if (mPointerEventData == null)
		{
			mPointerEventData = new PointerEventData(EventSystem.current);
		}
		mPointerEventData.button = eventData.button;
		mPointerEventData.position = eventData.position;
		mPointerEventData.pointerPressRaycast = eventData.pointerPressRaycast;
		mPointerEventData.pointerCurrentRaycast = eventData.pointerCurrentRaycast;
	}

	private LoopListViewItem2 GetNewItemByIndex(int index)
	{
		if (mSupportScrollBar && index < 0)
		{
			return null;
		}
		if (mItemTotalCount > 0 && index >= mItemTotalCount)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = mOnGetItemByIndex(this, index);
		if (loopListViewItem == null)
		{
			return null;
		}
		loopListViewItem.ItemIndex = index;
		loopListViewItem.ItemCreatedCheckFrameCount = mListUpdateCheckFrameCount;
		return loopListViewItem;
	}

	private void SetItemSize(int itemIndex, float itemSize, float padding)
	{
		mItemPosMgr.SetItemSize(itemIndex, itemSize + padding);
		if (itemIndex >= mLastItemIndex)
		{
			mLastItemIndex = itemIndex;
			mLastItemPadding = padding;
		}
	}

	private bool GetPlusItemIndexAndPosAtGivenPos(float pos, ref int index, ref float itemPos)
	{
		return mItemPosMgr.GetItemIndexAndPosAtGivenPos(pos, ref index, ref itemPos);
	}

	private float GetItemPos(int itemIndex)
	{
		return mItemPosMgr.GetItemPos(itemIndex);
	}

	public Vector3 GetItemCornerPosInViewPort(LoopListViewItem2 item, ItemCornerEnum corner = ItemCornerEnum.LeftBottom)
	{
		item.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
		return mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[(int)corner]);
	}

	private void AdjustPanelPos()
	{
		if (mItemList.Count == 0)
		{
			return;
		}
		UpdateAllShownItemsPos();
		float viewPortSize = ViewPortSize;
		float contentPanelSize = GetContentPanelSize();
		if (mArrangeType == ListItemArrangeType.TopToBottom)
		{
			if (contentPanelSize <= viewPortSize)
			{
				Vector3 anchoredPosition3D = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D.y = 0f;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D;
				mItemList[0].CachedRectTransform.anchoredPosition3D = new Vector3(mItemList[0].StartPosOffset, 0f, 0f);
				UpdateAllShownItemsPos();
				return;
			}
			mItemList[0].CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			if (mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]).y < mViewPortRectLocalCorners[1].y)
			{
				Vector3 anchoredPosition3D2 = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D2.y = 0f;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D2;
				mItemList[0].CachedRectTransform.anchoredPosition3D = new Vector3(mItemList[0].StartPosOffset, 0f, 0f);
				UpdateAllShownItemsPos();
				return;
			}
			mItemList[mItemList.Count - 1].CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			float num = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[0]).y - mViewPortRectLocalCorners[0].y;
			if (num > 0f)
			{
				Vector3 anchoredPosition3D3 = mItemList[0].CachedRectTransform.anchoredPosition3D;
				anchoredPosition3D3.y -= num;
				mItemList[0].CachedRectTransform.anchoredPosition3D = anchoredPosition3D3;
				UpdateAllShownItemsPos();
			}
		}
		else if (mArrangeType == ListItemArrangeType.BottomToTop)
		{
			if (contentPanelSize <= viewPortSize)
			{
				Vector3 anchoredPosition3D4 = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D4.y = 0f;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D4;
				mItemList[0].CachedRectTransform.anchoredPosition3D = new Vector3(mItemList[0].StartPosOffset, 0f, 0f);
				UpdateAllShownItemsPos();
				return;
			}
			mItemList[0].CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			if (mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[0]).y > mViewPortRectLocalCorners[0].y)
			{
				Vector3 anchoredPosition3D5 = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D5.y = 0f;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D5;
				mItemList[0].CachedRectTransform.anchoredPosition3D = new Vector3(mItemList[0].StartPosOffset, 0f, 0f);
				UpdateAllShownItemsPos();
				return;
			}
			mItemList[mItemList.Count - 1].CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]);
			float num2 = mViewPortRectLocalCorners[1].y - vector.y;
			if (num2 > 0f)
			{
				Vector3 anchoredPosition3D6 = mItemList[0].CachedRectTransform.anchoredPosition3D;
				anchoredPosition3D6.y += num2;
				mItemList[0].CachedRectTransform.anchoredPosition3D = anchoredPosition3D6;
				UpdateAllShownItemsPos();
			}
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight)
		{
			if (contentPanelSize <= viewPortSize)
			{
				Vector3 anchoredPosition3D7 = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D7.x = 0f;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D7;
				mItemList[0].CachedRectTransform.anchoredPosition3D = new Vector3(0f, mItemList[0].StartPosOffset, 0f);
				UpdateAllShownItemsPos();
				return;
			}
			mItemList[0].CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			if (mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]).x > mViewPortRectLocalCorners[1].x)
			{
				Vector3 anchoredPosition3D8 = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D8.x = 0f;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D8;
				mItemList[0].CachedRectTransform.anchoredPosition3D = new Vector3(0f, mItemList[0].StartPosOffset, 0f);
				UpdateAllShownItemsPos();
				return;
			}
			mItemList[mItemList.Count - 1].CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector2 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[2]);
			float num3 = mViewPortRectLocalCorners[2].x - vector2.x;
			if (num3 > 0f)
			{
				Vector3 anchoredPosition3D9 = mItemList[0].CachedRectTransform.anchoredPosition3D;
				anchoredPosition3D9.x += num3;
				mItemList[0].CachedRectTransform.anchoredPosition3D = anchoredPosition3D9;
				UpdateAllShownItemsPos();
			}
		}
		else if (mArrangeType == ListItemArrangeType.RightToLeft)
		{
			if (contentPanelSize <= viewPortSize)
			{
				Vector3 anchoredPosition3D10 = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D10.x = 0f;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D10;
				mItemList[0].CachedRectTransform.anchoredPosition3D = new Vector3(0f, mItemList[0].StartPosOffset, 0f);
				UpdateAllShownItemsPos();
				return;
			}
			mItemList[0].CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			if (mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[2]).x < mViewPortRectLocalCorners[2].x)
			{
				Vector3 anchoredPosition3D11 = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D11.x = 0f;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D11;
				mItemList[0].CachedRectTransform.anchoredPosition3D = new Vector3(0f, mItemList[0].StartPosOffset, 0f);
				UpdateAllShownItemsPos();
				return;
			}
			mItemList[mItemList.Count - 1].CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			float num4 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]).x - mViewPortRectLocalCorners[1].x;
			if (num4 > 0f)
			{
				Vector3 anchoredPosition3D12 = mItemList[0].CachedRectTransform.anchoredPosition3D;
				anchoredPosition3D12.x -= num4;
				mItemList[0].CachedRectTransform.anchoredPosition3D = anchoredPosition3D12;
				UpdateAllShownItemsPos();
			}
		}
		else
		{
			if (mArrangeType != ListItemArrangeType.LeftToRight_Center)
			{
				return;
			}
			if (contentPanelSize <= viewPortSize)
			{
				Vector3 anchoredPosition3D13 = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D13.x = 0f;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D13;
				float x = 0f - mContainerTrans.rect.width / 2f + mItemList[0].CachedRectTransform.rect.width / 2f;
				mItemList[0].CachedRectTransform.anchoredPosition3D = new Vector3(x, mItemList[0].StartPosOffset, 0f);
				UpdateAllShownItemsPos();
				return;
			}
			mItemList[0].CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			if (mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]).x < mViewPortRectLocalCorners[1].x)
			{
				Vector3 anchoredPosition3D14 = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D14.x = 0f;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D14;
				float x2 = 0f - mContainerTrans.rect.width / 2f + mItemList[0].CachedRectTransform.rect.width / 2f;
				mItemList[0].CachedRectTransform.anchoredPosition3D = new Vector3(x2, mItemList[0].StartPosOffset, 0f);
				UpdateAllShownItemsPos();
				return;
			}
			mItemList[mItemList.Count - 1].CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector3 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[2]);
			float num5 = mViewPortRectLocalCorners[2].x - vector3.x;
			if (num5 > 0f)
			{
				Vector3 anchoredPosition3D15 = mItemList[0].CachedRectTransform.anchoredPosition3D;
				anchoredPosition3D15.x += num5;
				mItemList[0].CachedRectTransform.anchoredPosition3D = anchoredPosition3D15;
				UpdateAllShownItemsPos();
			}
		}
	}

	private void Update()
	{
		if (!mListViewInited)
		{
			return;
		}
		if (mNeedAdjustVec)
		{
			mNeedAdjustVec = false;
			if (mIsVertList)
			{
				if (mScrollRect.velocity.y * mAdjustedVec.y > 0f)
				{
					mScrollRect.velocity = mAdjustedVec;
				}
			}
			else if (mScrollRect.velocity.x * mAdjustedVec.x > 0f)
			{
				mScrollRect.velocity = mAdjustedVec;
			}
		}
		if (mSupportScrollBar)
		{
			mItemPosMgr.Update(updateAll: false);
		}
		UpdateSnapMove();
		UpdateListView(mDistanceForRecycle0, mDistanceForRecycle1, mDistanceForNew0, mDistanceForNew1);
		ClearAllTmpRecycledItem();
		mLastFrameContainerPos = mContainerTrans.anchoredPosition3D;
	}

	private void UpdateSnapMove(bool immediate = true, bool forceSendEvent = false)
	{
		if (mItemSnapEnable)
		{
			if (mIsVertList)
			{
				UpdateSnapVertical(immediate, forceSendEvent);
			}
			else
			{
				UpdateSnapHorizontal(immediate, forceSendEvent);
			}
		}
	}

	public void UpdateAllShownItemSnapData()
	{
		if (!mItemSnapEnable)
		{
			return;
		}
		int count = mItemList.Count;
		if (count == 0)
		{
			return;
		}
		_ = mContainerTrans.anchoredPosition3D;
		LoopListViewItem2 loopListViewItem = mItemList[0];
		loopListViewItem.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		float num4 = 0f;
		if (mArrangeType == ListItemArrangeType.TopToBottom)
		{
			num4 = (0f - (1f - mViewPortSnapPivot.y)) * mViewPortRectTransform.rect.height;
			num = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]).y;
			num2 = num - loopListViewItem.ItemSizeWithPadding;
			num3 = num - loopListViewItem.ItemSize * (1f - mItemSnapPivot.y);
			for (int i = 0; i < count; i++)
			{
				mItemList[i].DistanceWithViewPortSnapCenter = num4 - num3;
				if (i + 1 < count)
				{
					num = num2;
					num2 -= mItemList[i + 1].ItemSizeWithPadding;
					num3 = num - mItemList[i + 1].ItemSize * (1f - mItemSnapPivot.y);
				}
			}
		}
		else if (mArrangeType == ListItemArrangeType.BottomToTop)
		{
			num4 = mViewPortSnapPivot.y * mViewPortRectTransform.rect.height;
			num = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[0]).y;
			num2 = num + loopListViewItem.ItemSizeWithPadding;
			num3 = num + loopListViewItem.ItemSize * mItemSnapPivot.y;
			for (int j = 0; j < count; j++)
			{
				mItemList[j].DistanceWithViewPortSnapCenter = num4 - num3;
				if (j + 1 < count)
				{
					num = num2;
					num2 += mItemList[j + 1].ItemSizeWithPadding;
					num3 = num + mItemList[j + 1].ItemSize * mItemSnapPivot.y;
				}
			}
		}
		else if (mArrangeType == ListItemArrangeType.RightToLeft)
		{
			num4 = (0f - (1f - mViewPortSnapPivot.x)) * mViewPortRectTransform.rect.width;
			num = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[2]).x;
			num2 = num - loopListViewItem.ItemSizeWithPadding;
			num3 = num - loopListViewItem.ItemSize * (1f - mItemSnapPivot.x);
			for (int k = 0; k < count; k++)
			{
				mItemList[k].DistanceWithViewPortSnapCenter = num4 - num3;
				if (k + 1 < count)
				{
					num = num2;
					num2 -= mItemList[k + 1].ItemSizeWithPadding;
					num3 = num - mItemList[k + 1].ItemSize * (1f - mItemSnapPivot.x);
				}
			}
		}
		else
		{
			if (mArrangeType != ListItemArrangeType.LeftToRight)
			{
				return;
			}
			num4 = mViewPortSnapPivot.x * mViewPortRectTransform.rect.width;
			num = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]).x;
			num2 = num + loopListViewItem.ItemSizeWithPadding;
			num3 = num + loopListViewItem.ItemSize * mItemSnapPivot.x;
			for (int l = 0; l < count; l++)
			{
				mItemList[l].DistanceWithViewPortSnapCenter = num4 - num3;
				if (l + 1 < count)
				{
					num = num2;
					num2 += mItemList[l + 1].ItemSizeWithPadding;
					num3 = num + mItemList[l + 1].ItemSize * mItemSnapPivot.x;
				}
			}
		}
	}

	private void UpdateSnapVertical(bool immediate = false, bool forceSendEvent = false)
	{
		if (!mItemSnapEnable)
		{
			return;
		}
		int count = mItemList.Count;
		if (count == 0)
		{
			return;
		}
		Vector3 anchoredPosition3D = mContainerTrans.anchoredPosition3D;
		bool flag = anchoredPosition3D.y != mLastSnapCheckPos.y;
		mLastSnapCheckPos = anchoredPosition3D;
		if (!flag && mLeftSnapUpdateExtraCount > 0)
		{
			mLeftSnapUpdateExtraCount--;
			flag = true;
		}
		if (flag)
		{
			LoopListViewItem2 loopListViewItem = mItemList[0];
			loopListViewItem.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			int num = -1;
			float num2 = 0f;
			float num3 = 0f;
			float num4 = 0f;
			float num5 = float.MaxValue;
			float num6 = 0f;
			float num7 = 0f;
			if (mArrangeType == ListItemArrangeType.TopToBottom)
			{
				num7 = (0f - (1f - mViewPortSnapPivot.y)) * mViewPortRectTransform.rect.height;
				num2 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]).y;
				num3 = num2 - loopListViewItem.ItemSizeWithPadding;
				num4 = num2 - loopListViewItem.ItemSize * (1f - mItemSnapPivot.y);
				for (int i = 0; i < count; i++)
				{
					num6 = Mathf.Abs(num7 - num4);
					if (!(num6 < num5))
					{
						break;
					}
					num5 = num6;
					num = i;
					if (i + 1 < count)
					{
						num2 = num3;
						num3 -= mItemList[i + 1].ItemSizeWithPadding;
						num4 = num2 - mItemList[i + 1].ItemSize * (1f - mItemSnapPivot.y);
					}
				}
			}
			else if (mArrangeType == ListItemArrangeType.BottomToTop)
			{
				num7 = mViewPortSnapPivot.y * mViewPortRectTransform.rect.height;
				num2 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[0]).y;
				num3 = num2 + loopListViewItem.ItemSizeWithPadding;
				num4 = num2 + loopListViewItem.ItemSize * mItemSnapPivot.y;
				for (int j = 0; j < count; j++)
				{
					num6 = Mathf.Abs(num7 - num4);
					if (!(num6 < num5))
					{
						break;
					}
					num5 = num6;
					num = j;
					if (j + 1 < count)
					{
						num2 = num3;
						num3 += mItemList[j + 1].ItemSizeWithPadding;
						num4 = num2 + mItemList[j + 1].ItemSize * mItemSnapPivot.y;
					}
				}
			}
			if (num >= 0)
			{
				int num8 = mCurSnapNearestItemIndex;
				mCurSnapNearestItemIndex = mItemList[num].ItemIndex;
				if ((forceSendEvent || (num8 >= 0 && mItemList[num].ItemIndex != num8)) && mOnSnapNearestChanged != null)
				{
					mOnSnapNearestChanged(this, mItemList[num]);
				}
			}
			else
			{
				mCurSnapNearestItemIndex = -1;
			}
		}
		if (!CanSnap())
		{
			ClearSnapData();
			return;
		}
		float num9 = Mathf.Abs(mScrollRect.velocity.y);
		UpdateCurSnapData();
		if (mCurSnapData.mSnapStatus != SnapStatus.SnapMoving)
		{
			return;
		}
		if (num9 > 0f)
		{
			mScrollRect.StopMovement();
		}
		float mCurSnapVal = mCurSnapData.mCurSnapVal;
		if (!mCurSnapData.mIsTempTarget)
		{
			if (mSmoothDumpVel * mCurSnapData.mTargetSnapVal < 0f)
			{
				mSmoothDumpVel = 0f;
			}
			mCurSnapData.mCurSnapVal = Mathf.SmoothDamp(mCurSnapData.mCurSnapVal, mCurSnapData.mTargetSnapVal, ref mSmoothDumpVel, mSmoothDumpRate);
		}
		else
		{
			float mMoveMaxAbsVec = mCurSnapData.mMoveMaxAbsVec;
			if (mMoveMaxAbsVec <= 0f)
			{
				mMoveMaxAbsVec = mSnapMoveDefaultMaxAbsVec;
			}
			mSmoothDumpVel = mMoveMaxAbsVec * Mathf.Sign(mCurSnapData.mTargetSnapVal);
			mCurSnapData.mCurSnapVal = Mathf.MoveTowards(mCurSnapData.mCurSnapVal, mCurSnapData.mTargetSnapVal, mMoveMaxAbsVec * Time.deltaTime);
		}
		float num10 = mCurSnapData.mCurSnapVal - mCurSnapVal;
		if (immediate || Mathf.Abs(mCurSnapData.mTargetSnapVal - mCurSnapData.mCurSnapVal) < mSnapFinishThreshold)
		{
			anchoredPosition3D.y = anchoredPosition3D.y + mCurSnapData.mTargetSnapVal - mCurSnapVal;
			mCurSnapData.mSnapStatus = SnapStatus.SnapMoveFinish;
			if (mOnSnapItemFinished != null)
			{
				LoopListViewItem2 shownItemByItemIndex = GetShownItemByItemIndex(mCurSnapNearestItemIndex);
				if (shownItemByItemIndex != null)
				{
					mOnSnapItemFinished(this, shownItemByItemIndex);
				}
			}
		}
		else
		{
			anchoredPosition3D.y += num10;
		}
		if (mArrangeType == ListItemArrangeType.TopToBottom)
		{
			float max = mViewPortRectLocalCorners[0].y + mContainerTrans.rect.height;
			anchoredPosition3D.y = Mathf.Clamp(anchoredPosition3D.y, 0f, max);
			mContainerTrans.anchoredPosition3D = anchoredPosition3D;
		}
		else if (mArrangeType == ListItemArrangeType.BottomToTop)
		{
			float min = mViewPortRectLocalCorners[1].y - mContainerTrans.rect.height;
			anchoredPosition3D.y = Mathf.Clamp(anchoredPosition3D.y, min, 0f);
			mContainerTrans.anchoredPosition3D = anchoredPosition3D;
		}
	}

	private void UpdateCurSnapData()
	{
		if (mItemList.Count == 0)
		{
			mCurSnapData.Clear();
			return;
		}
		if (mCurSnapData.mSnapStatus == SnapStatus.SnapMoveFinish)
		{
			if (mCurSnapData.mSnapTargetIndex == mCurSnapNearestItemIndex)
			{
				return;
			}
			mCurSnapData.mSnapStatus = SnapStatus.NoTargetSet;
		}
		if (mCurSnapData.mSnapStatus == SnapStatus.SnapMoving)
		{
			if (mCurSnapData.mIsForceSnapTo)
			{
				if (mCurSnapData.mIsTempTarget)
				{
					LoopListViewItem2 shownItemNearestItemIndex = GetShownItemNearestItemIndex(mCurSnapData.mSnapTargetIndex);
					if (shownItemNearestItemIndex == null)
					{
						mCurSnapData.Clear();
					}
					else if (shownItemNearestItemIndex.ItemIndex == mCurSnapData.mSnapTargetIndex)
					{
						UpdateAllShownItemSnapData();
						mCurSnapData.mTargetSnapVal = shownItemNearestItemIndex.DistanceWithViewPortSnapCenter;
						mCurSnapData.mCurSnapVal = 0f;
						mCurSnapData.mIsTempTarget = false;
						mCurSnapData.mSnapStatus = SnapStatus.SnapMoving;
					}
					else if (mCurSnapData.mTempTargetIndex != shownItemNearestItemIndex.ItemIndex)
					{
						UpdateAllShownItemSnapData();
						mCurSnapData.mTargetSnapVal = shownItemNearestItemIndex.DistanceWithViewPortSnapCenter;
						mCurSnapData.mCurSnapVal = 0f;
						mCurSnapData.mSnapStatus = SnapStatus.SnapMoving;
						mCurSnapData.mIsTempTarget = true;
						mCurSnapData.mTempTargetIndex = shownItemNearestItemIndex.ItemIndex;
					}
				}
				return;
			}
			if (mCurSnapData.mSnapTargetIndex == mCurSnapNearestItemIndex)
			{
				return;
			}
			mCurSnapData.mSnapStatus = SnapStatus.NoTargetSet;
		}
		if (mCurSnapData.mSnapStatus == SnapStatus.NoTargetSet)
		{
			if (GetShownItemByItemIndex(mCurSnapNearestItemIndex) == null)
			{
				return;
			}
			mCurSnapData.mSnapTargetIndex = mCurSnapNearestItemIndex;
			mCurSnapData.mSnapStatus = SnapStatus.TargetHasSet;
			mCurSnapData.mIsForceSnapTo = false;
		}
		if (mCurSnapData.mSnapStatus == SnapStatus.TargetHasSet)
		{
			LoopListViewItem2 shownItemNearestItemIndex2 = GetShownItemNearestItemIndex(mCurSnapData.mSnapTargetIndex);
			if (shownItemNearestItemIndex2 == null)
			{
				mCurSnapData.Clear();
			}
			else if (shownItemNearestItemIndex2.ItemIndex == mCurSnapData.mSnapTargetIndex)
			{
				UpdateAllShownItemSnapData();
				mCurSnapData.mTargetSnapVal = shownItemNearestItemIndex2.DistanceWithViewPortSnapCenter;
				mCurSnapData.mCurSnapVal = 0f;
				mCurSnapData.mIsTempTarget = false;
				mCurSnapData.mSnapStatus = SnapStatus.SnapMoving;
			}
			else
			{
				UpdateAllShownItemSnapData();
				mCurSnapData.mTargetSnapVal = shownItemNearestItemIndex2.DistanceWithViewPortSnapCenter;
				mCurSnapData.mCurSnapVal = 0f;
				mCurSnapData.mSnapStatus = SnapStatus.SnapMoving;
				mCurSnapData.mIsTempTarget = true;
				mCurSnapData.mTempTargetIndex = shownItemNearestItemIndex2.ItemIndex;
			}
		}
	}

	public void ClearSnapData()
	{
		mCurSnapData.Clear();
	}

	public void SetSnapTargetItemIndex(int itemIndex, float moveMaxAbsVec = -1f)
	{
		if (mItemTotalCount > 0)
		{
			if (itemIndex >= mItemTotalCount)
			{
				itemIndex = mItemTotalCount - 1;
			}
			if (itemIndex < 0)
			{
				itemIndex = 0;
			}
		}
		mScrollRect.StopMovement();
		mCurSnapData.mSnapTargetIndex = itemIndex;
		mCurSnapData.mSnapStatus = SnapStatus.TargetHasSet;
		mCurSnapData.mIsForceSnapTo = true;
		mCurSnapData.mMoveMaxAbsVec = moveMaxAbsVec;
	}

	public void ForceSnapUpdateCheck()
	{
		if (mLeftSnapUpdateExtraCount <= 0)
		{
			mLeftSnapUpdateExtraCount = 1;
		}
	}

	private void UpdateSnapHorizontal(bool immediate = false, bool forceSendEvent = false)
	{
		if (!mItemSnapEnable)
		{
			return;
		}
		int count = mItemList.Count;
		if (count == 0)
		{
			return;
		}
		Vector3 anchoredPosition3D = mContainerTrans.anchoredPosition3D;
		bool flag = anchoredPosition3D.x != mLastSnapCheckPos.x;
		mLastSnapCheckPos = anchoredPosition3D;
		if (!flag && mLeftSnapUpdateExtraCount > 0)
		{
			mLeftSnapUpdateExtraCount--;
			flag = true;
		}
		if (flag)
		{
			LoopListViewItem2 loopListViewItem = mItemList[0];
			loopListViewItem.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			int num = -1;
			float num2 = 0f;
			float num3 = 0f;
			float num4 = 0f;
			float num5 = float.MaxValue;
			float num6 = 0f;
			float num7 = 0f;
			if (mArrangeType == ListItemArrangeType.RightToLeft)
			{
				num7 = (0f - (1f - mViewPortSnapPivot.x)) * mViewPortRectTransform.rect.width;
				num2 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[2]).x;
				num3 = num2 - loopListViewItem.ItemSizeWithPadding;
				num4 = num2 - loopListViewItem.ItemSize * (1f - mItemSnapPivot.x);
				for (int i = 0; i < count; i++)
				{
					num6 = Mathf.Abs(num7 - num4);
					if (!(num6 < num5))
					{
						break;
					}
					num5 = num6;
					num = i;
					if (i + 1 < count)
					{
						num2 = num3;
						num3 -= mItemList[i + 1].ItemSizeWithPadding;
						num4 = num2 - mItemList[i + 1].ItemSize * (1f - mItemSnapPivot.x);
					}
				}
			}
			else if (mArrangeType == ListItemArrangeType.LeftToRight)
			{
				num7 = mViewPortSnapPivot.x * mViewPortRectTransform.rect.width;
				num2 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]).x;
				num3 = num2 + loopListViewItem.ItemSizeWithPadding;
				num4 = num2 + loopListViewItem.ItemSize * mItemSnapPivot.x;
				for (int j = 0; j < count; j++)
				{
					num6 = Mathf.Abs(num7 - num4);
					if (!(num6 < num5))
					{
						break;
					}
					num5 = num6;
					num = j;
					if (j + 1 < count)
					{
						num2 = num3;
						num3 += mItemList[j + 1].ItemSizeWithPadding;
						num4 = num2 + mItemList[j + 1].ItemSize * mItemSnapPivot.x;
					}
				}
			}
			if (num >= 0)
			{
				int num8 = mCurSnapNearestItemIndex;
				mCurSnapNearestItemIndex = mItemList[num].ItemIndex;
				if ((forceSendEvent || (num8 >= 0 && mItemList[num].ItemIndex != num8)) && mOnSnapNearestChanged != null)
				{
					mOnSnapNearestChanged(this, mItemList[num]);
				}
			}
			else
			{
				mCurSnapNearestItemIndex = -1;
			}
		}
		if (!CanSnap())
		{
			ClearSnapData();
			return;
		}
		float num9 = Mathf.Abs(mScrollRect.velocity.x);
		UpdateCurSnapData();
		if (mCurSnapData.mSnapStatus != SnapStatus.SnapMoving)
		{
			return;
		}
		if (num9 > 0f)
		{
			mScrollRect.StopMovement();
		}
		float mCurSnapVal = mCurSnapData.mCurSnapVal;
		if (!mCurSnapData.mIsTempTarget)
		{
			if (mSmoothDumpVel * mCurSnapData.mTargetSnapVal < 0f)
			{
				mSmoothDumpVel = 0f;
			}
			mCurSnapData.mCurSnapVal = Mathf.SmoothDamp(mCurSnapData.mCurSnapVal, mCurSnapData.mTargetSnapVal, ref mSmoothDumpVel, mSmoothDumpRate);
		}
		else
		{
			float mMoveMaxAbsVec = mCurSnapData.mMoveMaxAbsVec;
			if (mMoveMaxAbsVec <= 0f)
			{
				mMoveMaxAbsVec = mSnapMoveDefaultMaxAbsVec;
			}
			mSmoothDumpVel = mMoveMaxAbsVec * Mathf.Sign(mCurSnapData.mTargetSnapVal);
			mCurSnapData.mCurSnapVal = Mathf.MoveTowards(mCurSnapData.mCurSnapVal, mCurSnapData.mTargetSnapVal, mMoveMaxAbsVec * Time.deltaTime);
		}
		float num10 = mCurSnapData.mCurSnapVal - mCurSnapVal;
		if (immediate || Mathf.Abs(mCurSnapData.mTargetSnapVal - mCurSnapData.mCurSnapVal) < mSnapFinishThreshold)
		{
			anchoredPosition3D.x = anchoredPosition3D.x + mCurSnapData.mTargetSnapVal - mCurSnapVal;
			mCurSnapData.mSnapStatus = SnapStatus.SnapMoveFinish;
			if (mOnSnapItemFinished != null)
			{
				LoopListViewItem2 shownItemByItemIndex = GetShownItemByItemIndex(mCurSnapNearestItemIndex);
				if (shownItemByItemIndex != null)
				{
					mOnSnapItemFinished(this, shownItemByItemIndex);
				}
			}
		}
		else
		{
			anchoredPosition3D.x += num10;
		}
		if (mArrangeType == ListItemArrangeType.LeftToRight)
		{
			float min = mViewPortRectLocalCorners[2].x - mContainerTrans.rect.width;
			anchoredPosition3D.x = Mathf.Clamp(anchoredPosition3D.x, min, 0f);
			mContainerTrans.anchoredPosition3D = anchoredPosition3D;
		}
		else if (mArrangeType == ListItemArrangeType.RightToLeft)
		{
			float max = mViewPortRectLocalCorners[1].x + mContainerTrans.rect.width;
			anchoredPosition3D.x = Mathf.Clamp(anchoredPosition3D.x, 0f, max);
			mContainerTrans.anchoredPosition3D = anchoredPosition3D;
		}
	}

	private bool CanSnap()
	{
		if (mIsDraging)
		{
			return false;
		}
		if (mScrollBarClickEventListener != null && mScrollBarClickEventListener.IsPressd)
		{
			return false;
		}
		if (mIsVertList)
		{
			if (mContainerTrans.rect.height <= ViewPortHeight)
			{
				return false;
			}
		}
		else if (mContainerTrans.rect.width <= ViewPortWidth)
		{
			return false;
		}
		float num = 0f;
		num = ((!mIsVertList) ? Mathf.Abs(mScrollRect.velocity.x) : Mathf.Abs(mScrollRect.velocity.y));
		if (num > mSnapVecThreshold)
		{
			return false;
		}
		float num2 = 3f;
		Vector3 anchoredPosition3D = mContainerTrans.anchoredPosition3D;
		if (mArrangeType == ListItemArrangeType.LeftToRight)
		{
			float num3 = mViewPortRectLocalCorners[2].x - mContainerTrans.rect.width;
			if (anchoredPosition3D.x < num3 - num2 || anchoredPosition3D.x > num2)
			{
				return false;
			}
		}
		else if (mArrangeType == ListItemArrangeType.RightToLeft)
		{
			float num4 = mViewPortRectLocalCorners[1].x + mContainerTrans.rect.width;
			if (anchoredPosition3D.x > num4 + num2 || anchoredPosition3D.x < 0f - num2)
			{
				return false;
			}
		}
		else if (mArrangeType == ListItemArrangeType.TopToBottom)
		{
			float num5 = mViewPortRectLocalCorners[0].y + mContainerTrans.rect.height;
			if (anchoredPosition3D.y > num5 + num2 || anchoredPosition3D.y < 0f - num2)
			{
				return false;
			}
		}
		else if (mArrangeType == ListItemArrangeType.BottomToTop)
		{
			float num6 = mViewPortRectLocalCorners[1].y - mContainerTrans.rect.height;
			if (anchoredPosition3D.y < num6 - num2 || anchoredPosition3D.y > num2)
			{
				return false;
			}
		}
		return true;
	}

	public void UpdateListView(float distanceForRecycle0, float distanceForRecycle1, float distanceForNew0, float distanceForNew1)
	{
		mListUpdateCheckFrameCount++;
		if (mIsVertList)
		{
			bool flag = true;
			int num = 0;
			int num2 = 9999;
			while (flag)
			{
				num++;
				if (num >= num2)
				{
					Log.Error("UpdateListView Vertical while loop " + num + " times! something is wrong!");
					break;
				}
				flag = UpdateForVertList(distanceForRecycle0, distanceForRecycle1, distanceForNew0, distanceForNew1);
			}
			return;
		}
		bool flag2 = true;
		int num3 = 0;
		int num4 = 9999;
		while (flag2)
		{
			num3++;
			if (num3 >= num4)
			{
				Log.Error("UpdateListView  Horizontal while loop " + num3 + " times! something is wrong!");
				break;
			}
			flag2 = UpdateForHorizontalList(distanceForRecycle0, distanceForRecycle1, distanceForNew0, distanceForNew1);
		}
	}

	private bool UpdateForVertList(float distanceForRecycle0, float distanceForRecycle1, float distanceForNew0, float distanceForNew1)
	{
		if (mItemTotalCount == 0)
		{
			if (mItemList.Count > 0)
			{
				RecycleAllItem();
			}
			return false;
		}
		if (mArrangeType == ListItemArrangeType.TopToBottom)
		{
			if (mItemList.Count == 0)
			{
				float num = mContainerTrans.anchoredPosition3D.y;
				if (num < 0f)
				{
					num = 0f;
				}
				int index = 0;
				float itemPos = 0f - num;
				if (mSupportScrollBar)
				{
					if (!GetPlusItemIndexAndPosAtGivenPos(num, ref index, ref itemPos))
					{
						return false;
					}
					itemPos = 0f - itemPos;
				}
				LoopListViewItem2 newItemByIndex = GetNewItemByIndex(index);
				if (newItemByIndex == null)
				{
					return false;
				}
				if (mSupportScrollBar)
				{
					SetItemSize(index, newItemByIndex.CachedRectTransform.rect.height, newItemByIndex.Padding);
				}
				mItemList.Add(newItemByIndex);
				itemPos += mPaddingTop;
				newItemByIndex.CachedRectTransform.anchoredPosition3D = new Vector3(newItemByIndex.StartPosOffset, itemPos, 0f);
				UpdateContentSize();
				return true;
			}
			LoopListViewItem2 loopListViewItem = mItemList[0];
			loopListViewItem.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]);
			Vector3 vector2 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[0]);
			if (!mIsDraging && loopListViewItem.ItemCreatedCheckFrameCount != mListUpdateCheckFrameCount && vector2.y - mViewPortRectLocalCorners[1].y > distanceForRecycle0)
			{
				mItemList.RemoveAt(0);
				RecycleItemTmp(loopListViewItem);
				if (!mSupportScrollBar)
				{
					UpdateContentSize();
					CheckIfNeedUpdataItemPos();
				}
				return true;
			}
			LoopListViewItem2 loopListViewItem2 = mItemList[mItemList.Count - 1];
			loopListViewItem2.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector3 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]);
			Vector3 vector4 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[0]);
			if (!mIsDraging && loopListViewItem2.ItemCreatedCheckFrameCount != mListUpdateCheckFrameCount && mViewPortRectLocalCorners[0].y - vector3.y > distanceForRecycle1)
			{
				mItemList.RemoveAt(mItemList.Count - 1);
				RecycleItemTmp(loopListViewItem2);
				if (!mSupportScrollBar)
				{
					UpdateContentSize();
					CheckIfNeedUpdataItemPos();
				}
				return true;
			}
			if (mViewPortRectLocalCorners[0].y - vector4.y < distanceForNew1)
			{
				if (loopListViewItem2.ItemIndex > mCurReadyMaxItemIndex)
				{
					mCurReadyMaxItemIndex = loopListViewItem2.ItemIndex;
					mNeedCheckNextMaxItem = true;
				}
				int num2 = loopListViewItem2.ItemIndex + 1;
				if (num2 <= mCurReadyMaxItemIndex || mNeedCheckNextMaxItem)
				{
					LoopListViewItem2 newItemByIndex2 = GetNewItemByIndex(num2);
					if (!(newItemByIndex2 == null))
					{
						if (mSupportScrollBar)
						{
							SetItemSize(num2, newItemByIndex2.CachedRectTransform.rect.height, newItemByIndex2.Padding);
						}
						mItemList.Add(newItemByIndex2);
						float y = loopListViewItem2.CachedRectTransform.anchoredPosition3D.y - loopListViewItem2.CachedRectTransform.rect.height - loopListViewItem2.Padding;
						newItemByIndex2.CachedRectTransform.anchoredPosition3D = new Vector3(newItemByIndex2.StartPosOffset, y, 0f);
						UpdateContentSize();
						CheckIfNeedUpdataItemPos();
						if (num2 > mCurReadyMaxItemIndex)
						{
							mCurReadyMaxItemIndex = num2;
						}
						return true;
					}
					mCurReadyMaxItemIndex = loopListViewItem2.ItemIndex;
					mNeedCheckNextMaxItem = false;
					CheckIfNeedUpdataItemPos();
				}
			}
			if (vector.y - mViewPortRectLocalCorners[1].y < distanceForNew0)
			{
				if (loopListViewItem.ItemIndex < mCurReadyMinItemIndex)
				{
					mCurReadyMinItemIndex = loopListViewItem.ItemIndex;
					mNeedCheckNextMinItem = true;
				}
				int num3 = loopListViewItem.ItemIndex - 1;
				if (num3 >= mCurReadyMinItemIndex || mNeedCheckNextMinItem)
				{
					LoopListViewItem2 newItemByIndex3 = GetNewItemByIndex(num3);
					if (!(newItemByIndex3 == null))
					{
						if (mSupportScrollBar)
						{
							SetItemSize(num3, newItemByIndex3.CachedRectTransform.rect.height, newItemByIndex3.Padding);
						}
						mItemList.Insert(0, newItemByIndex3);
						float y2 = loopListViewItem.CachedRectTransform.anchoredPosition3D.y + newItemByIndex3.CachedRectTransform.rect.height + newItemByIndex3.Padding;
						newItemByIndex3.CachedRectTransform.anchoredPosition3D = new Vector3(newItemByIndex3.StartPosOffset, y2, 0f);
						UpdateContentSize();
						CheckIfNeedUpdataItemPos();
						if (num3 < mCurReadyMinItemIndex)
						{
							mCurReadyMinItemIndex = num3;
						}
						return true;
					}
					mCurReadyMinItemIndex = loopListViewItem.ItemIndex;
					mNeedCheckNextMinItem = false;
				}
			}
		}
		else
		{
			if (mItemList.Count == 0)
			{
				float num4 = mContainerTrans.anchoredPosition3D.y;
				if (num4 > 0f)
				{
					num4 = 0f;
				}
				int index2 = 0;
				float itemPos2 = 0f - num4;
				if (mSupportScrollBar && !GetPlusItemIndexAndPosAtGivenPos(0f - num4, ref index2, ref itemPos2))
				{
					return false;
				}
				LoopListViewItem2 newItemByIndex4 = GetNewItemByIndex(index2);
				if (newItemByIndex4 == null)
				{
					return false;
				}
				if (mSupportScrollBar)
				{
					SetItemSize(index2, newItemByIndex4.CachedRectTransform.rect.height, newItemByIndex4.Padding);
				}
				mItemList.Add(newItemByIndex4);
				itemPos2 -= mPaddingBottom;
				newItemByIndex4.CachedRectTransform.anchoredPosition3D = new Vector3(newItemByIndex4.StartPosOffset, itemPos2, 0f);
				UpdateContentSize();
				return true;
			}
			LoopListViewItem2 loopListViewItem3 = mItemList[0];
			loopListViewItem3.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector5 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]);
			Vector3 vector6 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[0]);
			if (!mIsDraging && loopListViewItem3.ItemCreatedCheckFrameCount != mListUpdateCheckFrameCount && mViewPortRectLocalCorners[0].y - vector5.y > distanceForRecycle0)
			{
				mItemList.RemoveAt(0);
				RecycleItemTmp(loopListViewItem3);
				if (!mSupportScrollBar)
				{
					UpdateContentSize();
					CheckIfNeedUpdataItemPos();
				}
				return true;
			}
			LoopListViewItem2 loopListViewItem4 = mItemList[mItemList.Count - 1];
			loopListViewItem4.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector7 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]);
			Vector3 vector8 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[0]);
			if (!mIsDraging && loopListViewItem4.ItemCreatedCheckFrameCount != mListUpdateCheckFrameCount && vector8.y - mViewPortRectLocalCorners[1].y > distanceForRecycle1)
			{
				mItemList.RemoveAt(mItemList.Count - 1);
				RecycleItemTmp(loopListViewItem4);
				if (!mSupportScrollBar)
				{
					UpdateContentSize();
					CheckIfNeedUpdataItemPos();
				}
				return true;
			}
			if (vector7.y - mViewPortRectLocalCorners[1].y < distanceForNew1)
			{
				if (loopListViewItem4.ItemIndex > mCurReadyMaxItemIndex)
				{
					mCurReadyMaxItemIndex = loopListViewItem4.ItemIndex;
					mNeedCheckNextMaxItem = true;
				}
				int num5 = loopListViewItem4.ItemIndex + 1;
				if (num5 <= mCurReadyMaxItemIndex || mNeedCheckNextMaxItem)
				{
					LoopListViewItem2 newItemByIndex5 = GetNewItemByIndex(num5);
					if (!(newItemByIndex5 == null))
					{
						if (mSupportScrollBar)
						{
							SetItemSize(num5, newItemByIndex5.CachedRectTransform.rect.height, newItemByIndex5.Padding);
						}
						mItemList.Add(newItemByIndex5);
						float y3 = loopListViewItem4.CachedRectTransform.anchoredPosition3D.y + loopListViewItem4.CachedRectTransform.rect.height + loopListViewItem4.Padding;
						newItemByIndex5.CachedRectTransform.anchoredPosition3D = new Vector3(newItemByIndex5.StartPosOffset, y3, 0f);
						UpdateContentSize();
						CheckIfNeedUpdataItemPos();
						if (num5 > mCurReadyMaxItemIndex)
						{
							mCurReadyMaxItemIndex = num5;
						}
						return true;
					}
					mNeedCheckNextMaxItem = false;
					CheckIfNeedUpdataItemPos();
				}
			}
			if (mViewPortRectLocalCorners[0].y - vector6.y < distanceForNew0)
			{
				if (loopListViewItem3.ItemIndex < mCurReadyMinItemIndex)
				{
					mCurReadyMinItemIndex = loopListViewItem3.ItemIndex;
					mNeedCheckNextMinItem = true;
				}
				int num6 = loopListViewItem3.ItemIndex - 1;
				if (num6 >= mCurReadyMinItemIndex || mNeedCheckNextMinItem)
				{
					LoopListViewItem2 newItemByIndex6 = GetNewItemByIndex(num6);
					if (newItemByIndex6 == null)
					{
						mNeedCheckNextMinItem = false;
						return false;
					}
					if (mSupportScrollBar)
					{
						SetItemSize(num6, newItemByIndex6.CachedRectTransform.rect.height, newItemByIndex6.Padding);
					}
					mItemList.Insert(0, newItemByIndex6);
					float y4 = loopListViewItem3.CachedRectTransform.anchoredPosition3D.y - newItemByIndex6.CachedRectTransform.rect.height - newItemByIndex6.Padding;
					newItemByIndex6.CachedRectTransform.anchoredPosition3D = new Vector3(newItemByIndex6.StartPosOffset, y4, 0f);
					UpdateContentSize();
					CheckIfNeedUpdataItemPos();
					if (num6 < mCurReadyMinItemIndex)
					{
						mCurReadyMinItemIndex = num6;
					}
					return true;
				}
			}
		}
		return false;
	}

	private bool UpdateForHorizontalList(float distanceForRecycle0, float distanceForRecycle1, float distanceForNew0, float distanceForNew1)
	{
		if (mItemTotalCount == 0)
		{
			if (mItemList.Count > 0)
			{
				RecycleAllItem();
			}
			return false;
		}
		if (mArrangeType == ListItemArrangeType.LeftToRight)
		{
			if (mItemList.Count == 0)
			{
				float num = mContainerTrans.anchoredPosition3D.x;
				if (num > 0f)
				{
					num = 0f;
				}
				int index = 0;
				float itemPos = 0f - num;
				if (mSupportScrollBar && !GetPlusItemIndexAndPosAtGivenPos(0f - num, ref index, ref itemPos))
				{
					return false;
				}
				LoopListViewItem2 newItemByIndex = GetNewItemByIndex(index);
				if (newItemByIndex == null)
				{
					return false;
				}
				if (mSupportScrollBar)
				{
					SetItemSize(index, newItemByIndex.CachedRectTransform.rect.width, newItemByIndex.Padding);
				}
				mItemList.Add(newItemByIndex);
				itemPos += mPaddingLeft;
				newItemByIndex.CachedRectTransform.anchoredPosition3D = new Vector3(itemPos, newItemByIndex.StartPosOffset, 0f);
				UpdateContentSize();
				return true;
			}
			LoopListViewItem2 loopListViewItem = mItemList[0];
			loopListViewItem.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]);
			Vector3 vector2 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[2]);
			if (!mIsDraging && loopListViewItem.ItemCreatedCheckFrameCount != mListUpdateCheckFrameCount && mViewPortRectLocalCorners[1].x - vector2.x > distanceForRecycle0)
			{
				mItemList.RemoveAt(0);
				RecycleItemTmp(loopListViewItem);
				if (!mSupportScrollBar)
				{
					UpdateContentSize();
					CheckIfNeedUpdataItemPos();
				}
				return true;
			}
			LoopListViewItem2 loopListViewItem2 = mItemList[mItemList.Count - 1];
			loopListViewItem2.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector3 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]);
			Vector3 vector4 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[2]);
			if (!mIsDraging && loopListViewItem2.ItemCreatedCheckFrameCount != mListUpdateCheckFrameCount && vector3.x - mViewPortRectLocalCorners[2].x > distanceForRecycle1)
			{
				mItemList.RemoveAt(mItemList.Count - 1);
				RecycleItemTmp(loopListViewItem2);
				if (!mSupportScrollBar)
				{
					UpdateContentSize();
					CheckIfNeedUpdataItemPos();
				}
				return true;
			}
			if (vector4.x - mViewPortRectLocalCorners[2].x < distanceForNew1)
			{
				if (loopListViewItem2.ItemIndex > mCurReadyMaxItemIndex)
				{
					mCurReadyMaxItemIndex = loopListViewItem2.ItemIndex;
					mNeedCheckNextMaxItem = true;
				}
				int num2 = loopListViewItem2.ItemIndex + 1;
				if (num2 <= mCurReadyMaxItemIndex || mNeedCheckNextMaxItem)
				{
					LoopListViewItem2 newItemByIndex2 = GetNewItemByIndex(num2);
					if (!(newItemByIndex2 == null))
					{
						if (mSupportScrollBar)
						{
							SetItemSize(num2, newItemByIndex2.CachedRectTransform.rect.width, newItemByIndex2.Padding);
						}
						mItemList.Add(newItemByIndex2);
						float x = loopListViewItem2.CachedRectTransform.anchoredPosition3D.x + loopListViewItem2.CachedRectTransform.rect.width + loopListViewItem2.Padding;
						newItemByIndex2.CachedRectTransform.anchoredPosition3D = new Vector3(x, newItemByIndex2.StartPosOffset, 0f);
						UpdateContentSize();
						CheckIfNeedUpdataItemPos();
						if (num2 > mCurReadyMaxItemIndex)
						{
							mCurReadyMaxItemIndex = num2;
						}
						return true;
					}
					mCurReadyMaxItemIndex = loopListViewItem2.ItemIndex;
					mNeedCheckNextMaxItem = false;
					CheckIfNeedUpdataItemPos();
				}
			}
			if (mViewPortRectLocalCorners[1].x - vector.x < distanceForNew0)
			{
				if (loopListViewItem.ItemIndex < mCurReadyMinItemIndex)
				{
					mCurReadyMinItemIndex = loopListViewItem.ItemIndex;
					mNeedCheckNextMinItem = true;
				}
				int num3 = loopListViewItem.ItemIndex - 1;
				if (num3 >= mCurReadyMinItemIndex || mNeedCheckNextMinItem)
				{
					LoopListViewItem2 newItemByIndex3 = GetNewItemByIndex(num3);
					if (!(newItemByIndex3 == null))
					{
						if (mSupportScrollBar)
						{
							SetItemSize(num3, newItemByIndex3.CachedRectTransform.rect.width, newItemByIndex3.Padding);
						}
						mItemList.Insert(0, newItemByIndex3);
						float x2 = loopListViewItem.CachedRectTransform.anchoredPosition3D.x - newItemByIndex3.CachedRectTransform.rect.width - newItemByIndex3.Padding;
						newItemByIndex3.CachedRectTransform.anchoredPosition3D = new Vector3(x2, newItemByIndex3.StartPosOffset, 0f);
						UpdateContentSize();
						CheckIfNeedUpdataItemPos();
						if (num3 < mCurReadyMinItemIndex)
						{
							mCurReadyMinItemIndex = num3;
						}
						return true;
					}
					mCurReadyMinItemIndex = loopListViewItem.ItemIndex;
					mNeedCheckNextMinItem = false;
				}
			}
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight_Center)
		{
			if (mItemList.Count == 0)
			{
				float num4 = mContainerTrans.anchoredPosition3D.x;
				if (num4 < 0f)
				{
					num4 = 0f;
				}
				int index2 = 0;
				float itemPos2 = 0f - num4;
				if (mSupportScrollBar)
				{
					if (!GetPlusItemIndexAndPosAtGivenPos(num4, ref index2, ref itemPos2))
					{
						return false;
					}
					itemPos2 = 0f - itemPos2;
				}
				LoopListViewItem2 newItemByIndex4 = GetNewItemByIndex(index2);
				if (newItemByIndex4 == null)
				{
					return false;
				}
				if (mSupportScrollBar)
				{
					SetItemSize(index2, newItemByIndex4.CachedRectTransform.rect.width, newItemByIndex4.Padding);
				}
				mItemList.Add(newItemByIndex4);
				itemPos2 -= ContainerTrans.rect.width / newItemByIndex4.CachedRectTransform.rect.width / 2f;
				newItemByIndex4.CachedRectTransform.anchoredPosition3D = new Vector3(itemPos2, newItemByIndex4.StartPosOffset, 0f);
				UpdateContentSize();
				return true;
			}
			LoopListViewItem2 loopListViewItem3 = mItemList[0];
			loopListViewItem3.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector5 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]);
			Vector3 vector6 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[2]);
			if (!mIsDraging && loopListViewItem3.ItemCreatedCheckFrameCount != mListUpdateCheckFrameCount && vector5.x - mViewPortRectLocalCorners[2].x > distanceForRecycle0)
			{
				mItemList.RemoveAt(0);
				RecycleItemTmp(loopListViewItem3);
				if (!mSupportScrollBar)
				{
					UpdateContentSize();
					CheckIfNeedUpdataItemPos();
				}
				return true;
			}
			LoopListViewItem2 loopListViewItem4 = mItemList[mItemList.Count - 1];
			loopListViewItem4.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector7 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]);
			Vector3 vector8 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[2]);
			if (!mIsDraging && loopListViewItem4.ItemCreatedCheckFrameCount != mListUpdateCheckFrameCount && mViewPortRectLocalCorners[1].x - vector8.x > distanceForRecycle1)
			{
				mItemList.RemoveAt(mItemList.Count - 1);
				RecycleItemTmp(loopListViewItem4);
				if (!mSupportScrollBar)
				{
					UpdateContentSize();
					CheckIfNeedUpdataItemPos();
				}
				return true;
			}
			if (mViewPortRectLocalCorners[1].x - vector7.x < distanceForNew1)
			{
				if (loopListViewItem4.ItemIndex > mCurReadyMaxItemIndex)
				{
					mCurReadyMaxItemIndex = loopListViewItem4.ItemIndex;
					mNeedCheckNextMaxItem = true;
				}
				int num5 = loopListViewItem4.ItemIndex + 1;
				if (num5 <= mCurReadyMaxItemIndex || mNeedCheckNextMaxItem)
				{
					LoopListViewItem2 newItemByIndex5 = GetNewItemByIndex(num5);
					if (!(newItemByIndex5 == null))
					{
						if (mSupportScrollBar)
						{
							SetItemSize(num5, newItemByIndex5.CachedRectTransform.rect.width, newItemByIndex5.Padding);
						}
						mItemList.Add(newItemByIndex5);
						UpdateContentSize();
						float x3 = 0f - ContainerTrans.rect.width / 2f + mItemList[0].CachedRectTransform.rect.width / 2f;
						mItemList[0].CachedRectTransform.anchoredPosition3D = new Vector3(x3, newItemByIndex5.StartPosOffset, 0f);
						for (int i = 1; i < mItemList.Count; i++)
						{
							x3 = mItemList[i - 1].CachedRectTransform.anchoredPosition3D.x + mItemList[i - 1].CachedRectTransform.rect.width + mItemList[i - 1].Padding;
							mItemList[i].CachedRectTransform.anchoredPosition3D = new Vector3(x3, newItemByIndex5.StartPosOffset, 0f);
						}
						float x4 = loopListViewItem4.CachedRectTransform.anchoredPosition3D.x + loopListViewItem4.CachedRectTransform.rect.width + loopListViewItem4.Padding;
						newItemByIndex5.CachedRectTransform.anchoredPosition3D = new Vector3(x4, newItemByIndex5.StartPosOffset, 0f);
						CheckIfNeedUpdataItemPos();
						if (num5 > mCurReadyMaxItemIndex)
						{
							mCurReadyMaxItemIndex = num5;
						}
						return true;
					}
					mCurReadyMaxItemIndex = loopListViewItem4.ItemIndex;
					mNeedCheckNextMaxItem = false;
					CheckIfNeedUpdataItemPos();
				}
			}
			if (vector6.x - mViewPortRectLocalCorners[2].x < distanceForNew0)
			{
				if (loopListViewItem3.ItemIndex < mCurReadyMinItemIndex)
				{
					mCurReadyMinItemIndex = loopListViewItem3.ItemIndex;
					mNeedCheckNextMinItem = true;
				}
				int num6 = loopListViewItem3.ItemIndex - 1;
				if (num6 >= mCurReadyMinItemIndex || mNeedCheckNextMinItem)
				{
					LoopListViewItem2 newItemByIndex6 = GetNewItemByIndex(num6);
					if (!(newItemByIndex6 == null))
					{
						if (mSupportScrollBar)
						{
							SetItemSize(num6, newItemByIndex6.CachedRectTransform.rect.width, newItemByIndex6.Padding);
						}
						mItemList.Insert(0, newItemByIndex6);
						float x5 = loopListViewItem3.CachedRectTransform.anchoredPosition3D.x + newItemByIndex6.CachedRectTransform.rect.width + newItemByIndex6.Padding;
						newItemByIndex6.CachedRectTransform.anchoredPosition3D = new Vector3(x5, newItemByIndex6.StartPosOffset, 0f);
						UpdateContentSize();
						CheckIfNeedUpdataItemPos();
						if (num6 < mCurReadyMinItemIndex)
						{
							mCurReadyMinItemIndex = num6;
						}
						return true;
					}
					mCurReadyMinItemIndex = loopListViewItem3.ItemIndex;
					mNeedCheckNextMinItem = false;
				}
			}
		}
		else
		{
			if (mItemList.Count == 0)
			{
				float num7 = mContainerTrans.anchoredPosition3D.x;
				if (num7 < 0f)
				{
					num7 = 0f;
				}
				int index3 = 0;
				float itemPos3 = 0f - num7;
				if (mSupportScrollBar)
				{
					if (!GetPlusItemIndexAndPosAtGivenPos(num7, ref index3, ref itemPos3))
					{
						return false;
					}
					itemPos3 = 0f - itemPos3;
				}
				LoopListViewItem2 newItemByIndex7 = GetNewItemByIndex(index3);
				if (newItemByIndex7 == null)
				{
					return false;
				}
				if (mSupportScrollBar)
				{
					SetItemSize(index3, newItemByIndex7.CachedRectTransform.rect.width, newItemByIndex7.Padding);
				}
				mItemList.Add(newItemByIndex7);
				itemPos3 -= mPaddingRight;
				newItemByIndex7.CachedRectTransform.anchoredPosition3D = new Vector3(itemPos3, newItemByIndex7.StartPosOffset, 0f);
				UpdateContentSize();
				return true;
			}
			LoopListViewItem2 loopListViewItem5 = mItemList[0];
			loopListViewItem5.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector9 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]);
			Vector3 vector10 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[2]);
			if (!mIsDraging && loopListViewItem5.ItemCreatedCheckFrameCount != mListUpdateCheckFrameCount && vector9.x - mViewPortRectLocalCorners[2].x > distanceForRecycle0)
			{
				mItemList.RemoveAt(0);
				RecycleItemTmp(loopListViewItem5);
				if (!mSupportScrollBar)
				{
					UpdateContentSize();
					CheckIfNeedUpdataItemPos();
				}
				return true;
			}
			LoopListViewItem2 loopListViewItem6 = mItemList[mItemList.Count - 1];
			loopListViewItem6.CachedRectTransform.GetWorldCorners(mItemWorldCorners);
			Vector3 vector11 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[1]);
			Vector3 vector12 = mViewPortRectTransform.InverseTransformPoint(mItemWorldCorners[2]);
			if (!mIsDraging && loopListViewItem6.ItemCreatedCheckFrameCount != mListUpdateCheckFrameCount && mViewPortRectLocalCorners[1].x - vector12.x > distanceForRecycle1)
			{
				mItemList.RemoveAt(mItemList.Count - 1);
				RecycleItemTmp(loopListViewItem6);
				if (!mSupportScrollBar)
				{
					UpdateContentSize();
					CheckIfNeedUpdataItemPos();
				}
				return true;
			}
			if (mViewPortRectLocalCorners[1].x - vector11.x < distanceForNew1)
			{
				if (loopListViewItem6.ItemIndex > mCurReadyMaxItemIndex)
				{
					mCurReadyMaxItemIndex = loopListViewItem6.ItemIndex;
					mNeedCheckNextMaxItem = true;
				}
				int num8 = loopListViewItem6.ItemIndex + 1;
				if (num8 <= mCurReadyMaxItemIndex || mNeedCheckNextMaxItem)
				{
					LoopListViewItem2 newItemByIndex8 = GetNewItemByIndex(num8);
					if (!(newItemByIndex8 == null))
					{
						if (mSupportScrollBar)
						{
							SetItemSize(num8, newItemByIndex8.CachedRectTransform.rect.width, newItemByIndex8.Padding);
						}
						mItemList.Add(newItemByIndex8);
						float x6 = loopListViewItem6.CachedRectTransform.anchoredPosition3D.x - loopListViewItem6.CachedRectTransform.rect.width - loopListViewItem6.Padding;
						newItemByIndex8.CachedRectTransform.anchoredPosition3D = new Vector3(x6, newItemByIndex8.StartPosOffset, 0f);
						UpdateContentSize();
						CheckIfNeedUpdataItemPos();
						if (num8 > mCurReadyMaxItemIndex)
						{
							mCurReadyMaxItemIndex = num8;
						}
						return true;
					}
					mCurReadyMaxItemIndex = loopListViewItem6.ItemIndex;
					mNeedCheckNextMaxItem = false;
					CheckIfNeedUpdataItemPos();
				}
			}
			if (vector10.x - mViewPortRectLocalCorners[2].x < distanceForNew0)
			{
				if (loopListViewItem5.ItemIndex < mCurReadyMinItemIndex)
				{
					mCurReadyMinItemIndex = loopListViewItem5.ItemIndex;
					mNeedCheckNextMinItem = true;
				}
				int num9 = loopListViewItem5.ItemIndex - 1;
				if (num9 >= mCurReadyMinItemIndex || mNeedCheckNextMinItem)
				{
					LoopListViewItem2 newItemByIndex9 = GetNewItemByIndex(num9);
					if (!(newItemByIndex9 == null))
					{
						if (mSupportScrollBar)
						{
							SetItemSize(num9, newItemByIndex9.CachedRectTransform.rect.width, newItemByIndex9.Padding);
						}
						mItemList.Insert(0, newItemByIndex9);
						float x7 = loopListViewItem5.CachedRectTransform.anchoredPosition3D.x + newItemByIndex9.CachedRectTransform.rect.width + newItemByIndex9.Padding;
						newItemByIndex9.CachedRectTransform.anchoredPosition3D = new Vector3(x7, newItemByIndex9.StartPosOffset, 0f);
						UpdateContentSize();
						CheckIfNeedUpdataItemPos();
						if (num9 < mCurReadyMinItemIndex)
						{
							mCurReadyMinItemIndex = num9;
						}
						return true;
					}
					mCurReadyMinItemIndex = loopListViewItem5.ItemIndex;
					mNeedCheckNextMinItem = false;
				}
			}
		}
		return false;
	}

	private float GetContentPanelSize()
	{
		if (mSupportScrollBar)
		{
			float num = ((mItemPosMgr.mTotalSize > 0f) ? (mItemPosMgr.mTotalSize - mLastItemPadding) : 0f);
			if (num < 0f)
			{
				num = 0f;
			}
			return num;
		}
		int count = mItemList.Count;
		switch (count)
		{
		case 0:
			return 0f;
		case 1:
			return mItemList[0].ItemSize;
		case 2:
			return mItemList[0].ItemSizeWithPadding + mItemList[1].ItemSize;
		default:
		{
			float num2 = 0f;
			for (int i = 0; i < count - 1; i++)
			{
				num2 += mItemList[i].ItemSizeWithPadding;
			}
			num2 += mItemList[count - 1].ItemSize;
			if (ArrangeType == ListItemArrangeType.BottomToTop || ArrangeType == ListItemArrangeType.TopToBottom)
			{
				num2 += mPaddingBottom + mPaddingTop;
			}
			else if (ArrangeType == ListItemArrangeType.RightToLeft || ArrangeType == ListItemArrangeType.LeftToRight)
			{
				num2 += mPaddingLeft + mPaddingRight;
			}
			return num2;
		}
		}
	}

	private void CheckIfNeedUpdataItemPos()
	{
		if (mItemList.Count == 0)
		{
			return;
		}
		if (mArrangeType == ListItemArrangeType.TopToBottom)
		{
			LoopListViewItem2 loopListViewItem = mItemList[0];
			LoopListViewItem2 loopListViewItem2 = mItemList[mItemList.Count - 1];
			float contentPanelSize = GetContentPanelSize();
			if (loopListViewItem.TopY > 0f || (loopListViewItem.ItemIndex == mCurReadyMinItemIndex && loopListViewItem.TopY != 0f))
			{
				UpdateAllShownItemsPos();
			}
			else if (0f - loopListViewItem2.BottomY > contentPanelSize || (loopListViewItem2.ItemIndex == mCurReadyMaxItemIndex && 0f - loopListViewItem2.BottomY != contentPanelSize))
			{
				UpdateAllShownItemsPos();
			}
		}
		else if (mArrangeType == ListItemArrangeType.BottomToTop)
		{
			LoopListViewItem2 loopListViewItem3 = mItemList[0];
			LoopListViewItem2 loopListViewItem4 = mItemList[mItemList.Count - 1];
			float contentPanelSize2 = GetContentPanelSize();
			if (loopListViewItem3.BottomY < 0f || (loopListViewItem3.ItemIndex == mCurReadyMinItemIndex && loopListViewItem3.BottomY != 0f))
			{
				UpdateAllShownItemsPos();
			}
			else if (loopListViewItem4.TopY > contentPanelSize2 || (loopListViewItem4.ItemIndex == mCurReadyMaxItemIndex && loopListViewItem4.TopY != contentPanelSize2))
			{
				UpdateAllShownItemsPos();
			}
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight)
		{
			LoopListViewItem2 loopListViewItem5 = mItemList[0];
			LoopListViewItem2 loopListViewItem6 = mItemList[mItemList.Count - 1];
			float contentPanelSize3 = GetContentPanelSize();
			if (loopListViewItem5.LeftX < 0f || (loopListViewItem5.ItemIndex == mCurReadyMinItemIndex && loopListViewItem5.LeftX != 0f))
			{
				UpdateAllShownItemsPos();
			}
			else if (loopListViewItem6.RightX > contentPanelSize3 || (loopListViewItem6.ItemIndex == mCurReadyMaxItemIndex && loopListViewItem6.RightX != contentPanelSize3))
			{
				UpdateAllShownItemsPos();
			}
		}
		else if (mArrangeType == ListItemArrangeType.RightToLeft)
		{
			LoopListViewItem2 loopListViewItem7 = mItemList[0];
			LoopListViewItem2 loopListViewItem8 = mItemList[mItemList.Count - 1];
			float contentPanelSize4 = GetContentPanelSize();
			if (loopListViewItem7.RightX > 0f || (loopListViewItem7.ItemIndex == mCurReadyMinItemIndex && loopListViewItem7.RightX != 0f))
			{
				UpdateAllShownItemsPos();
			}
			else if (0f - loopListViewItem8.LeftX > contentPanelSize4 || (loopListViewItem8.ItemIndex == mCurReadyMaxItemIndex && 0f - loopListViewItem8.LeftX != contentPanelSize4))
			{
				UpdateAllShownItemsPos();
			}
		}
	}

	private void UpdateItemArrangeType(RectTransform rtf)
	{
		AdjustAnchor(rtf);
		AdjustPivot(rtf);
	}

	private void UpdateAllShownItemsPos()
	{
		int count = mItemList.Count;
		if (count == 0)
		{
			return;
		}
		mAdjustedVec = (mContainerTrans.anchoredPosition3D - mLastFrameContainerPos) / Time.deltaTime;
		if (mArrangeType == ListItemArrangeType.TopToBottom)
		{
			float num = 0f;
			if (mSupportScrollBar)
			{
				num = 0f - GetItemPos(mItemList[0].ItemIndex);
			}
			num -= mPaddingTop;
			float y = mItemList[0].CachedRectTransform.anchoredPosition3D.y;
			float num2 = num - y;
			float num3 = num;
			for (int i = 0; i < count; i++)
			{
				LoopListViewItem2 loopListViewItem = mItemList[i];
				UpdateItemArrangeType(loopListViewItem.CachedRectTransform);
				loopListViewItem.CachedRectTransform.anchoredPosition3D = new Vector3(loopListViewItem.StartPosOffset, num3, 0f);
				num3 = num3 - loopListViewItem.CachedRectTransform.rect.height - loopListViewItem.Padding;
			}
			if (num2 != 0f)
			{
				Vector2 vector = mContainerTrans.anchoredPosition3D;
				vector.y -= num2;
				mContainerTrans.anchoredPosition3D = vector;
			}
		}
		else if (mArrangeType == ListItemArrangeType.BottomToTop)
		{
			float num4 = 0f;
			if (mSupportScrollBar)
			{
				num4 = GetItemPos(mItemList[0].ItemIndex);
			}
			num4 += mPaddingBottom;
			float y2 = mItemList[0].CachedRectTransform.anchoredPosition3D.y;
			float num5 = num4 - y2;
			float num6 = num4;
			for (int j = 0; j < count; j++)
			{
				LoopListViewItem2 loopListViewItem2 = mItemList[j];
				UpdateItemArrangeType(loopListViewItem2.CachedRectTransform);
				loopListViewItem2.CachedRectTransform.anchoredPosition3D = new Vector3(loopListViewItem2.StartPosOffset, num6, 0f);
				num6 = num6 + loopListViewItem2.CachedRectTransform.rect.height + loopListViewItem2.Padding;
			}
			if (num5 != 0f)
			{
				Vector3 anchoredPosition3D = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D.y -= num5;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D;
			}
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight)
		{
			float num7 = 0f;
			if (mSupportScrollBar)
			{
				num7 = GetItemPos(mItemList[0].ItemIndex);
			}
			num7 += mPaddingLeft;
			float x = mItemList[0].CachedRectTransform.anchoredPosition3D.x;
			float num8 = num7 - x;
			float num9 = num7;
			for (int k = 0; k < count; k++)
			{
				LoopListViewItem2 loopListViewItem3 = mItemList[k];
				UpdateItemArrangeType(loopListViewItem3.CachedRectTransform);
				loopListViewItem3.CachedRectTransform.anchoredPosition3D = new Vector3(num9, loopListViewItem3.StartPosOffset, 0f);
				num9 = num9 + loopListViewItem3.CachedRectTransform.rect.width + loopListViewItem3.Padding;
			}
			if (num8 != 0f)
			{
				Vector3 anchoredPosition3D2 = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D2.x -= num8;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D2;
			}
		}
		else if (mArrangeType == ListItemArrangeType.RightToLeft)
		{
			float num10 = 0f;
			if (mSupportScrollBar)
			{
				num10 = 0f - GetItemPos(mItemList[0].ItemIndex);
			}
			num10 -= mPaddingRight;
			float x2 = mItemList[0].CachedRectTransform.anchoredPosition3D.x;
			float num11 = num10 - x2;
			float num12 = num10;
			for (int l = 0; l < count; l++)
			{
				LoopListViewItem2 loopListViewItem4 = mItemList[l];
				UpdateItemArrangeType(loopListViewItem4.CachedRectTransform);
				loopListViewItem4.CachedRectTransform.anchoredPosition3D = new Vector3(num12, loopListViewItem4.StartPosOffset, 0f);
				num12 = num12 - loopListViewItem4.CachedRectTransform.rect.width - loopListViewItem4.Padding;
			}
			if (num11 != 0f)
			{
				Vector3 anchoredPosition3D3 = mContainerTrans.anchoredPosition3D;
				anchoredPosition3D3.x -= num11;
				mContainerTrans.anchoredPosition3D = anchoredPosition3D3;
			}
		}
		else if (mArrangeType == ListItemArrangeType.LeftToRight_Center)
		{
			float num13 = 0f;
			if (mSupportScrollBar)
			{
				num13 = GetItemPos(mItemList[0].ItemIndex);
			}
			float x3 = mItemList[0].CachedRectTransform.anchoredPosition3D.x;
			float num14 = num13 - mContainerTrans.rect.width / 2f + mItemList[0].CachedRectTransform.rect.width / 2f;
			for (int m = 0; m < count; m++)
			{
				LoopListViewItem2 loopListViewItem5 = mItemList[m];
				UpdateItemArrangeType(loopListViewItem5.CachedRectTransform);
				loopListViewItem5.CachedRectTransform.anchoredPosition3D = new Vector3(num14, loopListViewItem5.StartPosOffset, 0f);
				num14 = num14 + loopListViewItem5.CachedRectTransform.rect.width + loopListViewItem5.Padding;
			}
		}
		if (mIsDraging)
		{
			mScrollRect.OnBeginDrag(mPointerEventData);
			mScrollRect.Rebuild(CanvasUpdate.PostLayout);
			mScrollRect.velocity = mAdjustedVec;
			mNeedAdjustVec = true;
		}
	}

	private void UpdateContentSize()
	{
		float num = GetContentPanelSize();
		if (ArrangeType == ListItemArrangeType.BottomToTop || ArrangeType == ListItemArrangeType.TopToBottom)
		{
			num += mPaddingTop + mPaddingBottom;
		}
		else if (ArrangeType == ListItemArrangeType.RightToLeft || ArrangeType == ListItemArrangeType.LeftToRight)
		{
			num += mPaddingLeft + mPaddingRight;
		}
		if (mIsVertList)
		{
			if (mContainerTrans.rect.height != num)
			{
				mContainerTrans.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, num);
			}
		}
		else if (mContainerTrans.rect.width != num)
		{
			mContainerTrans.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, num);
		}
		onChangeContentSize?.Invoke();
	}
}
