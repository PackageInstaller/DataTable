using System.Collections.Generic;
using UnityEngine;

namespace SuperScrollView;

public class ItemPool
{
	private GameObject mPrefabObj;

	private string mPrefabName;

	private int mInitCreateCount = 1;

	private float mPadding;

	private float mStartPosOffset;

	private List<LoopListViewItem2> mTmpPooledItemList = new List<LoopListViewItem2>();

	private List<LoopListViewItem2> mPooledItemList = new List<LoopListViewItem2>();

	private static int mCurItemIdCount;

	private RectTransform mItemParent;

	public void Init(GameObject prefabObj, float padding, float startPosOffset, int createCount, RectTransform parent)
	{
		mPrefabObj = prefabObj;
		mPrefabName = mPrefabObj.name;
		mInitCreateCount = createCount;
		mPadding = padding;
		mStartPosOffset = startPosOffset;
		mItemParent = parent;
		mPrefabObj.SetActive(value: false);
		for (int i = 0; i < mInitCreateCount; i++)
		{
			LoopListViewItem2 item = CreateItem();
			RecycleItemReal(item);
		}
	}

	public LoopListViewItem2 GetItem()
	{
		mCurItemIdCount++;
		LoopListViewItem2 loopListViewItem = null;
		if (mTmpPooledItemList.Count > 0)
		{
			int count = mTmpPooledItemList.Count;
			loopListViewItem = mTmpPooledItemList[count - 1];
			mTmpPooledItemList.RemoveAt(count - 1);
			loopListViewItem.gameObject.SetActive(value: true);
		}
		else
		{
			int count2 = mPooledItemList.Count;
			if (count2 == 0)
			{
				loopListViewItem = CreateItem();
			}
			else
			{
				loopListViewItem = mPooledItemList[count2 - 1];
				mPooledItemList.RemoveAt(count2 - 1);
				loopListViewItem.gameObject.SetActive(value: true);
			}
		}
		loopListViewItem.Padding = mPadding;
		loopListViewItem.ItemId = mCurItemIdCount;
		return loopListViewItem;
	}

	public void DestroyAllItem()
	{
		ClearTmpRecycledItem();
		int count = mPooledItemList.Count;
		for (int i = 0; i < count; i++)
		{
			Object.DestroyImmediate(mPooledItemList[i].gameObject);
		}
		mPooledItemList.Clear();
	}

	public LoopListViewItem2 CreateItem()
	{
		GameObject gameObject = Object.Instantiate(mPrefabObj, Vector3.zero, Quaternion.identity, mItemParent);
		gameObject.SetActive(value: true);
		RectTransform component = gameObject.GetComponent<RectTransform>();
		component.localScale = Vector3.one;
		component.anchoredPosition3D = Vector3.zero;
		component.localEulerAngles = Vector3.zero;
		LoopListViewItem2 component2 = gameObject.GetComponent<LoopListViewItem2>();
		component2.ItemPrefabName = mPrefabName;
		component2.StartPosOffset = mStartPosOffset;
		return component2;
	}

	private void RecycleItemReal(LoopListViewItem2 item)
	{
		item.gameObject.SetActive(value: false);
		mPooledItemList.Add(item);
	}

	public void RecycleItem(LoopListViewItem2 item)
	{
		mTmpPooledItemList.Add(item);
	}

	public void ClearTmpRecycledItem()
	{
		int count = mTmpPooledItemList.Count;
		if (count != 0)
		{
			for (int i = 0; i < count; i++)
			{
				RecycleItemReal(mTmpPooledItemList[i]);
			}
			mTmpPooledItemList.Clear();
		}
	}
}
