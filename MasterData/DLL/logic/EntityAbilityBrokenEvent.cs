public sealed class EntityAbilityBrokenEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int mCaster;

	public int mAbilityID;

	public int mLogicTime;

	public EntityAbilityBrokenEvent()
	{
	}

	public EntityAbilityBrokenEvent(int caster, int abilityID, int logicTime)
	{
		mCaster = caster;
		mAbilityID = abilityID;
		mLogicTime = logicTime;
	}

	public static EntityAbilityBrokenEvent Claim()
	{
		return FrameObjectPool<EntityAbilityBrokenEvent>.Claim();
	}

	public override void OnEnterPool()
	{
		mCaster = 0;
		mAbilityID = 0;
		mLogicTime = 0;
	}

	public override void Release()
	{
		FrameObjectPool<EntityAbilityBrokenEvent>.Release(this);
	}
}
