using System;

namespace ACT.Config;

[Serializable]
public class SkillGroupData
{
	public readonly int id;

	public readonly string name = "";

	public readonly int levelUpLimit;

	public readonly int maxLevel;

	public readonly int isNeedHiddenValues;

	public readonly int skillType;

	public readonly int[] skillTotalIds = new int[0];

	public readonly int skillSetLocal;

	public readonly int[] frontPoint = new int[0];

	public readonly int skillLinkParamLocal;

	public SkillGroupData(int id, string name, int levelUpLimit, int maxLevel, int isNeedHiddenValues, int skillType, int[] skillTotalIds, int skillSetLocal, int[] frontPoint, int skillLinkParamLocal)
	{
		this.id = id;
		this.name = name;
		this.levelUpLimit = levelUpLimit;
		this.maxLevel = maxLevel;
		this.isNeedHiddenValues = isNeedHiddenValues;
		this.skillType = skillType;
		this.skillTotalIds = skillTotalIds;
		this.skillSetLocal = skillSetLocal;
		this.frontPoint = frontPoint;
		this.skillLinkParamLocal = skillLinkParamLocal;
	}
}
