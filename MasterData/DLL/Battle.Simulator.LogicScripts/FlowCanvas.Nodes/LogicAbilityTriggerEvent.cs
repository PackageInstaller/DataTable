using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能执行触发器事件", 0)]
[Category("Logic/事件")]
[Description("技能Update时调用的触发器事件, 不填条件的话, 就认为没有条件")]
public class LogicAbilityTriggerEvent : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected int m_triggerID;

	protected int m_entityID;

	protected int m_abilityID;

	protected int m_actionID;

	protected int m_logicTime;

	private FlowOutput m_output;

	private ValueInput<int> m_roleIDInput;

	private ValueInput<int> m_actionIDInput;

	private ValueInput<int> m_timeInput;

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
		ISimulatorInferface simulatorInferface = base.mLogicEvent;
		simulatorInferface.mUpdateAbilityLogicTriggerEvent = (Action<int, int, int, int, int>)Delegate.Combine(simulatorInferface.mUpdateAbilityLogicTriggerEvent, new Action<int, int, int, int, int>(OnLogicAbilityUpdateTriggerEventHandler));
	}

	protected override void RegisterPorts()
	{
		m_roleIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		m_actionIDInput = AddValueInput<int>("行为ID(后三位)");
		m_timeInput = AddValueInput<int>("时间(毫秒)");
		AddBaseFlowOutput();
		AddBaseValueOutput();
	}

	private void OnLogicAbilityUpdateTriggerEventHandler(int triggerID, int entityID, int abilityID, int logicTime, int logicTimeStep)
	{
		SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerID);
		if (simEntityByTriggerID != null && simEntityByTriggerID.entityTrigger.mEnabled)
		{
			m_triggerID = triggerID;
			m_entityID = entityID;
			m_abilityID = abilityID;
			m_actionID = abilityID % 1000;
			m_logicTime = logicTime;
			Flow f = new Flow
			{
				returnData = returnData
			};
			SimEntity simEntity = (SimEntity)(f.userData = base.mSimContext.GetEntityWithEntityID(entityID));
			int value = m_roleIDInput.value;
			int value2 = m_actionIDInput.value;
			int value3 = m_timeInput.value;
			if ((value == 0 || value == simEntity.ENTITY_CONFIG_ID.intVar) && (value2 == 0 || value2 == m_actionID) && (value3 == 0 || (value3 >= logicTime && value3 < logicTime + logicTimeStep)))
			{
				m_output.Call(f);
			}
		}
	}

	private void AddBaseFlowOutput()
	{
		m_output = AddFlowOutput("Out", "输出");
	}

	private void AddBaseValueOutput()
	{
		AddValueOutput("触发器ID", "触发器ID:", () => m_triggerID);
		AddValueOutput("实体ID", "实体ID:", () => m_entityID);
		AddValueOutput("后三位", "actionID", () => m_actionID);
		AddValueOutput("时间(毫秒)", "时间:", () => m_logicTime);
		AddValueOutput("TimelineID(过时)", "技能ID:", () => m_abilityID);
	}
}
