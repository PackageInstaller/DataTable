using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能结束事件(渲染)后三位", 0)]
[Category("Render/事件")]
[Description("Timeline结束时候触发的事件")]
public class TimelineFinishEventWithShortAbilityID : EventNode
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

	public void FuncHandler(int agentID, int lastTimelineID, int nextTimelineID)
	{
		if (NScene.GetCurrentScene() as BattleScene == null)
		{
			return;
		}
		AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
		if (agentManager == null)
		{
			return;
		}
		NAgent agent = agentManager.GetAgent(agentID);
		if (!(agent == null))
		{
			int num = lastTimelineID % (agent.AgentConfigID * 1000);
			if (lastTimelineID != nextTimelineID && num == m_timelineIDVar.GetValue())
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

	protected override void RegisterPorts()
	{
		m_timelineIDVar = AddValueInput<int>("TimelineID后三位", "TimelineIDVar");
		m_output = AddFlowOutput("输出", "output");
		AddValueOutput("实体ID", "agentID", () => m_agentID);
		AddValueOutput("进入TimelineID", "NextTimelineID", () => m_nextTimelineID);
	}
}
