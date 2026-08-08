using UnityEngine;

public interface ICombatStatusHost
{
	Transform CombatTransform { get; }

	Rigidbody2D CombatRigidbody { get; }

	SummerRaceBodyType CombatBodyType { get; }

	SummerRaceCombatTeam CombatTeam { get; }

	bool IsCombatAlive { get; }

	bool TryApplyCombatEffect(CombatEffectSpec effect, Vector2 hitDirection, ICombatSourceContext sourceContext, out int damageDealt);
}
