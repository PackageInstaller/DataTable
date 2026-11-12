using System;
using System.Collections.Generic;

[Serializable]
public class ActorSkillSlotLevelInfos
{
	public List<ActorSkillSlotLevelInfo> skillSlotLevelInfos = new List<ActorSkillSlotLevelInfo>();

	public void LoadFrom(ActorSkillSlotLevelInfos other)
	{
		skillSlotLevelInfos.Clear();
		foreach (ActorSkillSlotLevelInfo skillSlotLevelInfo in other.skillSlotLevelInfos)
		{
			ActorSkillSlotLevelInfo actorSkillSlotLevelInfo = new ActorSkillSlotLevelInfo();
			actorSkillSlotLevelInfo.LoadFrom(skillSlotLevelInfo);
			skillSlotLevelInfos.Add(actorSkillSlotLevelInfo);
		}
	}
}
