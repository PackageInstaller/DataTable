using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置实体朝向当前自身右边", 0)]
[Category("Logic/PosAndRot")]
[Description("设置实体朝向")]
[ExposeAsDefinition]
public class SetEntityLookatLeft : CallableActionNode<int>
{
	public override void Invoke(int entityID)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon)
		{
			entityWithEntityID.entityPositon.mForward = IntMath.GetXZRight(entityWithEntityID.entityPositon.mForward);
			entityWithEntityID.entityPositon.mForwardAngle = IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward);
			SimShapeProcessor.UpdateShapeWorldPosition(entityWithEntityID);
		}
	}
}
