using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("接收抛掷物出界事件", 0)]
[Category("Common/事件")]
[Description("接收抛掷物离开网格时候,发出的\"抛掷物出界事件\"")]
public class ReceiveThrownOutRangeEvent : EventNode
{
	private int _thrownID;

	private Int3 _borderPos;

	private FlowOutput _output;

	private ValueInput<bool> _isRenderInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("Out");
		AddValueOutput("抛掷物ID", () => _thrownID);
		AddValueOutput("边缘坐标", () => _borderPos);
		_isRenderInput = AddValueInput<bool>("是否渲染");
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<ThrownOutRangeEvent>(OnThrownOutRangeEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<ThrownOutRangeEvent>(OnThrownOutRangeEventHandler);
		}
	}

	private void OnThrownOutRangeEventHandler(ThrownOutRangeEvent triggerEvent)
	{
		_thrownID = triggerEvent.mThrownID;
		_borderPos = triggerEvent.mBorderPosition;
		Flow f = new Flow
		{
			returnData = returnData
		};
		_output.Call(f);
	}
}
