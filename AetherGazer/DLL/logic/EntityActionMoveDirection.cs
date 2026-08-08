using Entitas;

[Sim]
public class EntityActionMoveDirection : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public Int3 mDirection;

	public Int3 mLastDirection;

	public bool mIsTurn;

	public int mLogicTime;

	public Int3 mSpeedDirection;

	public int mMoveID;

	public int mTimeStep;

	public Int3 mMovementDirection;

	public EMoveDirectionMode mMoveMode;

	public void Reset(Entity entity)
	{
		mDirection = Int3.zero;
		mLogicTime = 0;
		mMoveID = 0;
		mTimeStep = 0;
		mLastDirection = Int3.zero;
		mIsTurn = false;
		mStatus = EntityActionStatus.None;
		mMovementDirection = Int3.zero;
		mMoveMode = EMoveDirectionMode.Lookat;
	}
}
