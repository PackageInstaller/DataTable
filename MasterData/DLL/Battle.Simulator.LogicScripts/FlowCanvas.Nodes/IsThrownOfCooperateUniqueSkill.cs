using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("是否为连携奥义抛掷物(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("为本场战斗使用的连携奥义抛掷物则走True,否则走 False\n未携带连携时会走error")]
public class IsThrownOfCooperateUniqueSkill : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> thrownTimelineID = AddValueInput<int>("抛掷物TimelineID", "thrownTimelineID");
		FlowOutput trueOut = AddFlowOutput("True", "true");
		FlowOutput falseOut = AddFlowOutput("False", "false");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			int cooperateUniqueSkillID = base.mSimContext.sEntityWorldState.status.m_CooperateUniqueSkillID;
			cooperate_unique_skill config;
			if (cooperateUniqueSkillID == 0)
			{
				errorOut.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(cooperateUniqueSkillID, out config))
			{
				errorOut.Call(f);
			}
			else if (!config.CooperateThrownIds.Contains(thrownTimelineID.value))
			{
				falseOut.Call(f);
			}
			else
			{
				trueOut.Call(f);
			}
		});
	}
}
