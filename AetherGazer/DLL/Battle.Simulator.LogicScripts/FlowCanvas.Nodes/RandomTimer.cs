using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("概率(随时间增加)节点(已过时)", 0)]
[Category("Logic/Control")]
[Description("概率(随时间增加)节点，会随时间增加概率，满足概率条件后一定时间后重置")]
public class RandomTimer : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueInput<int>("实体ID");
		AddValueInput<int>("随机属性编号");
		AddValueInput<int>("初始概率");
		AddValueInput<int>("概率增量");
		AddValueInput<int>("延时概率增加时间");
		AddValueInput<int>("概率重置时间");
		AddValueInput<int>("概率增加间隔");
		AddFlowOutput("true");
		AddFlowOutput("false");
		AddFlowInput("In", delegate
		{
		});
	}
}
