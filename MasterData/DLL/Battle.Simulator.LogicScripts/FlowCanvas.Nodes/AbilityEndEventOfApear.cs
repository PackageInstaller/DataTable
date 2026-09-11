using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("出场结束事件(逻辑)", 0)]
[Category("Logic/事件")]
[Description("当出场结束事件时触发,被Ability中断也会触发;\n如果不是被技能中断,新的abilityID就输出0;\n如果技能被Hit中断,则会走【当技能被Hit打断时】")]
public class AbilityEndEventOfApear : EventNode
{
	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	private int m_entityID;

	private int m_oldAbilityID;

	private int m_oldActionID;

	private int m_newAbilityID;

	private int m_newActionID;

	private FlowOutput m_out;

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAbilityFinishLogicEvent = (Action<int, int, int>)Delegate.Combine(simInterface.mAbilityFinishLogicEvent, new Action<int, int, int>(OnAbilityFinishEventHandler));
	}

	protected override void RegisterPorts()
	{
		m_out = AddFlowOutput("当技能结束时", "out");
		AddValueOutput("实体ID", "entityID", () => m_entityID);
		AddValueOutput("结束的技能ID(过时)", "oldAbilityID", () => m_oldAbilityID);
		AddValueOutput("结束的后三位", "oldActionID", () => m_oldActionID);
		AddValueOutput("进入的技能ID(过时)", "newAbilityID", () => m_newAbilityID);
		AddValueOutput("进入的后三位", "newActionID", () => m_newActionID);
	}

	private void OnAbilityFinishEventHandler(int entityID, int oldAbilityID, int newAbilityID)
	{
		m_entityID = entityID;
		m_oldAbilityID = oldAbilityID;
		m_oldActionID = oldAbilityID % 1000;
		m_newAbilityID = newAbilityID;
		m_newActionID = newAbilityID % 1000;
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
		if (entityWithEntityID != null && entityWithEntityID.hasEntityConfig)
		{
			Flow f = new Flow
			{
				returnData = returnData
			};
			RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(entityWithEntityID.ENTITY_CONFIG_ID);
			if (config != null && oldAbilityID == config.Appear)
			{
				m_out.Call(f);
			}
		}
	}
}
