using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取Agent黑板属性(已过时)", 0)]
[Category("Render/Agent")]
[Description("获取生命值")]
public class GetAgentBlackboardAttributePure : PureFunctionNode<int, int, int>
{
	public override int Invoke(int agentID, int varName)
	{
		return 0;
	}
}
