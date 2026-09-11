using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("打断事件", 0)]
[Category("Logic/事件")]
[Description("发生打断时触发")]
public class InterrupterEvent : EventNode
{
	private FlowOutput logicTickEventOutput;

	private int mInterrupter;

	private int mInterruptAbilityID;

	private int mBeInterrupter;

	private bool mIsInterrupter;

	private bool mIsHitRecoverInterrupter;

	private int mInterrupterThrownID;

	private ValueInput<bool> _isListenrHitRecoverInterrupter;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateAbilityInterruptLogicEvent = (Action<DamageEventParam, int, bool, bool>)Delegate.Combine(simInterface.mUpdateAbilityInterruptLogicEvent, new Action<DamageEventParam, int, bool, bool>(OnInterrupter));
	}

	public void OnInterrupter(DamageEventParam eventParam, int beInterrupterID, bool isSelfInterrupter, bool isInterrupter)
	{
		mInterrupter = eventParam.casterID;
		mInterruptAbilityID = eventParam.abilityID;
		mBeInterrupter = beInterrupterID;
		mIsInterrupter = isInterrupter;
		mIsHitRecoverInterrupter = isSelfInterrupter;
		mInterrupterThrownID = eventParam.thrownID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		if (isSelfInterrupter != _isListenrHitRecoverInterrupter.GetValue())
		{
			logicTickEventOutput.Call(f);
		}
	}

	protected override void RegisterPorts()
	{
		logicTickEventOutput = AddFlowOutput("输出");
		AddValueOutput("打断者ID:", () => mInterrupter);
		AddValueOutput("打断AbilityID:", () => mInterruptAbilityID);
		AddValueOutput("被打断者ID:", () => mBeInterrupter);
		AddValueOutput("打断结果:", () => mIsInterrupter);
		AddValueOutput("抛掷物ID(为0非抛掷物)", "mInterrupterThrownID", () => mInterrupterThrownID);
		_isListenrHitRecoverInterrupter = AddValueInput<bool>("是否临听外部打断");
	}
}
