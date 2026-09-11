using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("正在执行的ability的剩余时间(pure)", 0)]
[Category("Logic/Abilities")]
[Description("获取正在执行的ability的剩余时间")]
public class GetAbilityTimeRemainPure : PureFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (!entityWithEntityID.hasEntityActionAbility)
		{
			return 0;
		}
		int mAbilityID = entityWithEntityID.entityActionAbility.mAbilityID;
		return ConfigHelper.GetInstance().GetConfig<Timeline>(mAbilityID).Duration - entityWithEntityID.entityActionAbility.mLogicTime;
	}
}
