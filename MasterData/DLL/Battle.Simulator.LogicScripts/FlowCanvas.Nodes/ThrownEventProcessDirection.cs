using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物朝向逻辑", 0)]
[Category("Logic/抛掷物")]
[Description("处理抛掷物朝向")]
public class ThrownEventProcessDirection : EventNode
{
	private FlowOutput output;

	private int mThrownID;

	private int mTimelineID;

	private ValueInput<int> thrownTimelineIDVar;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mThrownProcessDirection = (Action<int, int>)Delegate.Combine(simInterface.mThrownProcessDirection, new Action<int, int>(ThrownDirectionHandler));
	}

	protected override void RegisterPorts()
	{
		thrownTimelineIDVar = AddValueInput<int>("抛掷物TimelineID", "thrownTimelineID");
		output = AddFlowOutput("输出");
		AddValueOutput("抛掷物ID", "thrownID", () => mThrownID);
		AddValueOutput("抛掷物TimelineID", "thrownTimelineID", () => mTimelineID);
	}

	public void ThrownDirectionHandler(int thrownID, int abilityID)
	{
		mThrownID = thrownID;
		mTimelineID = abilityID;
		if (thrownTimelineIDVar.GetValue() == -1)
		{
			Flow f = new Flow
			{
				returnData = returnData
			};
			output.Call(f);
		}
		else if (thrownTimelineIDVar.GetValue() == mTimelineID)
		{
			Flow f2 = new Flow
			{
				returnData = returnData
			};
			output.Call(f2);
		}
	}
}
