namespace ACT.Battle.Configs;

[AbilityTypeMetadata("移除玩家标签", "Action", new string[] { "remove", "player", "tag", "state", "status" })]
public class ActionRemovePlayerTag : ConfigAction
{
	public MonoECS.PlayerTag PlayerTag;

	public override void Do(ActionMemory memory)
	{
		MonoECS.instance.RemovePlayerTag(PlayerTag);
	}
}
