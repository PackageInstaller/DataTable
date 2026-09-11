using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Buff事件(高级筛选)(逻辑)", 0)]
[Category("Logic/事件")]
[Description("以实体类型ID，Buff配置Id，BuffClass筛选。0为忽略该项条件")]
public class BuffEventRoleAndConfig : EventNode
{
	private FlowOutput flowEnter;

	private FlowOutput flowTick;

	private FlowOutput flowLeave;

	private SimVar mBuffParam1;

	private SimVar mBuffParam2;

	private SimVar mBuffParam3;

	private SimVar mBuffParam4;

	private bool mIsTimeout;

	private ValueInput<int> vInBuffConfigId;

	private ValueInput<int> vInRoleId;

	private ValueInput<int> vInBuffClass;

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
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(ownerID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff)
		{
			return;
		}
		int value = vInRoleId.value;
		int value2 = vInBuffConfigId.value;
		int value3 = vInBuffClass.value;
		if ((value == 0 || entityWithEntityID.ENTITY_CONFIG_ID == value) && (value3 == 0 || buffClass == value3) && (value2 == 0 || entityWithEntityID.entityBuff.mBuffConfigID[buffIndex] == value2))
		{
			mOwnerID = ownerID;
			index = buffIndex;
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
		vInBuffConfigId = AddValueInput<int>("配置ID", "配置Id");
		vInRoleId = AddValueInput<int>("实体类型ID", "角色Id");
		vInBuffClass = AddValueInput<int>("类型(处理逻辑)ID", "处理逻辑");
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
