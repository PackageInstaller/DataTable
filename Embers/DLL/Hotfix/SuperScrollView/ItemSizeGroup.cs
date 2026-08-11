namespace SuperScrollView;

public class ItemSizeGroup
{
	public float[] mItemSizeArray;

	public float[] mItemStartPosArray;

	public int mItemCount;

	private int mDirtyBeginIndex = 100;

	public float mGroupSize;

	public float mGroupStartPos;

	public float mGroupEndPos;

	public int mGroupIndex;

	private float mItemDefaultSize;

	private int mMaxNoZeroIndex;

	public bool IsDirty => mDirtyBeginIndex < mItemCount;

	public ItemSizeGroup(int index, float itemDefaultSize)
	{
		mGroupIndex = index;
		mItemDefaultSize = itemDefaultSize;
		Init();
	}

	public void Init()
	{
		mItemSizeArray = new float[100];
		if (mItemDefaultSize != 0f)
		{
			for (int i = 0; i < mItemSizeArray.Length; i++)
			{
				mItemSizeArray[i] = mItemDefaultSize;
			}
		}
		mItemStartPosArray = new float[100];
		mItemStartPosArray[0] = 0f;
		mItemCount = 100;
		mGroupSize = mItemDefaultSize * (float)mItemSizeArray.Length;
		if (mItemDefaultSize != 0f)
		{
			mDirtyBeginIndex = 0;
		}
		else
		{
			mDirtyBeginIndex = 100;
		}
	}

	public float GetItemStartPos(int index)
	{
		return mGroupStartPos + mItemStartPosArray[index];
	}

	public float SetItemSize(int index, float size)
	{
		if (index > mMaxNoZeroIndex && size > 0f)
		{
			mMaxNoZeroIndex = index;
		}
		float num = mItemSizeArray[index];
		if (num == size)
		{
			return 0f;
		}
		mItemSizeArray[index] = size;
		if (index < mDirtyBeginIndex)
		{
			mDirtyBeginIndex = index;
		}
		float num2 = size - num;
		mGroupSize += num2;
		return num2;
	}

	public void SetItemCount(int count)
	{
		if (count < mMaxNoZeroIndex)
		{
			mMaxNoZeroIndex = count;
		}
		if (mItemCount != count)
		{
			mItemCount = count;
			RecalcGroupSize();
		}
	}

	public void RecalcGroupSize()
	{
		mGroupSize = 0f;
		for (int i = 0; i < mItemCount; i++)
		{
			mGroupSize += mItemSizeArray[i];
		}
	}

	public int GetItemIndexByPos(float pos)
	{
		if (mItemCount == 0)
		{
			return -1;
		}
		int num = 0;
		int num2 = mItemCount - 1;
		if (mItemDefaultSize == 0f)
		{
			if (mMaxNoZeroIndex < 0)
			{
				mMaxNoZeroIndex = 0;
			}
			num2 = mMaxNoZeroIndex;
		}
		while (num <= num2)
		{
			int num3 = (num + num2) / 2;
			float num4 = mItemStartPosArray[num3];
			float num5 = num4 + mItemSizeArray[num3];
			if (num4 <= pos && num5 >= pos)
			{
				return num3;
			}
			if (pos > num5)
			{
				num = num3 + 1;
			}
			else
			{
				num2 = num3 - 1;
			}
		}
		return -1;
	}

	public void UpdateAllItemStartPos()
	{
		if (mDirtyBeginIndex < mItemCount)
		{
			for (int i = ((mDirtyBeginIndex < 1) ? 1 : mDirtyBeginIndex); i < mItemCount; i++)
			{
				mItemStartPosArray[i] = mItemStartPosArray[i - 1] + mItemSizeArray[i - 1];
			}
			mDirtyBeginIndex = mItemCount;
		}
	}

	public void ClearOldData()
	{
		for (int i = mItemCount; i < 100; i++)
		{
			mItemSizeArray[i] = 0f;
		}
	}
}
