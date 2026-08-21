using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断血量是否小于等于0", 0)]
[Category("Logic/Attribute")]
[Description("获得实体血量.....")]
[ExposeAsDefinition]
public class ISEntityHEqualsZero : CallableFunctionNode<bool, int>
{
	public override bool Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
		{
			return true;
		}
		return entityWithEntityID.entityBlackboard.var.mHP <= 0;
	}
}
