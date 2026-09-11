using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置相机手动锁定某个怪", 0)]
[Category("Render/Camera")]
[Description("设置相机手动锁定某个怪, 传进来的如果不是怪可能会出错")]
public class SetCameraManulLock : FlowNode
{
	private LockTargetCinemachine lockTargetCinemachine;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("AgentID");
		ValueInput<bool> banInput = AddValueInput<bool>("禁止玩家拖动视角");
		AddValueOutput("AgentID", () => entityIDInput.value);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetPlayerAgent();
			if (playerAgent != null)
			{
				if (lockTargetCinemachine == null)
				{
					lockTargetCinemachine = playerAgent.GetComponent<ComponentCameraAnimation>().LockTargetCinemachine;
				}
				lockTargetCinemachine.banCameraCtrlUI = banInput.value;
				LockButton.LockAgent(playerAgent, entityIDInput.value, lockTargetCinemachine, entityIDInput.value);
				f.Call(output);
			}
		});
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		lockTargetCinemachine = null;
	}
}
