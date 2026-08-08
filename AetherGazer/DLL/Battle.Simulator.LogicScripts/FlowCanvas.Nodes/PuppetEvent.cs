using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("傀儡的更新事件", 0)]
[Category("Logic/事件")]
[Description("傀儡Update的更新事件")]
public class PuppetEvent : EventNode
{
	private FlowOutput logicTickEventOutput;

	private int mEntityID;

	private int mParentID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mPuppetEvent = (Action<int, int>)Delegate.Combine(simInterface.mPuppetEvent, new Action<int, int>(PuppetUpdateEvent));
	}

	public void PuppetUpdateEvent(int entityID, int parentID)
	{
		mEntityID = entityID;
		mParentID = parentID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		logicTickEventOutput.Call(f);
	}

	protected override void RegisterPorts()
	{
		logicTickEventOutput = AddFlowOutput("输出");
		AddValueOutput("实体ID:", () => mEntityID);
		AddValueOutput("宿主ID:", () => mParentID);
	}
}
