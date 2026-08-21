#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Ase;
using GameFramework;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SuperScrollView;

public class LoopGridView : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IEndDragHandler, IDragHandler
{
	private class SnapData
	{
		public SnapStatus mSnapStatus;

		public RowColumnPair mSnapTarget;

		public Vector2 mSnapNeedMoveDir;

		public float mTargetSnapVal;

		public float mCurSnapVal;

		public bool mIsForceSnapTo;

		public void Clear()
		{
			mSnapStatus = SnapStatus.NoTargetSet;
			mIsForceSnapTo = false;
		}
	}

	private class ItemRangeData
	{
		public int mMaxRow;

		public int mMinRow;

		public int mMaxColumn;

		public int mMinColumn;

		public Vector2 mCheckedPosition;
	}

	private Dictionary<string, GridItemPool> mItemPoolDict = new Dictionary<string, GridItemPool>();

	private List<GridItemPool> mItemPoolList = new List<GridItemPool>();

	[SerializeField]
	private List<GridViewItemPrefabConfData> mItemPrefabDataList = new List<GridViewItemPrefabConfData>();

	[SerializeField]
	private GridItemArrangeType mArrangeType;

	private RectTransform mContainerTrans;

	private ScrollRect mScrollRect;

	private RectTransform mScrollRectTransform;

	private RectTransform mViewPortRectTransform;

	private int mItemTotalCount;

	[SerializeField]
	private int mFixedRowOrColumnCount;

	[SerializeField]
	private RectOffset mPadding = new RectOffset();

	[SerializeField]
	private Vector2 mItemPadding = Vector2.zero;

	[SerializeField]
	private Vector2 mItemSize = Vector2.zero;

	[SerializeField]
	private Vector2 mItemRecycleDistance = new Vector2(50f, 50f);

	private Vector2 mItemSizeWithPadding = Vector2.zero;

	private Vector2 mStartPadding;

	private Vector2 mEndPadding;

	private Func<LoopGridView, int, int, int, LoopGridViewItem> mOnGetItemByRowColumn;

	private List<GridItemGroup> mItemGroupObjPool = new List<GridItemGroup>();

	private List<GridItemGroup> mItemGroupList = new List<GridItemGroup>();

	private bool mIsDraging;

	private int mRowCount;

	private int mColumnCount;

	public Action<PointerEventData> mOnBeginDragAction;

	public Action<PointerEventData> mOnDragingAction;

	public Action<PointerEventData> mOnEndDragAction;

	private float mSmoothDumpVel;

	private float mSmoothDumpRate = 0.3f;

	private float mSnapFinishThreshold = 0.1f;

	private float mSnapVecThreshold = 145f;

	[SerializeField]
	private bool mItemSnapEnable;

	[SerializeField]
	private GridFixedType mGridFixedType;

	public Action<LoopGridView, LoopGridViewItem> mOnSnapItemFinished;

	public Action<LoopGridView> mOnSnapNearestChanged;

	private int mLeftSnapUpdateExtraCount = 1;

	[SerializeField]
	private Vector2 mViewPortSnapPivot = Vector2.zero;

	[SerializeField]
	private Vector2 mItemSnapPivot = Vector2.zero;

	private SnapData mCurSnapData = new SnapData();

	private Vector3 mLastSnapCheckPos = Vector3.zero;

	private bool mListViewInited;

	private int mListUpdateCheckFrameCount;

	private ItemRangeData mCurFrameItemRangeData = new ItemRangeData();

	private int mNeedCheckContentPosLeftCount = 1;

	private ClickEventListener mScrollBarClickEventListener1;

	private ClickEventListener mScrollBarClickEventListener2;

	private RowColumnPair mCurSnapNearestItemRowColumn;

	[SerializeField]
	protected bool enableFrameCreate;

	private bool _isItemCreateEnded = true;

	private readonly List<WaitingItemData> _waitingItemDataList = new List<WaitingItemData>();

	private bool _isDragScrollBar;

	public GridItemArrangeType ArrangeType
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

	public List<GridViewItemPrefabConfData> ItemPrefabDataList => mItemPrefabDataList;

	public int ItemTotalCount => mItemTotalCount;

	public RectTransform ContainerTrans => mContainerTrans;

	public float ViewPortWidth => mViewPortRectTransform.rect.width;

	public float ViewPortHeight => mViewPortRectTransform.rect.height;

	public ScrollRect ScrollRect => mScrollRect;

	public bool IsDraging => mIsDraging;

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

	public Vector2 ItemSize
	{
		get
		{
			return mItemSize;
		}
		set
		{
			SetItemSize(value);
		}
	}

	public Vector2 ItemPadding
	{
		get
		{
			return mItemPadding;
		}
		set
		{
			SetItemPadding(value);
		}
	}

	public Vector2 ItemSizeWithPadding => mItemSizeWithPadding;

	public RectOffset Padding
	{
		get
		{
			return mPadding;
		}
		set
		{
			SetPadding(value);
		}
	}

	public bool MListViewInited => mListViewInited;

	public RowColumnPair CurSnapNearestItemRowColumn => mCurSnapNearestItemRowColumn;

	private bool IsScrolling
	{
		get
		{
			if (!IsDraging && !_isDragScrollBar)
			{
				return Mathf.Abs(mScrollRect.vertical ? mScrollRect.velocity.y : mScrollRect.velocity.x) > float.Epsilon;
			}
			return true;
		}
	}

