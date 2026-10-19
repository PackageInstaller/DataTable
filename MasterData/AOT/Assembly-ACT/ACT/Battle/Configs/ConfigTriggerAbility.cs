namespace ACT.Battle.Configs;

public class ConfigTriggerAbility : TimelineItem
{
	public ConfigAction triggerAbility;

	public override bool CanDoPeriod()
	{
		return false;
	}
}
