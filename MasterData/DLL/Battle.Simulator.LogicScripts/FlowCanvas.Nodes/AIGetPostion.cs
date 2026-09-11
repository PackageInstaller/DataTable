using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体位置", 0)]
[Category("Logic/PosAndRot")]
[Description("AI获得实体位置.....")]
[ExposeAsDefinition]
public class AIGetPostion : PureFunctionNode<Int3, int>
{
	public override Int3 Invoke(int entityID)
	{
		return AIProcessor.GetEntityPostion(entityID);
	}
}
