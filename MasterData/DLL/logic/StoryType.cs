using System;

[Flags]
public enum StoryType
{
	None = 0,
	PlayStory = 1,
	BossAppear = 2,
	CooperateUniqueSkill = 4,
	PlayBattleStory = 8,
	MasterSkill = 0x10
}
