using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置相机使用新平滑模式(渲染)", 0)]
[Category("Render/Camera")]
[Description("在 4.5 版本调整跟随相机的平滑模式，激活该节点可以解决大位移下相机跟随错误问题，例如 4.5版本的22-1-9")]
public class UseNewSmoothOfCamera : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> useNewSmoothOfCameraInput = AddValueInput<bool>("新镜头平滑", "useNewSmooth");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			LockTargetCinemachine lockTargetCinemachine = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.lockTargetCinemachine;
			if (lockTargetCinemachine == null)
			{
				errorOut.Call(f);
			}
			else
			{
				lockTargetCinemachine.useNewSmooth = useNewSmoothOfCameraInput.value;
				output.Call(f);
			}
		});
	}
}
