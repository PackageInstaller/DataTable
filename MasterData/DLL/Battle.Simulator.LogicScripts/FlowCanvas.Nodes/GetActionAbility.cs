using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取当前正在执行的ability", 0)]
[Category("Logic/Abilities")]
[Description("获取指定实体正在执行的ability")]
public class GetActionAbility : PureFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null)
		{
			return 0;
		}
		if (entityWithEntityID.hasEntityActionAbility)
		{
			return entityWithEntityID.entityActionAbility.mAbilityID;
		}
		return 0;
	}
}
