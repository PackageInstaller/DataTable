using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI停止移动", 0)]
[Category("Logic/PosAndRot")]
[Description("AI停止移动 .....")]
[ExposeAsDefinition]
public class AIStopMovement : CallableActionNode<int>
{
	public override void Invoke(int entityID)
	{
		AIProcessor.StopAIMovement(entityID);
	}
}
