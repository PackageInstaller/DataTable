using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中扣血事件(指定实体类型)", 0)]
[Category("Logic/事件")]
[Description("命中扣血事件,在这个事件后面处理命中扣血, 条件为0时认为没有条件")]
public class HitDamageEvent : EventNode
{
	private int _attacker;

	private int _target;

	private int _abilityID;

	private int _hitIndex;

	private bool _isLastHit;

	private int _targetPartID;

	private int _damage;

	private DamageType _damageType;

	private FlowOutput _hitTarget;

	private int _thrownID;

	private int m_attributeIDOfAttacker;

	private int m_attributeIDOfTarget;

	private ValueInput<int> _ablityIDInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		_hitTarget = AddFlowOutput("输出");
		AddValueOutput("攻击者", () => _attacker);
		AddValueOutput("受击目标", () => _target);
		AddValueOutput("技能ID", () => _abilityID);
		AddValueOutput("抛掷物唯一ID", () => _thrownID);
		AddValueOutput("第几次判定", () => _hitIndex);
		AddValueOutput("是否是最后一次判定", () => _isLastHit);
		AddValueOutput("伤害值", () => _damage);
		AddValueOutput("伤害类型", () => _damageType);
		AddValueOutput("攻击者黑板ID", "attributeIDOfCaster", () => m_attributeIDOfAttacker);
		AddValueOutput("受击目标黑板ID", "attributeIDOfTarget", () => m_attributeIDOfTarget);
		AddValueOutput("命中部位", () => _targetPartID);
		_ablityIDInput = AddValueInput<int>("实体类型ID", "角色ID");
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mCalcDamageEvent = (Action<DamageEventParam>)Delegate.Combine(simInterface.mCalcDamageEvent, new Action<DamageEventParam>(OnHitTargetEventHandler));
	}

	private void OnHitTargetEventHandler(DamageEventParam param)
	{
		int casterID = param.casterID;
		int abilityID = param.abilityID;
		int targetID = param.targetID;
		int hitIndex = param.hitIndex;
		m_attributeIDOfAttacker = AttributeProcessor.GetAttributeIDByEntityID(casterID);
		AttributeProcessor.GetAttributeWithIntName(m_attributeIDOfAttacker, 2189, out var baseValue, out var plusValue, out var tempPlusValue);
		if (_ablityIDInput.value == baseValue || _ablityIDInput.value == 0)
		{
			_abilityID = abilityID;
			_attacker = casterID;
			_target = targetID;
			_hitIndex = hitIndex;
			_thrownID = param.thrownID;
			_targetPartID = param.targetShapeID;
			m_attributeIDOfTarget = AttributeProcessor.GetAttributeIDByEntityID(targetID);
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(_abilityID);
			AttributeProcessor.GetAttributeWithIntName(m_attributeIDOfAttacker, 2175, out var baseValue2, out plusValue, out tempPlusValue);
			AttributeProcessor.GetAttributeWithIntName(m_attributeIDOfAttacker, 2176, out var baseValue3, out plusValue, out tempPlusValue);
			_damage = (int)baseValue2;
			_damageType = (DamageType)baseValue3;
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
