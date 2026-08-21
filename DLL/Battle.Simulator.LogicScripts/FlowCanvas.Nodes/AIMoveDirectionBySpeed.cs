using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("以指定速度移动AI到目标点", 0)]
[Category("Logic/PosAndRot")]
[Description("以指定速度移动AI到目标点 .....")]
[ExposeAsDefinition]
public class AIMoveDirectionBySpeed : CallableActionNode<int, Int3, int>
{
	public override void Invoke(int entityID, Int3 targetPosition, int speedFactor)
	{
		AIProcessor.MoveAIDirection(entityID, targetPosition, new VFactor(speedFactor, 100L));
	}
}
