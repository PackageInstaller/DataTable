using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[动画机]AnimatorSetInteger", 0)]
[Category("Render/Anime")]
[Description("设置Animator变量")]
public class AnimatorSetInteger : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goInput = AddValueInput<GameObject>("GameObject", "gameobject");
		ValueInput<string> nameInput = AddValueInput<string>("名字", "name");
		ValueInput<int> intValueInput = AddValueInput<int>("值", "value");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			Animator componentInChildren = goInput.value.GetComponentInChildren<Animator>();
			if (componentInChildren == null)
			{
				errorOut.Call(f);
			}
			else
			{
				componentInChildren.SetInteger(nameInput.value, intValueInput.value);
				output.Call(f);
			}
		});
	}
}
