using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[连携奥义]是否参与(1111定制)(渲染)", 0)]
[Category("Render/奥义")]
[Description("判断1111参与配置的连携奥义,无论连携奥义是否启用;\n参与:启用奥义并且参与其中;\n未参与:启用奥义但未参与其中;\n未携带:连携奥义未配置;\nError:传入的实体ID不存在、配置了错误的连携奥义ID")]
public class IsCooperateUniqueSkillAgentOf1111 : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("参与");
		FlowOutput falseOut = AddFlowOutput("未参与");
		FlowOutput unConfig = AddFlowOutput("未携带");
		FlowOutput errorOut = AddFlowOutput("Error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			int cooperateUniqueSkillID = (NScene.GetCurrentScene() as BattleScene).ready.SceneDataForExcehange.CooperateUniqueSkillID;
			cooperate_unique_skill config;
			if (cooperateUniqueSkillID == 0)
			{
				unConfig.Call(f);
			}
			else if (!ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(cooperateUniqueSkillID, out config))
			{
				errorOut.Call(f);
			}
			else if (config.CooperateRoleIds.Contains(1111))
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
