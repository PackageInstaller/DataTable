using Ase.ECS;
using GameFramework;

namespace Ase;

public class SkillIndicatorData : IReference
{
	private int type;

	private float skillRange;

	private float skillWidth;

	private float skillAngle;

	private int skillId;

	public ChangeIndicatorData ChangeIndicatorData;

	public int Type => type;

	public float SkillRange => skillRange;

	public float SkillAngle => skillAngle;

	public float SkillWidth => skillWidth;

	public int SkillId => skillId;

	public static SkillIndicatorData Create(HeroSkillData heroSkillData)
	{
		SkillIndicatorData skillIndicatorData = ReferencePool.Acquire<SkillIndicatorData>();
		skillIndicatorData.skillId = heroSkillData.Id;
		skillIndicatorData.type = heroSkillData.IndicatorType;
		skillIndicatorData.skillRange = heroSkillData.SkillRange;
		skillIndicatorData.skillAngle = heroSkillData.SkillAngle;
		skillIndicatorData.skillWidth = heroSkillData.SkillWidth;
		skillIndicatorData.ChangeIndicatorData = heroSkillData.ChangeIndicatorSaveData;
		return skillIndicatorData;
	}

	public void Clear()
	{
		skillRange = 0f;
		skillAngle = 0f;
		skillWidth = 0f;
		skillId = 0;
	}
}
