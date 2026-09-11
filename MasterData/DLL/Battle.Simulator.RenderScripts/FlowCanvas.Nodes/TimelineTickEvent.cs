using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行事件(渲染)", 0)]
[Category("Render/事件")]
[Description("Timeline执行时候触发")]
public class TimelineTickEvent : EventNode
{
	private FlowOutput m_timelineTickEventOutput;

	private int m_agentID;

	private int m_timelineID;

	private int m_lastTime;

	private int m_time;

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
		m_timelineTickEventOutput = AddFlowOutput("输出", "output");
		AddValueOutput("实体ID", "agentID", () => m_agentID);
		AddValueOutput("TimelineID", "TimelineID", () => m_timelineID);
		AddValueOutput("上次时间(毫秒)", "lastTime", () => m_lastTime);
		AddValueOutput("时间(毫秒)", "time", () => m_time);
	}

	public void FuncHandler(int agentID, int abilityID, int lastTime, int currentTime)
	{
		m_agentID = agentID;
		m_timelineID = abilityID;
		m_lastTime = lastTime;
		m_time = currentTime;
		Flow f = new Flow
		{
			returnData = returnData
		};
		m_timelineTickEventOutput.Call(f);
	}
}
