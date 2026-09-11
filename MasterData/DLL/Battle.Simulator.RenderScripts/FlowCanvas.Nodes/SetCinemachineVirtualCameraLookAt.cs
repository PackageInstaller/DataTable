using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置虚拟相机LookAt", 0)]
[Category("Render/Camera")]
[Description("设置虚拟相机LookAt")]
public class SetCinemachineVirtualCameraLookAt : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goInput = AddValueInput<GameObject>("GameObject");
		ValueInput<Transform> targetInput = AddValueInput<Transform>("target");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			goInput.value.GetComponent<CinemachineVirtualCamera>().LookAt = targetInput.value;
			output.Call(f);
		});
	}
}
