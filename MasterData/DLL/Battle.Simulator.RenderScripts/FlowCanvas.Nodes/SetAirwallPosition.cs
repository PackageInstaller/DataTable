using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置空气墙位置", 0)]
[Category("Render/Effect")]
[Description("设置空气墙位置")]
public class SetAirwallPosition : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> startGameObjectInput = AddValueInput<GameObject>("出现特效");
		ValueInput<GameObject> endGameObjectInput = AddValueInput<GameObject>("结束特效");
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向");
		FlowOutput output = AddFlowOutput("out");
		AddFlowInput("In", delegate(Flow f)
		{
			startGameObjectInput.value.transform.localPosition = (Vector3)(positionInput.value + new Int3(0, 100, 0));
			startGameObjectInput.value.transform.forward = (Vector3)forwardInput.value;
			endGameObjectInput.value.transform.localPosition = (Vector3)positionInput.value;
			endGameObjectInput.value.transform.forward = (Vector3)forwardInput.value;
			output.Call(f);
		});
	}
}
