using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Buff角色切片效果(渲染)", 0)]
[Category("Render/Buff/Buff特效/角色切片效果")]
[Description("增加Buff角色切片效果(渲染)")]
public class BuffCharacterSliceEffectProcessor : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput m_output = AddFlowOutput("Out");
		FlowOutput m_error = AddFlowOutput("Error");
		ValueInput<int> m_agentIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> m_buffCreationIndexInput = AddValueInput<int>("创建ID");
		ValueInput<int> m_orderInput = AddValueInput<int>("等级(播最大的)").SetDefaultAndSerializedValue(1);
		ValueInput<float> m_offsetInput = AddValueInput<float>("Offset");
		ValueInput<float> m_rangeInput = AddValueInput<float>("Range");
		ValueInput<float> m_densityInput = AddValueInput<float>("Desnsity");
		ValueInput<float> m_speedInput = AddValueInput<float>("Speed");
		AddFlowInput("增加", delegate(Flow f)
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(m_agentIDInput.GetValue());
			if (agent == null)
			{
				m_error.Call(f);
			}
			else if (agent.ComponentTimeline == null || agent.ComponentTimeline.TimelinePlayer == null)
			{
				m_error.Call(f);
			}
			else
			{
				TimelineCharacterSliceEffectClipPlayer timelineCharacterSliceEffectClipPlayer = agent.ComponentTimeline.TimelinePlayer.timelineCharacterSliceEffectClipPlayer;
				if (timelineCharacterSliceEffectClipPlayer == null)
				{
					m_error.Call(f);
				}
				else
				{
					timelineCharacterSliceEffectClipPlayer.AddBuffEffect(m_buffCreationIndexInput.GetValue(), m_orderInput.GetValue(), m_offsetInput.value, m_rangeInput.value, m_densityInput.value, m_speedInput.value);
					m_output.Call(f);
				}
			}
		});
		AddFlowInput("更新", delegate(Flow f)
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(m_agentIDInput.GetValue());
			if (agent == null)
			{
				m_error.Call(f);
			}
			else if (agent.ComponentTimeline == null || agent.ComponentTimeline.TimelinePlayer == null)
			{
				m_error.Call(f);
			}
			else
			{
				TimelineCharacterSliceEffectClipPlayer timelineCharacterSliceEffectClipPlayer = agent.ComponentTimeline.TimelinePlayer.timelineCharacterSliceEffectClipPlayer;
				if (timelineCharacterSliceEffectClipPlayer == null)
				{
					m_error.Call(f);
				}
				else
				{
					timelineCharacterSliceEffectClipPlayer.UpdateBuffEffect(m_buffCreationIndexInput.GetValue(), m_offsetInput.value, m_rangeInput.value, m_densityInput.value, m_speedInput.value);
					m_output.Call(f);
				}
			}
		});
		AddFlowInput("移除", delegate(Flow f)
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(m_agentIDInput.GetValue());
			if (agent == null)
			{
				m_error.Call(f);
			}
			else if (agent.ComponentTimeline == null || agent.ComponentTimeline.TimelinePlayer == null)
			{
				m_error.Call(f);
			}
			else
			{
				TimelineCharacterSliceEffectClipPlayer timelineCharacterSliceEffectClipPlayer = agent.ComponentTimeline.TimelinePlayer.timelineCharacterSliceEffectClipPlayer;
				if (timelineCharacterSliceEffectClipPlayer == null)
				{
					m_error.Call(f);
				}
				else
				{
					timelineCharacterSliceEffectClipPlayer.RemoveBuffEffect(m_buffCreationIndexInput.GetValue());
					m_output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", () => m_agentIDInput.GetValue());
		AddValueOutput("创建ID", () => m_buffCreationIndexInput.GetValue());
	}
}
