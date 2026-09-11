using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI指令集事件", 0)]
[Category("Logic/事件")]
[Description("AI指令集事件")]
public class AICommandSetConditionEvent : EventNode
{
	private FlowOutput AICommandCondOutput;

	private FlowOutput AICommandBeginOutput;

	private FlowOutput AICommandEndOutput;

	private int mCommandSetID;

	private int mCommandStep;

	private int mEntityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private ValueInput<int> mCurrentCommandSet;

	private ValueInput<int> mRoleIDInput;

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		AICommandCondOutput = AddFlowOutput("前置条件");
		AICommandBeginOutput = AddFlowOutput("开始");
		AICommandEndOutput = AddFlowOutput("结束");
		AddValueOutput("AI实体ID:", () => mEntityID);
		AddValueOutput("当前指令集ID:", () => mCommandSetID);
		AddValueOutput("当前步骤:", () => mCommandStep);
		mRoleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		mCurrentCommandSet = AddValueInput<int>("当前指令集ID");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAICommandBeginEvent = (Action<int, AICommand, int>)Delegate.Combine(simInterface.mAICommandBeginEvent, new Action<int, AICommand, int>(OnAICommandSetBeginEventHandler));
		ISimulatorInferface simInterface2 = base.mSimContext.GetSimInterface();
		simInterface2.mAICommandEndEvent = (Action<int, AICommand, int>)Delegate.Combine(simInterface2.mAICommandEndEvent, new Action<int, AICommand, int>(OnAICommandSetEndEventHandler));
		ISimulatorInferface simInterface3 = base.mSimContext.GetSimInterface();
		simInterface3.mAICommandSetConditionEvent = (Action<int, AICommandSet, int>)Delegate.Combine(simInterface3.mAICommandSetConditionEvent, new Action<int, AICommandSet, int>(OnAICommandSetConditionEventHandler));
	}

	private void OnAICommandSetConditionEventHandler(int entityID, AICommandSet cmdSet, int roleID)
	{
		mCommandSetID = cmdSet.mID;
		mCommandStep = cmdSet.mCurrent;
		int value = mRoleIDInput.value;
		if ((value == 0 || value == roleID) && (mCurrentCommandSet.value == 0 || mCommandSetID == mCurrentCommandSet.value))
		{
			mEntityID = entityID;
			Flow f = new Flow
			{
				userData = base.mSimContext.GetEntityWithEntityID(entityID),
				returnData = returnData
			};
			AICommandCondOutput.Call(f);
		}
	}

	private void OnAICommandSetEndEventHandler(int entityID, AICommand cmdSet, int roleID)
	{
		mCommandSetID = cmdSet.mID;
		int value = mRoleIDInput.value;
		if ((value == 0 || value == roleID) && (mCurrentCommandSet.value == 0 || mCommandSetID == mCurrentCommandSet.value))
		{
			mEntityID = entityID;
			Flow f = new Flow
			{
				userData = base.mSimContext.GetEntityWithEntityID(entityID),
				returnData = returnData
			};
			AICommandEndOutput.Call(f);
		}
	}

	private void OnAICommandSetBeginEventHandler(int entityID, AICommand cmdSet, int roleID)
	{
		mCommandSetID = cmdSet.mID;
		int value = mRoleIDInput.value;
		if ((value == 0 || value == roleID) && (mCurrentCommandSet.value == 0 || mCommandSetID == mCurrentCommandSet.value))
		{
			mEntityID = entityID;
			Flow f = new Flow
			{
				userData = base.mSimContext.GetEntityWithEntityID(entityID),
				returnData = returnData
			};
			AICommandBeginOutput.Call(f);
		}
	}
}
