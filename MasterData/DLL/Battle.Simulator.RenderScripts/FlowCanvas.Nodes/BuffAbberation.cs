using P08.EnvironmentHelper;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Buff画面分离", 0)]
[Category("Render/Buff/Buff特效/画面分离")]
[Description("Buff画面分离")]
public class BuffAbberation : FlowNode
{
	private TimelineAbberationEffectHelper TimelineAbberationEffectHelper;

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		if (TimelineAbberationEffectHelper != null)
		{
			TimelineAbberationEffectHelper = null;
		}
	}

	private TimelineAbberationEffectHelper GetExtend()
	{
		if (TimelineAbberationEffectHelper == null)
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
			TimelineAbberationEffectHelper = Camera.main.transform.GetComponent<TimelineAbberationEffectHelper>();
		}
		return TimelineAbberationEffectHelper;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID");
		ValueInput<int> priorityInput = AddValueInput<int>("优先级");
		ValueInput<bool> botherOthersInput = AddValueInput<bool>("影响其他人的相机");
		ValueInput<AnimationCurve> abberationIntensityInput = AddValueInput<AnimationCurve>("强度(0-1)");
		ValueInput<float> normalizeInput = AddValueInput<float>("更新进度(0-1)");
		FlowOutput output = AddFlowOutput("");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("添加", delegate(Flow f)
		{
			if (!(CheckValid(f) == null))
			{
				TimelineAbberationEffectHelper.AddAbberationEffectClip(entityIDInput.value, buffIDInput.value, float.MaxValue, 0f, pIsActive: true, priorityInput.value);
				output.Call(f);
			}
		});
		AddFlowInput("更新", delegate(Flow f)
		{
			if (!(CheckValid(f) == null))
			{
				float value = normalizeInput.value;
				float pIntensity = abberationIntensityInput.value.Evaluate(value);
				TimelineAbberationEffectHelper.UpdateAbberationEffect(entityIDInput.value, buffIDInput.value, pIntensity, 0f, pIsActive: true);
				output.Call(f);
			}
		});
		AddFlowInput("移除", delegate(Flow f)
		{
			if (!(CheckValid(f) == null))
			{
				TimelineAbberationEffectHelper.RemoveAbberationEffectClip(entityIDInput.value, buffIDInput.value);
				output.Call(f);
			}
		});
		TimelineAbberationEffectHelper CheckValid(Flow f)
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
			TimelineAbberationEffectHelper extend = GetExtend();
			if (extend == null)
			{
				errorOut.Call(f);
				return null;
			}
			return extend;
		}
	}
}
