using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("百分比(int)", 0)]
[Category("Logic/Control")]
[Description("获取某个值的百分比")]
public class PercentMutil : FlowControlNodeOfCommon
{
	protected override void RegisterPorts()
	{
		ValueInput<int> originValueInput = AddValueInput<int>("原始值", "originValue");
		ValueInput<int> percentInput = AddValueInput<int>("百分之", "percent");
		AddValueOutput("结果", () => originValueInput.value * percentInput.value / 100);
	}
}
