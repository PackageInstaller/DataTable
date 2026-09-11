using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("触发器初始化事件", 0)]
[Category("Logic/事件")]
[Description("在触发器初始化的时候触发,每一个触发器都会抛出这个事件")]
public class LogicTriggerInitEvent : EventNode
{
	private FlowOutput output;

	private int triggerEntityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("输出");
		AddValueOutput("触发器ID", () => triggerEntityID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mLogicTriggerInitEvent = (Action<int, ProtoEntityData>)Delegate.Combine(simInterface.mLogicTriggerInitEvent, new Action<int, ProtoEntityData>(OnTriggerInitEventHandler));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mLogicTriggerInitEvent = (Action<int, ProtoEntityData>)Delegate.Remove(simInterface.mLogicTriggerInitEvent, new Action<int, ProtoEntityData>(OnTriggerInitEventHandler));
	}

	private void OnTriggerInitEventHandler(int triggerEntityID, ProtoEntityData triggerData)
	{
		this.triggerEntityID = triggerData.Id;
		if (triggerData.Type.Contains(base.graphName))
		{
			Flow f = new Flow
			{
				returnData = returnData
			};
			output.Call(f);
		}
	}
}
