namespace ACT.Battle;

internal sealed class TrueInvincibilityHitResolveRule : IHitResolveRule
{
	public bool TryResolve(HitResolveContext context, out HitResolveDecision decision)
	{
		if ((context.defenseState.TrueInvincible || context.defenseState.HasDynamicTagId(DefenseStateDynamicTags.TrueInvincibleId) || context.defenseState.BlockThrow || context.defenseState.HasDynamicTagId(DefenseStateDynamicTags.BlockThrowId)) && !context.forceHit)
		{
			decision = HitResolveDecision.Reject;
			return true;
		}
		decision = HitResolveDecision.Reject;
		return false;
	}
}
