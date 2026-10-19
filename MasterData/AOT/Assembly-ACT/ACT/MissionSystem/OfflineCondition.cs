using ACT.Event;

namespace ACT.MissionSystem;

public class OfflineCondition : MissionCondition
{
	public bool Offline;

	public override bool RequireEnv => false;

	protected override void OnActivate()
	{
		if (Offline)
		{
			MarkSuccess();
		}
	}

	protected override void OnDeactivate()
	{
	}

	private void OnOffline(BaseEventContent obj)
	{
		MarkSuccess();
	}
}
