using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(实体类型ID&后三位ID组&时间)(渲染)", 0)]
[Category("Render/事件")]
[Description("Timeline执行时候触发")]
public class TimelineTickEvent6 : EventNode
{
	private FlowOutput m_timelineTickEventOutput;

	private ValueInput<List<int>> vInSuffix;

	private ValueInput<int> vInTime;

	private ValueInput<int> vInConfigId;

	private int m_agentID;

	private int m_timelineID;

	private int m_time;

	private int m_suffix;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		if (!(NScene.GetCurrentScene() as BattleScene == null))
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager != null)
			{
				agentManager.OnTimelineTick = (Action<int, int, int, int>)Delegate.Combine(agentManager.OnTimelineTick, new Action<int, int, int, int>(FuncHandler));
			}
		}
	}

	protected override void RegisterPorts()
	{
		vInSuffix = AddValueInput<List<int>>("技能Id后三位组", "TimelineIDsVar");
		vInTime = AddValueInput<int>("时间(毫秒)", "executeTimeVar");
		vInConfigId = AddValueInput<int>("实体类型ID", "roleId");
		m_timelineTickEventOutput = AddFlowOutput("输出", "output");
		AddValueOutput("实体ID", "agentID", () => m_agentID);
		AddValueOutput("TimelineID", "TimelineID", () => m_timelineID);
		AddValueOutput("时间(毫秒)", "time", () => m_time);
		AddValueOutput("后三位", "suffix", () => m_suffix);
	}

	public void FuncHandler(int agentID, int timelineID, int lastTime, int currentTime)
	{
		int num = timelineID % 1000;
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (vInSuffix.GetValue().Contains(num) && ((lastTime == 0 && vInTime.GetValue() == 0) || (vInTime.GetValue() > lastTime && vInTime.GetValue() <= currentTime)))
		{
			NAgent agent = agentManager.GetAgent(agentID);
			if ((object)agent != null && (vInConfigId.value == 0 || vInConfigId.value == agent.AgentConfigID))
			{
				m_agentID = agentID;
				m_timelineID = timelineID;
				m_time = currentTime;
				m_suffix = num;
				Flow f = new Flow
				{
					returnData = returnData
				};
				m_timelineTickEventOutput.Call(f);
			}
		}
	}
}
