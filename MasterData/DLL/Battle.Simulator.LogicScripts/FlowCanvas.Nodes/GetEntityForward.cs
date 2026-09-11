using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体朝向", 0)]
[Category("Logic/PosAndRot")]
[Description("获取实体朝向")]
[ExposeAsDefinition]
public class GetEntityForward : PureFunctionNode<Int3, int>
{
	public override Int3 Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityPositon)
		{
			return Int3.zero;
		}
		return entityWithEntityID.entityPositon.mForward;
	}
}
