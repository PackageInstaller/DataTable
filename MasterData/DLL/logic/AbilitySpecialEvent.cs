public sealed class AbilitySpecialEvent : NEventBase, IPostToSimulation, IPostToPresentation
{
	public int Caster;

	public int AbilityID;

	public override void OnEnterPool()
	{
		Caster = 0;
		AbilityID = 0;
	}

	public override void Release()
	{
		FrameObjectPool<AbilitySpecialEvent>.Release(this);
	}

	public static AbilitySpecialEvent Claim(int caster, int abilityID)
	{
		AbilitySpecialEvent abilitySpecialEvent = FrameObjectPool<AbilitySpecialEvent>.Claim();
		abilitySpecialEvent.Caster = caster;
		abilitySpecialEvent.AbilityID = abilityID;
		return abilitySpecialEvent;
	}
}
