using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Buff事件(类型(处理逻辑)ID)(多重)(逻辑)", 0)]
[Category("Logic/事件")]
[Description("")]
public class BuffEventWithBuffClassIDs : EventNode
{
	private ValueInput<List<int>> _BuffClassIDsInput;

	private FlowOutput flowEnter;

	private FlowOutput flowTick;

	private FlowOutput flowLeave;

	private SimVar mBuffParam1;

	private SimVar mBuffParam2;

	private SimVar mBuffParam3;

	private SimVar mBuffParam4;

	private bool mIsTimeout;

	private int mOwnerID;

	private int mCasterID;

	private int index;

	private int configID;

	private int level;

	private int _buffClassID;

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

	protected override void RegisterPorts()
	{
		_BuffClassIDsInput = AddValueInput<List<int>>("类型(处理逻辑)ID组", "buffClassIDs");
		flowEnter = AddFlowOutput("增加", "进入");
		flowTick = AddFlowOutput("触发", "触发");
		flowLeave = AddFlowOutput("移除", "结束");
		AddValueOutput("持有者实体ID", "作用对象ID", () => mOwnerID);
		AddValueOutput("释放者实体ID", "添加者ID", () => mCasterID);
		AddValueOutput("数组下标", "索引", () => index);
		AddValueOutput("配置ID", "配置ID", () => configID);
		AddValueOutput("类型(处理逻辑)ID", "buffClassID", () => _buffClassID);
		AddValueOutput("Buff等级", "BUFF等级", () => level);
		AddValueOutput("参数1", "参数1", () => mBuffParam1);
		AddValueOutput("参数2", "参数2", () => mBuffParam2);
		AddValueOutput("参数3", "参数3", () => mBuffParam3);
		AddValueOutput("参数4", "参数4", () => mBuffParam4);
		AddValueOutput("是否超时移除", () => mIsTimeout);
	}

	private void LogicBuffUpdate(int ownerID, int buffIndex, int buffClass, EBuffLife buffLife, bool isTimeout)
	{
		if (!_BuffClassIDsInput.GetValue().Contains(buffClass))
		{
			return;
		}
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(ownerID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityBuff)
		{
			mOwnerID = ownerID;
			index = buffIndex;
			configID = entityWithEntityID.entityBuff.mBuffConfigID[buffIndex];
			level = entityWithEntityID.entityBuff.mBuffFloor[buffIndex];
			_buffClassID = entityWithEntityID.entityBuff.mBuffClassIDArray[buffIndex];
			BuffParams buffParams = entityWithEntityID.entityBuff.mBuffParamsArray[buffIndex];
			mCasterID = entityWithEntityID.entityBuff.mBuffCasterArray[buffIndex];
			mBuffParam1 = buffParams.v1;
			mBuffParam2 = buffParams.v2;
			mBuffParam3 = buffParams.v3;
			mBuffParam4 = buffParams.v4;
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
}
