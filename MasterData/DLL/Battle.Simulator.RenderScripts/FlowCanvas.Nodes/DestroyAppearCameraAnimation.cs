using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("销毁相机出场动画", 0)]
[Category("Render/Camera")]
[Description("销毁相机出场动画")]
public class DestroyAppearCameraAnimation : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goInput = AddValueInput<GameObject>("资源");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			GameObject value = goInput.value;
			if (value != null)
			{
				value.GetComponentInChildren<CinemachineVirtualCamera>().LookAt = null;
				PooledAsset.DestroyOrReturn(value);
			}
			CinemachineBrain component = Camera.main.gameObject.GetComponent<CinemachineBrain>();
			component.m_DefaultBlend.m_Style = CinemachineBlendDefinition.Style.EaseIn;
			component.m_DefaultBlend.m_Time = 2f;
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			int mPlayerAgentID = agentManager.mPlayerAgentID;
			NAgent agent = agentManager.GetAgent(mPlayerAgentID);
			(NScene.GetCurrentScene() as BattleScene).virtualCameraParam.RotateCameraToRoleaBack(agent.transform);
			output.Call(f);
		});
	}
}
