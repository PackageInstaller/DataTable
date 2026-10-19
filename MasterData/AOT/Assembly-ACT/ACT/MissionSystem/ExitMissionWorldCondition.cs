namespace ACT.MissionSystem;

public class ExitMissionWorldCondition : MissionCondition
{
	private bool m_ExitedWorld;

	protected override void OnDeactivate()
	{
		m_ExitedWorld = false;
	}

	protected override void OnInMissionWorld()
	{
		ExitMissionWorldConditionParam exitMissionWorldConditionParam = Param as ExitMissionWorldConditionParam;
		if (m_ExitedWorld && !exitMissionWorldConditionParam.immediate)
		{
			MarkSuccess();
		}
		m_ExitedWorld = false;
	}

	protected override void OnOutMissionWorld()
	{
		m_ExitedWorld = true;
		if ((Param as ExitMissionWorldConditionParam).immediate)
		{
			MarkSuccess();
		}
	}

	public override bool PreCheckCondition()
	{
		return !Flow.InMissionWorld;
	}
}
