using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取胸部位置", 0)]
[Category("Render/Agent")]
[Description("获取胸部位置")]
public class GetAgentChestPosition : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID");
		AddValueOutput("位置", delegate
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			return (agent != null) ? agent.ChestPosition : Vector3.zero;
		});
	}
}
