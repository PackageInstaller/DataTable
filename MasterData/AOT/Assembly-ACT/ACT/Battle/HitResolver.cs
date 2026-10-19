namespace ACT.Battle;

public static class HitResolver
{
	private static readonly IHitResolveRule[] s_PreAttackRules = new IHitResolveRule[1]
	{
		new TrueInvincibilityHitResolveRule()
	};

	private static readonly IHitResolveRule[] s_PostAttackRules = new IHitResolveRule[2]
	{
		new SkipDamagePipelineHitResolveRule(),
		new InvincibilityHitResolveRule()
	};

	private static readonly IHitResolveRule[] s_DamageRules = new IHitResolveRule[1]
	{
		new DoDamageResolveRule()
	};

	public static bool ResolvePreAttackEvent(HitResolveContext context)
	{
		return Resolve(context, s_PreAttackRules);
	}

	public static bool ResolvePostAttackEvent(HitResolveContext context)
	{
		return Resolve(context, s_PostAttackRules);
	}

	public static bool ResolveDamageEvent(HitResolveContext context)
	{
		return Resolve(context, s_DamageRules);
	}

	private static bool Resolve(HitResolveContext context, IHitResolveRule[] rules)
	{
		context.defenseState = DefenseStateSnapshotBuilder.Build(context.memory.target.entity);
		for (int i = 0; i < rules.Length; i++)
		{
			if (rules[i].TryResolve(context, out var decision))
			{
				context.decision = decision;
				return false;
			}
		}
		return true;
	}
}
