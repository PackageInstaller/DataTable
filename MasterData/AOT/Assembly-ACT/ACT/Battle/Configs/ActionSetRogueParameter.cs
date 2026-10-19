namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置Rogue参数", "Action", new string[] { "set", "rogue", "parameter" })]
public class ActionSetRogueParameter : ConfigAction
{
	public string name;

	public ConfigFunction<float> value;

	public override void Do(ActionMemory memory)
	{
		GameManager.rogueSystem.SetRogueParameter(name, value.Return(memory), memory.owner, memory.ability);
	}
}
