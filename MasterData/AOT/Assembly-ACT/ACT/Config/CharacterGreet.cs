using System;

namespace ACT.Config;

[Serializable]
public class CharacterGreet
{
	public readonly int id;

	public readonly int characterId;

	public readonly int priority;

	public readonly int unlockType;

	public readonly int missionGroupId;

	public readonly int skinUnlock;

	public readonly int greetText;

	public CharacterGreet(int id, int characterId, int priority, int unlockType, int missionGroupId, int skinUnlock, int greetText)
	{
		this.id = id;
		this.characterId = characterId;
		this.priority = priority;
		this.unlockType = unlockType;
		this.missionGroupId = missionGroupId;
		this.skinUnlock = skinUnlock;
		this.greetText = greetText;
	}
}
