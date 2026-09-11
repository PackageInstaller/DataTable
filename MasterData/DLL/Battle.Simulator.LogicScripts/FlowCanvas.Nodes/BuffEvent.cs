using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Buff事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("身上的buff处理")]
public class BuffEvent : EventNode
{
	private int mOwnerID;

	private int mCasterID;

	private int mBuffClass;

	private int mBuffIndex;

	private SimVar mBuffParam1;

	private SimVar mBuffParam2;

	private SimVar mBuffParam3;

	private SimVar mBuffParam4;

	private bool mIsTimeout;

	private ValueInput<int> mWantedBuffInput;

	private FlowOutput flowEnter;

	private FlowOutput flowTick;

	private FlowOutput flowLeave;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateBuffLogicEvent = (Action<int, int, int, EBuffLife, bool>)Delegate.Combine(simInterface.mUpdateBuffLogicEvent, new Action<int, int, int, EBuffLife, bool>(LogicBuffUpdate));
	}

	public void LogicBuffUpdate(int ownerID, int buffIndex, int buffClass, EBuffLife buffLife, bool isTimeout)
	{
		if (buffClass == mWantedBuffInput.GetValue())
		{
			mOwnerID = ownerID;
			mBuffClass = buffClass;
			mBuffIndex = buffIndex;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(ownerID);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
			{
				BuffParams buffParams = entityWithEntityID.entityBuff.mBuffParamsArray[buffIndex];
				mCasterID = entityWithEntityID.entityBuff.mBuffCasterArray[buffIndex];
				mBuffParam1 = buffParams.v1;
				mBuffParam2 = buffParams.v2;
				mBuffParam3 = buffParams.v3;
				mBuffParam4 = buffParams.v4;
			}
			mIsTimeout = isTimeout;
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
		flowEnter = AddFlowOutput("增加", "进入");
		flowTick = AddFlowOutput("触发", "触发");
		flowLeave = AddFlowOutput("移除", "结束");
		AddValueOutput("持有者实体ID", "实体", () => mOwnerID);
		AddValueOutput("释放者实体ID", "添加者ID", () => mCasterID);
		AddValueOutput("类型(处理逻辑)ID", "buff类型", () => mBuffClass);
		AddValueOutput("数组下标", "buff索引", () => mBuffIndex);
		AddValueOutput("参数1", "buff参数1", () => mBuffParam1);
		AddValueOutput("参数2", "buff参数2", () => mBuffParam2);
		AddValueOutput("参数3", "buff参数3", () => mBuffParam3);
		AddValueOutput("参数4", "buff参数4", () => mBuffParam4);
		AddValueOutput("是否超时移除", () => mIsTimeout);
		mWantedBuffInput = AddValueInput<int>("类型(处理逻辑)ID", "期望buff类型");
	}
}
