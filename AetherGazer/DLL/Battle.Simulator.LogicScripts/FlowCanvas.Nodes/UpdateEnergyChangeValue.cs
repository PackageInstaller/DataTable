using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("更新机制值变更值(过时)", 0)]
[Category("Logic/Attribute")]
[Description("根据角色Id更新该角色所有技能的机制值消耗值, 使用表内属性走结算流程")]
public class UpdateEnergyChangeValue : FlowNode
{
	private Dictionary<int, int> temp = new Dictionary<int, int>();

	protected override void RegisterPorts()
	{
		AddValueInput<int>("实体ID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			output.Call(f);
		});
	}
}
