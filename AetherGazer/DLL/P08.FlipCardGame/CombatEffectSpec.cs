using System;

[Serializable]
public sealed class CombatEffectSpec
{
	public CombatTriggerType trigger = CombatTriggerType.ProjectileHit;

	public CombatEffectKind effectKind;

	public CombatTargetSelector targetSelector;

	public float magnitude;

	public float duration;

	public float radius;

	public int maxTargets = 1;

	public bool enabled = true;

	public CombatEffectSpec Clone()
	{
		return (CombatEffectSpec)MemberwiseClone();
	}
}
