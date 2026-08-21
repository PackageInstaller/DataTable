using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("逻辑激活事件", 0)]
[Category("Logic/事件")]
[Description("在激活后的第一帧触发")]
public class LogicEnableEvent : EventNode
{
	private FlowOutput logicTickEventOutput;

	private bool called;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		logicTickEventOutput = AddFlowOutput("输出");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateLogicEvent = (Action)Delegate.Combine(simInterface.mUpdateLogicEvent, new Action(LogicUpdate));
	}

	public void LogicUpdate()
	{
		if (!called)
		{
			called = true;
			Flow f = new Flow
			{
				returnData = returnData
			};
			logicTickEventOutput.Call(f);
		}
	}
}
