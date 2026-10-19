namespace ACT.Battle;

internal sealed class SkipDamagePipelineHitResolveRule : IHitResolveRule
{
	public bool TryResolve(HitResolveContext context, out HitResolveDecision decision)
	{
		if (context.defenseState.HasDynamicTagId(DefenseStateDynamicTags.NoDamageOnHitId))
		{
			decision = HitResolveDecision.NullifyDamage;
			return true;
		}
		decision = HitResolveDecision.Reject;
		return false;
	}
}
