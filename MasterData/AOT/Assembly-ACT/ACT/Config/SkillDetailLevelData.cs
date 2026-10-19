using System;

namespace ACT.Config;

[Serializable]
public class SkillDetailLevelData
{
	public readonly int id;

	public readonly int skillId;

	public readonly int level;

	public readonly float[] param = new float[0];

	public readonly float[] param1 = new float[0];

	public SkillDetailLevelData(int id, int skillId, int level, float[] param, float[] param1)
	{
		this.id = id;
		this.skillId = skillId;
		this.level = level;
		this.param = param;
		this.param1 = param1;
	}
}
