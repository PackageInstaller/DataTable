using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能开始事件(渲染)", 0)]
[Category("Render/事件")]
[Description("Timeline开始时候触发的事件")]
public class TimelineStartEvent : EventNode
{
	private ValueInput<int> m_timelineIDVar;

	private FlowOutput m_output;

	private int m_agentID;

	private int m_lastTimelineID;

	private int m_nextTimelineID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		if (!(NScene.GetCurrentScene() as BattleScene == null))
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager != null)
			{
				agentManager.OnTimelinePlay = (Action<int, int, int>)Delegate.Combine(agentManager.OnTimelinePlay, new Action<int, int, int>(FuncHandler));
			}
		}
	}

	protected override void RegisterPorts()
	{
		m_timelineIDVar = AddValueInput<int>("TimelineID", "TimelineIDVar");
		m_output = AddFlowOutput("输出", "output");
		AddValueOutput("实体ID", "agentID", () => m_agentID);
		AddValueOutput("离开TimelineID", "LastTimelineID", () => m_lastTimelineID);
	}

	public void FuncHandler(int agentID, int lastTimelineID, int nextTimelineID)
	{
		if (nextTimelineID == m_timelineIDVar.GetValue())
		{
			m_agentID = agentID;
			m_lastTimelineID = lastTimelineID;
			m_nextTimelineID = nextTimelineID;
			Flow f = new Flow
			{
				returnData = returnData
			};
			m_output.Call(f);
		}
	}
}
