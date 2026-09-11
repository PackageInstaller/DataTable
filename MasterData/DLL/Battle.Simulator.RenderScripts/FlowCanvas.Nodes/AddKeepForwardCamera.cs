using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("创建锁定朝向相机", 0)]
[Category("Render/Camera")]
[Description("创建锁定朝向相机")]
public class AddKeepForwardCamera : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<string> pathInput = AddValueInput<string>("资源路径").SetDefaultAndSerializedValue("Camera/KeepForwardCamera");
		GameObject res = null;
		AddValueOutput("资源", () => res);
		ValueInput<Vector3> followOffsetInput = AddValueInput<Vector3>("相对位置").SetDefaultAndSerializedValue(new Vector3(0f, 3f, -10f));
		ValueInput<float> fovInput = AddValueInput<float>("FOV").SetDefaultAndSerializedValue(50f);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager.mPlayerAgentID != entityIDInput.value)
			{
				f.Call(output);
			}
			else
			{
				NAgent playerAgent = agentManager.GetPlayerAgent();
				res = Asset.Instantiate(pathInput.value);
				if (res != null)
				{
					CinemachineVirtualCamera component = res.GetComponent<CinemachineVirtualCamera>();
					if (component != null)
					{
						CinemachineOrbitalTransposer cinemachineComponent = component.GetCinemachineComponent<CinemachineOrbitalTransposer>();
						CinemachineComposer cinemachineComponent2 = component.GetCinemachineComponent<CinemachineComposer>();
						component.m_Lens.FieldOfView = fovInput.value;
						component.LookAt = playerAgent.transform;
						component.Follow = playerAgent.transform;
						if (cinemachineComponent != null && cinemachineComponent2 != null)
						{
							cinemachineComponent.m_FollowOffset = followOffsetInput.value;
						}
					}
				}
				f.Call(output);
			}
		});
	}
}
