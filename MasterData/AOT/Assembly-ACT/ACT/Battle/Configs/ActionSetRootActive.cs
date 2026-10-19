using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置根节点激活", "Action", new string[] { "set", "root", "active", "state", "status", "tag" })]
public class ActionSetRootActive : ConfigAction
{
	public bool value;

	public override void Do(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		entity.GetRoot().SetActive(value);
		MonoECS.instance.ResetEffect(entity, isBack: true);
	}
}
