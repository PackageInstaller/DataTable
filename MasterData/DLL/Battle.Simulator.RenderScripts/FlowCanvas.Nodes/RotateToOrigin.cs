using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("旋转GameObject到某个朝向", 0)]
[Category("Render/GameObject")]
[Description("指定时间内旋转GameObject到某个朝向")]
public class RotateToOrigin : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		ValueInput<GameObject> gameObjectInput = AddValueInput<GameObject>("目标Gameobject");
		ValueInput<Vector3> targetForwardInput = AddValueInput<Vector3>("目标朝向");
		ValueInput<float> timeInput = AddValueInput<float>("旋转时间");
		AddFlowInput("in", delegate(Flow f)
		{
			GameObject value = gameObjectInput.value;
			if (value == null)
			{
				errorOut.Call(f);
			}
			else
			{
				U3DUtil.Get<LerpRotateToOrigin>(value).BeginRotation(targetForwardInput.value, timeInput.value);
				output.Call(f);
			}
		});
	}
}
