using UnityEngine;

namespace SuperScrollView;

public class LoopGridViewItem : MonoBehaviour
{
	private int mItemIndex = -1;

	private int mRow = -1;

	private int mColumn = -1;

	private int mItemId = -1;

	private LoopGridView mParentGridView;

	private bool mIsInitHandlerCalled;

	private string mItemPrefabName;

	private RectTransform mCachedRectTransform;

	private int mItemCreatedCheckFrameCount;

	private object mUserObjectData;

	private int mUserIntData1;

	private int mUserIntData2;

	private string mUserStringData1;

	private string mUserStringData2;

	private LoopGridViewItem mPrevItem;

	private LoopGridViewItem mNextItem;

	public object UserObjectData
	{
		get
		{
			return mUserObjectData;
		}
		set
		{
			mUserObjectData = value;
		}
	}

	public int UserIntData1
	{
		get
		{
			return mUserIntData1;
		}
		set
		{
			mUserIntData1 = value;
		}
	}

	public int UserIntData2
	{
		get
		{
			return mUserIntData2;
		}
		set
		{
			mUserIntData2 = value;
		}
	}

	public string UserStringData1
	{
		get
		{
			return mUserStringData1;
		}
		set
		{
			mUserStringData1 = value;
		}
	}

	public string UserStringData2
	{
		get
		{
			return mUserStringData2;
		}
		set
		{
			mUserStringData2 = value;
		}
	}

	public int ItemCreatedCheckFrameCount
	{
		get
		{
			return mItemCreatedCheckFrameCount;
		}
		set
		{
			mItemCreatedCheckFrameCount = value;
		}
	}

	public RectTransform CachedRectTransform
	{
		get
		{
			if (mCachedRectTransform == null)
			{
				mCachedRectTransform = base.gameObject.GetComponent<RectTransform>();
			}
			return mCachedRectTransform;
		}
	}

	public string ItemPrefabName
	{
		get
		{
			return mItemPrefabName;
		}
		set
		{
			mItemPrefabName = value;
		}
	}

	public int Row
	{
		get
		{
			return mRow;
		}
		set
		{
			mRow = value;
		}
	}

	public int Column
	{
		get
		{
			return mColumn;
		}
		set
		{
			mColumn = value;
		}
	}

	public int ItemIndex
	{
		get
		{
			return mItemIndex;
		}
		set
		{
			mItemIndex = value;
		}
	}

	public int ItemId
	{
		get
		{
			return mItemId;
		}
		set
		{
			mItemId = value;
		}
	}

	public bool IsInitHandlerCalled
	{
		get
		{
			return mIsInitHandlerCalled;
		}
		set
		{
			mIsInitHandlerCalled = value;
		}
	}

	public LoopGridView ParentGridView
	{
		get
		{
			return mParentGridView;
		}
		set
		{
			mParentGridView = value;
		}
	}

	public LoopGridViewItem PrevItem
	{
		get
		{
			return mPrevItem;
		}
		set
		{
			mPrevItem = value;
		}
	}

	public LoopGridViewItem NextItem
	{
		get
		{
			return mNextItem;
		}
		set
		{
			mNextItem = value;
		}
	}
}
