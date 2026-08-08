using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("技能按钮激活状态修改(过时)", 0)]
[Category("Render/UI")]
[Description("设置UI上按钮的状态")]
public class DisableAbilityButton : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> abilityButtonVar = AddValueInput<GameObject>("按钮", "abilityButtonVar");
		ValueInput<bool> stateVar = AddValueInput<bool>("启用状态", "stateVar");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AbilityButton component = abilityButtonVar.GetValue().GetComponent<AbilityButton>();
			if (component != null)
			{
				component.Enable = stateVar.GetValue();
				output.Call(f);
			}
			else
			{
				error.Call(f);
			}
		});
	}
}
