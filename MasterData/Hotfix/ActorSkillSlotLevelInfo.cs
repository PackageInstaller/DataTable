using System;

[Serializable]
public class ActorSkillSlotLevelInfo
{
	public ActionKey key = ActionKey.B;

	public int level = 1;

	public void LoadFrom(ActorSkillSlotLevelInfo other)
	{
		key = other.key;
		level = other.level;
	}
}
