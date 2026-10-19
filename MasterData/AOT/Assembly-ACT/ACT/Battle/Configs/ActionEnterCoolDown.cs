namespace ACT.Battle.Configs;

[AbilityTypeMetadata("进入CoolDown", "Action", new string[] { "enter", "cool", "down" })]
public class ActionEnterCoolDown : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		memory.ability.cooldownTimestamp = memory.ability.time;
	}
}
