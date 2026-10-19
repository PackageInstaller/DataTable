namespace ACT.MissionSystem;

public sealed class BindEnvNodeCondition : MissionCondition
{
	public override bool RequireEnv => true;

	protected override void OnActivate()
	{
		Refresh();
	}

	protected override void OnInMissionWorld()
	{
		Refresh();
	}

	protected override void OnOutMissionWorld()
	{
		Refresh();
	}

	private void Refresh()
	{
		foreach (string node in (Param as BindEnvNodeConditionParam).nodes)
		{
			Flow.Env.transform.Find(node).gameObject.SetActive(InMissionWorld);
		}
	}
}
