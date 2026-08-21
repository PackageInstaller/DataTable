using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断实体类型ID(渲染)", 0)]
[Category("Render/Agent")]
[Description("判断实体类型ID")]
public class CheckRoleIDByAgentID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(entityIDInput.value);
			if (agent != null && agent.AgentConfigID == roleIDInput.value)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
