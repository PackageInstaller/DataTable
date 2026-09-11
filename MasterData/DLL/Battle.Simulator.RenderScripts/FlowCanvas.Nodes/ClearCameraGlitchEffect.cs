using ParadoxNotion.Design;
using UnityEngine.Pipelines.SimPipeline;

namespace FlowCanvas.Nodes;

[Name("清除镜头故障(渲染)", 0)]
[Category("Render/Buff/Buff特效/镜头故障")]
[Description("将 CameraExtension 的 glitchIntensity(强度)、glitchFrequency(频率) 重置为0,该数值同帧依旧可能被其他效果影响")]
public class ClearCameraGlitchEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "Out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "异常");
		AddFlowInput("In", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				CameraExtension cameraExtension = battleScene.CameraExtension;
				if (cameraExtension == null)
				{
					abnormalOut.Call(f);
				}
				else
				{
					cameraExtension.glitchIntensity = 0f;
					cameraExtension.glitchFrequency = 0f;
					output.Call(f);
				}
			}
		});
	}
}
