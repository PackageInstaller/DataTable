using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除特效(所有Timeline释放)(渲染)", 0)]
[Category("Render/函数")]
[Description("移除掉 Agent 身上所有由Timeline创建的特效")]
public class CleanAllTimelineEffectOfAgent : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentID");
		FlowOutput Out = AddFlowOutput("Out", "output");
		FlowOutput Error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null)
			{
				Error.Call(f);
			}
			else
			{
				agent.ComponentTimeline.StopAllTimelineEffect();
				Out.Call(f);
			}
		});
	}
}
