using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到跟随虚拟相机朝向(渲染)", 0)]
[Category("Render/Camera")]
[Description("得到跟随的虚拟相机机位朝向")]
public class GetFollowVirtualCameraForward : FlowControlNode
{
	private FlowOutput _Out;

	private Vector3 _Forward;

	protected override void RegisterPorts()
	{
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_Forward = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.virtualCamera.transform.forward;
			_Out.Call(f);
		});
		AddValueOutput("朝向", "forward", () => _Forward);
	}
}
