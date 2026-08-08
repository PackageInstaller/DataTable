using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("销毁实体", 0)]
[Category("Logic/Spawn")]
[Description("销毁实体")]
public class DestroyEntity : CallableActionNode<int>
{
	public override void Invoke(int entityID)
	{
		SpawnProcessor.DestoryEntity(entityID, 0);
	}
}
