using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Reset参数", "Action", new string[] { "reset", "trigger", "parameter", "event", "signal" })]
public class ActionResetTriggerParameter : ConfigAction
{
	public string name;

	public ConfigAnimParameterType type;

	public override void Do(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		if (type == ConfigAnimParameterType.Trigger)
		{
			entity.ResetTrigger(name);
		}
	}
}
