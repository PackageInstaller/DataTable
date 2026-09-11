using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能切换事件(渲染)", 0)]
[Category("Render/事件")]
[Description("Timeline发生变化的时候执行")]
public class TimelineTransitionEvent : EventNode
{
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

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		if (!(NScene.GetCurrentScene() as BattleScene == null))
		{
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (agentManager != null)
			{
				agentManager.OnTimelinePlay = (Action<int, int, int>)Delegate.Remove(agentManager.OnTimelinePlay, new Action<int, int, int>(FuncHandler));
			}
		}
	}

	protected override void RegisterPorts()
	{
		m_output = AddFlowOutput("输出", "output");
		AddValueOutput("实体ID", "agentID", () => m_agentID);
		AddValueOutput("离开TimelineID", "LastTimelineID", () => m_lastTimelineID);
		AddValueOutput("进入TimelineID", "NextTimelineID", () => m_nextTimelineID);
	}

	public void FuncHandler(int agentID, int lastTimelineID, int nextTimelineID)
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
