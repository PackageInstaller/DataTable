using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移动到目标点", 0)]
[Category("Logic/PosAndRot")]
[Description("移动到目标点 .....")]
[ExposeAsDefinition]
public class AIMoveDirection : CallableActionNode<int, Int3>
{
	public override void Invoke(int entityID, Int3 targetPosition)
	{
		AIProcessor.MoveAIDirection(entityID, targetPosition, VFactor.one);
	}
}
