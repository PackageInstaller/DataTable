using P08.EnvironmentHelper;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Buff镜头故障", 0)]
[Category("Render/Buff/Buff特效/镜头故障")]
[Description("Buff镜头故障, x 轴0-1")]
public class BuffCameraGlitch : FlowNode
{
	private TimelineGlitchEffectHelper TimelineGlitchEffectHelper;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		if (TimelineGlitchEffectHelper != null)
		{
			TimelineGlitchEffectHelper = null;
		}
	}

	private TimelineGlitchEffectHelper GetExtend()
	{
		if (TimelineGlitchEffectHelper == null)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				return null;
			}
			if (battleScene.virtualCameraParam == null)
			{
				return null;
			}
			TimelineGlitchEffectHelper = Camera.main.transform.GetComponent<TimelineGlitchEffectHelper>();
		}
		return TimelineGlitchEffectHelper;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID");
		ValueInput<int> priorityInput = AddValueInput<int>("优先级");
		ValueInput<bool> botherOthersInput = AddValueInput<bool>("影响其他人的相机");
		ValueInput<AnimationCurve> glitchIntensityInput = AddValueInput<AnimationCurve>("glitchIntensity(0-1)");
		ValueInput<AnimationCurve> glitchFrequencyInput = AddValueInput<AnimationCurve>("glitchFrequency(0-30)");
		ValueInput<float> normalizeInput = AddValueInput<float>("更新进度(0-1)");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("添加", delegate(Flow f)
		{
			if (!(CheckValid(f) == null))
			{
				TimelineGlitchEffectHelper.AddGlitchEffectClip(entityIDInput.value, buffIDInput.value, float.MaxValue, 0f, 0f, priorityInput.value);
				output.Call(f);
			}
		});
		AddFlowInput("更新", delegate(Flow f)
		{
			if (!(CheckValid(f) == null))
			{
				float value = normalizeInput.value;
				float pIntensity = glitchIntensityInput.value.Evaluate(value);
				float pFrequency = glitchFrequencyInput.value.Evaluate(value);
				TimelineGlitchEffectHelper.UpdateGlitchEffect(entityIDInput.value, buffIDInput.value, 0f, pIntensity, pFrequency);
				output.Call(f);
			}
		});
		AddFlowInput("移除", delegate(Flow f)
		{
			if (!(CheckValid(f) == null))
			{
				TimelineGlitchEffectHelper.RemoveGlitchEffectClip(entityIDInput.value, buffIDInput.value);
				output.Call(f);
			}
		});
		TimelineGlitchEffectHelper CheckValid(Flow f)
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
			if (!agent.IsLocalPlayer && !botherOthersInput.value)
			{
				output.Call(f);
				return null;
			}
			TimelineGlitchEffectHelper extend = GetExtend();
			if (extend == null)
			{
				errorOut.Call(f);
				return null;
			}
			return extend;
		}
	}
}
