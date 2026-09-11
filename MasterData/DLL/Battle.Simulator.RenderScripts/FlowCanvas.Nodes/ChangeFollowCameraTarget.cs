using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("更改主相机跟随实体(渲染)", 0)]
[Category("Render/Camera")]
[Description("变更主相机当前跟随的渲染实体。仅变更相机跟随，其余一切组件不影响。3.0AI玩法使用。")]
public class ChangeFollowCameraTarget : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("agentID");
		FlowOutput output = AddFlowOutput("");
		FlowOutput outputError = AddFlowOutput("error");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				outputError.Call(f);
			}
			else
			{
				NAgent agent = agentManager.GetAgent(agentIDInput.value);
				if (agent == null)
				{
					outputError.Call(f);
				}
				else
				{
					BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
					if (battleScene != null && battleScene.virtualCameraParam != null && battleScene.virtualCameraParam.virtualCamera != null && battleScene.virtualCameraParam.targetGroup != null)
					{
						battleScene.virtualCameraParam.virtualCamera.Follow = agent.transform;
						battleScene.virtualCameraParam.targetGroup.m_Targets[0].target = agent.transform;
						output.Call(f);
					}
					else
					{
						outputError.Call(f);
					}
				}
			}
		});
	}
}
