using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("开关实体预警特效", 0)]
[Category("Render/Effect")]
[Description("开关实体预警特效")]
public class SetIsPlayEarlyWarning : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("agentID");
		ValueInput<bool> activeInput = AddValueInput<bool>("是否开启预警").SetDefaultAndSerializedValue(v: true);
		FlowOutput output = AddFlowOutput("out");
		AddFlowInput("in", delegate(Flow f)
		{
			NAgent agent = AgentManager.GetAgentManager().GetAgent(agentIDInput.value);
			if (agent != null)
			{
				agent.ComponentTimeline.TimelinePlayer.SetEarlyWarningPlay(activeInput.value);
			}
			output.Call(f);
		});
	}
}
