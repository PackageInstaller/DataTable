using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行AI实体激活", "Action", new string[] { "ai", "entity", "active", "bt", "behavior", "behaviour" })]
public class ActionAIEntityActive : ConfigAction
{
	public bool value;

	public override void Do(ActionMemory memory)
	{
		Entity entity = memory.target.entity;
		if (value)
		{
			entity.ShowRoot();
			entity.GetModel().SafeSetActive(active: true);
		}
		MonoECS.instance.EntityDitherPureCallback(entity, 0.5f, value, () =>
		{
			entity.GetModel().SafeSetActive(value);
		});
	}
}