	public GridViewItemPrefabConfData GetItemPrefabConfData(string prefabName)
	{
		foreach (GridViewItemPrefabConfData mItemPrefabData in mItemPrefabDataList)
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

	public void SetAutoGridSize(float contentWidth)
	{
		float num = (contentWidth - (float)(mColumnCount - 1) * ItemPadding.x) / (float)mFixedRowOrColumnCount;
		ItemSize = new Vector2(num, num);
	}

	public void InitGridView(int itemTotalCount, Func<LoopGridView, int, int, int, LoopGridViewItem> onGetItemByRowColumn, LoopGridViewSettingParam settingParam = null, LoopGridViewInitParam initParam = null)
	{
		if (mListViewInited)
		{
			Log.Error("LoopGridView.InitListView method can be called only once.");
			return;
		}
		mListViewInited = true;
		if (itemTotalCount < 0)
		{
			Log.Error("itemTotalCount is  < 0");
			itemTotalCount = 0;
		}
		if (settingParam != null)
		{
			UpdateFromSettingParam(settingParam);
		}
		if (initParam != null)
		{
			mSmoothDumpRate = initParam.mSmoothDumpRate;
			mSnapFinishThreshold = initParam.mSnapFinishThreshold;
			mSnapVecThreshold = initParam.mSnapVecThreshold;
		}
		mScrollRect = base.gameObject.GetComponent<ScrollRect>();
		if (mScrollRect == null)
		{
			Log.Error("ListView Init Failed! ScrollRect component not found!");
			return;
		}
		mCurSnapData.Clear();
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
		SetScrollbarListener();
		AdjustViewPortPivot();
		AdjustContainerAnchorAndPivot();
		InitItemPool();
		mOnGetItemByRowColumn = onGetItemByRowColumn;
		mNeedCheckContentPosLeftCount = 4;
		mCurSnapData.Clear();
		mItemTotalCount = itemTotalCount;
		UpdateAllGridSetting();
	}

	public void SetListItemCount(int itemCount, bool resetPos = true)
	{
		if (itemCount < 0 || itemCount == mItemTotalCount)
		{
			return;
		}
		mCurSnapData.Clear();
		mItemTotalCount = itemCount;
		UpdateColumnRowCount();
		UpdateContentSize();
		ForceToCheckContentPos();
		if (mItemTotalCount == 0)
		{
			RecycleAllItem();
			ClearAllTmpRecycledItem();
			return;
		}
		VaildAndSetContainerPos();
		UpdateGridViewContent(forceImmediately: false);
		ClearAllTmpRecycledItem();
		if (resetPos)
		{
			MovePanelToItemByRowColumn(0, 0);
		}
	}

	public LoopGridViewItem NewListViewItem(string itemPrefabName)
	{
		GridItemPool value = null;
		if (!mItemPoolDict.TryGetValue(itemPrefabName, out value))
		{
			return null;
		}
		LoopGridViewItem item = value.GetItem();
		RectTransform component = item.GetComponent<RectTransform>();
		component.SetParent(mContainerTrans);
		component.localScale = Vector3.one;
		component.anchoredPosition3D = Vector3.zero;
		component.localEulerAngles = Vector3.zero;
		item.ParentGridView = this;
		return item;
	}

	public void RefreshItemByItemIndex(int itemIndex)
	{
		if (itemIndex >= 0 && itemIndex < ItemTotalCount && mItemGroupList.Count != 0)
		{
			RowColumnPair rowColumnByItemIndex = GetRowColumnByItemIndex(itemIndex);
			RefreshItemByRowColumn(rowColumnByItemIndex.mRow, rowColumnByItemIndex.mColumn);
		}
	}

	public void RefreshItemByRowColumn(int row, int column)
	{
		if (mItemGroupList.Count == 0)
		{
			return;
		}
		if (mGridFixedType == GridFixedType.ColumnCountFixed)
		{
			GridItemGroup shownGroup = GetShownGroup(row);
			if (shownGroup == null)
			{
				return;
			}
			LoopGridViewItem itemByColumn = shownGroup.GetItemByColumn(column);
			if (!(itemByColumn == null))
			{
				LoopGridViewItem newItemByRowColumn = GetNewItemByRowColumn(row, column);
				if (!(newItemByRowColumn == null))
				{
					Vector3 anchoredPosition3D = itemByColumn.CachedRectTransform.anchoredPosition3D;
					shownGroup.ReplaceItem(itemByColumn, newItemByRowColumn);
					RecycleItemTmp(itemByColumn);
					newItemByRowColumn.CachedRectTransform.anchoredPosition3D = anchoredPosition3D;
					ClearAllTmpRecycledItem();
				}
			}
			return;
		}
		GridItemGroup shownGroup2 = GetShownGroup(column);
		if (shownGroup2 == null)
		{
			return;
		}
		LoopGridViewItem itemByRow = shownGroup2.GetItemByRow(row);
		if (!(itemByRow == null))
		{
			LoopGridViewItem newItemByRowColumn2 = GetNewItemByRowColumn(row, column);
			if (!(newItemByRowColumn2 == null))
			{
				Vector3 anchoredPosition3D2 = itemByRow.CachedRectTransform.anchoredPosition3D;
				shownGroup2.ReplaceItem(itemByRow, newItemByRowColumn2);
				RecycleItemTmp(itemByRow);
				newItemByRowColumn2.CachedRectTransform.anchoredPosition3D = anchoredPosition3D2;
				ClearAllTmpRecycledItem();
			}
		}
	}

	public void ClearSnapData()
	{
		mCurSnapData.Clear();
	}

	public void SetSnapTargetItemRowColumn(int row, int column)
	{
		if (row < 0)
		{
			row = 0;
		}
		if (column < 0)
		{
			column = 0;
		}
		mCurSnapData.mSnapTarget.mRow = row;
		mCurSnapData.mSnapTarget.mColumn = column;
		mCurSnapData.mSnapStatus = SnapStatus.TargetHasSet;
		mCurSnapData.mIsForceSnapTo = true;
	}

	public void ForceSnapUpdateCheck()
	{
		if (mLeftSnapUpdateExtraCount <= 0)
		{
			mLeftSnapUpdateExtraCount = 1;
		}
	}

	public void ForceToCheckContentPos()
	{
		if (mNeedCheckContentPosLeftCount <= 0)
		{
			mNeedCheckContentPosLeftCount = 1;
		}
	}

	public void MovePanelToItemByIndex(int itemIndex, float offsetX = 0f, float offsetY = 0f)
	{
		if (ItemTotalCount != 0)
		{
			if (itemIndex >= ItemTotalCount)
			{
				itemIndex = ItemTotalCount - 1;
			}
			if (itemIndex < 0)
			{
				itemIndex = 0;
			}
			RowColumnPair rowColumnByItemIndex = GetRowColumnByItemIndex(itemIndex);
			MovePanelToItemByRowColumn(rowColumnByItemIndex.mRow, rowColumnByItemIndex.mColumn, offsetX, offsetY);
		}
	}

	public void MovePanelToItemByRowColumn(int row, int column, float offsetX = 0f, float offsetY = 0f)
	{
		mScrollRect.StopMovement();
		mCurSnapData.Clear();
		if (mItemTotalCount == 0)
		{
			return;
		}
		Vector2 itemPos = GetItemPos(row, column);
		Vector3 anchoredPosition3D = mContainerTrans.anchoredPosition3D;
		if (mScrollRect.horizontal)
		{
			float num = Mathf.Max(ContainerTrans.rect.width - ViewPortWidth, 0f);
			if (num > 0f)
			{
				float f = 0f - itemPos.x + offsetX;
				f = Mathf.Min(Mathf.Abs(f), num) * Mathf.Sign(f);
				anchoredPosition3D.x = f;
			}
		}
		if (mScrollRect.vertical)
		{
			float num2 = Mathf.Max(ContainerTrans.rect.height - ViewPortHeight, 0f);
			if (num2 > 0f)
			{
				float f2 = 0f - itemPos.y + offsetY;
				f2 = Mathf.Min(Mathf.Abs(f2), num2) * Mathf.Sign(f2);
				anchoredPosition3D.y = f2;
			}
		}
		if (anchoredPosition3D != mContainerTrans.anchoredPosition3D)
		{
			mContainerTrans.anchoredPosition3D = anchoredPosition3D;
		}
		VaildAndSetContainerPos();
		ForceToCheckContentPos();
	}

	public void RefreshAllShownItem()
	{
		if (mItemGroupList.Count != 0)
		{
			ForceToCheckContentPos();
			RecycleAllItem();
			UpdateGridViewContent(forceImmediately: false);
		}
	}

	public virtual void OnBeginDrag(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			mCurSnapData.Clear();
			mIsDraging = true;
			if (mOnBeginDragAction != null)
			{
				mOnBeginDragAction(eventData);
			}
		}
	}

