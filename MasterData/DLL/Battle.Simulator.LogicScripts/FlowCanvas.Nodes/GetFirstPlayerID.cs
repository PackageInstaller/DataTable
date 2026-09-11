using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取最后一个玩家ID", 0)]
[Category("Logic/AI")]
[Description("获取最后一个不是AI的玩家ID")]
public class GetFirstPlayerID : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => CommonNodeFunction.GetLastPlayerID(base.mSimContext));
	}
}
