namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置玩家标签", "Action", new string[] { "set", "player", "tag", "state", "status" })]
public class ActionSetPlayerTag : ConfigAction
{
	public MonoECS.PlayerTag PlayerTag;

	public override void Do(ActionMemory memory)
	{
		MonoECS.instance.SetPlayerTag(PlayerTag);
	}
}