	public virtual void OnEndDrag(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			mIsDraging = false;
			ForceSnapUpdateCheck();
			if (mOnEndDragAction != null)
			{
				mOnEndDragAction(eventData);
			}
		}
	}

	public virtual void OnDrag(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left && mOnDragingAction != null)
		{
			mOnDragingAction(eventData);
		}
	}

	public int GetItemIndexByRowColumn(int row, int column)
	{
		if (mGridFixedType == GridFixedType.ColumnCountFixed)
		{
			return row * mFixedRowOrColumnCount + column;
		}
		return column * mFixedRowOrColumnCount + row;
	}

	public RowColumnPair GetRowColumnByItemIndex(int itemIndex)
	{
		if (itemIndex < 0)
		{
			itemIndex = 0;
		}
		if (mGridFixedType == GridFixedType.ColumnCountFixed)
		{
			int row = itemIndex / mFixedRowOrColumnCount;
			int column = itemIndex % mFixedRowOrColumnCount;
			return new RowColumnPair(row, column);
		}
		int column2 = itemIndex / mFixedRowOrColumnCount;
		return new RowColumnPair(itemIndex % mFixedRowOrColumnCount, column2);
	}

	public Vector2 GetItemAbsPos(int row, int column)
	{
		float x = mStartPadding.x + (float)column * mItemSizeWithPadding.x;
		float y = mStartPadding.y + (float)row * mItemSizeWithPadding.y;
		return new Vector2(x, y);
	}

	public Vector2 GetItemPos(int row, int column)
	{
		Vector2 itemAbsPos = GetItemAbsPos(row, column);
		float x = itemAbsPos.x;
		float y = itemAbsPos.y;
		if (ArrangeType == GridItemArrangeType.TopLeftToBottomRight)
		{
			return new Vector2(x, 0f - y);
		}
		if (ArrangeType == GridItemArrangeType.BottomLeftToTopRight)
		{
			return new Vector2(x, y);
		}
		if (ArrangeType == GridItemArrangeType.TopRightToBottomLeft)
		{
			return new Vector2(0f - x, 0f - y);
		}
		if (ArrangeType == GridItemArrangeType.BottomRightToTopLeft)
		{
			return new Vector2(0f - x, y);
		}
		return Vector2.zero;
	}

	public LoopGridViewItem GetShownItemByItemIndex(int itemIndex)
	{
		if (itemIndex < 0 || itemIndex >= ItemTotalCount)
		{
			return null;
		}
		if (mItemGroupList.Count == 0)
		{
			return null;
		}
		RowColumnPair rowColumnByItemIndex = GetRowColumnByItemIndex(itemIndex);
		return GetShownItemByRowColumn(rowColumnByItemIndex.mRow, rowColumnByItemIndex.mColumn);
	}

	public LoopGridViewItem GetShownItemByRowColumn(int row, int column)
	{
		if (mItemGroupList.Count == 0)
		{
			return null;
		}
		if (mGridFixedType == GridFixedType.ColumnCountFixed)
		{
			return GetShownGroup(row)?.GetItemByColumn(column);
		}
		return GetShownGroup(column)?.GetItemByRow(row);
	}

	public void UpdateAllGridSetting()
	{
		UpdateStartEndPadding();
		UpdateItemSize();
		UpdateColumnRowCount();
		UpdateContentSize();
		ForceSnapUpdateCheck();
		ForceToCheckContentPos();
	}

	public void SetGridFixedGroupCount(GridFixedType fixedType, int count)
	{
		if (mGridFixedType != fixedType || mFixedRowOrColumnCount != count)
		{
			mGridFixedType = fixedType;
			mFixedRowOrColumnCount = count;
			UpdateColumnRowCount();
			UpdateContentSize();
			if (mItemGroupList.Count != 0)
			{
				RecycleAllItem();
				ForceSnapUpdateCheck();
				ForceToCheckContentPos();
			}
		}
	}

	public void SetItemSize(Vector2 newSize)
	{
		if (!(newSize == mItemSize))
		{
			mItemSize = newSize;
			UpdateItemSize();
			UpdateContentSize();
			if (mItemGroupList.Count != 0)
			{
				RecycleAllItem();
				ForceSnapUpdateCheck();
				ForceToCheckContentPos();
			}
		}
	}

	public void SetItemPadding(Vector2 newPadding)
	{
		if (!(newPadding == mItemPadding))
		{
			mItemPadding = newPadding;
			UpdateItemSize();
			UpdateContentSize();
			if (mItemGroupList.Count != 0)
			{
				RecycleAllItem();
				ForceSnapUpdateCheck();
				ForceToCheckContentPos();
			}
		}
	}

	public void SetPadding(RectOffset newPadding)
	{
		if (newPadding != mPadding)
		{
			mPadding = newPadding;
			UpdateStartEndPadding();
			UpdateContentSize();
			if (mItemGroupList.Count != 0)
			{
				RecycleAllItem();
				ForceSnapUpdateCheck();
				ForceToCheckContentPos();
			}
		}
	}

	public void UpdateContentSize()
	{
		float num = mStartPadding.x + (float)mColumnCount * mItemSizeWithPadding.x - mItemPadding.x + mEndPadding.x;
		float num2 = mStartPadding.y + (float)mRowCount * mItemSizeWithPadding.y - mItemPadding.y + mEndPadding.y;
		if (mContainerTrans.rect.height != num2)
		{
			mContainerTrans.SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, num2);
		}
		if (mContainerTrans.rect.width != num)
		{
			mContainerTrans.SetSizeWithCurrentAnchors(RectTransform.Axis.Horizontal, num);
		}
	}

	public void VaildAndSetContainerPos()
	{
		Vector3 anchoredPosition3D = mContainerTrans.anchoredPosition3D;
		mContainerTrans.anchoredPosition3D = GetContainerVaildPos(anchoredPosition3D.x, anchoredPosition3D.y);
	}

	public void ClearAllTmpRecycledItem()
	{
		int count = mItemPoolList.Count;
		for (int i = 0; i < count; i++)
		{
			mItemPoolList[i].ClearTmpRecycledItem();
		}
	}

	public void RecycleAllItem()
	{
		foreach (GridItemGroup mItemGroup in mItemGroupList)
		{
			RecycleItemGroupTmp(mItemGroup);
		}
		ClearAllTask();
		mItemGroupList.Clear();
	}

	public void UpdateGridViewContent(bool forceImmediately = true)
	{
		mListUpdateCheckFrameCount++;
		if (mItemTotalCount == 0)
		{
			if (mItemGroupList.Count > 0)
			{
				RecycleAllItem();
			}
			return;
		}
		UpdateCurFrameItemRangeData();
		if (mGridFixedType == GridFixedType.ColumnCountFixed)
		{
			int count = mItemGroupList.Count;
			int mMinRow = mCurFrameItemRangeData.mMinRow;
			int mMaxRow = mCurFrameItemRangeData.mMaxRow;
			for (int num = count - 1; num >= 0; num--)
			{
				GridItemGroup gridItemGroup = mItemGroupList[num];
				if (gridItemGroup.GroupIndex < mMinRow || gridItemGroup.GroupIndex > mMaxRow)
				{
					CheckQueueRange(mMinRow, mMaxRow, -1, -1);
					RecycleItemGroupTmp(gridItemGroup);
					mItemGroupList.RemoveAt(num);
				}
			}
			if (mItemGroupList.Count == 0)
			{
				GridItemGroup item = CreateItemGroup(mMinRow);
				mItemGroupList.Add(item);
			}
			while (mItemGroupList[0].GroupIndex > mMinRow)
			{
				GridItemGroup item2 = CreateItemGroup(mItemGroupList[0].GroupIndex - 1);
				mItemGroupList.Insert(0, item2);
			}
			while (mItemGroupList[mItemGroupList.Count - 1].GroupIndex < mMaxRow)
			{
				GridItemGroup item3 = CreateItemGroup(mItemGroupList[mItemGroupList.Count - 1].GroupIndex + 1);
				mItemGroupList.Add(item3);
			}
			int count2 = mItemGroupList.Count;
			if (enableFrameCreate && !forceImmediately)
			{
				for (int i = 0; i < count2; i++)
				{
					UpdateRowItemGroupForRecycleAndNewPrepare(mItemGroupList[i]);
				}
			}
			else
			{
				for (int j = 0; j < count2; j++)
				{
					UpdateRowItemGroupForRecycleAndNew(mItemGroupList[j]);
				}
			}
			return;
		}
		int count3 = mItemGroupList.Count;
		int mMinColumn = mCurFrameItemRangeData.mMinColumn;
		int mMaxColumn = mCurFrameItemRangeData.mMaxColumn;
		for (int num2 = count3 - 1; num2 >= 0; num2--)
		{
			GridItemGroup gridItemGroup2 = mItemGroupList[num2];
			if (gridItemGroup2.GroupIndex < mMinColumn || gridItemGroup2.GroupIndex > mMaxColumn)
			{
				CheckQueueRange(-1, -1, mMinColumn, mMaxColumn);
				RecycleItemGroupTmp(gridItemGroup2);
				mItemGroupList.RemoveAt(num2);
			}
		}
		if (mItemGroupList.Count == 0)
		{
			GridItemGroup item4 = CreateItemGroup(mMinColumn);
			mItemGroupList.Add(item4);
		}
		while (mItemGroupList[0].GroupIndex > mMinColumn)
		{
			GridItemGroup item5 = CreateItemGroup(mItemGroupList[0].GroupIndex - 1);
			mItemGroupList.Insert(0, item5);
		}
		while (mItemGroupList[mItemGroupList.Count - 1].GroupIndex < mMaxColumn)
		{
			GridItemGroup item6 = CreateItemGroup(mItemGroupList[mItemGroupList.Count - 1].GroupIndex + 1);
			mItemGroupList.Add(item6);
		}
		int count4 = mItemGroupList.Count;
		if (enableFrameCreate && !forceImmediately)
		{
			for (int k = 0; k < count4; k++)
			{
				UpdateColumnItemGroupForRecycleAndNewPrepare(mItemGroupList[k]);
			}
		}
		else
		{
			for (int l = 0; l < count4; l++)
			{
				UpdateColumnItemGroupForRecycleAndNew(mItemGroupList[l]);
			}
		}
	}

	public void UpdateStartEndPadding()
	{
		if (ArrangeType == GridItemArrangeType.TopLeftToBottomRight)
		{
			mStartPadding.x = mPadding.left;
			mStartPadding.y = mPadding.top;
			mEndPadding.x = mPadding.right;
			mEndPadding.y = mPadding.bottom;
		}
		else if (ArrangeType == GridItemArrangeType.BottomLeftToTopRight)
		{
			mStartPadding.x = mPadding.left;
			mStartPadding.y = mPadding.bottom;
			mEndPadding.x = mPadding.right;
			mEndPadding.y = mPadding.top;
		}
		else if (ArrangeType == GridItemArrangeType.TopRightToBottomLeft)
		{
			mStartPadding.x = mPadding.right;
			mStartPadding.y = mPadding.top;
			mEndPadding.x = mPadding.left;
			mEndPadding.y = mPadding.bottom;
		}
		else if (ArrangeType == GridItemArrangeType.BottomRightToTopLeft)
		{
			mStartPadding.x = mPadding.right;
			mStartPadding.y = mPadding.bottom;
			mEndPadding.x = mPadding.left;
			mEndPadding.y = mPadding.top;
		}
	}

	public void UpdateItemSize()
	{
		if (mItemSize.x > 0f && mItemSize.y > 0f)
		{
			mItemSizeWithPadding = mItemSize + mItemPadding;
			return;
		}
		if (mItemPrefabDataList.Count != 0)
		{
			GameObject mItemPrefab = mItemPrefabDataList[0].mItemPrefab;
			if (!(mItemPrefab == null))
			{
				RectTransform component = mItemPrefab.GetComponent<RectTransform>();
				if (!(component == null))
				{
					mItemSize = component.rect.size;
					mItemSizeWithPadding = mItemSize + mItemPadding;
				}
			}
		}
		if (mItemSize.x <= 0f || mItemSize.y <= 0f)
		{
			Log.Error("Error, ItemSize is invaild.");
		}
	}

	public void UpdateColumnRowCount()
	{
		if (mGridFixedType == GridFixedType.ColumnCountFixed)
		{
			mColumnCount = mFixedRowOrColumnCount;
			mRowCount = mItemTotalCount / mColumnCount;
			if (mItemTotalCount % mColumnCount > 0)
			{
				mRowCount++;
			}
			if (mItemTotalCount <= mColumnCount)
			{
				mColumnCount = mItemTotalCount;
			}
		}
		else
		{
			mRowCount = mFixedRowOrColumnCount;
			mColumnCount = mItemTotalCount / mRowCount;
			if (mItemTotalCount % mRowCount > 0)
			{
				mColumnCount++;
			}
			if (mItemTotalCount <= mRowCount)
			{
				mRowCount = mItemTotalCount;
			}
		}
	}

	private bool IsContainerTransCanMove()
	{
		if (mItemTotalCount == 0)
		{
			return false;
		}
		if (mScrollRect.horizontal && ContainerTrans.rect.width > ViewPortWidth)
		{
			return true;
		}
		if (mScrollRect.vertical && ContainerTrans.rect.height > ViewPortHeight)
		{
			return true;
		}
		return false;
	}

	private void RecycleItemGroupTmp(GridItemGroup group)
	{
		if (group != null)
		{
			while (group.First != null)
			{
				LoopGridViewItem item = group.RemoveFirst();
				RecycleItemTmp(item);
			}
			group.Clear();
			RecycleOneItemGroupObj(group);
		}
	}

	private void RecycleItemTmp(LoopGridViewItem item)
	{
		if (!(item == null) && !string.IsNullOrEmpty(item.ItemPrefabName))
		{
			GridItemPool value = null;
			if (mItemPoolDict.TryGetValue(item.ItemPrefabName, out value))
			{
				value.RecycleItem(item);
			}
		}
	}

	private void AdjustViewPortPivot()
	{
		RectTransform rectTransform = mViewPortRectTransform;
		if (ArrangeType == GridItemArrangeType.TopLeftToBottomRight)
		{
			rectTransform.pivot = new Vector2(0f, 1f);
		}
		else if (ArrangeType == GridItemArrangeType.BottomLeftToTopRight)
		{
			rectTransform.pivot = new Vector2(0f, 0f);
		}
		else if (ArrangeType == GridItemArrangeType.TopRightToBottomLeft)
		{
			rectTransform.pivot = new Vector2(1f, 1f);
		}
		else if (ArrangeType == GridItemArrangeType.BottomRightToTopLeft)
		{
			rectTransform.pivot = new Vector2(1f, 0f);
		}
	}

	private void AdjustContainerAnchorAndPivot()
	{
		RectTransform containerTrans = ContainerTrans;
		if (ArrangeType == GridItemArrangeType.TopLeftToBottomRight)
		{
			containerTrans.anchorMin = new Vector2(0f, 1f);
			containerTrans.anchorMax = new Vector2(0f, 1f);
			containerTrans.pivot = new Vector2(0f, 1f);
		}
		else if (ArrangeType == GridItemArrangeType.BottomLeftToTopRight)
		{
			containerTrans.anchorMin = new Vector2(0f, 0f);
			containerTrans.anchorMax = new Vector2(0f, 0f);
			containerTrans.pivot = new Vector2(0f, 0f);
		}
		else if (ArrangeType == GridItemArrangeType.TopRightToBottomLeft)
		{
			containerTrans.anchorMin = new Vector2(1f, 1f);
			containerTrans.anchorMax = new Vector2(1f, 1f);
			containerTrans.pivot = new Vector2(1f, 1f);
		}
		else if (ArrangeType == GridItemArrangeType.BottomRightToTopLeft)
		{
			containerTrans.anchorMin = new Vector2(1f, 0f);
			containerTrans.anchorMax = new Vector2(1f, 0f);
			containerTrans.pivot = new Vector2(1f, 0f);
		}
	}

	private void AdjustItemAnchorAndPivot(RectTransform rtf)
	{
		if (ArrangeType == GridItemArrangeType.TopLeftToBottomRight)
		{
			rtf.anchorMin = new Vector2(0f, 1f);
			rtf.anchorMax = new Vector2(0f, 1f);
			rtf.pivot = new Vector2(0f, 1f);
		}
		else if (ArrangeType == GridItemArrangeType.BottomLeftToTopRight)
		{
			rtf.anchorMin = new Vector2(0f, 0f);
			rtf.anchorMax = new Vector2(0f, 0f);
			rtf.pivot = new Vector2(0f, 0f);
		}
		else if (ArrangeType == GridItemArrangeType.TopRightToBottomLeft)
		{
			rtf.anchorMin = new Vector2(1f, 1f);
			rtf.anchorMax = new Vector2(1f, 1f);
			rtf.pivot = new Vector2(1f, 1f);
		}
		else if (ArrangeType == GridItemArrangeType.BottomRightToTopLeft)
		{
			rtf.anchorMin = new Vector2(1f, 0f);
			rtf.anchorMax = new Vector2(1f, 0f);
			rtf.pivot = new Vector2(1f, 0f);
		}
	}

	private void InitItemPool()
	{
		foreach (GridViewItemPrefabConfData mItemPrefabData in mItemPrefabDataList)
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
			AdjustItemAnchorAndPivot(component);
			if (mItemPrefabData.mItemPrefab.GetComponent<LoopGridViewItem>() == null)
			{
				mItemPrefabData.mItemPrefab.AddComponent<LoopGridViewItem>();
			}
			GridItemPool gridItemPool = new GridItemPool();
			gridItemPool.Init(mItemPrefabData.mItemPrefab, mItemPrefabData.mInitCreateCount, mContainerTrans);
			mItemPoolDict.Add(text, gridItemPool);
			mItemPoolList.Add(gridItemPool);
		}
	}

	private LoopGridViewItem GetNewItemByRowColumn(int row, int column)
	{
		int itemIndexByRowColumn = GetItemIndexByRowColumn(row, column);
		if (itemIndexByRowColumn < 0 || itemIndexByRowColumn >= ItemTotalCount)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = mOnGetItemByRowColumn(this, itemIndexByRowColumn, row, column);
		if (loopGridViewItem == null)
		{
			return null;
		}
		loopGridViewItem.NextItem = null;
		loopGridViewItem.PrevItem = null;
		loopGridViewItem.Row = row;
		loopGridViewItem.Column = column;
		loopGridViewItem.ItemIndex = itemIndexByRowColumn;
		loopGridViewItem.ItemCreatedCheckFrameCount = mListUpdateCheckFrameCount;
		return loopGridViewItem;
	}

	private RowColumnPair GetCeilItemRowColumnAtGivenAbsPos(float ax, float ay)
	{
		ax = Mathf.Abs(ax);
		ay = Mathf.Abs(ay);
		int num = Mathf.CeilToInt((ay - mStartPadding.y) / mItemSizeWithPadding.y) - 1;
		int num2 = Mathf.CeilToInt((ax - mStartPadding.x) / mItemSizeWithPadding.x) - 1;
		if (num < 0)
		{
			num = 0;
		}
		if (num >= mRowCount)
		{
			num = mRowCount - 1;
		}
		if (num2 < 0)
		{
			num2 = 0;
		}
		if (num2 >= mColumnCount)
		{
			num2 = mColumnCount - 1;
		}
		return new RowColumnPair(num, num2);
	}

	private void Update()
	{
		if (mListViewInited)
		{
			UpdateSnapMove();
			UpdateGridViewContent(IsScrolling);
			if (enableFrameCreate)
			{
				UpdateToCreateItem();
			}
			ClearAllTmpRecycledItem();
		}
	}

	private GridItemGroup CreateItemGroup(int groupIndex)
	{
		GridItemGroup oneItemGroupObj = GetOneItemGroupObj();
		oneItemGroupObj.GroupIndex = groupIndex;
		return oneItemGroupObj;
	}

	private Vector2 GetContainerMovedDistance()
	{
		Vector2 containerVaildPos = GetContainerVaildPos(ContainerTrans.anchoredPosition3D.x, ContainerTrans.anchoredPosition3D.y);
		return new Vector2(Mathf.Abs(containerVaildPos.x), Mathf.Abs(containerVaildPos.y));
	}

	private Vector2 GetContainerVaildPos(float curX, float curY)
	{
		float num = Mathf.Max(ContainerTrans.rect.width - ViewPortWidth, 0f);
		float num2 = Mathf.Max(ContainerTrans.rect.height - ViewPortHeight, 0f);
		if (mArrangeType == GridItemArrangeType.TopLeftToBottomRight)
		{
			curX = Mathf.Clamp(curX, 0f - num, 0f);
			curY = Mathf.Clamp(curY, 0f, num2);
		}
		else if (mArrangeType == GridItemArrangeType.BottomLeftToTopRight)
		{
			curX = Mathf.Clamp(curX, 0f - num, 0f);
			curY = Mathf.Clamp(curY, 0f - num2, 0f);
		}
		else if (mArrangeType == GridItemArrangeType.BottomRightToTopLeft)
		{
			curX = Mathf.Clamp(curX, 0f, num);
			curY = Mathf.Clamp(curY, 0f - num2, 0f);
		}
		else if (mArrangeType == GridItemArrangeType.TopRightToBottomLeft)
		{
			curX = Mathf.Clamp(curX, 0f, num);
			curY = Mathf.Clamp(curY, 0f, num2);
		}
		return new Vector2(curX, curY);
	}

	private void UpdateCurFrameItemRangeData()
	{
		Vector2 containerMovedDistance = GetContainerMovedDistance();
		if (mNeedCheckContentPosLeftCount > 0 || !(mCurFrameItemRangeData.mCheckedPosition == containerMovedDistance))
		{
			if (mNeedCheckContentPosLeftCount > 0)
			{
				mNeedCheckContentPosLeftCount--;
			}
			float num = containerMovedDistance.x - mItemRecycleDistance.x;
			float num2 = containerMovedDistance.y - mItemRecycleDistance.y;
			if (num < 0f)
			{
				num = 0f;
			}
			if (num2 < 0f)
			{
				num2 = 0f;
			}
			RowColumnPair ceilItemRowColumnAtGivenAbsPos = GetCeilItemRowColumnAtGivenAbsPos(num, num2);
			mCurFrameItemRangeData.mMinColumn = ceilItemRowColumnAtGivenAbsPos.mColumn;
			mCurFrameItemRangeData.mMinRow = ceilItemRowColumnAtGivenAbsPos.mRow;
			num = containerMovedDistance.x + mItemRecycleDistance.x + ViewPortWidth;
			num2 = containerMovedDistance.y + mItemRecycleDistance.y + ViewPortHeight;
			ceilItemRowColumnAtGivenAbsPos = GetCeilItemRowColumnAtGivenAbsPos(num, num2);
			mCurFrameItemRangeData.mMaxColumn = ceilItemRowColumnAtGivenAbsPos.mColumn;
			mCurFrameItemRangeData.mMaxRow = ceilItemRowColumnAtGivenAbsPos.mRow;
			mCurFrameItemRangeData.mCheckedPosition = containerMovedDistance;
		}
	}

	private void UpdateRowItemGroupForRecycleAndNew(GridItemGroup group)
	{
		int mMinColumn = mCurFrameItemRangeData.mMinColumn;
		int mMaxColumn = mCurFrameItemRangeData.mMaxColumn;
		int groupIndex = group.GroupIndex;
		while (group.First != null && group.First.Column < mMinColumn)
		{
			RecycleItemTmp(group.RemoveFirst());
		}
		while (group.Last != null && (group.Last.Column > mMaxColumn || group.Last.ItemIndex >= ItemTotalCount))
		{
			RecycleItemTmp(group.RemoveLast());
		}
		if (group.First == null)
		{
			LoopGridViewItem newItemByRowColumn = GetNewItemByRowColumn(groupIndex, mMinColumn);
			if (newItemByRowColumn == null)
			{
				return;
			}
			newItemByRowColumn.CachedRectTransform.anchoredPosition3D = GetItemPos(newItemByRowColumn.Row, newItemByRowColumn.Column);
			group.AddFirst(newItemByRowColumn);
		}
		while (group.First.Column > mMinColumn)
		{
			LoopGridViewItem newItemByRowColumn2 = GetNewItemByRowColumn(groupIndex, group.First.Column - 1);
			if (newItemByRowColumn2 == null)
			{
				break;
			}
			newItemByRowColumn2.CachedRectTransform.anchoredPosition3D = GetItemPos(newItemByRowColumn2.Row, newItemByRowColumn2.Column);
			group.AddFirst(newItemByRowColumn2);
		}
		while (group.Last.Column < mMaxColumn)
		{
			LoopGridViewItem newItemByRowColumn3 = GetNewItemByRowColumn(groupIndex, group.Last.Column + 1);
			if (!(newItemByRowColumn3 == null))
			{
				newItemByRowColumn3.CachedRectTransform.anchoredPosition3D = GetItemPos(newItemByRowColumn3.Row, newItemByRowColumn3.Column);
				group.AddLast(newItemByRowColumn3);
				continue;
			}
			break;
		}
	}

	private void UpdateColumnItemGroupForRecycleAndNew(GridItemGroup group)
	{
		int mMinRow = mCurFrameItemRangeData.mMinRow;
		int mMaxRow = mCurFrameItemRangeData.mMaxRow;
		int groupIndex = group.GroupIndex;
		while (group.First != null && group.First.Row < mMinRow)
		{
			RecycleItemTmp(group.RemoveFirst());
		}
		while (group.Last != null && (group.Last.Row > mMaxRow || group.Last.ItemIndex >= ItemTotalCount))
		{
			RecycleItemTmp(group.RemoveLast());
		}
		if (group.First == null)
		{
			LoopGridViewItem newItemByRowColumn = GetNewItemByRowColumn(mMinRow, groupIndex);
			if (newItemByRowColumn == null)
			{
				return;
			}
			newItemByRowColumn.CachedRectTransform.anchoredPosition3D = GetItemPos(newItemByRowColumn.Row, newItemByRowColumn.Column);
			group.AddFirst(newItemByRowColumn);
		}
		while (group.First.Row > mMinRow)
		{
			LoopGridViewItem newItemByRowColumn2 = GetNewItemByRowColumn(group.First.Row - 1, groupIndex);
			if (newItemByRowColumn2 == null)
			{
				break;
			}
			newItemByRowColumn2.CachedRectTransform.anchoredPosition3D = GetItemPos(newItemByRowColumn2.Row, newItemByRowColumn2.Column);
			group.AddFirst(newItemByRowColumn2);
		}
		while (group.Last.Row < mMaxRow)
		{
			LoopGridViewItem newItemByRowColumn3 = GetNewItemByRowColumn(group.Last.Row + 1, groupIndex);
			if (!(newItemByRowColumn3 == null))
			{
				newItemByRowColumn3.CachedRectTransform.anchoredPosition3D = GetItemPos(newItemByRowColumn3.Row, newItemByRowColumn3.Column);
				group.AddLast(newItemByRowColumn3);
				continue;
			}
			break;
		}
	}

	private void SetScrollbarListener()
	{
		if (ItemSnapEnable || enableFrameCreate)
		{
			mScrollBarClickEventListener1 = null;
			mScrollBarClickEventListener2 = null;
			Scrollbar scrollbar = null;
			Scrollbar scrollbar2 = null;
			if (mScrollRect.vertical && mScrollRect.verticalScrollbar != null)
			{
				scrollbar = mScrollRect.verticalScrollbar;
			}
			if (mScrollRect.horizontal && mScrollRect.horizontalScrollbar != null)
			{
				scrollbar2 = mScrollRect.horizontalScrollbar;
			}
			if (scrollbar != null)
			{
				ClickEventListener clickEventListener = (mScrollBarClickEventListener1 = ClickEventListener.Get(scrollbar.gameObject));
				clickEventListener.SetPointerUpHandler(OnPointerUpInScrollBar);
				clickEventListener.SetPointerDownHandler(OnPointerDownInScrollBar);
			}
			if (scrollbar2 != null)
			{
				ClickEventListener clickEventListener2 = (mScrollBarClickEventListener2 = ClickEventListener.Get(scrollbar2.gameObject));
				clickEventListener2.SetPointerUpHandler(OnPointerUpInScrollBar);
				clickEventListener2.SetPointerDownHandler(OnPointerDownInScrollBar);
			}
		}
	}

	private void OnPointerDownInScrollBar(GameObject obj)
	{
		if (ItemSnapEnable)
		{
			mCurSnapData.Clear();
		}
		if (enableFrameCreate)
		{
			_isDragScrollBar = true;
		}
	}

	private void OnPointerUpInScrollBar(GameObject obj)
	{
		if (ItemSnapEnable)
		{
			ForceSnapUpdateCheck();
		}
		if (enableFrameCreate)
		{
			_isDragScrollBar = false;
		}
	}

	private RowColumnPair FindNearestItemWithLocalPos(float x, float y)
	{
		Vector2 vector = new Vector2(x, y);
		RowColumnPair ceilItemRowColumnAtGivenAbsPos = GetCeilItemRowColumnAtGivenAbsPos(vector.x, vector.y);
		int mRow = ceilItemRowColumnAtGivenAbsPos.mRow;
		int mColumn = ceilItemRowColumnAtGivenAbsPos.mColumn;
		float num = 0f;
		RowColumnPair result = new RowColumnPair(-1, -1);
		_ = Vector2.zero;
		float num2 = float.MaxValue;
		for (int i = mRow - 1; i <= mRow + 1; i++)
		{
			for (int j = mColumn - 1; j <= mColumn + 1; j++)
			{
				if (i >= 0 && i < mRowCount && j >= 0 && j < mColumnCount)
				{
					num = (GetItemSnapPivotLocalPos(i, j) - vector).sqrMagnitude;
					if (num < num2)
					{
						num2 = num;
						result.mRow = i;
						result.mColumn = j;
					}
				}
			}
		}
		return result;
	}

	private Vector2 GetItemSnapPivotLocalPos(int row, int column)
	{
		Vector2 itemAbsPos = GetItemAbsPos(row, column);
		if (mArrangeType == GridItemArrangeType.TopLeftToBottomRight)
		{
			float x = itemAbsPos.x + mItemSize.x * mItemSnapPivot.x;
			float y = 0f - itemAbsPos.y - mItemSize.y * (1f - mItemSnapPivot.y);
			return new Vector2(x, y);
		}
		if (mArrangeType == GridItemArrangeType.BottomLeftToTopRight)
		{
			float x2 = itemAbsPos.x + mItemSize.x * mItemSnapPivot.x;
			float y2 = itemAbsPos.y + mItemSize.y * mItemSnapPivot.y;
			return new Vector2(x2, y2);
		}
		if (mArrangeType == GridItemArrangeType.TopRightToBottomLeft)
		{
			float x3 = 0f - itemAbsPos.x - mItemSize.x * (1f - mItemSnapPivot.x);
			float y3 = 0f - itemAbsPos.y - mItemSize.y * (1f - mItemSnapPivot.y);
			return new Vector2(x3, y3);
		}
		if (mArrangeType == GridItemArrangeType.BottomRightToTopLeft)
		{
			float x4 = 0f - itemAbsPos.x - mItemSize.x * (1f - mItemSnapPivot.x);
			float y4 = itemAbsPos.y + mItemSize.y * mItemSnapPivot.y;
			return new Vector2(x4, y4);
		}
		return Vector2.zero;
	}

	private Vector2 GetViewPortSnapPivotLocalPos(Vector2 pos)
	{
		float x = 0f;
		float y = 0f;
		if (mArrangeType == GridItemArrangeType.TopLeftToBottomRight)
		{
			x = 0f - pos.x + ViewPortWidth * mViewPortSnapPivot.x;
			y = 0f - pos.y - ViewPortHeight * (1f - mViewPortSnapPivot.y);
		}
		else if (mArrangeType == GridItemArrangeType.BottomLeftToTopRight)
		{
			x = 0f - pos.x + ViewPortWidth * mViewPortSnapPivot.x;
			y = 0f - pos.y + ViewPortHeight * mViewPortSnapPivot.y;
		}
		else if (mArrangeType == GridItemArrangeType.TopRightToBottomLeft)
		{
			x = 0f - pos.x - ViewPortWidth * (1f - mViewPortSnapPivot.x);
			y = 0f - pos.y - ViewPortHeight * (1f - mViewPortSnapPivot.y);
		}
		else if (mArrangeType == GridItemArrangeType.BottomRightToTopLeft)
		{
			x = 0f - pos.x - ViewPortWidth * (1f - mViewPortSnapPivot.x);
			y = 0f - pos.y + ViewPortHeight * mViewPortSnapPivot.y;
		}
		return new Vector2(x, y);
	}

	private void UpdateNearestSnapItem(bool forceSendEvent)
	{
		if (!mItemSnapEnable || mItemGroupList.Count == 0 || !IsContainerTransCanMove())
		{
			return;
		}
		Vector2 containerVaildPos = GetContainerVaildPos(ContainerTrans.anchoredPosition3D.x, ContainerTrans.anchoredPosition3D.y);
		bool flag = containerVaildPos.y != mLastSnapCheckPos.y || containerVaildPos.x != mLastSnapCheckPos.x;
		mLastSnapCheckPos = containerVaildPos;
		if (!flag && mLeftSnapUpdateExtraCount > 0)
		{
			mLeftSnapUpdateExtraCount--;
			flag = true;
		}
		if (!flag)
		{
			return;
		}
		RowColumnPair rowColumnPair = new RowColumnPair(-1, -1);
		Vector2 viewPortSnapPivotLocalPos = GetViewPortSnapPivotLocalPos(containerVaildPos);
		rowColumnPair = FindNearestItemWithLocalPos(viewPortSnapPivotLocalPos.x, viewPortSnapPivotLocalPos.y);
		if (rowColumnPair.mRow >= 0)
		{
			RowColumnPair rowColumnPair2 = mCurSnapNearestItemRowColumn;
			mCurSnapNearestItemRowColumn = rowColumnPair;
			if ((forceSendEvent || rowColumnPair2 != mCurSnapNearestItemRowColumn) && mOnSnapNearestChanged != null)
			{
				mOnSnapNearestChanged(this);
			}
		}
		else
		{
			mCurSnapNearestItemRowColumn.mRow = -1;
			mCurSnapNearestItemRowColumn.mColumn = -1;
		}
	}

	private void UpdateFromSettingParam(LoopGridViewSettingParam param)
	{
		if (param != null)
		{
			if (param.mItemSize != null)
			{
				mItemSize = (Vector2)param.mItemSize;
			}
			if (param.mItemPadding != null)
			{
				mItemPadding = (Vector2)param.mItemPadding;
			}
			if (param.mPadding != null)
			{
				mPadding = (RectOffset)param.mPadding;
			}
			if (param.mGridFixedType != null)
			{
				mGridFixedType = (GridFixedType)param.mGridFixedType;
			}
			if (param.mFixedRowOrColumnCount != null)
			{
				mFixedRowOrColumnCount = (int)param.mFixedRowOrColumnCount;
			}
		}
	}

	public void FinishSnapImmediately()
	{
		UpdateSnapMove(immediate: true);
	}

	private void UpdateSnapMove(bool immediate = false, bool forceSendEvent = false)
	{
		if (!mItemSnapEnable)
		{
			return;
		}
		UpdateNearestSnapItem(forceSendEvent: false);
		Vector2 vector = mContainerTrans.anchoredPosition3D;
		if (!CanSnap())
		{
			ClearSnapData();
			return;
		}
		UpdateCurSnapData();
		if (mCurSnapData.mSnapStatus != SnapStatus.SnapMoving)
		{
			return;
		}
		if (Mathf.Abs(mScrollRect.velocity.x) + Mathf.Abs(mScrollRect.velocity.y) > 0f)
		{
			mScrollRect.StopMovement();
		}
		float mCurSnapVal = mCurSnapData.mCurSnapVal;
		mCurSnapData.mCurSnapVal = Mathf.SmoothDamp(mCurSnapData.mCurSnapVal, mCurSnapData.mTargetSnapVal, ref mSmoothDumpVel, mSmoothDumpRate);
		float num = mCurSnapData.mCurSnapVal - mCurSnapVal;
		if (immediate || Mathf.Abs(mCurSnapData.mTargetSnapVal - mCurSnapData.mCurSnapVal) < mSnapFinishThreshold)
		{
			vector += (mCurSnapData.mTargetSnapVal - mCurSnapVal) * mCurSnapData.mSnapNeedMoveDir;
			mCurSnapData.mSnapStatus = SnapStatus.SnapMoveFinish;
			if (mOnSnapItemFinished != null)
			{
				LoopGridViewItem shownItemByRowColumn = GetShownItemByRowColumn(mCurSnapNearestItemRowColumn.mRow, mCurSnapNearestItemRowColumn.mColumn);
				if (shownItemByRowColumn != null)
				{
					mOnSnapItemFinished(this, shownItemByRowColumn);
				}
			}
		}
		else
		{
			vector += num * mCurSnapData.mSnapNeedMoveDir;
		}
		mContainerTrans.anchoredPosition3D = GetContainerVaildPos(vector.x, vector.y);
	}

	private GridItemGroup GetShownGroup(int groupIndex)
	{
		if (groupIndex < 0)
		{
			return null;
		}
		int count = mItemGroupList.Count;
		if (count == 0)
		{
			return null;
		}
		if (groupIndex < mItemGroupList[0].GroupIndex || groupIndex > mItemGroupList[count - 1].GroupIndex)
		{
			return null;
		}
		int index = groupIndex - mItemGroupList[0].GroupIndex;
		return mItemGroupList[index];
	}

	private void FillCurSnapData(int row, int column)
	{
		Vector2 itemSnapPivotLocalPos = GetItemSnapPivotLocalPos(row, column);
		Vector2 containerVaildPos = GetContainerVaildPos(ContainerTrans.anchoredPosition3D.x, ContainerTrans.anchoredPosition3D.y);
		Vector2 vector = GetViewPortSnapPivotLocalPos(containerVaildPos) - itemSnapPivotLocalPos;
		if (!mScrollRect.horizontal)
		{
			vector.x = 0f;
		}
		if (!mScrollRect.vertical)
		{
			vector.y = 0f;
		}
		mCurSnapData.mTargetSnapVal = vector.magnitude;
		mCurSnapData.mCurSnapVal = 0f;
		mCurSnapData.mSnapNeedMoveDir = vector.normalized;
	}

	private void UpdateCurSnapData()
	{
		if (mItemGroupList.Count == 0)
		{
			mCurSnapData.Clear();
			return;
		}
		if (mCurSnapData.mSnapStatus == SnapStatus.SnapMoveFinish)
		{
			if (mCurSnapData.mSnapTarget == mCurSnapNearestItemRowColumn)
			{
				return;
			}
			mCurSnapData.mSnapStatus = SnapStatus.NoTargetSet;
		}
		if (mCurSnapData.mSnapStatus == SnapStatus.SnapMoving)
		{
			if (mCurSnapData.mSnapTarget == mCurSnapNearestItemRowColumn || mCurSnapData.mIsForceSnapTo)
			{
				return;
			}
			mCurSnapData.mSnapStatus = SnapStatus.NoTargetSet;
		}
		if (mCurSnapData.mSnapStatus == SnapStatus.NoTargetSet)
		{
			if (GetShownItemByRowColumn(mCurSnapNearestItemRowColumn.mRow, mCurSnapNearestItemRowColumn.mColumn) == null)
			{
				return;
			}
			mCurSnapData.mSnapTarget = mCurSnapNearestItemRowColumn;
			mCurSnapData.mSnapStatus = SnapStatus.TargetHasSet;
			mCurSnapData.mIsForceSnapTo = false;
		}
		if (mCurSnapData.mSnapStatus == SnapStatus.TargetHasSet)
		{
			LoopGridViewItem shownItemByRowColumn = GetShownItemByRowColumn(mCurSnapData.mSnapTarget.mRow, mCurSnapData.mSnapTarget.mColumn);
			if (shownItemByRowColumn == null)
			{
				mCurSnapData.Clear();
				return;
			}
			FillCurSnapData(shownItemByRowColumn.Row, shownItemByRowColumn.Column);
			mCurSnapData.mSnapStatus = SnapStatus.SnapMoving;
		}
	}

	private bool CanSnap()
	{
		if (mIsDraging)
		{
			return false;
		}
		if (mScrollBarClickEventListener1 != null && mScrollBarClickEventListener1.IsPressd)
		{
			return false;
		}
		if (mScrollBarClickEventListener2 != null && mScrollBarClickEventListener2.IsPressd)
		{
			return false;
		}
		if (!IsContainerTransCanMove())
		{
			return false;
		}
		if (Mathf.Abs(mScrollRect.velocity.x) > mSnapVecThreshold)
		{
			return false;
		}
		if (Mathf.Abs(mScrollRect.velocity.y) > mSnapVecThreshold)
		{
			return false;
		}
		Vector3 anchoredPosition3D = mContainerTrans.anchoredPosition3D;
		Vector2 containerVaildPos = GetContainerVaildPos(anchoredPosition3D.x, anchoredPosition3D.y);
		if (Mathf.Abs(anchoredPosition3D.x - containerVaildPos.x) > 3f)
		{
			return false;
		}
		if (Mathf.Abs(anchoredPosition3D.y - containerVaildPos.y) > 3f)
		{
			return false;
		}
		return true;
	}

	private GridItemGroup GetOneItemGroupObj()
	{
		int count = mItemGroupObjPool.Count;
		if (count == 0)
		{
			return new GridItemGroup();
		}
		GridItemGroup result = mItemGroupObjPool[count - 1];
		mItemGroupObjPool.RemoveAt(count - 1);
		return result;
	}

	private void RecycleOneItemGroupObj(GridItemGroup obj)
	{
		mItemGroupObjPool.Add(obj);
	}

	public void ShellSort(List<WaitingItemData> list)
	{
		int count = list.Count;
		int num;
		for (num = 1; num < count; num = 3 * num + 1)
		{
		}
		while (num > 1)
		{
			num /= 3;
			for (int i = 0; i < num; i++)
			{
				for (int j = i + num; j < count; j += num)
				{
					WaitingItemData value = list[j];
					int num2 = j;
					while (num2 >= num && GetItemIndexByRowColumn(list[num2 - num].Row, list[num2 - num].Col) - GetItemIndexByRowColumn(value.Row, value.Col) > 0)
					{
						list[num2] = list[num2 - num];
						num2 -= num;
					}
					list[num2] = value;
				}
			}
		}
	}

	private void ClearAllTask()
	{
		_waitingItemDataList.Clear();
		_isItemCreateEnded = true;
	}

	private void EnqueueTask(WaitingItemData data)
	{
		for (int num = _waitingItemDataList.Count - 1; num >= 0; num--)
		{
			WaitingItemData waitingItemData = _waitingItemDataList[num];
			if (waitingItemData.Col == data.Col && waitingItemData.Row == data.Row)
			{
				return;
			}
		}
		_waitingItemDataList.Add(data);
	}

	private WaitingItemData DequeueTask()
	{
		if (_waitingItemDataList.Count > 0)
		{
			return _waitingItemDataList.Pop();
		}
		return default(WaitingItemData);
	}

	private void CheckQueueRange(int minRow, int maxRow, int minCol, int maxCol)
	{
		for (int num = _waitingItemDataList.Count - 1; num >= 0; num--)
		{
			WaitingItemData waitingItemData = _waitingItemDataList[num];
			if (maxCol > 0 && (waitingItemData.Col < minCol || waitingItemData.Col > maxCol))
			{
				_waitingItemDataList.RemoveAt(num);
				waitingItemData.GroupPtr = null;
			}
			else if (maxRow > 0 && (waitingItemData.Row < minRow || waitingItemData.Row > maxRow))
			{
				_waitingItemDataList.RemoveAt(num);
				waitingItemData.GroupPtr = null;
			}
		}
	}

	private void UpdateRowItemGroupForRecycleAndNewPrepare(GridItemGroup group)
	{
		if (_isItemCreateEnded)
		{
			int mMinColumn = mCurFrameItemRangeData.mMinColumn;
			int mMaxColumn = mCurFrameItemRangeData.mMaxColumn;
			int groupIndex = group.GroupIndex;
			CheckQueueRange(-1, -1, mMinColumn, mMaxColumn);
			while (group.First != null && group.First.Column < mMinColumn)
			{
				RecycleItemTmp(group.RemoveFirst());
			}
			while (group.Last != null && (group.Last.Column > mMaxColumn || group.Last.ItemIndex >= ItemTotalCount))
			{
				RecycleItemTmp(group.RemoveLast());
			}
			int num;
			int num2;
			if (group.First == null)
			{
				EnqueueTask(new WaitingItemData
				{
					Row = groupIndex,
					Col = mMinColumn,
					GroupPtr = group,
					isFirst = true
				});
				num = (num2 = mMinColumn);
			}
			else
			{
				num = group.First.Column;
				num2 = group.Last.Column;
			}
			while (num > mMinColumn)
			{
				WaitingItemData data = new WaitingItemData
				{
					Row = groupIndex
				};
				num = (data.Col = num - 1);
				data.GroupPtr = group;
				data.isFirst = true;
				EnqueueTask(data);
			}
			while (num2 < mMaxColumn)
			{
				WaitingItemData data = new WaitingItemData
				{
					Row = groupIndex
				};
				num2 = (data.Col = num2 + 1);
				data.GroupPtr = group;
				EnqueueTask(data);
			}
			ShellSort(_waitingItemDataList);
		}
	}

	private void UpdateColumnItemGroupForRecycleAndNewPrepare(GridItemGroup group)
	{
		if (_isItemCreateEnded)
		{
			int mMinRow = mCurFrameItemRangeData.mMinRow;
			int mMaxRow = mCurFrameItemRangeData.mMaxRow;
			int groupIndex = group.GroupIndex;
			CheckQueueRange(mMinRow, mMaxRow, -1, -1);
			while (group.First != null && group.First.Row < mMinRow)
			{
				RecycleItemTmp(group.RemoveFirst());
			}
			while (group.Last != null && (group.Last.Row > mMaxRow || group.Last.ItemIndex >= ItemTotalCount))
			{
				RecycleItemTmp(group.RemoveLast());
			}
			int num;
			int num2;
			if (group.First == null)
			{
				EnqueueTask(new WaitingItemData
				{
					Row = mMinRow,
					Col = groupIndex,
					GroupPtr = group,
					isFirst = true
				});
				num = (num2 = mMinRow);
			}
			else
			{
				num = group.First.Row;
				num2 = group.Last.Row;
			}
			while (num > mMinRow)
			{
				WaitingItemData data = default(WaitingItemData);
				num = (data.Row = num - 1);
				data.Col = groupIndex;
				data.GroupPtr = group;
				data.isFirst = true;
				EnqueueTask(data);
			}
			while (num2 < mMaxRow)
			{
				WaitingItemData data = default(WaitingItemData);
				num2 = (data.Row = num2 + 1);
				data.Col = groupIndex;
				data.GroupPtr = group;
				EnqueueTask(data);
			}
			ShellSort(_waitingItemDataList);
		}
	}

	private bool UpdateToCreateItem()
	{
		if (IsScrolling)
		{
			ClearAllTask();
			return true;
		}
		if (_waitingItemDataList.Count > 0)
		{
			WaitingItemData waitingItemData = DequeueTask();
			GridItemGroup groupPtr = waitingItemData.GroupPtr;
			waitingItemData.GroupPtr = null;
			LoopGridViewItem newItemByRowColumn = GetNewItemByRowColumn(waitingItemData.Row, waitingItemData.Col);
			if (newItemByRowColumn == null)
			{
				_isItemCreateEnded = true;
				return _isItemCreateEnded;
			}
			newItemByRowColumn.CachedRectTransform.anchoredPosition3D = GetItemPos(newItemByRowColumn.Row, newItemByRowColumn.Column);
			if (waitingItemData.isFirst)
			{
				groupPtr.AddFirst(newItemByRowColumn);
			}
			else
			{
				groupPtr.AddLast(newItemByRowColumn);
			}
		}
		_isItemCreateEnded = _waitingItemDataList.Count <= 0;
		return _isItemCreateEnded;
	}
}
