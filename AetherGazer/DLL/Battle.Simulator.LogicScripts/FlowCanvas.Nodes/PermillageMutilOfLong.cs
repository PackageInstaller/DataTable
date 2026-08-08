using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("千分比(long)", 0)]
[Category("Logic/Control")]
[Description("获取某个值的千分比")]
public class PermillageMutilOfLong : FlowControlNodeOfCommon
{
	protected override void RegisterPorts()
	{
		ValueInput<long> valueOrgInput = AddValueInput<long>("原始值");
		ValueInput<int> permillageInput = AddValueInput<int>("比例");
		AddValueOutput("结果", () => valueOrgInput.value * permillageInput.value / 1000);
	}
}
