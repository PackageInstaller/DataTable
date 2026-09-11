using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("旋转GameObject子物体到某个朝向", 0)]
[Category("Render/GameObject")]
[Description("指定时间内旋转GameObject到某个朝向")]
public class BarbetteRotateToOrigin : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("out");
		FlowOutput errorOut = AddFlowOutput("error");
		ValueInput<GameObject> gameObjectInput = AddValueInput<GameObject>("目标Gameobject");
		ValueInput<List<string>> targetListInput = AddValueInput<List<string>>("目标子部件");
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
				List<string> value2 = targetListInput.value;
				for (int i = 0; i < value2.Count; i++)
				{
					Transform transform = value.transform.Find(value2[i]);
					if (transform == null)
					{
						errorOut.Call(f);
						return;
					}
					U3DUtil.Get<LerpRotateToOrigin>(transform.gameObject).BeginRotation(targetForwardInput.value, timeInput.value);
				}
				output.Call(f);
			}
		});
	}
}
