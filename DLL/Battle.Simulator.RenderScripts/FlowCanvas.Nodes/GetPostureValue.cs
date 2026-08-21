using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取霸体值(过时)", 0)]
[Category("Render/Agent")]
[Description("获取霸体值")]
public class GetPostureValue : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDInput = AddValueInput<int>("AgentID");
		AddValueOutput("AgentID", () => agentIDInput.value);
		long maxPostureValue = 0L;
		long postureValue = 0L;
		AddValueOutput("霸体值", () => postureValue);
		AddValueOutput("最大霸体值", () => maxPostureValue);
		AddFlowOutput("");
		AddFlowInput("", delegate
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			maxPostureValue = (agent.Blackboard as BBHumanoid).m_LastSimFrameData.mMaxExposedValue;
			postureValue = (agent.Blackboard as BBHumanoid).m_LastSimFrameData.mExposedValue;
		});
	}
}
