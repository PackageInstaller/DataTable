using ACT.Battle.Configs;

namespace ACT.Battle;

internal sealed class DoDamageResolveRule : IHitResolveRule
{
	public bool TryResolve(HitResolveContext context, out HitResolveDecision decision)
	{
		if ((context.defenseState.Invincible || context.defenseState.HasDynamicTagId(DefenseStateDynamicTags.InvincibleId)) && !HitResolveTagUtility.HasResolveTag(context, HitResolveTag.IgnoreInvincibility))
		{
			decision = HitResolveDecision.Reject;
			return true;
		}
		if (context.defenseState.TrueInvincible || context.defenseState.HasDynamicTagId(DefenseStateDynamicTags.TrueInvincibleId))
		{
			decision = HitResolveDecision.Reject;
			return true;
		}
		decision = HitResolveDecision.Reject;
		return false;
	}
}
