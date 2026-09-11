using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("应用技能UI数据(渲染)", 0)]
[Category("Render/UI")]
[Description("应用技能UI数据,与【修改技能UI数据事件】配合使用")]
public class ApplySkillButtonUIData : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID", "agentID");
		ValueInput<int> timelineIDInput = AddValueInput<int>("TimelineID", "timelineID");
		ValueInput<int> cdInput = AddValueInput<int>("显示的CD", "cd");
		ValueInput<int> maxCDInput = AddValueInput<int>("显示的MaxCD", "maxCd");
		ValueInput<int> chargingCountInput = AddValueInput<int>("显示的次数", "chargingCountInput");
		ValueInput<bool> enableInput = AddValueInput<bool>("显示的激活状态", "enable");
		ValueInput<int> consumeInput = AddValueInput<int>("显示的消耗(值负数)", "consume");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			AgentManager agentManager = AgentManager.GetAgentManager();
			if (agentManager == null)
			{
				errorOut.Call(f);
			}
			else
			{
				NAgent agent = agentManager.GetAgent(agentIDInput.value);
				if (agent == null)
				{
					errorOut.Call(f);
				}
				else
				{
					AbilityStatueInfo tempAbilityStatus = agent.TempAbilityStatus;
					tempAbilityStatus.ID = timelineIDInput.value;
					tempAbilityStatus.CD = cdInput.value;
					tempAbilityStatus.MaxCD = maxCDInput.value;
					tempAbilityStatus.ChargingCount = chargingCountInput.value;
					tempAbilityStatus.Enable = enableInput.value;
					tempAbilityStatus.Consume = consumeInput.value;
					agent.TempAbilityStatus = tempAbilityStatus;
					output.Call(f);
				}
			}
		});
	}
}
