using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("CD结束事件(触发器)", 0)]
[Category("Logic/事件")]
[Description("每次CD结束的时候会触发一次该事件")]
public class CDEndEventWithTriggerID : EventNode
{
	private ValueInput<int> m_roleIDInput;

	private ValueInput<int> m_actionIDInput;

	private int m_entityID;

	private int m_roleID;

	private int m_actionID;

	private int m_abilityID;

	private int m_usedCount;

	private int m_triggerID;

	protected FlowOutput m_output;

	protected Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		m_roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		m_actionIDInput = AddValueInput<int>("后三位", "actionID");
		AddValueOutput("实体ID", "entityID", () => m_entityID);
		AddValueOutput("实体类型ID", "roleID", () => m_roleID);
		AddValueOutput("后三位", "actionID", () => m_actionID);
		AddValueOutput("AbilityID", "abilityID", () => m_abilityID);
		AddValueOutput("已使用次数", "usedCount", () => m_usedCount);
		AddValueOutput("触发器ID", () => m_triggerID);
		m_output = AddFlowOutput("Out", "输出");
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simulatorInferface = base.mLogicEvent;
		simulatorInferface.mCDEndTriggerEvent = (Action<int, int, AbilityCD>)Delegate.Combine(simulatorInferface.mCDEndTriggerEvent, new Action<int, int, AbilityCD>(EvtHandler));
	}

	protected bool ConditionFunc(SimEntity simEntity, AbilityCD abilityCD)
	{
		int value = m_actionIDInput.GetValue();
		int value2 = m_roleIDInput.GetValue();
		if (value == 0 || value == m_actionID)
		{
			if (value2 != 0)
			{
				return value2 == m_roleID;
			}
			return true;
		}
		return false;
	}

	private void EvtHandler(int triggerID, int entityID, AbilityCD abilityCD)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig)
		{
			return;
		}
		SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerID);
		if (simEntityByTriggerID != null && simEntityByTriggerID.entityTrigger.mEnabled)
		{
			m_entityID = entityID;
			m_roleID = entityWithEntityID.entityConfig.mId;
			m_actionID = abilityCD.AbilityID % 1000;
			m_abilityID = abilityCD.AbilityID;
			m_usedCount = abilityCD.UsedCount;
			m_triggerID = triggerID;
			Flow f = new Flow
			{
				returnData = returnData,
				userData = base.mSimContext.GetEntityWithEntityID(entityID)
			};
			if (ConditionFunc(entityWithEntityID, abilityCD))
			{
				m_output.Call(f);
			}
		}
	}
}
