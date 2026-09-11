using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("接收抛掷物到达目标点事件", 0)]
[Category("Common/事件")]
[Description("接收抛掷物到达目标点时候,发出的\"抛掷物到达目标点事件\"")]
public class ReceiveThrownArrivedPositionEvent : EventNode
{
	private int m_thrownID;

	private Int3 m_arrivedPos;

	private FlowOutput m_output;

	private ValueInput<bool> m_isRenderInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		m_output = AddFlowOutput("Out");
		AddValueOutput("抛掷物ID", () => m_thrownID);
		AddValueOutput("目标点坐标", () => m_arrivedPos);
		m_isRenderInput = AddValueInput<bool>("是否渲染");
	}

	public override void OnGraphStarted()
	{
		if (!m_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<ThrownArriedPositionEvent>(OnThrownArriedPositionEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<ThrownArriedPositionEvent>(OnThrownArriedPositionEventHandler);
		}
	}

	private void OnThrownArriedPositionEventHandler(ThrownArriedPositionEvent triggerEvent)
	{
		m_thrownID = triggerEvent.mThrownID;
		m_arrivedPos = triggerEvent.mArrivedPosition;
		Flow f = new Flow
		{
			returnData = returnData
		};
		m_output.Call(f);
	}
}
