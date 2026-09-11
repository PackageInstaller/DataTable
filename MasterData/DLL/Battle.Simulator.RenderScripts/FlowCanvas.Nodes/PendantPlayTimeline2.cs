using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("渲染挂件播放Timeline(挂件ID)", 0)]
[Category("Render/事件")]
[Description("渲染层挂件播放传入的TimelineID对应的Timeline")]
public class PendantPlayTimeline2 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentID");
		ValueInput<int> pendantIDInput = AddValueInput<int>("挂件ID", "pendantIDVar");
		ValueInput<int> timelineIDInput = AddValueInput<int>("TimelineID", "timelineIDVar");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null)
			{
				errorOut.Call(f);
			}
			else
			{
				List<IPendant>.Enumerator enumerator = agent.gameObject.GetComponent<ComponentPendant>().GetPendants().GetEnumerator();
				while (enumerator.MoveNext())
				{
					RenderPendant renderPendant = enumerator.Current as RenderPendant;
					if (renderPendant != null && renderPendant.PendantID == pendantIDInput.value)
					{
						renderPendant.PlayTimeline(timelineIDInput.GetValue());
					}
				}
				output.Call(f);
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDInput.value);
		AddValueOutput("挂件ID", "pendantID", () => pendantIDInput.value);
	}
}
