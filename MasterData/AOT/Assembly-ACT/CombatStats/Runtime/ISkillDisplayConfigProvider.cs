namespace CombatStats.Runtime;

public interface ISkillDisplayConfigProvider
{
	bool TryGetSkillDisplay(int characterId, int skillId, out SkillDisplayInfo info);
}
