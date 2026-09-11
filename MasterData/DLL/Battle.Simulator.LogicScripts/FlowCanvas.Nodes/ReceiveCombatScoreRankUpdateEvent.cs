using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("评分等级变更事件", 0)]
[Category("Logic/事件")]
[Description("当战斗评分等级发生变化时候,触发该事件;\n 增量为想要的变化量,而非 新值 - 旧值 的结果")]
public class ReceiveCombatScoreRankUpdateEvent : EventNode
{
	[Name("是否渲染", 0)]
	public bool IsRender;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private int m_entityID;

	private int m_rank;

	private int m_lastRank;

	private FlowOutput m_out;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(IsRender);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		IsRender = reader.ReadBoolean();
	}

	public override void OnGraphStarted()
	{
		if (!IsRender)
		{
			base.mSimContext.SimEventSystem.AddHandler<CombatScoreRankUpdateEvent>(eventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<CombatScoreRankUpdateEvent>(eventHandler);
		}
	}

	protected override void RegisterPorts()
	{
		m_out = AddFlowOutput("Out", "output");
		AddValueOutput("实体ID", "entityID", () => m_entityID);
		AddValueOutput("新等级", "newValue", () => m_rank);
		AddValueOutput("旧等级", "oldValue", () => m_lastRank);
	}

	private void eventHandler(CombatScoreRankUpdateEvent evt)
	{
		m_entityID = evt.mEntityID;
		m_rank = evt.mValue;
		m_lastRank = evt.mLastValue;
		Flow f = new Flow
		{
			returnData = returnData
		};
		m_out.Call(f);
	}
}
