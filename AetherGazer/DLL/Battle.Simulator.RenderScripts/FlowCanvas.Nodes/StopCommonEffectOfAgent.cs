using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除特效(通用)(受管控)(渲染)", 0)]
[Category("Render/函数")]
[Description("停止【创建特效(通用)(受管控)】节点创建出来的特效\n特效路径对应【创建特效(通用)(受管控)】中的路径字段")]
public class StopCommonEffectOfAgent : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentID");
		ValueInput<string> effectNameInput = AddValueInput<string>("路径", "effectName");
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
				agent.ComponentTimeline.StopCommonEffect(effectNameInput.value);
				Out.Call(f);
			}
		});
	}
}
