using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("执行触发器传递参数事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("触发器传递参数事件")]
public class DoTriggerParamtersEvent : EventNode
{
	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	private FlowOutput _output;

	private int _triggerID;

	private int _param1;

	private int _param2;

	private int _param3;

	private int _param4;

	protected override void RegisterPorts()
	{
		_output = AddFlowOutput("Out", "output");
		AddValueOutput("触发器ID", "triggerID", () => _triggerID);
		AddValueOutput("参数1", "param1", () => _param1);
		AddValueOutput("参数2", "param2", () => _param2);
		AddValueOutput("参数3", "param3", () => _param3);
		AddValueOutput("参数4", "param4", () => _param4);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simulatorInferface = base.mLogicEvent;
		simulatorInferface.mLogicTriggerParametersEvent = (Action<int, int, int, int, int>)Delegate.Combine(simulatorInferface.mLogicTriggerParametersEvent, new Action<int, int, int, int, int>(OnEventHandler));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simulatorInferface = base.mLogicEvent;
		simulatorInferface.mLogicTriggerParametersEvent = (Action<int, int, int, int, int>)Delegate.Remove(simulatorInferface.mLogicTriggerParametersEvent, new Action<int, int, int, int, int>(OnEventHandler));
	}

	private void OnEventHandler(int triggerID, int param1, int param2, int param3, int param4)
	{
		_triggerID = triggerID;
		_param1 = param1;
		_param2 = param2;
		_param3 = param3;
		_param4 = param4;
		Flow f = new Flow
		{
			returnData = mReturnData
		};
		_output.Call(f);
	}
}
