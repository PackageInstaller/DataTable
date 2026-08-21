using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("取消相机的手动锁定", 0)]
[Category("Render/Camera")]
[Description("设置相机手动锁定某个怪, 传进来的如果不是怪可能会出错")]
public class SetCameraManulLockFalse : FlowNode
{
	private LockTargetCinemachine lockTargetCinemachine;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetPlayerAgent();
			if (lockTargetCinemachine == null)
			{
				lockTargetCinemachine = playerAgent.GetComponent<ComponentCameraAnimation>().LockTargetCinemachine;
			}
			if (lockTargetCinemachine.hasManualLock)
			{
				lockTargetCinemachine.hasManualLock = false;
				lockTargetCinemachine.banCameraCtrlUI = false;
			}
			f.Call(output);
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		lockTargetCinemachine = null;
	}
}
