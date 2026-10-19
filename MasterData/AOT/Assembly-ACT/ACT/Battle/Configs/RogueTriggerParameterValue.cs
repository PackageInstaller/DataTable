namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取Rogue参数值", "Function", new string[] { "rogue", "trigger", "parameter", "value" })]
public class RogueTriggerParameterValue : ConfigFunction<float>
{
	public enum RogueTriggerType
	{
		Ability,
		Evt
	}

	public RogueTriggerType type;

	public string name;

	protected override float Evaluate(ActionMemory memory)
	{
		if (GameManager.rogueSystem.TryGetTriggerParameter((type == RogueTriggerType.Ability) ? memory.ability.rogueTrigger : memory.evt.ability.rogueTrigger, name, out var value))
		{
			return value;
		}
		return 0f;
	}
}
