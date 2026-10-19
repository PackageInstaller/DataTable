namespace CombatStats.Runtime;

public interface IAttackDataAccessor
{
	bool TryGetCharacterId(object attackData, out string value);

	bool TryGetCharacterName(object attackData, out string value);

	bool TryGetSkillId(object attackData, out int value);

	bool TryGetDamageValue(object attackData, out long value);

	bool TryGetIsCrit(object attackData, out bool value);

	bool TryGetTimestamp(object attackData, out float value);
}
