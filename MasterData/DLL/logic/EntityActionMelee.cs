using Entitas;

[Sim]
public class EntityActionMelee : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public int mAttackID;

	public bool mIsReady;

	public int mAttackTime;

	public Int3 mAttackDirection;

	public int mAttackStatus;

	public int mCurOffsetCount;

	public int mCurHitCount;

	public int mNextAttackTime;

	public int mAttackOnceDuring;

	public int mHitDuring;

	public int mHitCheckCount;

	public void Reset(Entity entity)
	{
		mStatus = EntityActionStatus.E_ACTIVE;
		mIsReady = false;
		mAttackTime = 0;
		mAttackStatus = 0;
		mCurOffsetCount = 0;
		mCurHitCount = 0;
	}

	public void AddActionStatus(MeleeAttackStatus status, MeleeStatusMask mask)
	{
		mAttackStatus = (int)((uint)mAttackStatus & (uint)mask) | (int)status;
	}

	public void RemoveActionStatus(MeleeStatusMask mask)
	{
		mAttackStatus &= (int)mask;
	}

	public bool HasActionStatus(MeleeAttackStatus status, MeleeStatusMask mask)
	{
		return ((uint)mAttackStatus & (uint)(~mask)) == (uint)status;
	}

	public void ResetActionStatus()
	{
		mAttackStatus = 0;
	}
}
