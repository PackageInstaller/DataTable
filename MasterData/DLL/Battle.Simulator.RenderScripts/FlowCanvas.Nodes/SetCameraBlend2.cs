using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置相机切换方式2", 0)]
[Category("Render/Camera")]
[Description("设置相机切换方式")]
public class SetCameraBlend2 : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<CinemachineBlendDefinition> enterBlendInput = AddValueInput<CinemachineBlendDefinition>("切换方式");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			Camera.main.gameObject.GetComponent<CinemachineBrain>().m_DefaultBlend = enterBlendInput.value;
			output.Call(f);
		});
	}
}
