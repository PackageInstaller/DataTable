namespace SuperScrollView;

public class LoopListViewInitParam
{
	public float mDistanceForRecycle0 = 300f;

	public float mDistanceForNew0 = 200f;

	public float mDistanceForRecycle1 = 300f;

	public float mDistanceForNew1 = 200f;

	public float mSmoothDumpRate = 0.3f;

	public float mSnapFinishThreshold = 0.01f;

	public float mSnapVecThreshold = 145f;

	public float mItemDefaultWithPaddingSize = 20f;

	public static LoopListViewInitParam CopyDefaultInitParam()
	{
		return new LoopListViewInitParam();
	}
}
