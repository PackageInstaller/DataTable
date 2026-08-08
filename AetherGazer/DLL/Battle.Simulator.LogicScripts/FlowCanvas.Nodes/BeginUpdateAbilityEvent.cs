using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("AbilityTick开始事件", 0)]
[Category("Logic/事件")]
[Description("AbilityTick开始事件, 在每一帧的技能执行事件之前触发")]
public class BeginUpdateAbilityEvent : EventNode
{
	private int m_entityID;

	private int m_actionID;

	private int m_logicTime;

	private FlowOutput m_output;

	private ValueInput<int> m_executeTime;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		m_output = AddFlowOutput("Out", "输出");
		AddValueOutput("实体ID", "实体ID:", () => m_entityID);
		AddValueOutput("后三位", "actionID", () => m_actionID);
		AddValueOutput("时间(毫秒)", "时间:", () => m_logicTime);
		m_executeTime = AddValueInput<int>("时间点", "executeTime");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mUpdateAbilityBeginLogicEvent = (Action<int, int, int, int>)Delegate.Combine(simInterface.mUpdateAbilityBeginLogicEvent, new Action<int, int, int, int>(LogicAbilityUpdate));
	}

	private void LogicAbilityUpdate(int entityID, int abilityID, int logicTime, int logicTimeStep)
	{
		Flow f = new Flow
		{
			returnData = returnData
		};
		if (logicTime >= m_executeTime.value && logicTime < m_executeTime.value + CommonProcessor.GetConfigInterval())
		{
			m_entityID = entityID;
			m_actionID = abilityID % 1000;
			m_logicTime = logicTime;
			m_output.Call(f);
		}
	}
}
