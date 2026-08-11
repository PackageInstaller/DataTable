#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace SuperScrollView;

public class LoopStaggeredGridView : MonoBehaviour, IBeginDragHandler, IEventSystemHandler, IEndDragHandler, IDragHandler
{
	private Dictionary<string, StaggeredGridItemPool> mItemPoolDict = new Dictionary<string, StaggeredGridItemPool>();

	private List<StaggeredGridItemPool> mItemPoolList = new List<StaggeredGridItemPool>();

	[SerializeField]
	private List<StaggeredGridItemPrefabConfData> mItemPrefabDataList = new List<StaggeredGridItemPrefabConfData>();

	[SerializeField]
	private ListItemArrangeType mArrangeType;

	private RectTransform mContainerTrans;

	private ScrollRect mScrollRect;

	private int mGroupCount;

	private List<StaggeredGridItemGroup> mItemGroupList = new List<StaggeredGridItemGroup>();

	private List<ItemIndexData> mItemIndexDataList = new List<ItemIndexData>();

	private RectTransform mScrollRectTransform;

	private RectTransform mViewPortRectTransform;

	private float mItemDefaultWithPaddingSize = 20f;

	private int mItemTotalCount;

	private bool mIsVertList;

	private Func<LoopStaggeredGridView, int, LoopStaggeredGridViewItem> mOnGetItemByItemIndex;

	private Vector3[] mItemWorldCorners = new Vector3[4];

	private Vector3[] mViewPortRectLocalCorners = new Vector3[4];

	private float mDistanceForRecycle0 = 300f;

	private float mDistanceForNew0 = 200f;

	private float mDistanceForRecycle1 = 300f;

	private float mDistanceForNew1 = 200f;

	private bool mIsDraging;

	private PointerEventData mPointerEventData;

	public Action mOnBeginDragAction;

	public Action mOnDragingAction;

	public Action mOnEndDragAction;

	private Vector3 mLastFrameContainerPos = Vector3.zero;

	private bool mListViewInited;

	private int mListUpdateCheckFrameCount;

	private GridViewLayoutParam mLayoutParam;

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

	public List<StaggeredGridItemPrefabConfData> ItemPrefabDataList => mItemPrefabDataList;

	public int ListUpdateCheckFrameCount => mListUpdateCheckFrameCount;

	public bool IsVertList => mIsVertList;

	public int ItemTotalCount => mItemTotalCount;

	public RectTransform ContainerTrans => mContainerTrans;

	public ScrollRect ScrollRect => mScrollRect;

	public bool IsDraging => mIsDraging;

	public GridViewLayoutParam LayoutParam => mLayoutParam;

	public bool IsInited => mListViewInited;

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

	public int CurMaxCreatedItemIndexCount => mItemIndexDataList.Count;

	public StaggeredGridItemGroup GetItemGroupByIndex(int index)
	{
		int count = mItemGroupList.Count;
		if (index < 0 || index >= count)
		{
			return null;
		}
		return mItemGroupList[index];
	}

