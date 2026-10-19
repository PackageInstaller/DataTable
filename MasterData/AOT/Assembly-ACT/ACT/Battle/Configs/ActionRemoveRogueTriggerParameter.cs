namespace ACT.Battle.Configs;

[AbilityTypeMetadata("移除Rogue参数", "Action", new string[] { "remove", "rogue", "trigger", "parameter" })]
public class ActionRemoveRogueTriggerParameter : ConfigAction
{
	public string name;

	public override void Do(ActionMemory memory)
	{
		int rogueTrigger = memory.ability.rogueTrigger;
		if (rogueTrigger != -1)
		{
			GameManager.rogueSystem.RemoveRogueTriggerParameter(rogueTrigger);
		}
	}
}
