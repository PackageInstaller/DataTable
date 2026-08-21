using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("输入打断事件", 0)]
[Category("Logic/事件")]
[Description("发生打断时触发")]
public class LogicInputInterrupterEvent : EventNode
{
	private FlowOutput logicTickEventOutput;

	private int mInterrupter;

	private int mInterruptAbilityID;

	private int mBeInterruptAbilityID;

	private bool mInterruptResult;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilityLogicInputInterruptEvent = (Action<int, int, int, bool>)Delegate.Combine(simInterface.mAbilityLogicInputInterruptEvent, new Action<int, int, int, bool>(OnInterrupter));
	}

	public void OnInterrupter(int beInterrupterID, int abilityID, int beInterruptAbilityID, bool result)
	{
		mInterrupter = beInterrupterID;
		mInterruptAbilityID = abilityID;
		mBeInterruptAbilityID = beInterruptAbilityID;
		mInterruptResult = result;
		Flow f = new Flow
		{
			returnData = returnData
		};
		logicTickEventOutput.Call(f);
	}

	protected override void RegisterPorts()
	{
		logicTickEventOutput = AddFlowOutput("输出");
		AddValueOutput("打断者ID:", () => mInterrupter);
		AddValueOutput("打断AbilityID:", () => mInterruptAbilityID);
		AddValueOutput("被打断AbilityID:", () => mBeInterruptAbilityID);
		AddValueOutput("打断结果:", () => mInterruptResult);
	}
}
