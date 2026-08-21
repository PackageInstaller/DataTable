using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("传送实体", 0)]
[Category("Logic/PosAndRot")]
[Description("传送实体")]
[ExposeAsDefinition]
public class TeleportEntity : CallableActionNode<int, Int3, Int3>
{
	public override void Invoke(int entityID, Int3 position, Int3 forward)
	{
		SimEntity entityWithEntityID = base.parentNode.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityPositon)
		{
			MovementProcessor.Teleport(entityWithEntityID, position, forward);
		}
	}
}
