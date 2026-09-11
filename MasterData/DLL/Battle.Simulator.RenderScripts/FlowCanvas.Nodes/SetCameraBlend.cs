using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置相机切换方式", 0)]
[Category("Render/Camera")]
[Description("设置相机切换方式")]
public class SetCameraBlend : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<CinemachineBlendDefinition.Style> enterBlendInput = AddValueInput<CinemachineBlendDefinition.Style>("切换方式");
		ValueInput<float> timeInput = AddValueInput<float>("时间(秒)");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			CinemachineBrain component = Camera.main.gameObject.GetComponent<CinemachineBrain>();
			component.m_DefaultBlend.m_Style = enterBlendInput.value;
			component.m_DefaultBlend.m_Time = timeInput.value;
			output.Call(f);
		});
	}
}
