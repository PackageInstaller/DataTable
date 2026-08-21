namespace SuperScrollView;

public class LoopGridViewInitParam
{
	public float mSmoothDumpRate = 0.3f;

	public float mSnapFinishThreshold = 0.01f;

	public float mSnapVecThreshold = 145f;

	public static LoopGridViewInitParam CopyDefaultInitParam()
	{
		return new LoopGridViewInitParam();
	}
}
