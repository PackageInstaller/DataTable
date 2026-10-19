namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改行为树行为冷却", "Action", new string[] { "change", "bt", "behavior", "cd", "ai", "behaviour" })]
public class ActionChangeBTBehaviorCD : ConfigAction
{
	public string[] behaviors;

	public override void Do(ActionMemory memory)
	{
		_ = memory.target.entity;
	}
}
