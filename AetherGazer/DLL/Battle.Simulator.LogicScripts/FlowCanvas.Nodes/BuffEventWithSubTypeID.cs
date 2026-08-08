using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Buff事件(子类型)(逻辑)", 0)]
[Category("Logic/事件")]
[Description("身上的buff处理")]
public class BuffEventWithSubTypeID : EventNode
{
	private int m_ownerID;

	private int m_casterID;

	private int m_buffClassID;

	private int m_buffIndex;

	private int m_buffConfigId;

	private int m_buffLevel;

	private SimVar m_buffParam1;

	private SimVar m_buffParam2;

	private SimVar m_buffParam3;

	private SimVar m_buffParam4;

	private bool mIsTimeout;

	private FlowOutput m_add;

	private FlowOutput m_tick;

	private FlowOutput m_remove;

	private ValueInput<string> m_subTypeInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		m_add = AddFlowOutput("增加", "进入");
		m_tick = AddFlowOutput("触发", "触发");
		m_remove = AddFlowOutput("移除", "结束");
		m_subTypeInput = AddValueInput<string>("子类型", "expectationSubType");
		AddValueOutput("持有者实体ID", "ownerID", () => m_ownerID);
		AddValueOutput("释放者实体ID", "casterID", () => m_casterID);
		AddValueOutput("类型(处理逻辑)ID", "buffClassID", () => m_buffClassID);
		AddValueOutput("配置ID", "buffConfigID", () => m_buffConfigId);
		AddValueOutput("Buff等级", "buffLevel", () => m_buffLevel);
		AddValueOutput("数组下标", "buffIndex", () => m_buffIndex);
		AddValueOutput("参数1", "buffParam1", () => m_buffParam1);
		AddValueOutput("参数2", "buffParam2", () => m_buffParam2);
		AddValueOutput("参数3", "buffParam3", () => m_buffParam3);
		AddValueOutput("参数4", "buffParam4", () => m_buffParam4);
		AddValueOutput("是否超时移除", () => mIsTimeout);
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateBuffLogicEvent = (Action<int, int, int, EBuffLife, bool>)Delegate.Combine(simInterface.mUpdateBuffLogicEvent, new Action<int, int, int, EBuffLife, bool>(LogicBuffUpdate));
	}

	public void LogicBuffUpdate(int ownerID, int buffIndex, int buffClass, EBuffLife buffLife, bool isTimeout)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(ownerID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff)
		{
			return;
		}
		int num = entityWithEntityID.entityBuff.mBuffConfigID[buffIndex];
		if (num == 0)
		{
			return;
		}
		public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(num);
		if (config != null && BuffSubTypeComparer.ContainsAny(m_subTypeInput.value, config.SubType))
		{
			m_ownerID = ownerID;
			m_buffClassID = buffClass;
			m_buffIndex = buffIndex;
			m_casterID = entityWithEntityID.entityBuff.mBuffCasterArray[buffIndex];
			m_buffLevel = entityWithEntityID.entityBuff.mBuffFloor[buffIndex];
			m_buffConfigId = num;
			BuffParams buffParams = entityWithEntityID.entityBuff.mBuffParamsArray[buffIndex];
			m_buffParam1 = buffParams.v1;
			m_buffParam2 = buffParams.v2;
			m_buffParam3 = buffParams.v3;
			m_buffParam4 = buffParams.v4;
			mIsTimeout = isTimeout;
			Flow f = new Flow
			{
				returnData = returnData
			};
			if (buffLife == EBuffLife.Bind)
			{
				m_add.Call(f);
			}
			if (buffLife == EBuffLife.Tick)
			{
				m_tick.Call(f);
			}
			if (buffLife == EBuffLife.Leave)
			{
				m_remove.Call(f);
			}
		}
	}
}
