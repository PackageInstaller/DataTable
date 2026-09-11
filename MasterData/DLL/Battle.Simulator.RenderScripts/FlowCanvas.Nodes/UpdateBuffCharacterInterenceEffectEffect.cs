using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("更新Buff角色干涉特效(渲染)", 0)]
[Category("Render/Buff/Buff特效/角色干涉特效")]
[Description("更新Buff角色干涉特效(渲染);\n配合节点【运行比率曲线值】")]
public class UpdateBuffCharacterInterenceEffectEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "abnormalOut");
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentIDInput");
		ValueInput<int> buffIDInput = AddValueInput<int>("创建ID", "buffIDInput");
		ValueInput<float> IntensityInput = AddValueInput<float>("强度", "IntensityInput");
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
						componentTimeline.UpdateBuffCharacterInterenceEffect(buffIDInput.GetValue(), IntensityInput.GetValue());
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDInput.value);
		AddValueOutput("创建ID", "buffID", () => buffIDInput.GetValue());
	}
}
