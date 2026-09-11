using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Buff镜头升降", 0)]
[Category("Render/Buff/Buff特效/镜头升降")]
[Description("Buff镜头升降")]
public class BuffCameraCraneShot : FlowNode
{
	private CinemachineCraneShotExtension m_Extend;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		if (m_Extend != null)
		{
			m_Extend.RemoveAll();
			m_Extend = null;
		}
	}

	private CinemachineCraneShotExtension GetExtend()
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
			m_Extend = U3DUtil.Get<CinemachineCraneShotExtension>(virtualCameraParam.gameObject);
		}
		return m_Extend;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID");
		ValueInput<AnimationCurve> curveInput = AddValueInput<AnimationCurve>("曲线");
		ValueInput<int> priorityInput = AddValueInput<int>("优先级");
		ValueInput<float> slowActionTimeInput = AddValueInput<float>("缓动时间(秒)", "slowActionTime").SetDefaultAndSerializedValue(0f);
		ValueInput<float> startSlowActionTimeInput = AddValueInput<float>("起始缓动时间(秒)", "startSlowActionTime").SetDefaultAndSerializedValue(0f);
		ValueInput<bool> botherOthersInput = AddValueInput<bool>("影响其他人的相机");
		ValueInput<float> normalizeInput = AddValueInput<float>("更新进度(0-1)");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("添加", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				CameraCraneShotClip cameraCraneShotClip = buffManager.GetCameraCraneShotClip();
				cameraCraneShotClip.CaraneShotCurve = curveInput.value;
				cameraCraneShotClip.Key = buffIDInput.value;
				cameraCraneShotClip.Length = 1f;
				cameraCraneShotClip.NormalizedBegin = 0f;
				cameraCraneShotClip.NormalizedEnd = 1f;
				cameraCraneShotClip.priority = priorityInput.value;
				cameraCraneShotClip.SlowActionTime = slowActionTimeInput.value;
				cameraCraneShotClip.StartSlowActionTime = startSlowActionTimeInput.value;
				cameraCraneShotClip.botherOthers = botherOthersInput.value;
				m_Extend.AddClip(cameraCraneShotClip);
				buffManager.runningCameraCraneShotClip[cameraCraneShotClip.Key] = cameraCraneShotClip;
				output.Call(f);
			}
		});
		AddFlowInput("更新", delegate(Flow f)
		{
			BuffManager buffManager = CheckValid(f);
			if (buffManager != null)
			{
				if (!buffManager.runningCameraCraneShotClip.TryGetValue(buffIDInput.value, out var value) || value == null)
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
				if (!buffManager.runningCameraCraneShotClip.TryGetValue(buffIDInput.value, out var value))
				{
					errorOut.Call(f);
				}
				else
				{
					buffManager.runningCameraCraneShotClip.Remove(buffIDInput.value);
					if (value == null)
					{
						errorOut.Call(f);
					}
					else
					{
						m_Extend.RemoveClip(value);
						buffManager.ReturnCameraCraneShotClip(value);
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
