using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改技能UI数据事件(渲染)", 0)]
[Category("Render/事件")]
[Description("修改技能UI数据事件,与【应用技能UI数据】配合使用;\nTimeineID为0则处理所有")]
public class ModifySkillButtonUIDataEvent : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private int _agentID;

	private int _id;

	private int _cd;

	private int _maxCD;

	private int _chargingCount;

	private bool _enable;

	private int _consume;

	private FlowOutput _Out;

	private ValueInput<int> _timelineIDInput;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager != null)
		{
			agentManager.ModifySkillButtonUIDataEvent = (Action<int>)Delegate.Combine(agentManager.ModifySkillButtonUIDataEvent, new Action<int>(FuncHandler));
		}
	}

	protected override void RegisterPorts()
	{
		_Out = AddFlowOutput("Out", "output");
		_timelineIDInput = AddValueInput<int>("TimelineID", "timelineID");
		AddValueOutput("实体ID", "agentID", () => _agentID);
		AddValueOutput("TimelineID", "timelineID", () => _id);
		AddValueOutput("显示的CD", "cd", () => _cd);
		AddValueOutput("显示的MaxCD", "maxCD", () => _maxCD);
		AddValueOutput("显示的次数", "chargingCount", () => _chargingCount);
		AddValueOutput("显示的激活状态", "enable", () => _enable);
		AddValueOutput("显示的消耗(值负数)", "consume", () => _consume);
	}

	public void FuncHandler(int agentID)
	{
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager != null)
		{
			NAgent agent = agentManager.GetAgent(agentID);
			if (agent != null && (_timelineIDInput.value == 0 || _timelineIDInput.value == agent.TempAbilityStatus.ID))
			{
				_agentID = agentID;
				_id = agent.TempAbilityStatus.ID;
				_cd = agent.TempAbilityStatus.CD;
				_maxCD = agent.TempAbilityStatus.MaxCD;
				_chargingCount = agent.TempAbilityStatus.ChargingCount;
				_enable = agent.TempAbilityStatus.Enable;
				_consume = agent.TempAbilityStatus.Consume;
				Flow f = new Flow
				{
					returnData = returnData
				};
				_Out.Call(f);
			}
		}
	}
}
