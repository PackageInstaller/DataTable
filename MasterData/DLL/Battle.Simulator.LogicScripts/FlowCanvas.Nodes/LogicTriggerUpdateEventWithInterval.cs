using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("触发器更新事件(计时)", 0)]
[Category("Logic/事件")]
[Description("每一个激活状态的触发器都以固定的频率触发这个事件")]
public class LogicTriggerUpdateEventWithInterval : EventNode
{
	private FlowOutput falseOut;

	private FlowOutput trueOut;

	private int triggerID;

	private ValueInput<int> updateIntervalInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		trueOut = AddFlowOutput("true");
		falseOut = AddFlowOutput("false");
		updateIntervalInput = AddValueInput<int>("触发间隔");
		AddValueOutput("触发器ID", () => triggerID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simulatorInferface = base.mLogicEvent;
		simulatorInferface.mLogicTriggerEvent = (Action<int>)Delegate.Combine(simulatorInferface.mLogicTriggerEvent, new Action<int>(OnLogicTriggerEventHandler));
	}

	private void OnLogicTriggerEventHandler(int triggerEntityID)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(triggerEntityID);
		triggerID = entityWithEntityID.entityTrigger.mTriggerID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		int num = entityWithEntityID.entityTrigger.mActiveFrameCount * CommonProcessor.GetLogicConstTick();
		int value = updateIntervalInput.value;
		value = ((value == 0) ? 1 : value);
		if (num > CommonProcessor.GetLogicConstTick() && num % value < CommonProcessor.GetLogicConstTick())
		{
			trueOut.Call(f);
		}
		else
		{
			falseOut.Call(f);
		}
	}
}
