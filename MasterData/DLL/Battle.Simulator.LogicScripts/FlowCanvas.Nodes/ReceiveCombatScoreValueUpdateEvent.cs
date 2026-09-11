using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("评分变更事件", 0)]
[Category("Logic/事件")]
[Description("当战斗评分发生变化时候,触发该事件;\n 增量为想要的变化量,而非 新值 - 旧值 的结果")]
public class ReceiveCombatScoreValueUpdateEvent : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	[Name("是否渲染", 0)]
	public bool IsRender;

	private int m_entityID;

	private int m_value;

	private int m_lastValue;

	private int m_delta;

	private FlowOutput m_out;

	public override void OnGraphStarted()
	{
		if (!IsRender)
		{
			base.mSimContext.SimEventSystem.AddHandler<CombatScoreValueUpdateEvent>(eventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<CombatScoreValueUpdateEvent>(eventHandler);
		}
	}

	protected override void RegisterPorts()
	{
		m_out = AddFlowOutput("Out", "output");
		AddValueOutput("实体ID", "entityID", () => m_entityID);
		AddValueOutput("新的分数", "newValue", () => m_value);
		AddValueOutput("旧的分数", "oldValue", () => m_lastValue);
		AddValueOutput("增量", "delta", () => m_delta);
	}

	private void eventHandler(CombatScoreValueUpdateEvent evt)
	{
		m_entityID = evt.mEntityID;
		m_value = evt.mValue;
		m_lastValue = evt.mLastValue;
		m_delta = evt.mDelta;
		Flow f = new Flow
		{
			returnData = returnData
		};
		m_out.Call(f);
	}
}
