using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("接收抛掷物创建完成事件", 0)]
[Category("Common/事件")]
[Description("接收抛掷物创建成功时候发生的事件")]
public class ReceiveThrownSpawnedEvent : EventNode
{
	private int m_thrownID;

	private int m_timelineID;

	private int m_casterID;

	private Int3 m_spawnedPosition = Int3.zero;

	private Int3 m_spawnedForward = Int3.forward;

	private ValueInput<bool> IsRenderEvent;

	private FlowOutput m_output;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		IsRenderEvent = AddValueInput<bool>("是否渲染");
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownID);
		AddValueOutput("抛掷物TimelineID", "thrownTimelineID", () => m_timelineID);
		AddValueOutput("创建坐标", "position", () => m_spawnedPosition);
		AddValueOutput("朝向", "forward", () => m_spawnedForward);
		AddValueOutput("创建者ID", () => m_casterID);
		m_output = AddFlowOutput("Out");
	}

	public override void OnGraphStarted()
	{
		if (!IsRenderEvent.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<ThrownSpawnedEvent>(OnThrownSpawnedEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<ThrownSpawnedEvent>(OnThrownSpawnedEventHandler);
		}
	}

	private void OnThrownSpawnedEventHandler(ThrownSpawnedEvent evt)
	{
		m_thrownID = evt.mThrownID;
		m_timelineID = evt.mTimelineID;
		m_spawnedPosition = evt.mSpawnPosition;
		m_spawnedForward = evt.mSpawnForward;
		m_casterID = evt.mCasterID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		m_output.Call(f);
	}
}
