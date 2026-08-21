namespace SuperScrollView;

public class GridItemGroup
{
	private int mCount;

	private int mGroupIndex = -1;

	private LoopGridViewItem mFirst;

	private LoopGridViewItem mLast;

	public int Count => mCount;

	public LoopGridViewItem First => mFirst;

	public LoopGridViewItem Last => mLast;

	public int GroupIndex
	{
		get
		{
			return mGroupIndex;
		}
		set
		{
			mGroupIndex = value;
		}
	}

	public LoopGridViewItem GetItemByColumn(int column)
	{
		LoopGridViewItem nextItem = mFirst;
		while (nextItem != null)
		{
			if (nextItem.Column == column)
			{
				return nextItem;
			}
			nextItem = nextItem.NextItem;
		}
		return null;
	}

	public LoopGridViewItem GetItemByRow(int row)
	{
		LoopGridViewItem nextItem = mFirst;
		while (nextItem != null)
		{
			if (nextItem.Row == row)
			{
				return nextItem;
			}
			nextItem = nextItem.NextItem;
		}
		return null;
	}

	public void ReplaceItem(LoopGridViewItem curItem, LoopGridViewItem newItem)
	{
		newItem.PrevItem = curItem.PrevItem;
		newItem.NextItem = curItem.NextItem;
		if (newItem.PrevItem != null)
		{
			newItem.PrevItem.NextItem = newItem;
		}
		if (newItem.NextItem != null)
		{
			newItem.NextItem.PrevItem = newItem;
		}
		if (mFirst == curItem)
		{
			mFirst = newItem;
		}
		if (mLast == curItem)
		{
			mLast = newItem;
		}
	}

	public void AddFirst(LoopGridViewItem newItem)
	{
		newItem.PrevItem = null;
		newItem.NextItem = null;
		if (mFirst == null)
		{
			mFirst = newItem;
			mLast = newItem;
			mFirst.PrevItem = null;
			mFirst.NextItem = null;
			mCount++;
		}
		else
		{
			mFirst.PrevItem = newItem;
			newItem.PrevItem = null;
			newItem.NextItem = mFirst;
			mFirst = newItem;
			mCount++;
		}
	}

	public void AddLast(LoopGridViewItem newItem)
	{
		newItem.PrevItem = null;
		newItem.NextItem = null;
		if (mFirst == null)
		{
			mFirst = newItem;
			mLast = newItem;
			mFirst.PrevItem = null;
			mFirst.NextItem = null;
			mCount++;
		}
		else
		{
			mLast.NextItem = newItem;
			newItem.PrevItem = mLast;
			newItem.NextItem = null;
			mLast = newItem;
			mCount++;
		}
	}

	public LoopGridViewItem RemoveFirst()
	{
		LoopGridViewItem result = mFirst;
		if (mFirst == null)
		{
			return result;
		}
		if (mFirst == mLast)
		{
			mFirst = null;
			mLast = null;
			mCount--;
			return result;
		}
		mFirst = mFirst.NextItem;
		mFirst.PrevItem = null;
		mCount--;
		return result;
	}

	public LoopGridViewItem RemoveLast()
	{
		LoopGridViewItem result = mLast;
		if (mFirst == null)
		{
			return result;
		}
		if (mFirst == mLast)
		{
			mFirst = null;
			mLast = null;
			mCount--;
			return result;
		}
		mLast = mLast.PrevItem;
		mLast.NextItem = null;
		mCount--;
		return result;
	}

	public void Clear()
	{
		LoopGridViewItem nextItem = mFirst;
		while (nextItem != null)
		{
			nextItem.PrevItem = null;
			nextItem.NextItem = null;
			nextItem = nextItem.NextItem;
		}
		mFirst = null;
		mLast = null;
		mCount = 0;
	}
}
