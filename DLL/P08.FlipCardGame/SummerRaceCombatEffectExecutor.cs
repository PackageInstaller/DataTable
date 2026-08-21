using System;
using System.Collections.Generic;
using UnityEngine;

public sealed class SummerRaceCombatEffectExecutor : ICombatEffectExecutor
{
	public static readonly SummerRaceCombatEffectExecutor Shared = new SummerRaceCombatEffectExecutor();

	private readonly List<ICombatStatusHost> resolvedTargets = new List<ICombatStatusHost>(8);

	private SummerRaceCombatEffectExecutor()
	{
	}

	public CombatExecutionResult ExecuteImpact(ICombatStatusHost target, CombatImpactPayload payload, Vector2 hitDirection, ICombatSourceContext sourceContext)
	{
		if (target == null || payload == null)
		{
			return CombatExecutionResult.Failed("Combat payload target is missing.");
		}
		if (!SummerRaceCombatResolver.IsHostile(sourceContext, target))
		{
			return CombatExecutionResult.Failed("Combat payload target is not hostile.");
		}
		int appliedEffects = 0;
		int damageDealt = 0;
		CombatEffectSpec[] array = payload.effects ?? Array.Empty<CombatEffectSpec>();
		foreach (CombatEffectSpec combatEffectSpec in array)
		{
			if (combatEffectSpec == null || !combatEffectSpec.enabled)
			{
				continue;
			}
			switch (combatEffectSpec.targetSelector)
			{
			case CombatTargetSelector.HitTarget:
			{
				if (target.TryApplyCombatEffect(combatEffectSpec, hitDirection, sourceContext, out var damageDealt2))
				{
					appliedEffects++;
					damageDealt += Mathf.Max(0, damageDealt2);
				}
				break;
			}
			case CombatTargetSelector.FrontRadius:
				ApplyImpactRadiusEffect(target, combatEffectSpec, hitDirection, sourceContext, ref appliedEffects, ref damageDealt);
				break;
			default:
				throw new InvalidOperationException("[SummerRaceCombatEffectExecutor] ExecuteImpact does not support selector=" + combatEffectSpec.targetSelector.ToString() + ".");
			}
		}
		if (appliedEffects <= 0)
		{
			return CombatExecutionResult.Failed("Combat impact had no applicable effects.");
		}
		return CombatExecutionResult.Succeeded(appliedEffects, damageDealt);
	}

	private void ApplyImpactRadiusEffect(ICombatStatusHost primaryTarget, CombatEffectSpec effect, Vector2 hitDirection, ICombatSourceContext sourceContext, ref int appliedEffects, ref int damageDealt)
	{
		if (primaryTarget == null || primaryTarget.CombatTransform == null)
		{
			throw new InvalidOperationException("[SummerRaceCombatEffectExecutor] Impact radius execution requires a primary target transform.");
		}
		float num = Mathf.Max(0f, effect.radius);
		if (num <= 0f)
		{
			throw new InvalidOperationException("[SummerRaceCombatEffectExecutor] Impact radius selector requires radius > 0.");
		}
		Vector2 vector = primaryTarget.CombatTransform.position;
		SummerRaceCombatResolver.CollectTargetsNearPoint(sourceContext, vector, num, resolvedTargets);
		if (resolvedTargets.Count <= 0)
		{
			return;
		}
		int num2 = ((effect.maxTargets <= 0) ? resolvedTargets.Count : Mathf.Min(resolvedTargets.Count, effect.maxTargets));
		for (int i = 0; i < num2; i++)
		{
			ICombatStatusHost combatStatusHost = resolvedTargets[i];
			if (combatStatusHost != null)
			{
				Vector2 hitDirection2 = ResolveImpactRadiusHitDirection(vector, combatStatusHost, hitDirection);
				if (combatStatusHost.TryApplyCombatEffect(effect, hitDirection2, sourceContext, out var damageDealt2))
				{
					appliedEffects++;
					damageDealt += Mathf.Max(0, damageDealt2);
				}
			}
		}
	}

	private static Vector2 ResolveImpactRadiusHitDirection(Vector2 impactCenter, ICombatStatusHost target, Vector2 fallbackDirection)
	{
		if (target != null && target.CombatTransform != null)
		{
			Vector2 vector = (Vector2)target.CombatTransform.position - impactCenter;
			if (vector.sqrMagnitude > 0.0001f)
			{
				return vector.normalized;
			}
		}
		if (fallbackDirection.sqrMagnitude > 0.0001f)
		{
			return fallbackDirection.normalized;
		}
		return Vector2.right;
	}

