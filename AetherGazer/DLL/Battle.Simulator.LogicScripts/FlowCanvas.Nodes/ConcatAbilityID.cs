using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("拼接技能ID", 0)]
[Category("Common/Config")]
[Description("拼接技能ID")]
public class ConcatAbilityID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		ValueInput<int> endInput = AddValueInput<int>("后3位");
		AddValueOutput("技能ID", () => roleIDInput.value * 1000 + endInput.value);
	}
}
