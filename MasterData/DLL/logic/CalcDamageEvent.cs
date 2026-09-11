public sealed class CalcDamageEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public SimEntity mAttacker;

	public SimEntity mTarget;

	public int mAbilityID;

	public int mHitIndex;

	public int mDamage;

	public CalcDamageEvent(SimEntity attcker, SimEntity target, int abilityID, int hitIndex, int damage)
	{
		mAttacker = attcker;
		mTarget = target;
		mAbilityID = abilityID;
		mHitIndex = hitIndex;
		mDamage = damage;
	}

	public CalcDamageEvent()
	{
	}

	public static CalcDamageEvent Claim(SimEntity attcker, SimEntity target, int abilityID, int hitIndex, int damage)
	{
		CalcDamageEvent calcDamageEvent = FrameObjectPool<CalcDamageEvent>.Claim();
		calcDamageEvent.mAttacker = attcker;
		calcDamageEvent.mTarget = target;
		calcDamageEvent.mAbilityID = abilityID;
		calcDamageEvent.mHitIndex = hitIndex;
		calcDamageEvent.mDamage = damage;
		return calcDamageEvent;
	}

	public override void OnEnterPool()
	{
		mAttacker = null;
		mTarget = null;
		mAbilityID = 0;
		mHitIndex = 0;
		mDamage = 0;
	}

	public override void Release()
	{
		FrameObjectPool<CalcDamageEvent>.Release(this);
	}
}
