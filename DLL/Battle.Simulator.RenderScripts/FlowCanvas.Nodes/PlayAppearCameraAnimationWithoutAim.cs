using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放相机出场动画(特殊-无AIM)", 0)]
[Category("Render/Camera")]
[Description("播放相机出场动画")]
public class PlayAppearCameraAnimationWithoutAim : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向");
		ValueInput<string> assetNameInput = AddValueInput<string>("资源名");
		GameObject go = null;
		AddValueOutput("资源", () => go);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			go = Asset.Instantiate(assetNameInput.value);
			go.transform.forward = (Vector3)forwardInput.value;
			go.transform.position = (Vector3)positionInput.value;
			Camera.main.gameObject.GetComponent<CinemachineBrain>().m_DefaultBlend.m_Style = CinemachineBlendDefinition.Style.Cut;
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			int mPlayerAgentID = agentManager.mPlayerAgentID;
			NAgent agent = agentManager.GetAgent(mPlayerAgentID);
			CinemachineVirtualCamera component = go.transform.Find("VirtualCamera").GetComponent<CinemachineVirtualCamera>();
			CameraParamComponent virtualCameraParam = agent.GetComponent<ComponentCameraAnimation>().virtualCameraParam;
			component.LookAt = virtualCameraParam.virtualCamera.Follow;
			GameObject gameObject = GameObject.Find("UICamera/Canvas/UIMain");
			GameObject obj = Asset.InstantiateWithoutCache("Widget/Common/Pop/BattleStart", gameObject.transform);
			output.Call(f);
			go.GetComponent<Animator>().Play("DollyTrackCamera_battle_star", 0, 0f);
			Object.Destroy(obj, 3f);
		});
	}
}