	public CombatExecutionResult ExecuteEffects(ICombatSourceContext sourceContext, Vector2 aimDirection, CombatEffectSpec[] effects)
	{
		if (sourceContext == null)
		{
			return CombatExecutionResult.Failed("Combat source context is missing.");
		}
		int num = 0;
		int num2 = 0;
		CombatEffectSpec[] array = effects ?? Array.Empty<CombatEffectSpec>();
		foreach (CombatEffectSpec combatEffectSpec in array)
		{
			if (combatEffectSpec == null || !combatEffectSpec.enabled)
			{
				continue;
			}
			SummerRaceCombatResolver.ResolveTargets(sourceContext, combatEffectSpec.targetSelector, aimDirection, combatEffectSpec.radius, resolvedTargets);
			if (resolvedTargets.Count <= 0)
			{
				continue;
			}
			int num3 = ((combatEffectSpec.maxTargets <= 0) ? resolvedTargets.Count : Mathf.Min(resolvedTargets.Count, combatEffectSpec.maxTargets));
			for (int j = 0; j < num3; j++)
			{
				ICombatStatusHost combatStatusHost = resolvedTargets[j];
				if (combatStatusHost != null)
				{
					Vector2 hitDirection = ResolveHitDirection(sourceContext, combatStatusHost, aimDirection);
					if (combatStatusHost.TryApplyCombatEffect(combatEffectSpec, hitDirection, sourceContext, out var damageDealt))
					{
						num++;
						num2 += Mathf.Max(0, damageDealt);
					}
				}
			}
		}
		if (num <= 0)
		{
			return CombatExecutionResult.Failed("Combat effect execution found no valid targets.");
		}
		return CombatExecutionResult.Succeeded(num, num2);
	}

	public CombatExecutionResult ExecuteResolvedEffects(ICombatSourceContext sourceContext, Vector2 aimDirection, CombatEffectSpec[] effects, IList<ICombatStatusHost> resolvedTargets)
	{
		if (sourceContext == null)
		{
			return CombatExecutionResult.Failed("Combat source context is missing.");
		}
		int num = 0;
		int num2 = 0;
		CombatEffectSpec[] array = effects ?? Array.Empty<CombatEffectSpec>();
		ICombatStatusHost combatStatusHost = sourceContext as ICombatStatusHost;
		if ((combatStatusHost == null || !combatStatusHost.IsCombatAlive) && sourceContext.CombatSourceTransform != null)
		{
			combatStatusHost = sourceContext.CombatSourceTransform.GetComponentInParent<ICombatStatusHost>();
		}
		foreach (CombatEffectSpec combatEffectSpec in array)
		{
			if (combatEffectSpec == null || !combatEffectSpec.enabled)
			{
				continue;
			}
			if (combatEffectSpec.targetSelector == CombatTargetSelector.Self)
			{
				if (combatStatusHost != null && combatStatusHost.IsCombatAlive)
				{
					Vector2 hitDirection = ((aimDirection.sqrMagnitude > 0.0001f) ? aimDirection.normalized : ResolveHitDirection(sourceContext, combatStatusHost, aimDirection));
					if (combatStatusHost.TryApplyCombatEffect(combatEffectSpec, hitDirection, sourceContext, out var damageDealt))
					{
						num++;
						num2 += Mathf.Max(0, damageDealt);
					}
				}
			}
			else
			{
				if (resolvedTargets == null || resolvedTargets.Count <= 0)
				{
					continue;
				}
				int num3 = ((combatEffectSpec.maxTargets <= 0) ? resolvedTargets.Count : Mathf.Min(resolvedTargets.Count, combatEffectSpec.maxTargets));
				for (int j = 0; j < num3; j++)
				{
					ICombatStatusHost combatStatusHost2 = resolvedTargets[j];
					if (combatStatusHost2 != null)
					{
						Vector2 hitDirection2 = ResolveHitDirection(sourceContext, combatStatusHost2, aimDirection);
						if (combatStatusHost2.TryApplyCombatEffect(combatEffectSpec, hitDirection2, sourceContext, out var damageDealt2))
						{
							num++;
							num2 += Mathf.Max(0, damageDealt2);
						}
					}
				}
			}
		}
		if (num <= 0)
		{
			return CombatExecutionResult.Failed("Combat effect execution found no valid resolved targets.");
		}
		return CombatExecutionResult.Succeeded(num, num2);
	}

	private static Vector2 ResolveHitDirection(ICombatSourceContext sourceContext, ICombatStatusHost target, Vector2 aimDirection)
	{
		if (sourceContext != null && sourceContext.CombatSourceTransform != null && target != null && target.CombatTransform != null)
		{
			Vector2 vector = target.CombatTransform.position - sourceContext.CombatSourceTransform.position;
			if (vector.sqrMagnitude > 0.0001f)
			{
				return vector.normalized;
			}
		}
		if (aimDirection.sqrMagnitude > 0.0001f)
		{
			return aimDirection.normalized;
		}
		return Vector2.right;
	}
}