	public StaggeredGridItemPrefabConfData GetItemPrefabConfData(string prefabName)
	{
		foreach (StaggeredGridItemPrefabConfData mItemPrefabData in mItemPrefabDataList)
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

	public void InitListView(int itemTotalCount, GridViewLayoutParam layoutParam, Func<LoopStaggeredGridView, int, LoopStaggeredGridViewItem> onGetItemByItemIndex, StaggeredGridViewInitParam initParam = null)
	{
		mLayoutParam = layoutParam;
		if (mLayoutParam == null)
		{
			Log.Error("layoutParam can not be null!");
		}
		else
		{
			if (!mLayoutParam.CheckParam())
			{
				return;
			}
			if (initParam != null)
			{
				mDistanceForRecycle0 = initParam.mDistanceForRecycle0;
				mDistanceForNew0 = initParam.mDistanceForNew0;
				mDistanceForRecycle1 = initParam.mDistanceForRecycle1;
				mDistanceForNew1 = initParam.mDistanceForNew1;
				mItemDefaultWithPaddingSize = initParam.mItemDefaultWithPaddingSize;
			}
			mScrollRect = base.gameObject.GetComponent<ScrollRect>();
			if (mScrollRect == null)
			{
				Log.Error("LoopStaggeredGridView Init Failed! ScrollRect component not found!");
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
			mScrollRectTransform = mScrollRect.GetComponent<RectTransform>();
			mContainerTrans = mScrollRect.content;
			mViewPortRectTransform = mScrollRect.viewport;
			mGroupCount = mLayoutParam.mColumnOrRowCount;
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
			AdjustPivot(mViewPortRectTransform);
			AdjustAnchor(mContainerTrans);
			AdjustContainerPivot(mContainerTrans);
			InitItemPool();
			mOnGetItemByItemIndex = onGetItemByItemIndex;
			if (mListViewInited)
			{
				Log.Error("LoopStaggeredGridView.InitListView method can be called only once.");
			}
			mListViewInited = true;
			mViewPortRectTransform.GetLocalCorners(mViewPortRectLocalCorners);
			mContainerTrans.anchoredPosition3D = Vector3.zero;
			mItemTotalCount = itemTotalCount;
			UpdateLayoutParamAutoValue();
			mItemGroupList.Clear();
			for (int i = 0; i < mGroupCount; i++)
			{
				StaggeredGridItemGroup staggeredGridItemGroup = new StaggeredGridItemGroup();
				staggeredGridItemGroup.Init(this, mItemTotalCount, i, GetNewItemByGroupAndIndex);
				mItemGroupList.Add(staggeredGridItemGroup);
			}
			UpdateContentSize();
		}
	}

	public void ResetGridViewLayoutParam(int itemTotalCount, GridViewLayoutParam layoutParam)
	{
		if (!mListViewInited)
		{
			Log.Error("ResetLayoutParam can not use before LoopStaggeredGridView.InitListView are called!");
			return;
		}
		mScrollRect.StopMovement();
		SetListItemCount(0);
		RecycleAllItem();
		ClearAllTmpRecycledItem();
		mLayoutParam = layoutParam;
		if (mLayoutParam == null)
		{
			Log.Error("layoutParam can not be null!");
		}
		else if (mLayoutParam.CheckParam())
		{
			mGroupCount = mLayoutParam.mColumnOrRowCount;
			mViewPortRectTransform.GetLocalCorners(mViewPortRectLocalCorners);
			mContainerTrans.anchoredPosition3D = Vector3.zero;
			mItemTotalCount = itemTotalCount;
			UpdateLayoutParamAutoValue();
			mItemGroupList.Clear();
			for (int i = 0; i < mGroupCount; i++)
			{
				StaggeredGridItemGroup staggeredGridItemGroup = new StaggeredGridItemGroup();
				staggeredGridItemGroup.Init(this, mItemTotalCount, i, GetNewItemByGroupAndIndex);
				mItemGroupList.Add(staggeredGridItemGroup);
			}
			UpdateContentSize();
		}
	}

	private void UpdateLayoutParamAutoValue()
	{
		if (mLayoutParam.mCustomColumnOrRowOffsetArray != null)
		{
			return;
		}
		mLayoutParam.mCustomColumnOrRowOffsetArray = new float[mGroupCount];
		float num = mLayoutParam.mItemWidthOrHeight * (float)mGroupCount;
		float num2 = 0f;
		num2 = ((!IsVertList) ? ((ViewPortHeight - mLayoutParam.mPadding1 - mLayoutParam.mPadding2 - num) / (float)(mGroupCount - 1)) : ((ViewPortWidth - mLayoutParam.mPadding1 - mLayoutParam.mPadding2 - num) / (float)(mGroupCount - 1)));
		float num3 = mLayoutParam.mPadding1;
		for (int i = 0; i < mGroupCount; i++)
		{
			if (IsVertList)
			{
				mLayoutParam.mCustomColumnOrRowOffsetArray[i] = num3;
			}
			else
			{
				mLayoutParam.mCustomColumnOrRowOffsetArray[i] = 0f - num3;
			}
			num3 = num3 + mLayoutParam.mItemWidthOrHeight + num2;
		}
	}

	public LoopStaggeredGridViewItem NewListViewItem(string itemPrefabName)
	{
		StaggeredGridItemPool value = null;
		if (!mItemPoolDict.TryGetValue(itemPrefabName, out value))
		{
			return null;
		}
		LoopStaggeredGridViewItem item = value.GetItem();
		RectTransform component = item.GetComponent<RectTransform>();
		component.SetParent(mContainerTrans);
		component.localScale = Vector3.one;
		component.anchoredPosition3D = Vector3.zero;
		component.localEulerAngles = Vector3.zero;
		item.ParentListView = this;
		return item;
	}

	public void SetListItemCount(int itemCount, bool resetPos = true)
	{
		if (itemCount == mItemTotalCount)
		{
			return;
		}
		int count = mItemGroupList.Count;
		mItemTotalCount = itemCount;
		for (int i = 0; i < count; i++)
		{
			mItemGroupList[i].SetListItemCount(mItemTotalCount);
		}
		UpdateContentSize();
		if (mItemTotalCount == 0)
		{
			mItemIndexDataList.Clear();
			ClearAllTmpRecycledItem();
			return;
		}
		int count2 = mItemIndexDataList.Count;
		if (count2 > mItemTotalCount)
		{
			mItemIndexDataList.RemoveRange(mItemTotalCount, count2 - mItemTotalCount);
		}
		if (resetPos)
		{
			MovePanelToItemIndex(0, 0f);
		}
		else if (count2 > mItemTotalCount)
		{
			MovePanelToItemIndex(mItemTotalCount - 1, 0f);
		}
	}

	public void MovePanelToItemIndex(int itemIndex, float offset)
	{
		mScrollRect.StopMovement();
		if (mItemTotalCount == 0 || itemIndex < 0)
		{
			return;
		}
		CheckAllGroupIfNeedUpdateItemPos();
		UpdateContentSize();
		float viewPortSize = ViewPortSize;
		float contentSize = GetContentSize();
		if (contentSize <= viewPortSize)
		{
			if (IsVertList)
			{
				SetAnchoredPositionY(mContainerTrans, 0f);
			}
			else
			{
				SetAnchoredPositionX(mContainerTrans, 0f);
			}
			return;
		}
		if (itemIndex >= mItemTotalCount)
		{
			itemIndex = mItemTotalCount - 1;
		}
		float itemAbsPosByItemIndex = GetItemAbsPosByItemIndex(itemIndex);
		if (itemAbsPosByItemIndex < 0f)
		{
			return;
		}
		if (IsVertList)
		{
			float num = ((mArrangeType == ListItemArrangeType.TopToBottom) ? 1 : (-1));
			float num2 = itemAbsPosByItemIndex + offset;
			if (num2 < 0f)
			{
				num2 = 0f;
			}
			if (contentSize - num2 >= viewPortSize)
			{
				SetAnchoredPositionY(mContainerTrans, num * num2);
				return;
			}
			SetAnchoredPositionY(mContainerTrans, num * (contentSize - viewPortSize));
			UpdateListView(viewPortSize + 100f, viewPortSize + 100f, viewPortSize, viewPortSize);
			ClearAllTmpRecycledItem();
			UpdateContentSize();
			contentSize = GetContentSize();
			if (contentSize - num2 >= viewPortSize)
			{
				SetAnchoredPositionY(mContainerTrans, num * num2);
			}
			else
			{
				SetAnchoredPositionY(mContainerTrans, num * (contentSize - viewPortSize));
			}
			return;
		}
		float num3 = ((mArrangeType == ListItemArrangeType.RightToLeft) ? 1 : (-1));
		float num4 = itemAbsPosByItemIndex + offset;
		if (num4 < 0f)
		{
			num4 = 0f;
		}
		if (contentSize - num4 >= viewPortSize)
		{
			SetAnchoredPositionX(mContainerTrans, num3 * num4);
			return;
		}
		SetAnchoredPositionX(mContainerTrans, num3 * (contentSize - viewPortSize));
		UpdateListView(viewPortSize + 100f, viewPortSize + 100f, viewPortSize, viewPortSize);
		ClearAllTmpRecycledItem();
		UpdateContentSize();
		contentSize = GetContentSize();
		if (contentSize - num4 >= viewPortSize)
		{
			SetAnchoredPositionX(mContainerTrans, num3 * num4);
		}
		else
		{
			SetAnchoredPositionX(mContainerTrans, num3 * (contentSize - viewPortSize));
		}
	}

	public LoopStaggeredGridViewItem GetShownItemByItemIndex(int itemIndex)
	{
		ItemIndexData itemIndexData = GetItemIndexData(itemIndex);
		if (itemIndexData == null)
		{
			return null;
		}
		return GetItemGroupByIndex(itemIndexData.mGroupIndex).GetShownItemByIndexInGroup(itemIndexData.mIndexInGroup);
	}

	public void RefreshAllShownItem()
	{
		int count = mItemGroupList.Count;
		for (int i = 0; i < count; i++)
		{
			mItemGroupList[i].RefreshAllShownItem();
		}
	}

	public void OnItemSizeChanged(int itemIndex)
	{
		ItemIndexData itemIndexData = GetItemIndexData(itemIndex);
		if (itemIndexData != null)
		{
			GetItemGroupByIndex(itemIndexData.mGroupIndex).OnItemSizeChanged(itemIndexData.mIndexInGroup);
		}
	}

	public void RefreshItemByItemIndex(int itemIndex)
	{
		ItemIndexData itemIndexData = GetItemIndexData(itemIndex);
		if (itemIndexData != null)
		{
			GetItemGroupByIndex(itemIndexData.mGroupIndex).RefreshItemByIndexInGroup(itemIndexData.mIndexInGroup);
		}
	}

	public void ResetListView(bool resetPos = true)
	{
		mViewPortRectTransform.GetLocalCorners(mViewPortRectLocalCorners);
		if (resetPos)
		{
			mContainerTrans.anchoredPosition3D = Vector3.zero;
		}
	}

	public void RecycleAllItem()
	{
		int count = mItemGroupList.Count;
		for (int i = 0; i < count; i++)
		{
			mItemGroupList[i].RecycleAllItem();
		}
	}

	public void RecycleItemTmp(LoopStaggeredGridViewItem item)
	{
		if (!(item == null) && !string.IsNullOrEmpty(item.ItemPrefabName))
		{
			StaggeredGridItemPool value = null;
			if (mItemPoolDict.TryGetValue(item.ItemPrefabName, out value))
			{
				value.RecycleItem(item);
			}
		}
	}

	public void ClearAllTmpRecycledItem()
	{
		int count = mItemPoolList.Count;
		for (int i = 0; i < count; i++)
		{
			mItemPoolList[i].ClearTmpRecycledItem();
		}
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
		rtf.anchorMin = anchorMin;
		rtf.anchorMax = anchorMax;
	}

	private void InitItemPool()
	{
		foreach (StaggeredGridItemPrefabConfData mItemPrefabData in mItemPrefabDataList)
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
			if (mItemPrefabData.mItemPrefab.GetComponent<LoopStaggeredGridViewItem>() == null)
			{
				mItemPrefabData.mItemPrefab.AddComponent<LoopStaggeredGridViewItem>();
			}
			StaggeredGridItemPool staggeredGridItemPool = new StaggeredGridItemPool();
			staggeredGridItemPool.Init(mItemPrefabData.mItemPrefab, mItemPrefabData.mPadding, mItemPrefabData.mInitCreateCount, mContainerTrans);
			mItemPoolDict.Add(text, staggeredGridItemPool);
			mItemPoolList.Add(staggeredGridItemPool);
		}
	}

	public virtual void OnBeginDrag(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			mIsDraging = true;
			CacheDragPointerEventData(eventData);
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

	private void SetAnchoredPositionX(RectTransform rtf, float x)
	{
		Vector3 anchoredPosition3D = rtf.anchoredPosition3D;
		anchoredPosition3D.x = x;
		rtf.anchoredPosition3D = anchoredPosition3D;
	}

	private void SetAnchoredPositionY(RectTransform rtf, float y)
	{
		Vector3 anchoredPosition3D = rtf.anchoredPosition3D;
		anchoredPosition3D.y = y;
		rtf.anchoredPosition3D = anchoredPosition3D;
	}

	public ItemIndexData GetItemIndexData(int itemIndex)
	{
		int count = mItemIndexDataList.Count;
		if (itemIndex < 0 || itemIndex >= count)
		{
			return null;
		}
		return mItemIndexDataList[itemIndex];
	}

	public void UpdateAllGroupShownItemsPos()
	{
		int count = mItemGroupList.Count;
		for (int i = 0; i < count; i++)
		{
			mItemGroupList[i].UpdateAllShownItemsPos();
		}
	}

	private void CheckAllGroupIfNeedUpdateItemPos()
	{
		int count = mItemGroupList.Count;
		for (int i = 0; i < count; i++)
		{
			mItemGroupList[i].CheckIfNeedUpdateItemPos();
		}
	}

	public float GetItemAbsPosByItemIndex(int itemIndex)
	{
		if (itemIndex < 0 || itemIndex >= mItemIndexDataList.Count)
		{
			return -1f;
		}
		ItemIndexData itemIndexData = mItemIndexDataList[itemIndex];
		return mItemGroupList[itemIndexData.mGroupIndex].GetItemPos(itemIndexData.mIndexInGroup);
	}

	public LoopStaggeredGridViewItem GetNewItemByGroupAndIndex(int groupIndex, int indexInGroup)
	{
		if (indexInGroup < 0)
		{
			return null;
		}
		if (mItemTotalCount == 0)
		{
			return null;
		}
		LoopStaggeredGridViewItem loopStaggeredGridViewItem = null;
		int num = 0;
		List<int> itemIndexMap = mItemGroupList[groupIndex].ItemIndexMap;
		int count = itemIndexMap.Count;
		if (count > indexInGroup)
		{
			num = itemIndexMap[indexInGroup];
			loopStaggeredGridViewItem = mOnGetItemByItemIndex(this, num);
			if (loopStaggeredGridViewItem == null)
			{
				return null;
			}
			loopStaggeredGridViewItem.StartPosOffset = mLayoutParam.mCustomColumnOrRowOffsetArray[groupIndex];
			loopStaggeredGridViewItem.ItemIndexInGroup = indexInGroup;
			loopStaggeredGridViewItem.ItemIndex = num;
			loopStaggeredGridViewItem.ItemCreatedCheckFrameCount = mListUpdateCheckFrameCount;
			return loopStaggeredGridViewItem;
		}
		if (count != indexInGroup)
		{
			return null;
		}
		int count2 = mItemIndexDataList.Count;
		if (count2 >= mItemTotalCount)
		{
			return null;
		}
		num = count2;
		loopStaggeredGridViewItem = mOnGetItemByItemIndex(this, num);
		if (loopStaggeredGridViewItem == null)
		{
			return null;
		}
		itemIndexMap.Add(num);
		ItemIndexData itemIndexData = new ItemIndexData();
		itemIndexData.mGroupIndex = groupIndex;
		itemIndexData.mIndexInGroup = indexInGroup;
		mItemIndexDataList.Add(itemIndexData);
		loopStaggeredGridViewItem.StartPosOffset = mLayoutParam.mCustomColumnOrRowOffsetArray[groupIndex];
		loopStaggeredGridViewItem.ItemIndexInGroup = indexInGroup;
		loopStaggeredGridViewItem.ItemIndex = num;
		loopStaggeredGridViewItem.ItemCreatedCheckFrameCount = mListUpdateCheckFrameCount;
		return loopStaggeredGridViewItem;
	}

	private int GetCurShouldAddNewItemGroupIndex()
	{
		float num = float.MaxValue;
		int count = mItemGroupList.Count;
		int result = 0;
		for (int i = 0; i < count; i++)
		{
			float shownItemPosMaxValue = mItemGroupList[i].GetShownItemPosMaxValue();
			if (shownItemPosMaxValue < num)
			{
				num = shownItemPosMaxValue;
				result = i;
			}
		}
		return result;
	}

	public void UpdateListViewWithDefault()
	{
		UpdateListView(mDistanceForRecycle0, mDistanceForRecycle1, mDistanceForNew0, mDistanceForNew1);
		UpdateContentSize();
	}

	private void Update()
	{
		if (mListViewInited)
		{
			UpdateListViewWithDefault();
			ClearAllTmpRecycledItem();
			mLastFrameContainerPos = mContainerTrans.anchoredPosition3D;
		}
	}

	public void UpdateListView(float distanceForRecycle0, float distanceForRecycle1, float distanceForNew0, float distanceForNew1)
	{
		mListUpdateCheckFrameCount++;
		bool flag = true;
		int num = 0;
		int num2 = 9999;
		int count = mItemGroupList.Count;
		for (int i = 0; i < count; i++)
		{
			mItemGroupList[i].UpdateListViewPart1(distanceForRecycle0, distanceForRecycle1, distanceForNew0, distanceForNew1);
		}
		while (flag)
		{
			num++;
			if (num >= num2)
			{
				Log.Error("UpdateListView while loop " + num + " times! something is wrong!");
				break;
			}
			int curShouldAddNewItemGroupIndex = GetCurShouldAddNewItemGroupIndex();
			flag = mItemGroupList[curShouldAddNewItemGroupIndex].UpdateListViewPart2(distanceForRecycle0, distanceForRecycle1, distanceForNew0, distanceForNew1);
		}
	}

	public float GetContentSize()
	{
		if (mIsVertList)
		{
			return mContainerTrans.rect.height;
		}
		return mContainerTrans.rect.width;
	}

	public void UpdateContentSize()
	{
		int count = mItemGroupList.Count;
		float num = 0f;
		for (int i = 0; i < count; i++)
		{
			float contentPanelSize = mItemGroupList[i].GetContentPanelSize();
			if (contentPanelSize > num)
			{
				num = contentPanelSize;
			}
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
	}
}
