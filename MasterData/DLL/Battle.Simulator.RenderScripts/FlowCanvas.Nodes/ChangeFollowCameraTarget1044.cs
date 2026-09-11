using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[荷鲁斯]更改主相机跟随实体(渲染)", 0)]
[Category("Render/Camera")]
[Description("变更主相机当前跟随的渲染实体。仅变更相机跟随，其余一切组件不影响。")]
public class ChangeFollowCameraTarget1044 : FlowNode
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
						GameObject gameObject = new GameObject("follow1044");
						FollowOf1044 followOf = U3DUtil.Get<FollowOf1044>(gameObject);
						followOf.Root = agent.transform;
						followOf.Bip001 = agent.AttachPointSetup.GetAttachPoint("Bip001");
						followOf.Length = battleScene.virtualCameraParam.composer.m_TrackedObjectOffset.y;
						gameObject.transform.position = agent.transform.position;
						gameObject.transform.forward = agent.transform.forward;
						battleScene.virtualCameraParam.virtualCamera.Follow = followOf.transform;
						battleScene.virtualCameraParam.targetGroup.m_Targets[0].target = followOf.transform;
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
