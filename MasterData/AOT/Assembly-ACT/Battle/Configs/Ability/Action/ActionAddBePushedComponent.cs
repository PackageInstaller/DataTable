using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;

namespace Battle.Configs.Ability.Action;

[AbilityTypeMetadata("添加BePushedComponent", "Action", new string[] { "add", "be", "pushed", "component" })]
public class ActionAddBePushedComponent : ConfigAction
{
	public WhereTargets where;

	public ConfigAction[] onPushedActions;

	public override void Do(ActionMemory memory)
	{
		MonoEntity mono = memory.target.entity.GetMono();
		MonoEntityBePushed monoEntityBePushed = mono.gameObject.AddComponent<MonoEntityBePushed>();
		monoEntityBePushed.actions = onPushedActions;
		monoEntityBePushed.where = where;
		monoEntityBePushed.ownerEntity = mono;
	}
}
