using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[连携奥义]尝试禁用(实体ID)(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("成功:计数-1，且从启用变为禁用;\n失败:计数-1，但仍是启用状态;\n未启用:计数-1，但本来就是禁用状态;\n未参与:非传入实体参与的连携,放弃禁用;\n未携带:连携奥义ID为0;\nError:实体为空、连携技ID不存在")]
public class TryDisableCooperateUniqueSkillWithEntityID : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput succeedOut = AddFlowOutput("成功", "succeed");
		FlowOutput faildOut = AddFlowOutput("失败", "faild");
		FlowOutput unableOut = AddFlowOutput("未启用", "unable");
		FlowOutput nonmemberOut = AddFlowOutput("未参与", "nonmember");
		FlowOutput unConfig = AddFlowOutput("未携带", "unConfig");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBlackboard)
			{
				errorOut.Call(f);
			}
			else
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
				else if (!config.CooperateRoleIds.Contains(entityWithEntityID.entityConfig.mId))
				{
					nonmemberOut.Call(f);
				}
				else
				{
					bool flag = simWorldState.m_cooperateUniqueSkillIsActive > 0;
					simWorldState.m_cooperateUniqueSkillIsActive += -1;
					bool flag2 = simWorldState.m_cooperateUniqueSkillIsActive > 0;
					if (flag != flag2)
					{
						base.mSimContext.GetSimInterface().mCooperateUniqueSkillStatusChangeEvent?.Invoke(flag2, simWorldState.m_CooperateUniqueSkillID);
						succeedOut.Call(f);
					}
					else if (!flag)
					{
						unableOut.Call(f);
					}
					else
					{
						faildOut.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", "entityID", (string f) => entityIDInput.value);
	}
}
