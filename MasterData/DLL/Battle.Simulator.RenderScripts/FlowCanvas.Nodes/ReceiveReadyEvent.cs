using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("准备信号事件", 0)]
[Category("Common/事件")]
[Description("准备信号事件,用于接收玩家准备信号")]
public class ReceiveReadyEvent : EventNode
{
	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	private FlowOutput _out;

	private ValueInput<bool> _isRenderInput;

	private int entityID;

	private bool isReady;

	protected override void RegisterPorts()
	{
		_isRenderInput = AddValueInput<bool>("是否渲染");
		_out = AddFlowOutput("out");
		AddValueOutput("实体ID", () => entityID);
		AddValueOutput("准备状态", () => isReady);
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<OnlineReadyEvent>(OnOnlineReadyEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<OnlineReadyEvent>(OnOnlineReadyEventHandler);
		}
	}

	private void OnOnlineReadyEventHandler(OnlineReadyEvent eventReceived)
	{
		entityID = eventReceived.entityID;
		isReady = eventReceived.isReady;
		Flow f = new Flow
		{
			returnData = _returnData
		};
		_out.Call(f);
	}
}
