using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取打断的ID", 0)]
[Category("Logic/Attribute")]
[Description("获取打断的ID")]
[ExposeAsDefinition]
public class GetBrokenAbilityID : CallableFunctionNode<int, int>
{
	public override int Invoke(int target)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(target);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityActionAbilityLogicInput)
		{
			return entityWithEntityID.entityActionAbilityLogicInput.mBrokenAbilityID;
		}
		return 0;
	}
}
