using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("截取技能ID", 0)]
[Category("Common/Config")]
[Description("截取技能ID, 取技能ID最后3位")]
public class SplitAbilityID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID");
		AddValueOutput("后3位", () => abilityIDInput.value % (roleIDInput.value * 1000));
	}
}
