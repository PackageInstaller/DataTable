using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取正在执行的ability", 0)]
[Category("Logic/Abilities")]
[Description("获取正在执行的ability")]
public class SetAIBusy : CallableFunctionNode<int, int>
{
	public override int Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (!entityWithEntityID.hasEntityActionAbility)
		{
			return 0;
		}
		return entityWithEntityID.entityActionAbility.mAbilityID;
	}
}
