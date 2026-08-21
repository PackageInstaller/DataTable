using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置trigger特殊指示器", 0)]
[Category("Render/UI")]
[Description("设置特殊指示器")]
public class SetLocalIndicator : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentInput = AddValueInput<int>("triggerID");
		ValueInput<string> pathInput = AddValueInput<string>("指示器路径", "path").SetDefaultAndSerializedValue("UI/DirectionIndicatorUI");
		ValueInput<Vector3> posInput = AddValueInput<Vector3>("POS");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager != null)
			{
				NAgent playerAgent = agentManager.GetPlayerAgent();
				if (playerAgent != null && playerAgent.ComponentTimeline != null && playerAgent.ComponentTimeline.m_componentIndicator != null)
				{
					playerAgent.ComponentTimeline.m_componentIndicator.AddLocalIndicator(posInput.value, pathInput.value, agentInput.value);
				}
			}
			output.Call(f);
		});
	}
}
