namespace Ase.ECS;

public class ChangeIndicatorData
{
	private DRHeroSKillConfig skillConfig;

	public float SkillRangeIncreaseValue;

	public float SkillWidthInCreaseValue;

	public float SkillAngleIncreaseValue;

	public float ChangeRangeTime;

	public float ChangeWidthTime;

	public float ChangeAngleTime;

	public float FinalSkillRange;

	public float FinalSkillWidth;

	public float FinalSkillAngle;

	public ChangeIndicatorData()
	{
	}

	public ChangeIndicatorData(DRHeroSKillConfig sKillConfig)
	{
		skillConfig = sKillConfig;
		FinalSkillRange = sKillConfig.SkillRange;
		FinalSkillWidth = sKillConfig.SkillWidth;
		FinalSkillAngle = sKillConfig.SkillAngle;
	}

	public void ChangeDataReset()
	{
		SkillRangeIncreaseValue = 0f;
		SkillWidthInCreaseValue = 0f;
		SkillAngleIncreaseValue = 0f;
		ChangeRangeTime = 0f;
		ChangeWidthTime = 0f;
		ChangeAngleTime = 0f;
		FinalSkillRange = skillConfig.SkillRange;
		FinalSkillWidth = skillConfig.SkillWidth;
		FinalSkillAngle = skillConfig.SkillAngle;
	}
}
