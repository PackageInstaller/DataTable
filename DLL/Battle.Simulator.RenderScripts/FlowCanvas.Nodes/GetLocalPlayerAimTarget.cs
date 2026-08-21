using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取本地玩家锁定目标", 0)]
[Category("Render/Agent")]
[Description("获取本地玩家锁定目标")]
public class GetLocalPlayerAimTarget : FlowNode
{
	private LockTargetCinemachine lockCom;

	protected override void RegisterPorts()
	{
		lockCom = null;
		FlowOutput trueOut = AddFlowOutput("目标有效");
		FlowOutput falseOut = AddFlowOutput("目标无效");
		int res = 0;
		AddValueOutput("目标agentID", () => res);
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (lockCom == null)
			{
				lockCom = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.lockTargetCinemachine;
			}
			res = lockCom.GetTargetAgent();
			if (agentManager.GetAgent(res) == null || !lockCom.IsLocking())
			{
				f.Call(falseOut);
			}
			else
			{
				f.Call(trueOut);
			}
		});
	}
}
