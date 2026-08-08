using System;

[Serializable]
public sealed class CombatImpactPayload
{
	public CombatTriggerType trigger = CombatTriggerType.ProjectileHit;

	public CombatEffectSpec[] effects = Array.Empty<CombatEffectSpec>();

	public bool boomerangFlight;

	public CombatImpactPayload Clone()
	{
		CombatImpactPayload combatImpactPayload = (CombatImpactPayload)MemberwiseClone();
		if (effects != null && effects.Length != 0)
		{
			CombatEffectSpec[] array = new CombatEffectSpec[effects.Length];
			for (int i = 0; i < effects.Length; i++)
			{
				array[i] = ((effects[i] != null) ? effects[i].Clone() : null);
			}
			combatImpactPayload.effects = array;
		}
		else
		{
			combatImpactPayload.effects = Array.Empty<CombatEffectSpec>();
		}
		return combatImpactPayload;
	}
}
