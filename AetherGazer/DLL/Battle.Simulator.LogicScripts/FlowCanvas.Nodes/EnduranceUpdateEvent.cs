using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("耐力更新事件", 0)]
[Category("Logic/事件")]
[Description("耐力更新事件")]
public class EnduranceUpdateEvent : EventNode
{
	private int entityID;

	private FlowOutput output;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		AddValueOutput("实体ID", () => entityID);
		output = AddFlowOutput("输出");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mEnduranceUpdateEvent = (Action<int>)Delegate.Combine(simInterface.mEnduranceUpdateEvent, new Action<int>(OnEnduranceUpdateHandler));
	}

	private void OnEnduranceUpdateHandler(int entityID)
	{
		this.entityID = entityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		output.Call(f);
	}
}
