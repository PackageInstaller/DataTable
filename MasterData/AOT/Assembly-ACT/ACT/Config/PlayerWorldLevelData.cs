using System;

namespace ACT.Config;

[Serializable]
public class PlayerWorldLevelData
{
	public readonly int id;

	public readonly int monsterLevelDelta;

	public readonly int characterLevel;

	public readonly int weaponLevel;

	public readonly int skillLevel;

	public readonly int chipLevel;

	public PlayerWorldLevelData(int id, int monsterLevelDelta, int characterLevel, int weaponLevel, int skillLevel, int chipLevel)
	{
		this.id = id;
		this.monsterLevelDelta = monsterLevelDelta;
		this.characterLevel = characterLevel;
		this.weaponLevel = weaponLevel;
		this.skillLevel = skillLevel;
		this.chipLevel = chipLevel;
	}
}
