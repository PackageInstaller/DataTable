using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("百分比(long)", 0)]
[Category("Logic/Control")]
[Description("获取某个值的百分比")]
public class PercentMutilOfLong : FlowControlNodeOfCommon
{
	protected override void RegisterPorts()
	{
		ValueInput<long> originValueInput = AddValueInput<long>("原始值", "originValue");
		ValueInput<int> percentInput = AddValueInput<int>("百分之", "percent");
		AddValueOutput("结果", () => originValueInput.value * percentInput.value / 100);
	}
}
