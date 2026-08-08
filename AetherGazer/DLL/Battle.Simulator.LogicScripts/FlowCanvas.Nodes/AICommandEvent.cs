using System;
using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AI指令事件", 0)]
[Category("Logic/事件")]
[Description("AI指令执行事件")]
public class AICommandEvent : EventNode
{
	private FlowOutput AICommandCondOutput;

	private FlowOutput AICommandBeginOutput;

	private FlowOutput AICommandRunOutput;

	private FlowOutput AICommandEndOutput;

	private FlowOutput AICommandTimeoutOutput;

	private int mEntityID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private int mCommandSetID;

	private int mCommandID;

	private int mStep;

	private ValueInput<int> mCommandSetIDInput;

	private ValueInput<int> mCommandStepInput;

	private ValueInput<int> mRoleIDInput;

	public int updateIntervalFrame;

	public override string name => $"{base.name}";

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		updateIntervalFrame = reader.ReadInt32();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.WriteInt32(updateIntervalFrame);
	}

	protected override void RegisterPorts()
	{
		AICommandCondOutput = AddFlowOutput("前置条件");
		AICommandBeginOutput = AddFlowOutput("开始");
		AICommandRunOutput = AddFlowOutput("运行");
		AICommandEndOutput = AddFlowOutput("结束");
		AICommandTimeoutOutput = AddFlowOutput("超时");
		AddValueOutput("AI实体ID:", () => mEntityID);
		AddValueOutput("当前动作ID:", () => mCommandID);
		mCommandSetIDInput = AddValueInput<int>("指令集ID");
		mCommandStepInput = AddValueInput<int>("步骤");
		mRoleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAICommandConditionEvent = (Action<int, AICommand, int>)Delegate.Combine(simInterface.mAICommandConditionEvent, new Action<int, AICommand, int>(OnAICommandConditionEventHandler));
		ISimulatorInferface simInterface2 = base.mSimContext.GetSimInterface();
		simInterface2.mAICommandBeginEvent = (Action<int, AICommand, int>)Delegate.Combine(simInterface2.mAICommandBeginEvent, new Action<int, AICommand, int>(OnAICommandBeginEventHandler));
		ISimulatorInferface simInterface3 = base.mSimContext.GetSimInterface();
		simInterface3.mAICommandRunEvent = (Action<int, AICommand, int>)Delegate.Combine(simInterface3.mAICommandRunEvent, new Action<int, AICommand, int>(OnAICommandRunEventHandler));
		ISimulatorInferface simInterface4 = base.mSimContext.GetSimInterface();
		simInterface4.mAICommandEndEvent = (Action<int, AICommand, int>)Delegate.Combine(simInterface4.mAICommandEndEvent, new Action<int, AICommand, int>(OnAICommandEndEventHandler));
		ISimulatorInferface simInterface5 = base.mSimContext.GetSimInterface();
		simInterface5.mAICommandTimeoutEvent = (Action<int, AICommand, int>)Delegate.Combine(simInterface5.mAICommandTimeoutEvent, new Action<int, AICommand, int>(OnAICommandTimeoutEventHandler));
	}

	private void OnAICommandRunEventHandler(int entityID, AICommand cmd, int roleID)
	{
		if (cmd is AICommandSet)
		{
			return;
		}
		int value = mRoleIDInput.value;
		if (value == 0 || value == roleID)
		{
			mEntityID = entityID;
			int num = 0;
			int mID = cmd.mID;
			if (cmd.mParent != null && cmd.mParent is AICommandSet)
			{
				AICommandSet obj = (AICommandSet)cmd.mParent;
				num = obj.mCurrent;
				mID = obj.mID;
			}
			int logicConstTick = CommonProcessor.GetLogicConstTick();
			int num2 = cmd.mExcutingTime / logicConstTick;
			if ((updateIntervalFrame == 0 || num2 % updateIntervalFrame == 0) && mID == mCommandSetIDInput.value && num == mCommandStepInput.value)
			{
				mCommandID = cmd.mID;
				Flow f = new Flow
				{
					returnData = returnData,
					userData = base.mSimContext.GetEntityWithEntityID(entityID)
				};
				AICommandRunOutput.Call(f);
			}
		}
	}

	private void OnAICommandConditionEventHandler(int entityID, AICommand cmd, int roleID)
	{
		if (cmd is AICommandSet)
		{
			return;
		}
		int value = mRoleIDInput.value;
		if (value == 0 || value == roleID)
		{
			mEntityID = entityID;
			int num = 0;
			int mID = cmd.mID;
			if (cmd.mParent != null && cmd.mParent is AICommandSet)
			{
				AICommandSet obj = (AICommandSet)cmd.mParent;
				num = obj.mCurrent;
				mID = obj.mID;
			}
			if (mID == mCommandSetIDInput.value && num == mCommandStepInput.value)
			{
				mCommandID = cmd.mID;
				Flow f = new Flow
				{
					returnData = returnData,
					userData = base.mSimContext.GetEntityWithEntityID(entityID)
				};
				AICommandCondOutput.Call(f);
			}
		}
	}

	private void OnAICommandTimeoutEventHandler(int entityID, AICommand cmd, int roleID)
	{
		if (cmd is AICommandSet)
		{
			return;
		}
		int value = mRoleIDInput.value;
		if (value == 0 || value == roleID)
		{
			mEntityID = entityID;
			int num = 0;
			int mID = cmd.mID;
			if (cmd.mParent != null && cmd.mParent is AICommandSet)
			{
				AICommandSet obj = (AICommandSet)cmd.mParent;
				num = obj.mCurrent;
				mID = obj.mID;
			}
			if (mID == mCommandSetIDInput.value && num == mCommandStepInput.value)
			{
				mCommandID = cmd.mID;
				Flow f = new Flow
				{
					returnData = returnData,
					userData = base.mSimContext.GetEntityWithEntityID(entityID)
				};
				AICommandTimeoutOutput.Call(f);
			}
		}
	}

	private void OnAICommandEndEventHandler(int entityID, AICommand cmd, int roleID)
	{
		if (cmd is AICommandSet)
		{
			return;
		}
		int value = mRoleIDInput.value;
		if (value == 0 || value == roleID)
		{
			mEntityID = entityID;
			int num = 0;
			int mID = cmd.mID;
			if (cmd.mParent != null && cmd.mParent is AICommandSet)
			{
				AICommandSet obj = (AICommandSet)cmd.mParent;
				num = obj.mCurrent;
				mID = obj.mID;
			}
			if (mID == mCommandSetIDInput.value && num == mCommandStepInput.value)
			{
				mCommandID = cmd.mID;
				Flow f = new Flow
				{
					returnData = returnData,
					userData = base.mSimContext.GetEntityWithEntityID(entityID)
				};
				AICommandEndOutput.Call(f);
			}
		}
	}

	private void OnAICommandBeginEventHandler(int entityID, AICommand cmd, int roleID)
	{
		if (cmd is AICommandSet)
		{
			return;
		}
		int value = mRoleIDInput.value;
		if (value == 0 || value == roleID)
		{
			mEntityID = entityID;
			int num = 0;
			int mID = cmd.mID;
			if (cmd.mParent != null && cmd.mParent is AICommandSet)
			{
				AICommandSet obj = (AICommandSet)cmd.mParent;
				num = obj.mCurrent;
				mID = obj.mID;
			}
			if (mID == mCommandSetIDInput.value && num == mCommandStepInput.value)
			{
				mCommandID = cmd.mID;
				Flow f = new Flow
				{
					returnData = returnData,
					userData = base.mSimContext.GetEntityWithEntityID(entityID)
				};
				AICommandBeginOutput.Call(f);
			}
		}
	}
}
