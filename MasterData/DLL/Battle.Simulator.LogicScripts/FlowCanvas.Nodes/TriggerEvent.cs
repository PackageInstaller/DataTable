using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("触发器事件", 0)]
[Category("Logic/事件")]
[Description("在触发器启用或者禁用时触发")]
public class TriggerEvent : EventNode
{
	private FlowOutput enableOutput;

	private FlowOutput disableOutput;

	private int id;

	private Stack<Flow.ReturnData> mReturnData = new Stack<Flow.ReturnData>();

	protected override void RegisterPorts()
	{
		enableOutput = AddFlowOutput("启用");
		disableOutput = AddFlowOutput("禁用");
		AddValueOutput("触发器ID", () => id);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simulatorInferface = base.mLogicEvent;
		simulatorInferface.mTriggerEnableEvent = (Action<int, bool>)Delegate.Combine(simulatorInferface.mTriggerEnableEvent, new Action<int, bool>(OnTriggerEvent));
	}

	private void OnTriggerEvent(int triggerID, bool enable)
	{
		Flow f = new Flow
		{
			returnData = mReturnData
		};
		id = triggerID;
		if (enable)
		{
			enableOutput.Call(f);
		}
		else
		{
			disableOutput.Call(f);
		}
	}
}
