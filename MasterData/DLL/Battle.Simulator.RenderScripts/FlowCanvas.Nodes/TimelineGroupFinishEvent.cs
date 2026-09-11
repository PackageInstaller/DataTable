using System;
using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能结束事件(技能组)(渲染)", 0)]
[Category("Render/事件")]
[Description("Timeline结束时候触发的事件，可用多技能组筛选")]
public class TimelineGroupFinishEvent : EventNode
{
	public List<int> m_actionIDs = new List<int>();

	private FlowOutput m_output;

	private int m_agentID;

	private int m_lastTimelineID;

	private int m_nextTimelineID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<List<int>>().Serialize(ref writer, m_actionIDs, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		m_actionIDs = options.Resolver.GetFormatterWithVerify<List<int>>().Deserialize(ref reader, options);
	}

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
		m_output = AddFlowOutput("输出", "output");
		AddValueOutput("实体ID", "agentID", () => m_agentID);
		AddValueOutput("进入TimelineID", "NextTimelineID", () => m_nextTimelineID);
	}

	public void FuncHandler(int agentID, int lastTimelineID, int nextTimelineID)
	{
		if (lastTimelineID != nextTimelineID && m_actionIDs.Contains(lastTimelineID))
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
