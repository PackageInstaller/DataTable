using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否为后摇(过时)", 0)]
[Category("Logic/Abilities")]
[Description("检查是否在施放技能\n")]
public class AbilityIsRecover : PureFunctionNode<bool, int>
{
	public override bool Invoke(int simEntityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityActionAbility)
		{
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(entityWithEntityID.entityActionAbility.mAbilityID);
			return entityWithEntityID.entityActionAbility.mLogicTime >= config.RecoverTime;
		}
		return false;
	}
}
