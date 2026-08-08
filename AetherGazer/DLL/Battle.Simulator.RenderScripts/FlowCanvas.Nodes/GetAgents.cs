using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("通过实体类型ID获取所有Agent", 0)]
[Category("Render/Agent")]
[Description("通过实体类型ID获取所有Agent")]
[ExposeAsDefinition]
public class GetAgents : FlowControlNode
{
	private int entityId;

	protected override void RegisterPorts()
	{
		ValueInput<int> agentConfigId = AddValueInput<int>("实体类型ID", "角色类型");
		FlowOutput flowOutput = AddFlowOutput(" ");
		AddValueOutput("实体ID:", () => entityId);
		AddFlowInput("In", delegate(Flow f)
		{
			foreach (KeyValuePair<int, NAgent> item in (NScene.GetCurrentScene() as BattleScene).GetAgentManager().mAgentsCreatedThisFrame)
			{
				if (item.Value.AgentConfigID == agentConfigId.value)
				{
					entityId = item.Key;
					flowOutput.Call(f);
				}
			}
		});
	}
}
