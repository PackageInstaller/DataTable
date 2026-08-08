using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能结束事件后三位(逻辑)", 0)]
[Category("Logic/事件")]
[Description("当技能结束事件时触发,被Ability中断也会触发,且此时已经完成了打断事件;\n如果不是被技能中断,或者衔接的行为是移动、待机、受击等渲染层行为,新的abilityID就输出0;")]
public class AbilityEndToActionIDEvent : EventNode
{
	private int m_entityID;

	private int m_oldAbilityID;

	private int m_oldActionID;

	private int m_newAbilityID;

	private int m_newActionID;

	private FlowOutput m_out;

	private FlowOutput m_error;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilityFinishLogicEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mAbilityFinishLogicEvent, new Action<int, int, int>(OnAbilityFinishEventHandler));
	}

	private void OnAbilityFinishEventHandler(int entityID, int oldAbilityID, int newAbilityID)
	{
		m_entityID = entityID;
		m_oldAbilityID = oldAbilityID;
		m_oldActionID = oldAbilityID % 1000;
		m_newAbilityID = newAbilityID;
		m_newActionID = newAbilityID % 1000;
		Flow f = new Flow
		{
			returnData = returnData
		};
		if (base.mSimContext.GetEntityWithEntityID(entityID) == null)
		{
			m_error.Call(f);
		}
		else
		{
			m_out.Call(f);
		}
	}

	protected override void RegisterPorts()
	{
		m_out = AddFlowOutput("当技能结束时");
		m_error = AddFlowOutput("Error", "error");
		AddValueOutput("实体ID", "entityID", () => m_entityID);
		AddValueOutput("结束的技能ID", "oldAbilityID", () => m_oldAbilityID);
		AddValueOutput("结束的后三位", "oldActionID", () => m_oldActionID);
		AddValueOutput("进入的技能ID", "newAbilityID", () => m_newAbilityID);
		AddValueOutput("进入的后三位", "newActionID", () => m_newActionID);
	}
}
