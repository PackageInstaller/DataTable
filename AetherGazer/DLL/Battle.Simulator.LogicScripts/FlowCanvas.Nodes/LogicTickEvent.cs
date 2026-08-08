using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("逻辑更新事件", 0)]
[Category("Logic/事件")]
[Description("逻辑tick AI的固定频率")]
public class LogicTickEvent : EventNode
{
	private FlowOutput logicTickEventOutput;

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
		Flow f = new Flow
		{
			returnData = returnData
		};
		logicTickEventOutput.Call(f);
	}
}
