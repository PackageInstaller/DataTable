public interface ISummerRaceCombatPayloadOverrideProvider
{
	CombatImpactPayload CreateWeaponImpactPayload(WeaponModuleDefinition def, CombatTriggerType trigger);

	CombatEffectSpec[] CreateEquipEffects(UtilityModuleDefinition def);
}
