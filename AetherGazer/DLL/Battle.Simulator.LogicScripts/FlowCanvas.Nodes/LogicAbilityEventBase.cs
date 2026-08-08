using System;
using System.Collections.Generic;

namespace FlowCanvas.Nodes;

public abstract class LogicAbilityEventBase : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected int m_entityID;

	protected int m_abilityID;

	protected int m_actionID;

	protected int m_logicTime;

	private FlowOutput m_output;

	public override string name
	{
		get
		{
			if (m_abilityID != 0)
			{
				return base.name + "_" + m_abilityID;
			}
			return base.name;
		}
	}

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateAbilityLogicEvent = (Action<int, int, int, int>)Delegate.Combine(simInterface.mUpdateAbilityLogicEvent, new Action<int, int, int, int>(LogicAbilityUpdateHandler));
	}

	public void LogicAbilityUpdateHandler(int entityID, int abilityID, int logicTime, int logicTimeStep)
	{
		m_entityID = entityID;
		m_abilityID = abilityID;
		m_actionID = abilityID % 1000;
		m_logicTime = logicTime;
		Flow f = new Flow
		{
			returnData = returnData
		};
		if (ConditionFunc((SimEntity)(f.userData = base.mSimContext.GetEntityWithEntityID(entityID)), abilityID, logicTime, m_actionID))
		{
			m_output.Call(f);
		}
	}

	protected abstract void AddCustomValueInput();

	protected abstract void AddCustionValueOutput();

	protected abstract bool ConditionFunc(SimEntity simEntity, int timelineID, int logicTime, int actionID);

	protected override void RegisterPorts()
	{
		AddBaseFlowOutput();
		AddCustomValueInput();
		AddBaseValueOutput();
		AddCustionValueOutput();
	}

	private void AddBaseFlowOutput()
	{
		m_output = AddFlowOutput("Out", "输出");
	}

	private void AddBaseValueOutput()
	{
		AddValueOutput("实体ID", "实体ID:", () => m_entityID);
		AddValueOutput("后三位", "actionID", () => m_actionID);
		AddValueOutput("时间(毫秒)", "时间:", () => m_logicTime);
		AddValueOutput("TimelineID(过时)", "技能ID:", () => m_abilityID);
	}
}
