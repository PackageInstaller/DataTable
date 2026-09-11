using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置实体朝向", 0)]
[Category("Logic/PosAndRot")]
[Description("设置实体朝向")]
[ExposeAsDefinition]
public class SetEntityForward : CallableActionNode<int, Int3>
{
	public override void Invoke(int entityID, Int3 forward)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon)
		{
			if (forward != Int3.zero)
			{
				entityWithEntityID.entityPositon.mForward = forward.NormalizeTo(1000);
				entityWithEntityID.entityPositon.mForwardAngle = IntMath.AngleOfVector(entityWithEntityID.entityPositon.mForward);
			}
			SimShapeProcessor.UpdateShapeWorldPosition(entityWithEntityID);
		}
	}
}
