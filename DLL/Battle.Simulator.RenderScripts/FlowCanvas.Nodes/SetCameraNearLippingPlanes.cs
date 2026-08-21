using Cinemachine;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置相机最近裁切面值(渲染)", 0)]
[Category("Render/Camera")]
[Description("设置主虚拟相机上的最近裁切面的值，用来实现一些碎片非常靠近镜头的效果")]
public class SetCameraNearLippingPlanes : FlowControlNode
{
	private CinemachineVirtualCamera _VirtualCamera;

	private ValueInput<float> _NearValue;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		_NearValue = AddValueInput<float>("最近裁切面值", "nearValue").SetDefaultAndSerializedValue(0.3f);
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			if (_VirtualCamera == null)
			{
				_VirtualCamera = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.virtualCamera;
			}
			if (_VirtualCamera == null)
			{
				_Error.Call(f);
			}
			else
			{
				_VirtualCamera.m_Lens.NearClipPlane = _NearValue.GetValue();
				_Out.Call(f);
			}
		});
	}
}
