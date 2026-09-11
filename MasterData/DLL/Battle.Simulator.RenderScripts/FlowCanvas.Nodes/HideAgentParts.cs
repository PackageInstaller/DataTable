using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("控制角色部件隐藏(过时)", 0)]
[Category("Render/Agent")]
[Description("Hide Agnet")]
public class HideAgentParts : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID");
		AddValueOutput("AgentID", () => agentIDInput.value);
		ValueInput<string> pathInput = AddValueInput<string>("路径");
		ValueInput<bool> hidenInput = AddValueInput<bool>("是否显示");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			if (agent != null)
			{
				agent.transform.Find(pathInput.value).GetComponent<Renderer>().enabled = hidenInput.value;
			}
			f.Call(output);
		});
	}
}
