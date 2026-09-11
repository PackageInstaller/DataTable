public class EntityHitRecoverStatusEvent : NEventBase, IPostToPresentation, IPostToSimulation
{
	public int mEntityID;

	public int mAbilityID;

	public int mCasterID;

	public int mActionID;

	public int mHitIndex;

	public E_HitRecover mHitRecover;

	public E_HitRecoverStatus mHitRecoverStatus;

	public EntityHitRecoverStatusEvent()
	{
	}

	protected EntityHitRecoverStatusEvent(int newEntity, E_HitRecoverStatus hitRecoverStatus)
	{
		mEntityID = newEntity;
		mHitRecoverStatus = hitRecoverStatus;
	}

	public static EntityHitRecoverStatusEvent Claim(int newEntity, int abilityID, E_HitRecoverStatus hitRecoverStatus, int actionID, E_HitRecover hitRecover, int casterID, int hitIndex)
	{
		EntityHitRecoverStatusEvent entityHitRecoverStatusEvent = FrameObjectPool<EntityHitRecoverStatusEvent>.Claim();
		entityHitRecoverStatusEvent.mEntityID = newEntity;
		entityHitRecoverStatusEvent.mAbilityID = abilityID;
		entityHitRecoverStatusEvent.mActionID = actionID;
		entityHitRecoverStatusEvent.mCasterID = casterID;
		entityHitRecoverStatusEvent.mHitRecover = hitRecover;
		entityHitRecoverStatusEvent.mHitIndex = hitIndex;
		entityHitRecoverStatusEvent.mHitRecoverStatus = hitRecoverStatus;
		return entityHitRecoverStatusEvent;
	}

	public override void OnEnterPool()
	{
		mEntityID = 0;
		mHitRecoverStatus = E_HitRecoverStatus.None;
		mActionID = 0;
		mHitRecover = E_HitRecover.None;
	}

	public override void Release()
	{
		FrameObjectPool<EntityHitRecoverStatusEvent>.Release(this);
	}
}
