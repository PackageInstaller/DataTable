using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置实体朝向目标当前右边", 0)]
[Category("Logic/PosAndRot")]
[Description("设置实体朝向")]
[ExposeAsDefinition]
public class SetEntityLookatTargetRight : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int targetID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		SimEntity entityWithEntityID2 = base.parentNode.mSimContext.GetEntityWithEntityID(targetID);
		if (entityWithEntityID != null && entityWithEntityID2 != null)
		{
			Int3 forward = entityWithEntityID2.entityPositon.mPosition - entityWithEntityID.entityPositon.mPosition;
			entityWithEntityID.entityPositon.mForward = IntMath.GetXZRight(forward).NormalizeTo(1000);
			entityWithEntityID.entityPositon.mForwardAngle = IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward);
			SimShapeProcessor.UpdateShapeWorldPosition(entityWithEntityID);
		}
	}
}
