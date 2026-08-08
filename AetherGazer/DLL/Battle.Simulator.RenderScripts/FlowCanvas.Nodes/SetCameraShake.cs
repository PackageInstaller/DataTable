using Cinemachine;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置相机震动", 0)]
[Category("Render/Camera")]
[Description("设置相机震动")]
public class SetCameraShake : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID");
		AddValueOutput("AgentID", () => agentIDInput.value);
		ValueInput<string> profileNameInput = AddValueInput<string>("ProfileName").SetDefaultAndSerializedValue("Camera/Noise/6D_Shake");
		ValueInput<float> amplitudeGainInput = AddValueInput<float>("AmplitudeGain");
		ValueInput<float> frequencyGainInput = AddValueInput<float>("FrequencyGain");
		ValueInput<int> priorityInput = AddValueInput<int>("优先级");
		ValueInput<bool> botherOthersInput = AddValueInput<bool>("全局震动");
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetPlayerAgent();
			if (playerAgent == null || (playerAgent.AgentID != agentIDInput.value && !botherOthersInput.value))
			{
				output.Call(f);
			}
			else
			{
				CinemachineBasicMultiChannelPerlin cinemachineComponent = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.virtualCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
				if (null == cinemachineComponent)
				{
					output.Call(f);
				}
				else
				{
					playerAgent.GetComponent<ComponentCameraAnimation>().SetCameraShake(cinemachineComponent, new TimelineCameraClip
					{
						duration = 1f,
						noiseProfilePath = ((profileNameInput.value == null) ? "" : profileNameInput.value),
						amplitude = amplitudeGainInput.value,
						frequency = frequencyGainInput.value,
						priority = priorityInput.value,
						key = buffIDInput.value
					});
					output.Call(f);
				}
			}
		});
	}
}
