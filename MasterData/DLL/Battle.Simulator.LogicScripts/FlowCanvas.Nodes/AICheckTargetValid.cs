using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI检查目标是否有效(可以用 目标是否有效 代替)", 0)]
[Category("Logic/AI")]
[Description("AI检查目标是否有效.....")]
[ExposeAsDefinition]
public class AICheckTargetValid : CallableFunctionNode<bool, int, int>
{
	public override bool Invoke(int entityID, int targetID)
	{
		return AIProcessor.AICheckTargetValid(entityID, targetID);
	}
}
