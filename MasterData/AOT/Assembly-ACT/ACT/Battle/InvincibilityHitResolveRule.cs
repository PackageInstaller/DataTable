using ACT.Battle.Configs;

namespace ACT.Battle;

internal sealed class InvincibilityHitResolveRule : IHitResolveRule
{
	public bool TryResolve(HitResolveContext context, out HitResolveDecision decision)
	{
		if ((context.defenseState.Invincible || context.defenseState.HasDynamicTagId(DefenseStateDynamicTags.InvincibleId)) && !HitResolveTagUtility.HasResolveTag(context, HitResolveTag.IgnoreInvincibility) && !context.forceHit)
		{
			decision = HitResolveDecision.Reject;
			return true;
		}
		decision = HitResolveDecision.Reject;
		return false;
	}
}
