using ParadoxNotion.Design;
using UnityEngine.Pipelines.SimPipeline;

namespace FlowCanvas.Nodes;

[Name("清除镜头模糊(渲染)", 0)]
[Category("Render/Buff/Buff特效/镜头模糊")]
[Description("将 CameraExtension 的 radialBlurScale(中心尺寸)、radialBlurGradient(梯度)、radialBlurIntensity(强度)、radialBlurTarget(中心) 重置,该数值同帧依旧可能被其他效果影响")]
public class ClearCameraAbberationList : FlowControlNode
{
	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_out = AddFlowOutput("Out", "Out");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				m_error.Call(f);
			}
			else
			{
				CameraExtension cameraExtension = battleScene.CameraExtension;
				if (cameraExtension == null)
				{
					m_error.Call(f);
				}
				else
				{
					cameraExtension.radialBlurScale = 0f;
					cameraExtension.radialBlurTarget = null;
					m_out.Call(f);
				}
			}
		});
	}
}
