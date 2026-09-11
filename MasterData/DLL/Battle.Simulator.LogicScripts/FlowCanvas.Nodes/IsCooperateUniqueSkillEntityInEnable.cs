using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[连携奥义]是否参与(需启用)(逻辑)", 0)]
[Category("Logic/奥义")]
[Description("判断实体是否参与配置的连携奥义,该节点增加连携奥义启用检查;\n参与:启用奥义并且参与其中;\n未参与:启用奥义但未参与其中;\n未启用:连携奥义配置了但是未启用,该分支无法确定是否参与其中;\n未携带:连携奥义未配置;\nError:传入的实体ID不存在、配置了错误的连携奥义ID")]
public class IsCooperateUniqueSkillEntityInEnable : FlowControlNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		FlowOutput trueOut = AddFlowOutput("参与", "true");
		FlowOutput falseOut = AddFlowOutput("未参与", "false");
		FlowOutput unableOut = AddFlowOutput("未启用", "unable");
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
				else if (simWorldState.m_cooperateUniqueSkillIsActive <= 0)
				{
					unableOut.Call(f);
				}
				else if (config.CooperateRoleIds.Contains(entityWithEntityID.entityConfig.mId))
				{
					trueOut.Call(f);
				}
				else
				{
					falseOut.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
	}
}
