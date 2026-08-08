using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除Buff动态雾效(渲染)", 0)]
[Category("Render/Buff/Buff特效/动态雾效")]
[Description("移除BUFFID对应动态雾效(渲染)")]
public class RemoveBuffSceneSettingDynamicFogEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentIDInput");
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID", "buffIDInput");
		ValueInput<EnMemberPositionOfFog> enMemberPositionOfFogInput = AddValueInput<EnMemberPositionOfFog>("雾效类型", "memberPositionOfFog").SetDefaultAndSerializedValue(EnMemberPositionOfFog.UltimateAvoid);
		ValueInput<EnMemberPositionOfFog> enMemberPositionOfTintInput = AddValueInput<EnMemberPositionOfFog>("氛围类型", "memberPositionOfTint").SetDefaultAndSerializedValue(EnMemberPositionOfFog.UltimateAvoid);
		AddFlowInput("In", "input", delegate(Flow f)
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
						componentTimeline.RemoveBuffSceneSettingDynamicFogEffect(buffIDInput.GetValue(), enMemberPositionOfFogInput.value, enMemberPositionOfTintInput.value);
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "AgentID", () => agentIDInput.value);
		AddValueOutput("创建ID", "buffID", () => buffIDInput.GetValue());
	}
}
