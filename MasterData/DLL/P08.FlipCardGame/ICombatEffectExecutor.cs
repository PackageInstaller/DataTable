using UnityEngine;

public interface ICombatEffectExecutor
{
	CombatExecutionResult ExecuteImpact(ICombatStatusHost target, CombatImpactPayload payload, Vector2 hitDirection, ICombatSourceContext sourceContext);

	CombatExecutionResult ExecuteEffects(ICombatSourceContext sourceContext, Vector2 aimDirection, CombatEffectSpec[] effects);
}
