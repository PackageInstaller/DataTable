using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Buff事件(类型(处理逻辑)ID)(逻辑)", 0)]
[Category("Logic/事件")]
[Description("身上的buff处理, 如果层数没有变化的话, 变化前层数和变化后层数就没有意义")]
public class BuffEventWithConfigID : EventNode
{
	private FlowOutput flowEnter;

	private FlowOutput flowTick;

	private FlowOutput flowLeave;

	private SimVar mBuffParam1;

	private SimVar mBuffParam2;

	private SimVar mBuffParam3;

	private SimVar mBuffParam4;

	private bool mIsTimeout;

	private ValueInput<int> mWantedBuffInput;

	private int mOwnerID;

	private int mCasterID;

	private int index;

	private int configID;

	private int level;

	private int buffID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateBuffLogicEvent = (Action<int, int, int, EBuffLife, bool>)Delegate.Combine(simInterface.mUpdateBuffLogicEvent, new Action<int, int, int, EBuffLife, bool>(LogicBuffUpdate));
	}

	public override void OnGraphStoped()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateBuffLogicEvent = (Action<int, int, int, EBuffLife, bool>)Delegate.Remove(simInterface.mUpdateBuffLogicEvent, new Action<int, int, int, EBuffLife, bool>(LogicBuffUpdate));
	}

	private void LogicBuffUpdate(int ownerID, int buffIndex, int buffClass, EBuffLife buffLife, bool isTimeout)
	{
		if (buffClass == mWantedBuffInput.GetValue())
		{
			mOwnerID = ownerID;
			index = buffIndex;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(ownerID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
			{
				BuffParams buffParams = entityWithEntityID.entityBuff.mBuffParamsArray[buffIndex];
				mCasterID = entityWithEntityID.entityBuff.mBuffCasterArray[buffIndex];
				mBuffParam1 = buffParams.v1;
				mBuffParam2 = buffParams.v2;
				mBuffParam3 = buffParams.v3;
				mBuffParam4 = buffParams.v4;
				configID = entityWithEntityID.entityBuff.mBuffConfigID[buffIndex];
				level = entityWithEntityID.entityBuff.mBuffFloor[buffIndex];
				buffID = entityWithEntityID.entityBuff.mBuffID[buffIndex];
				mIsTimeout = isTimeout;
			}
			Flow f = new Flow
			{
				returnData = returnData
			};
			if (buffLife == EBuffLife.Bind)
			{
				flowEnter.Call(f);
			}
			if (buffLife == EBuffLife.Tick)
			{
				flowTick.Call(f);
			}
			if (buffLife == EBuffLife.Leave)
			{
				flowLeave.Call(f);
			}
		}
	}

	protected override void RegisterPorts()
	{
		mWantedBuffInput = AddValueInput<int>("类型(处理逻辑)ID", "处理逻辑编号");
		flowEnter = AddFlowOutput("增加", "进入");
		flowTick = AddFlowOutput("触发", "触发");
		flowLeave = AddFlowOutput("移除", "结束");
		AddValueOutput("持有者实体ID", "作用对象ID", () => mOwnerID);
		AddValueOutput("释放者实体ID", "添加者ID", () => mCasterID);
		AddValueOutput("数组下标", "索引", () => index);
		AddValueOutput("buff唯一ID", () => buffID);
		AddValueOutput("配置ID", "配置ID", () => configID);
		AddValueOutput("Buff等级", "BUFF等级", () => level);
		AddValueOutput("参数1", "参数1", () => mBuffParam1);
		AddValueOutput("参数2", "参数2", () => mBuffParam2);
		AddValueOutput("参数3", "参数3", () => mBuffParam3);
		AddValueOutput("参数4", "参数4", () => mBuffParam4);
		AddValueOutput("是否超时移除", () => mIsTimeout);
	}
}
