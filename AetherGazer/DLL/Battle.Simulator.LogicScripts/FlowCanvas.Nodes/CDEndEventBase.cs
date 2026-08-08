using System;
using System.Collections.Generic;

namespace FlowCanvas.Nodes;

public abstract class CDEndEventBase : EventNode
{
	protected Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected int m_entityID;

	protected int m_roleID;

	protected int m_actionID;

	protected int m_abilityID;

	protected int m_usedCount;

	protected FlowOutput m_output;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mCDEndEvent = (Action<int, AbilityCD>)Delegate.Combine(simInterface.mCDEndEvent, new Action<int, AbilityCD>(EvtHandler));
	}

	private void EvtHandler(int entityID, AbilityCD abilityCD)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig)
		{
			m_entityID = entityID;
			m_roleID = entityWithEntityID.entityConfig.mId;
			m_actionID = abilityCD.AbilityID % 1000;
			m_abilityID = abilityCD.AbilityID;
			m_usedCount = abilityCD.UsedCount;
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

	protected abstract void AddCustomValueInput();

	protected abstract void AddCustionValueOutput();

	protected abstract bool ConditionFunc(SimEntity simEntity, AbilityCD abilityCD);

	protected override void RegisterPorts()
	{
		AddCustomValueInput();
		AddBaseValueOutput();
		AddCustionValueOutput();
		AddBaseFlowOutput();
	}

	private void AddBaseValueOutput()
	{
		AddValueOutput("实体ID", "entityID", () => m_entityID);
		AddValueOutput("实体类型ID", "roleID", () => m_roleID);
		AddValueOutput("后三位", "actionID", () => m_actionID);
		AddValueOutput("AbilityID", "abilityID", () => m_abilityID);
		AddValueOutput("已使用次数", "usedCount", () => m_usedCount);
	}

	private void AddBaseFlowOutput()
	{
		m_output = AddFlowOutput("Out", "输出");
	}
}
