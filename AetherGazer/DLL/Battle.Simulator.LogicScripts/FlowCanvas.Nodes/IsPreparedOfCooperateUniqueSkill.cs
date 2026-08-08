using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[连携奥义]是否可以释放(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("可以释放:如题;\n不可释放:如题;\n未启用:连携已配置未启用;\n未携带:未配置;\nError:配置错误")]
public class IsPreparedOfCooperateUniqueSkill : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("可以释放", "true");
		FlowOutput falseOut = AddFlowOutput("不可释放", "false");
		FlowOutput unableOut = AddFlowOutput("未启用", "unable");
		FlowOutput unConfig = AddFlowOutput("未携带", "unConfig");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimWorldState simWorldState = base.mSimContext.sEntityWorldState.status;
			cooperate_unique_skill config;
			if (simWorldState.m_CooperateUniqueSkillID == 0)
			{
				unConfig.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(simWorldState.m_CooperateUniqueSkillID, out config))
			{
				errorOut.Call(f);
			}
			else if (simWorldState.m_cooperateUniqueSkillIsActive <= 0)
			{
				unableOut.Call(f);
			}
			else if (simWorldState.m_cooperateUniqueSkillVaild)
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
