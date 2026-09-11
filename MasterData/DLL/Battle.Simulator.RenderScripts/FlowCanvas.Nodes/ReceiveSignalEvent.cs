using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("交流信号事件", 0)]
[Category("Render/事件")]
[Description("交流信号事件")]
public class ReceiveSignalEvent : EventNode
{
	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	private FlowOutput _out;

	private int _entityID;

	private int _contentID;

	public override void OnGraphStarted()
	{
		base.mSimContext.SimToPresentationEventSystem.AddHandler<SignalExchangeEvent>(OnSignalExchangeEvent);
	}

	private void OnSignalExchangeEvent(SignalExchangeEvent eventReceived)
	{
		Flow f = new Flow
		{
			returnData = _returnData
		};
		_entityID = eventReceived.entityID;
		_contentID = eventReceived.contentID;
		_out.Call(f);
	}

	protected override void RegisterPorts()
	{
		_out = AddFlowOutput("");
		AddValueOutput("agentID", () => _entityID);
		AddValueOutput("内容ID", () => _contentID);
	}
}
