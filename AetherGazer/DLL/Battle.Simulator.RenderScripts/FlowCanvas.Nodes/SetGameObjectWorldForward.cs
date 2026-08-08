using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置GameObject的朝向", 0)]
[Category("Render/Agent")]
[Description("设置GameObject的世界坐标系的朝向")]
public class SetGameObjectWorldForward : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goInput = AddValueInput<GameObject>("GameObject");
		ValueInput<Vector3> forwardInput = AddValueInput<Vector3>("朝向");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			goInput.value.transform.forward = forwardInput.value;
			output.Call(f);
		});
	}
}
