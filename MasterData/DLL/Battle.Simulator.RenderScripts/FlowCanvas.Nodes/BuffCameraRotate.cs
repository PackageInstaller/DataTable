using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Buff镜头旋转", 0)]
[Category("Render/Buff/Buff特效/镜头旋转")]
[Description("Buff镜头旋转")]
public class BuffCameraRotate : FlowNode
{
	private CinemachineRotateExtension m_Extend;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		if (m_Extend != null)
		{
			m_Extend.RemoveAll();
			m_Extend = null;
		}
	}

	private CinemachineRotateExtension GetExtend()
	{
		if (m_Extend == null)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				return null;
			}
			CameraParamComponent virtualCameraParam = battleScene.virtualCameraParam;
			if (virtualCameraParam == null)
			{
				return null;
			}
			m_Extend = U3DUtil.Get<CinemachineRotateExtension>(virtualCameraParam.gameObject);
		}
		return m_Extend;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID");
		ValueInput<int> priorityInput = AddValueInput<int>("优先级");
		ValueInput<float> slowActionTimeInput = AddValueInput<float>("缓动时间(秒)", "slowActionTime").SetDefaultAndSerializedValue(0f);
		ValueInput<float> startSlowActionTimeInput = AddValueInput<float>("起始缓动时间(秒)", "startSlowActionTime").SetDefaultAndSerializedValue(0f);
		ValueInput<bool> botherOthersInput = AddValueInput<bool>("影响其他人的相机");
		ValueInput<AnimationCurve> curveXInput = AddValueInput<AnimationCurve>("曲线x");
		ValueInput<AnimationCurve> curveYInput = AddValueInput<AnimationCurve>("曲线y");
		ValueInput<AnimationCurve> curveZInput = AddValueInput<AnimationCurve>("曲线z");
		ValueInput<float> normalizeInput = AddValueInput<float>("更新进度(0-1)");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("添加", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				CameraRotateClip cameraRotateClip = buffManager.GetCameraRotateClip();
				cameraRotateClip.curveX = curveXInput.value;
				cameraRotateClip.curveY = curveYInput.value;
				cameraRotateClip.curveZ = curveZInput.value;
				cameraRotateClip.Key = buffIDInput.value;
				cameraRotateClip.Length = 1f;
				cameraRotateClip.NormalizedBegin = 0f;
				cameraRotateClip.NormalizedEnd = 1f;
				cameraRotateClip.priority = priorityInput.value;
				cameraRotateClip.SlowActionTime = slowActionTimeInput.value;
				cameraRotateClip.StartSlowActionTime = startSlowActionTimeInput.value;
				cameraRotateClip.botherOthers = botherOthersInput.value;
				m_Extend.AddClip(cameraRotateClip);
				buffManager.runningCameraRotateClip[cameraRotateClip.Key] = cameraRotateClip;
				output.Call(f);
			}
		});
		AddFlowInput("更新", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				if (!buffManager.runningCameraRotateClip.TryGetValue(buffIDInput.value, out var value) || value == null)
				{
					errorOut.Call(f);
				}
				else
				{
					m_Extend.TickClipNormalized(value, normalizeInput.value);
					output.Call(f);
				}
			}
		});
		AddFlowInput("移除", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				if (!buffManager.runningCameraRotateClip.TryGetValue(buffIDInput.value, out var value))
				{
					errorOut.Call(f);
				}
				else
				{
					buffManager.runningCameraRotateClip.Remove(buffIDInput.value);
					if (value == null)
					{
						errorOut.Call(f);
					}
					else
					{
						m_Extend.RemoveClip(value);
						buffManager.ReturnCameraRotateClip(value);
						output.Call(f);
					}
				}
			}
		});
		BuffManager CheckValid(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				errorOut.Call(f);
				return null;
			}
			NAgent agent = agentManager.GetAgent(entityIDInput.value);
			if (agent == null)
			{
				errorOut.Call(f);
				return null;
			}
			if (GetExtend() == null)
			{
				errorOut.Call(f);
				return null;
			}
			if (!agent.IsLocalPlayer && !botherOthersInput.value)
			{
				output.Call(f);
				return null;
			}
			BuffManager buffManager = BuffManager.GetBuffManager();
			if (buffManager == null)
			{
				errorOut.Call(f);
				return null;
			}
			return buffManager;
		}
	}
}
