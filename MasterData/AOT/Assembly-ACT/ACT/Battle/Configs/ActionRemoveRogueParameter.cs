namespace ACT.Battle.Configs;

[AbilityTypeMetadata("移除Rogue参数", "Action", new string[] { "remove", "rogue", "parameter" })]
public class ActionRemoveRogueParameter : ConfigAction
{
	public string name;

	public override void Do(ActionMemory memory)
	{
		GameManager.rogueSystem.RemoveRogueParameter(name);
	}
}
