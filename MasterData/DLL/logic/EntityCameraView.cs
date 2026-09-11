using Entitas;

[Sim]
public class EntityCameraView : IComponent
{
	public Int3 mViewPosition;

	public Int3 mViewDirection;

	public int mFOV = 60;

	public int mLimitDegree = 15;

	public int mViewDistance = 7000;

	public int mIsColinear;

	public int mViewLerpTime;
}
