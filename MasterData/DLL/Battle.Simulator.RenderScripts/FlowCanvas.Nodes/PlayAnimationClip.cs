using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放Animation组件动画", 0)]
[Category("Render/Anime")]
[Description("Animation组件动画")]
public class PlayAnimationClip : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID");
		ValueInput<string> nameInput = AddValueInput<string>("clip名字");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				output.Call(f);
			}
			else
			{
				NAgent agent = agentManager.GetAgent(agentIDInput.value);
				if (agent == null)
				{
					output.Call(f);
				}
				else
				{
					Animation component = agent.GetComponent<Animation>();
					if (component == null)
					{
						output.Call(f);
					}
					else
					{
						component.Play(nameInput.value);
						output.Call(f);
					}
				}
			}
		});
	}
}
