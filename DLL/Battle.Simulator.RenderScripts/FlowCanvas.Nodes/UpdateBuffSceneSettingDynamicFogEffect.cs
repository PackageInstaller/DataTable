using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("更新Buff动态雾效(渲染)", 0)]
[Category("Render/Buff/Buff特效/动态雾效")]
[Description("更新Buff动态雾效(渲染);\n配合节点【运行比率曲线值】\n自定义颜色对【Ultimate Avoid】和【Source Space】没效果, 如果之前已经添加过来, 颜色也没有用, 只有第一次添加的时候会初始化颜色")]
public class UpdateBuffSceneSettingDynamicFogEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "abnormalOut");
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentIDInput");
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID", "buffIDInput");
		ValueInput<EnMemberPositionOfFog> enMemberPositionOfFogInput = AddValueInput<EnMemberPositionOfFog>("雾效类型", "memberPositionOfFog").SetDefaultAndSerializedValue(EnMemberPositionOfFog.UltimateAvoid);
		ValueInput<bool> useCustomFogColorInput = AddValueInput<bool>("使用自定义Fog颜色").SetDefaultAndSerializedValue(v: false);
		ValueInput<Color> customFogColorInput = AddValueInput<Color>("自定义Fog颜色").SetDefaultAndSerializedValue(new Color(1f, 0f, 1f, 1f));
		ValueInput<float> IntensityInput = AddValueInput<float>("强度", "IntensityInput");
		ValueInput<EnMemberPositionOfFog> enMemberPositionOfTintInput = AddValueInput<EnMemberPositionOfFog>("氛围类型", "memberPositionOfTint").SetDefaultAndSerializedValue(EnMemberPositionOfFog.UltimateAvoid);
		ValueInput<bool> useCustomTintColorInput = AddValueInput<bool>("使用自定义Tint颜色").SetDefaultAndSerializedValue(v: false);
		ValueInput<Color> customTintColorInput = AddValueInput<Color>("自定义Tint颜色").SetDefaultAndSerializedValue(new Color(1f, 0f, 1f, 1f));
		AddFlowInput("In", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				error.Call(f);
			}
			else
			{
				NAgent agent = battleScene.GetAgentManager().GetAgent(agentIDInput.GetValue());
				if (agent == null)
				{
					error.Call(f);
				}
				else
				{
					ComponentTimeline componentTimeline = agent.ComponentTimeline;
					if (componentTimeline == null)
					{
						error.Call(f);
					}
					else
					{
						Color fogColor = Color.magenta;
						if (useCustomFogColorInput.value)
						{
							fogColor = customFogColorInput.value;
						}
						Color tintColor = Color.magenta;
						if (useCustomTintColorInput.value)
						{
							tintColor = customTintColorInput.value;
						}
						componentTimeline.UpdateBuffSceneSettingDynamicFogEffect(buffIDInput.GetValue(), enMemberPositionOfFogInput.value, IntensityInput.GetValue(), enMemberPositionOfTintInput.value, fogColor, tintColor);
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDInput.value);
		AddValueOutput("创建ID", "buffID", () => buffIDInput.GetValue());
	}
}
