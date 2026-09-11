using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[动画机]AnimatorSetTrigger", 0)]
[Category("Render/Anime")]
[Description("AnimatorSetTrigger")]
public class AnimatorSetTrigger : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goInput = AddValueInput<GameObject>("GameObject");
		ValueInput<string> nameInput = AddValueInput<string>("Name");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			goInput.value.GetComponentInChildren<Animator>().SetTrigger(nameInput.value);
			output.Call(f);
		});
	}
}
