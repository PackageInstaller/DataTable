using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("千分比(int)", 0)]
[Category("Logic/Control")]
[Description("获取某个值的千分比")]
[Color("c0c0c0")]
public class PermillageMutil : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> valueOrgInput = AddValueInput<int>("原始值");
		ValueInput<int> permillageInput = AddValueInput<int>("比例");
		AddValueOutput("结果", () => (int)((long)valueOrgInput.value * (long)permillageInput.value / 1000));
	}
}
