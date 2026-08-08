using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[连携奥义]尝试启用(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("成功:计数+1，且从禁用变为启用;\n失败:计数+1，但仍是禁用状态;\n已启用:计数+1，但本来就是启用状态;\n未携带:连携奥义ID为0;\nError:表里不存在该连携奥义ID")]
public class TryEnableCooperateUniqueSkill : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput succeedOut = AddFlowOutput("成功", "succeed");
		FlowOutput faildOut = AddFlowOutput("失败", "faild");
		FlowOutput enabledOut = AddFlowOutput("已启用", "enable");
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
			else
			{
				bool flag = simWorldState.m_cooperateUniqueSkillIsActive > 0;
				simWorldState.m_cooperateUniqueSkillIsActive++;
				bool flag2 = simWorldState.m_cooperateUniqueSkillIsActive > 0;
				if (flag != flag2)
				{
					base.mSimContext.GetSimInterface().mCooperateUniqueSkillStatusChangeEvent?.Invoke(flag2, simWorldState.m_CooperateUniqueSkillID);
					succeedOut.Call(f);
				}
				else if (flag)
				{
					enabledOut.Call(f);
				}
				else
				{
					faildOut.Call(f);
				}
			}
		});
	}
}
