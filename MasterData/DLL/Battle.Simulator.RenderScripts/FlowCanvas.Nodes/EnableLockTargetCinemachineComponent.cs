using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("激活相机锁定组件(渲染)", 0)]
[Category("Render/Camera")]
[Description("激活相机锁定组件")]
public class EnableLockTargetCinemachineComponent : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		AddFlowOutput("Out", "output");
		ValueInput<bool> enableInput = AddValueInput<bool>("激活", "enable");
		AddFlowInput("In", "input", delegate
		{
			CameraParamComponent virtualCameraParam = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam;
			if (virtualCameraParam != null)
			{
				LockTargetCinemachine component = virtualCameraParam.gameObject.GetComponent<LockTargetCinemachine>();
				if (component != null)
				{
					component.enabled = enableInput.value;
				}
			}
		});
	}
}
