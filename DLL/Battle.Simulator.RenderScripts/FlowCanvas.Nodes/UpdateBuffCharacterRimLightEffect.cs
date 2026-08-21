using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("更新Buff外发光(渲染)", 0)]
[Category("Render/Buff/Buff特效/外发光")]
[Description("更新BUFFID对应外发光数据(Render)")]
public class UpdateBuffCharacterRimLightEffect : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput abnormalOut = AddFlowOutput("异常", "abnormalOut");
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "agentIDVar");
		ValueInput<int> buffIDVar = AddValueInput<int>("创建ID", "buffIDVar");
		ValueInput<float> radioVar = AddValueInput<float>("Radio", "radioVar");
		ValueInput<float> softVar = AddValueInput<float>("Soft", "soft").SetDefaultAndSerializedValue(2f);
		AddFlowInput("In", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				NAgent agent = battleScene.GetAgentManager().GetAgent(agentIDVar.GetValue());
				if (agent == null)
				{
					abnormalOut.Call(f);
				}
				else
				{
					ComponentTimeline componentTimeline = agent.ComponentTimeline;
					if (componentTimeline == null)
					{
						abnormalOut.Call(f);
					}
					else
					{
						componentTimeline.UpdateBuffRimLight(buffIDVar.GetValue(), radioVar.GetValue(), softVar.GetValue());
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDVar.value);
		AddValueOutput("创建ID", "buffID", () => buffIDVar.GetValue());
	}
}
