using Entitas;

[Sim]
public class EntityActionAttack : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public bool mIsReady;

	public int mAimDuring = 200;

	public int mHitDuring;

	public int mHitCheckCount;

	public int mAttackTime;

	public int mAttackOnceDuring = 300;

	public int mNextAttackTime = 2000;

	public bool mIsCD;

	public Int3 mAttackDirection;

	public void Reset(Entity entity)
	{
		mStatus = EntityActionStatus.E_ACTIVE;
		mIsReady = false;
		mAimDuring = 200;
		mAttackTime = 0;
		mIsCD = false;
		mAttackDirection = Int3.zero;
	}
}
