using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中击杀事件(过时)", 0)]
[Category("Logic/事件")]
[Description("命中击杀事件, 攻击者一定要存活才会走")]
public class HitKillEvent : EventNode
{
	private FlowOutput m_killTarget;

	private ValueInput<int> m_attackerRoleID;

	private int m_attacker;

	private int m_target;

	private int m_targetPartID;

	private int m_abilityID;

	private int m_thrownID;

	private int m_hitIndex;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		m_killTarget = AddFlowOutput("输出");
		m_attackerRoleID = AddValueInput<int>("攻击者实体类型ID");
		AddValueOutput("攻击者", () => m_attacker);
		AddValueOutput("受击目标", () => m_target);
		AddValueOutput("技能ID", () => m_abilityID);
		AddValueOutput("抛掷物唯一ID", () => m_thrownID);
		AddValueOutput("第几次判定", () => m_hitIndex);
		AddValueOutput("命中部位", () => m_targetPartID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAfterCalcDamageEvent = (Action<DamageEventParam>)Delegate.Combine(simInterface.mAfterCalcDamageEvent, new Action<DamageEventParam>(OnAfterCalcDamageEventHandler));
	}

	private void OnAfterCalcDamageEventHandler(DamageEventParam param)
	{
		if (AIProcessor.IsAIDeath(param.casterID))
		{
			return;
		}
		int value = m_attackerRoleID.value;
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(param.casterID);
		if (value == 0 || !entityWithEntityID.hasEntityConfig || entityWithEntityID.entityConfig.mId == value)
		{
			SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(param.targetID);
			AttributeProcessor.GetAttributeWithIntName(AttributeProcessor.GetAttributeIDByEntityID(param.casterID), 2175, out var baseValue, out var _, out var _);
			if (entityWithEntityID2.entityBlackboard.var.mHP <= baseValue)
			{
				m_attacker = param.casterID;
				m_target = param.targetID;
				m_abilityID = param.abilityID;
				m_thrownID = param.thrownID;
				m_hitIndex = param.hitIndex;
				m_targetPartID = param.targetShapeID;
				Flow f = new Flow
				{
					returnData = returnData
				};
				m_killTarget.Call(f);
			}
		}
	}
}
