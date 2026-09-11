using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取当前最近目标ID", 0)]
[Category("Logic/Spawn")]
[Description("获取最近的敌对单位")]
[ExposeAsDefinition]
public class GetCurrentClosestPlayerID : CallableFunctionNode<int, int, int>
{
	public override int Invoke(int entityID, int distance)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null && !entityWithEntityID.hasEntityShape)
		{
			return 0;
		}
		return CommonProcessor.GetSimEntityByMultiColliders(AbilitiesProcessor.LookatNearestTarget(entityWithEntityID, distance))?.creationIndex ?? 0;
	}
}
