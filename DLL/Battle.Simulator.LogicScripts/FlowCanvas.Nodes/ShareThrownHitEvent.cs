using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("发送抛掷物接触事件(过时)", 0)]
[Category("Logic/抛掷物/事件")]
[Description("发送抛掷物接触实体事件,触发类型：0-无、1-接触条、2-锁定条")]
public class ShareThrownHitEvent : FlowControlNode
{
	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		AddFlowOutput("Out");
		m_error = AddFlowOutput("Error", "error");
		AddValueInput<int>("抛掷物ID");
		AddValueInput<List<int>>("接触列表");
		AddValueInput<int>("TimelineID");
		AddValueInput<int>("事件索引");
		AddFlowInput("In", delegate
		{
		});
	}
}
