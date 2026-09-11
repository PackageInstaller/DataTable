using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("指挥官事件", 0)]
[Category("Logic/事件")]
[Description("指挥官事件")]
public class CommanderEvent : EventNode
{
	private FlowOutput attackOutput;

	private FlowOutput approachOutput;

	private ValueInput<int> roleInput;

	private int entityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		attackOutput = AddFlowOutput("攻击指令");
		approachOutput = AddFlowOutput("追击指令");
		AddValueOutput("小怪实体ID", () => entityID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mCommanderCommandEvent = (Action<int, AICommanderEventType>)Delegate.Combine(simInterface.mCommanderCommandEvent, new Action<int, AICommanderEventType>(OnEventhandler));
	}

	private void OnEventhandler(int entityID, AICommanderEventType eventType)
	{
		this.entityID = entityID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		switch (eventType)
		{
		case AICommanderEventType.Attack:
			attackOutput.Call(f);
			break;
		case AICommanderEventType.Approach:
			approachOutput.Call(f);
			break;
		}
	}
}
