#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;

namespace SuperScrollView;

public class GridViewLayoutParam
{
	public int mColumnOrRowCount;

	public float mItemWidthOrHeight;

	public float mPadding1;

	public float mPadding2;

	public float[] mCustomColumnOrRowOffsetArray;

	public bool CheckParam()
	{
		if (mColumnOrRowCount <= 0)
		{
			Log.Error("mColumnOrRowCount shoud be > 0");
			return false;
		}
		if (mItemWidthOrHeight <= 0f)
		{
			Log.Error("mItemWidthOrHeight shoud be > 0");
			return false;
		}
		if (mCustomColumnOrRowOffsetArray != null && mCustomColumnOrRowOffsetArray.Length != mColumnOrRowCount)
		{
			Log.Error("mGroupOffsetArray.Length != mColumnOrRowCount");
			return false;
		}
		return true;
	}
}
