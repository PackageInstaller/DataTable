using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物执行事件(逻辑)", 0)]
[Category("Logic/抛掷物")]
[Description("抛掷物Update时调用的事件, 输入为0表示不过滤")]
public class ThrownRuntimeEvent : EventNode
{
	private FlowOutput logicTickEventOutput;

	private ValueInput<int> input;

	private int mEntityID;

	private int mAbilityID;

	private int mLogicTime;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mThrownUpdateAbilityLogicEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mThrownUpdateAbilityLogicEvent, new Action<int, int, int>(LogicAbilityUpdateEventHandler));
	}

	protected override void RegisterPorts()
	{
		input = AddValueInput<int>("抛掷物TimelineID");
		logicTickEventOutput = AddFlowOutput("输出");
		AddValueOutput("抛掷物ID", "thrownID", () => mEntityID);
		AddValueOutput("抛掷物TimelineID", "thrownTimelineID", () => mAbilityID);
		AddValueOutput("时间", "time", () => mLogicTime);
	}

	public void LogicAbilityUpdateEventHandler(int entityID, int abilityID, int logicTime)
	{
		mEntityID = entityID;
		mAbilityID = abilityID;
		mLogicTime = logicTime;
		if (input.value == 0 || input.value == mAbilityID)
		{
			Flow f = new Flow
			{
				returnData = returnData
			};
			logicTickEventOutput.Call(f);
		}
	}
}
