using System;

namespace ACT.MissionSystem;

[Serializable]
public class TrainingCompletionConditionParam
{
	public int raidId;

	public int count = 1;

	public int specifiedLevel;
}
