namespace SuperScrollView;

public class StaggeredGridViewInitParam
{
	public float mDistanceForRecycle0 = 300f;

	public float mDistanceForNew0 = 200f;

	public float mDistanceForRecycle1 = 300f;

	public float mDistanceForNew1 = 200f;

	public float mItemDefaultWithPaddingSize = 20f;

	public static StaggeredGridViewInitParam CopyDefaultInitParam()
	{
		return new StaggeredGridViewInitParam();
	}
}
