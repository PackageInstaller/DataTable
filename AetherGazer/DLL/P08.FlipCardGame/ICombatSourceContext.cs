using UnityEngine;

public interface ICombatSourceContext
{
	Transform CombatSourceTransform { get; }

	Rigidbody2D CombatSourceRigidbody { get; }

	SummerRaceCombatTeam CombatTeam { get; }

	bool OverclockDamageTextActive { get; }

	void NotifyCombatDamageDealt(int amount);
}
