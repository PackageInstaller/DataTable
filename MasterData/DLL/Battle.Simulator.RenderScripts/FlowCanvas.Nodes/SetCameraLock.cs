using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置相机锁定", 0)]
[Category("Render/Camera")]
[Description("设置相机锁定")]
public class SetCameraLock : FlowNode
{
	private LockTargetCinemachine lockTargetCinemachine;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			(NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (lockTargetCinemachine == null)
			{
				lockTargetCinemachine = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.lockTargetCinemachine;
			}
			if (!(lockTargetCinemachine == null))
			{
				lockTargetCinemachine.SetTargetAgent(entityIDInput.value);
				lockTargetCinemachine.ResetLockTime();
				output.Call(f);
			}
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		lockTargetCinemachine = null;
	}
}
