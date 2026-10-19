using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改实体标签", "Action", new string[] { "change", "entity", "tag", "state", "status" })]
public class ActionChangeEntityTag : ConfigAction
{
	public bool add;

	public EntityTag tag;

	public override void Do(ActionMemory memory)
	{
		if (add)
		{
			memory.owner.GetCompBehave().EntityTags.AddTag(tag);
		}
		else
		{
			memory.owner.GetCompBehave().EntityTags.RemoveTag(tag);
		}
	}
}
