using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取重量", 0)]
[Category("Logic/Attribute")]
[Description("获取重量")]
public class GetWeight : PureFunctionNode<int, int>
{
	public override int Invoke(int simEntityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(simEntityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityShape)
		{
			return entityWithEntityID.entityShape.mWeight;
		}
		return 0;
	}
}
