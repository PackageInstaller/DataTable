using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中扣血事件后", 0)]
[Category("Logic/事件")]
[Description("在命中扣血事件后面触发")]
public class AfterHitDamageEvent : FlowNode
{
	private int _attacker;

	private int _target;

	private int _abilityID;

	private int _hitIndex;

	private bool _isLastHit;

	private FlowOutput _hitTarget;

	private ValueInput<bool> m_ignroeAttackerStateInput;

	private long _damage;

	private DamageType _damageType;

	private int _thrownID;

	private int m_attributeIDOfAttacker;

	private long m_roleIDOfAttacker;

	private int m_attributeIDOfTarget;

	private long m_roleIDOfTarget;

	private int m_actionID;

	private int _targetPartID;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		_hitTarget = AddFlowOutput("输出");
		m_ignroeAttackerStateInput = AddValueInput<bool>("忽略攻击者生死", "ignoreAvlieState").SetDefaultAndSerializedValue(v: false);
		AddValueOutput("攻击者", () => _attacker);
		AddValueOutput("受击目标", () => _target);
		AddValueOutput("技能ID", () => _abilityID);
		AddValueOutput("后三位", "actionID", () => m_actionID);
		AddValueOutput("抛掷物唯一ID", () => _thrownID);
		AddValueOutput("第几次判定", () => _hitIndex);
		AddValueOutput("是否是最后一次判定", () => _isLastHit);
		AddValueOutput("伤害值", () => (int)_damage);
		AddValueOutput("伤害类型", () => _damageType);
		AddValueOutput("攻击者黑板ID", "attributeIDOfCaster", () => m_attributeIDOfAttacker);
		AddValueOutput("攻击者实体类型ID", "roleIDOfAttacker", () => (int)m_roleIDOfAttacker);
		AddValueOutput("受击目标黑板ID", "attributeIDOfTarget", () => m_attributeIDOfTarget);
		AddValueOutput("受击目标实体类型ID", "roleIDOfTarget", () => (int)m_roleIDOfTarget);
		AddValueOutput("命中部位", () => _targetPartID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mAfterCalcDamageEvent = (Action<DamageEventParam>)Delegate.Combine(simInterface.mAfterCalcDamageEvent, new Action<DamageEventParam>(OnAfterCalcDamageEventHandler));
	}

	private void OnAfterCalcDamageEventHandler(DamageEventParam param)
	{
		int casterID = param.casterID;
		if (m_ignroeAttackerStateInput.GetValue() || !AIProcessor.IsAIDeath(casterID))
		{
			int abilityID = param.abilityID;
			int targetID = param.targetID;
			int hitIndex = param.hitIndex;
			_attacker = casterID;
			_target = targetID;
			_abilityID = abilityID;
			_hitIndex = hitIndex;
			_thrownID = param.thrownID;
			_targetPartID = param.targetShapeID;
			m_attributeIDOfAttacker = AttributeProcessor.GetAttributeIDByEntityID(casterID);
			AttributeProcessor.GetAttributeWithIntName(m_attributeIDOfAttacker, 2189, out m_roleIDOfAttacker, out var plusValue, out var tempPlusValue);
			m_attributeIDOfTarget = AttributeProcessor.GetAttributeIDByEntityID(targetID);
			AttributeProcessor.GetAttributeWithIntName(m_attributeIDOfTarget, 2189, out m_roleIDOfTarget, out plusValue, out tempPlusValue);
			m_actionID = _abilityID % 1000;
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(_abilityID);
			if (config != null)
			{
				_isLastHit = config.HitTimeList.get_Item(config.HitTimeList.Count - 1).HitCheckID == _hitIndex;
			}
			base.mSimContext.GetEntityWithEntityID(casterID);
			AttributeProcessor.GetAttributeWithIntName(m_attributeIDOfAttacker, 2175, out _damage, out plusValue, out tempPlusValue);
			AttributeProcessor.GetAttributeWithIntName(m_attributeIDOfAttacker, 2176, out var baseValue, out plusValue, out tempPlusValue);
			_damageType = (DamageType)baseValue;
			Flow f = new Flow
			{
				returnData = returnData
			};
			_hitTarget.Call(f);
		}
	}
}
