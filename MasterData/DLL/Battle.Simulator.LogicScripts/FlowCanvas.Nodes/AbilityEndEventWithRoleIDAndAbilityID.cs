using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("技能结束事件(技能ID)", 0)]
[Category("Logic/事件")]
[Description("当技能结束事件时触发,被Ability中断也会触发,且此时已经完成了打断事件;\n如果不是被技能中断,或者衔接的行为是移动、待机、受击等渲染层行为,新的abilityID就输出0;")]
public class AbilityEndEventWithRoleIDAndAbilityID : EventNode
{
	private FlowOutput m_output;

	private FlowOutput m_error;

	private Stack<Flow.ReturnData> m_returnData = new Stack<Flow.ReturnData>(16);

	private ValueInput<int> m_abilityIDVar;

	private int m_entityID;

	private int m_oldAbilityID;

	private int m_newAbilityID;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilityFinishLogicEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mAbilityFinishLogicEvent, new Action<int, int, int>(OnAbilityFinishEventHandler));
	}

	public void OnAbilityFinishEventHandler(int entityID, int oldAbilityID, int newAbilityID)
	{
		int value = m_abilityIDVar.GetValue();
		if (value == 0 || oldAbilityID == value)
		{
			Flow f = new Flow
			{
				returnData = m_returnData
			};
			if (base.mSimContext.GetEntityWithEntityID(entityID) == null)
			{
				m_error.Call(f);
				return;
			}
			m_entityID = entityID;
			m_oldAbilityID = oldAbilityID;
			m_newAbilityID = newAbilityID;
			m_output.Call(f);
		}
	}

	protected override void RegisterPorts()
	{
		m_abilityIDVar = AddValueInput<int>("技能ID", "m_abilityIDVar");
		m_output = AddFlowOutput("Out");
		m_error = AddFlowOutput("Error", "error");
		AddValueOutput("实体ID:", () => m_entityID);
		AddValueOutput("结束的技能ID:", () => m_oldAbilityID);
		AddValueOutput("新的技能ID:", () => m_newAbilityID);
	}
}
