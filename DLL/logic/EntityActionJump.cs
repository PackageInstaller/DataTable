using Entitas;

[Sim]
public class EntityActionJump : IComponent, IComponentReset
{
	public Int3 mTargetPos;

	public int mMaxHeight;

	public int mStartActionReadyTime;

	public int mG = 10;

	public E_JumpActionStatus mStatus;

	public Int3 mHSpeed;

	public int mVSpeed;

	public bool mUseTartgetPos;

	public void Reset(Entity entity)
	{
		mTargetPos = Int3.zero;
		mMaxHeight = 0;
		mStartActionReadyTime = 0;
		mG = 10;
		mStatus = E_JumpActionStatus.None;
		mHSpeed = Int3.zero;
		mVSpeed = 0;
		mUseTartgetPos = true;
	}
}
