using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否为后摇(逻辑)", 0)]
[Category("Logic/Abilities")]
[Description("检查是否在施放技能")]
public class AbilityIsRecover2 : PureFunctionNode<bool, int>
{
	public override bool Invoke(int simEntityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityActionAbility && GetAbilityBackswingTime.TryGetCastBackswingPoint(ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityActionAbility.mAbilityID), out var point))
		{
			return entityWithEntityID.entityActionAbility.mLogicTime >= point;
		}
		return false;
	}
}
