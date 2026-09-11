using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取Agent释放的技能", 0)]
[Category("Render/Agent")]
[Description("获取Agent释放的技能")]
[ExposeAsDefinition]
public class GetAgentAbility : FlowControlNode
{
	private int skillId;

	private int frameTime;

	protected override void RegisterPorts()
	{
		ValueInput<int> agentId = AddValueInput<int>("实体Id");
		FlowOutput flowOutput = AddFlowOutput(" ");
		AddValueOutput("技能Id", () => skillId);
		AddValueOutput("技能FrameTime", () => frameTime);
		AddFlowInput(" ", delegate(Flow f)
		{
			skillId = ((NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentId.value).Blackboard as BBHumanoid).m_NextSimFrameData.mAbilityID;
			frameTime = ((NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentId.value).Blackboard as BBHumanoid).m_NextSimFrameData.AbilityTime;
			flowOutput.Call(f);
		});
	}
}
