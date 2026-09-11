using Entitas;
using Pathfinding;

[Sim]
public class EntityActionMove : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public Int3 mTargetPos;

	public int mCurrentWaypointIndex;

	[VarBinding(EntityVarName.NONE, false, false, true, "")]
	public Path mPath;

	public bool mHasCaculated;

	public bool mNeedAutoPath;

	public void Reset(Entity entity)
	{
		mTargetPos = Int3.zero;
		mCurrentWaypointIndex = 0;
		if (mPath != null)
		{
			mPath.Release(entity);
			mPath = null;
		}
		mHasCaculated = false;
		mNeedAutoPath = false;
	}
}
