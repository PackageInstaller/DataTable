using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置实体位置", 0)]
[Category("Logic/PosAndRot")]
[Description("设置实体位置")]
[ExposeAsDefinition]
public class SetEntityPosition : CallableActionNode<int, Int3>
{
	public override void Invoke(int entityID, Int3 position)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon)
		{
			entityWithEntityID.entityPositon.mPosition = position;
			SimShapeProcessor.UpdateShapeWorldPosition(entityWithEntityID);
		}
	}
}
