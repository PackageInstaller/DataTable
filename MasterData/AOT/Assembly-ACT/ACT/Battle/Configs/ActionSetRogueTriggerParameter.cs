namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置Rogue参数", "Action", new string[] { "set", "rogue", "trigger", "parameter" })]
public class ActionSetRogueTriggerParameter : ConfigAction
{
	public string name;

	public ConfigFunction<float> value;

	public override void Do(ActionMemory memory)
	{
		GameManager.rogueSystem.SetTriggerParameter(memory.ability.rogueTrigger, name, value.Return(memory), memory.owner, memory.ability);
	}
}
