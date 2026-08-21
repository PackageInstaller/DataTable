using UnityEngine;

namespace SuperScrollView;

public class LoopListViewItem2 : MonoBehaviour
{
	private int mItemIndex = -1;

	private int mItemId = -1;

	private LoopListView2 mParentListView;

	private bool mIsInitHandlerCalled;

	private string mItemPrefabName;

	private RectTransform mCachedRectTransform;

	private float mPadding;

	private float mDistanceWithViewPortSnapCenter;

	private int mItemCreatedCheckFrameCount;

	private float mStartPosOffset;

	private object mUserObjectData;

	private int mUserIntData1;

	private int mUserIntData2;

	private string mUserStringData1;

	private string mUserStringData2;

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

	public float DistanceWithViewPortSnapCenter
	{
		get
		{
			return mDistanceWithViewPortSnapCenter;
		}
		set
		{
			mDistanceWithViewPortSnapCenter = value;
		}
	}

	public float StartPosOffset
	{
		get
		{
			return mStartPosOffset;
		}
		set
		{
			mStartPosOffset = value;
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

	public float Padding
	{
		get
		{
			return mPadding;
		}
		set
		{
			mPadding = value;
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

	public LoopListView2 ParentListView
	{
		get
		{
			return mParentListView;
		}
		set
		{
			mParentListView = value;
		}
	}

	public float TopY => ParentListView.ArrangeType switch
	{
		ListItemArrangeType.TopToBottom => CachedRectTransform.anchoredPosition3D.y, 
		ListItemArrangeType.BottomToTop => CachedRectTransform.anchoredPosition3D.y + CachedRectTransform.rect.height, 
		_ => 0f, 
	};

	public float BottomY => ParentListView.ArrangeType switch
	{
		ListItemArrangeType.TopToBottom => CachedRectTransform.anchoredPosition3D.y - CachedRectTransform.rect.height, 
		ListItemArrangeType.BottomToTop => CachedRectTransform.anchoredPosition3D.y, 
		_ => 0f, 
	};

	public float LeftX => ParentListView.ArrangeType switch
	{
		ListItemArrangeType.LeftToRight => CachedRectTransform.anchoredPosition3D.x, 
		ListItemArrangeType.RightToLeft => CachedRectTransform.anchoredPosition3D.x - CachedRectTransform.rect.width, 
		_ => 0f, 
	};

	public float RightX => ParentListView.ArrangeType switch
	{
		ListItemArrangeType.LeftToRight => CachedRectTransform.anchoredPosition3D.x + CachedRectTransform.rect.width, 
		ListItemArrangeType.RightToLeft => CachedRectTransform.anchoredPosition3D.x, 
		_ => 0f, 
	};

	public float ItemSize
	{
		get
		{
			if (ParentListView.IsVertList)
			{
				return CachedRectTransform.rect.height;
			}
			return CachedRectTransform.rect.width;
		}
	}

	public float ItemSizeWithPadding => ItemSize + mPadding;
}
