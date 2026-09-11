using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("实体初始化完成事件", 0)]
[Category("Logic/事件")]
[Description("实体初始化完成事件, 会在实体创建之后的一帧触发")]
public class EntityInitFinishedEvent : EventNode
{
	private int entityID;

	private FlowOutput output;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => entityID);
		output = AddFlowOutput("");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mInitEntityFinishedEvent = (Action<int>)Delegate.Combine(simInterface.mInitEntityFinishedEvent, new Action<int>(OnEntityInitFinishedEventHandler));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mInitEntityFinishedEvent = (Action<int>)Delegate.Remove(simInterface.mInitEntityFinishedEvent, new Action<int>(OnEntityInitFinishedEventHandler));
	}

	private void OnEntityInitFinishedEventHandler(int id)
	{
		entityID = id;
		Flow f = new Flow
		{
			returnData = returnData
		};
		output.Call(f);
	}
}
