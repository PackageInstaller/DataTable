using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("增加Buff外发光(渲染)", 0)]
[Category("Render/Buff/Buff特效/外发光")]
[Description("BUFF使角色外发光")]
public class AddBuffCharacterRimLightEffect : FlowControlNode
{
	private ValueInput<int> m_orderInput;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput abnormalOut = AddFlowOutput("异常");
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "AgentID");
		ValueInput<int> buffIDVar = AddValueInput<int>("创建ID", "BuffID");
		ValueInput<float> ratioVar = AddValueInput<float>("ratio");
		ValueInput<float> softVar = AddValueInput<float>("soft", "soft").SetDefaultAndSerializedValue(2f);
		ValueInput<Color> outerVar = AddValueInput<Color>("outer");
		ValueInput<Color> innerVar = AddValueInput<Color>("inner");
		m_orderInput = AddValueInput<int>("等级(播最大的)", "orderInput").SetDefaultAndSerializedValue(1);
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
						componentTimeline.AddBuffRimLight(buffIDVar.GetValue(), ratioVar.GetValue(), softVar.GetValue(), outerVar.GetValue(), innerVar.GetValue(), m_orderInput.GetValue());
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("AgentID", () => agentIDVar.value);
	}
}
