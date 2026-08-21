using ParadoxNotion.Design;
using UnityEngine.Pipelines.SimPipeline;

namespace FlowCanvas.Nodes;

[Name("清除画面分离(渲染)", 0)]
[Category("Render/Buff/Buff特效/画面分离")]
[Description("将 CameraExtension 的 abberationIntensity (控制画面分离强度) 重置为0,该数值依旧可能被其他效果影响")]
public class ClearCameraAbberationEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "Out");
		FlowOutput abnormalOut = AddFlowOutput("Error", "异常");
		AddFlowInput("In", "input", delegate(Flow f)
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
				cameraExtension.abberationIntensity = 0f;
				output.Call(f);
			}
		});
	}
}
