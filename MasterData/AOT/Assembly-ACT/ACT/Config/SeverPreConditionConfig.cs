namespace ACT.Config;

public class SeverPreConditionConfig : GuideStepFinishConditionConfig
{
	public int MissionGroupId;

	public override RuntimeStepCondition CreateRuntimeStepFinishCondition()
	{
		return new RuntimeSeverPreCondition(this);
	}
}
