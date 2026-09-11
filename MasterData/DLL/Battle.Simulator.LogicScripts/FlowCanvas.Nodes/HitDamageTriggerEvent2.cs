using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中扣血触发器事件(技能ID)", 0)]
[Category("Logic/事件")]
[Description("命中扣血事件,在这个事件后面处理命中扣血, 条件为0时认为没有条件")]
public class HitDamageTriggerEvent2 : EventNode
{
	private int _attacker;

	private int _target;

	private int _abilityID;

	private int _triggerID;

	private int _hitIndex;

	private bool _isLastHit;

	private long _damage;

	private int _targetPartID;

	private DamageType _damageType;

	private FlowOutput _hitTarget;

	private int _thrownID;

	private int m_attributeIDOfAttacker;

	private int m_attributeIDOfTarget;

	private ValueInput<int> m_abilityIDInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		_hitTarget = AddFlowOutput("输出");
		AddValueOutput("触发器ID", "触发器ID", () => _triggerID);
		AddValueOutput("攻击者", "_attacker", () => _attacker);
		AddValueOutput("受击目标", "_target", () => _target);
		AddValueOutput("技能ID", "_abilityID", () => _abilityID);
		AddValueOutput("抛掷物唯一ID", "_thrownID", () => _thrownID);
		AddValueOutput("第几次判定", "_hitIndex", () => _hitIndex);
		AddValueOutput("是否是最后一次判定", "_isLastHit", () => _isLastHit);
		AddValueOutput("伤害值", "_damage", () => (int)_damage);
		AddValueOutput("伤害类型", "_damageType", () => _damageType);
		AddValueOutput("攻击者黑板ID", "attributeIDOfCaster", () => m_attributeIDOfAttacker);
		AddValueOutput("受击目标黑板ID", "attributeIDOfTarget", () => m_attributeIDOfTarget);
		AddValueOutput("命中部位", () => _targetPartID);
		m_abilityIDInput = AddValueInput<int>("技能ID", "abilityIDInput");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simulatorInferface = base.mLogicEvent;
		simulatorInferface.mCalcDamageTriggerEvent = (Action<int, DamageEventParam>)Delegate.Combine(simulatorInferface.mCalcDamageTriggerEvent, new Action<int, DamageEventParam>(OnHitTargetEventHandler));
	}

	private void OnHitTargetEventHandler(int triggerID, DamageEventParam param)
	{
		int casterID = param.casterID;
		int abilityID = param.abilityID;
		int targetID = param.targetID;
		int hitIndex = param.hitIndex;
		if (m_abilityIDInput.GetValue() != param.abilityID && m_abilityIDInput.value != 0)
		{
			return;
		}
		SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerID);
		if (simEntityByTriggerID != null && simEntityByTriggerID.entityTrigger.mEnabled)
		{
			_triggerID = triggerID;
			_abilityID = abilityID;
			_attacker = casterID;
			_target = targetID;
			_hitIndex = hitIndex;
			_thrownID = param.thrownID;
			_targetPartID = param.targetShapeID;
			m_attributeIDOfAttacker = AttributeProcessor.GetAttributeIDByEntityID(casterID);
			m_attributeIDOfTarget = AttributeProcessor.GetAttributeIDByEntityID(targetID);
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(_abilityID);
			AttributeProcessor.GetAttributeWithIntName(m_attributeIDOfAttacker, 2175, out _damage, out var plusValue, out var tempPlusValue);
			AttributeProcessor.GetAttributeWithIntName(m_attributeIDOfAttacker, 2176, out var baseValue, out plusValue, out tempPlusValue);
			_damageType = (DamageType)baseValue;
			if (config != null)
			{
				_isLastHit = config.HitTimeList.get_Item(config.HitTimeList.Count - 1).HitCheckID == _hitIndex;
			}
			Flow f = new Flow
			{
				returnData = returnData
			};
			_hitTarget.Call(f);
		}
	}
}
