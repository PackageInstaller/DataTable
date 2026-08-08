using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中扣血事件前", 0)]
[Category("Logic/事件")]
[Description("在命中扣血事件前面触发")]
public class BeforeHitDamageEvent : FlowNode
{
	private int _attacker;

	private int _target;

	private int _abilityID;

	private int _hitIndex;

	private int _targetPartID;

	private bool _isLastHit;

	private FlowOutput _hitTarget;

	private int _thrownID;

	private int m_attributeIDOfAttacker;

	private int m_attributeIDOfTarget;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		_hitTarget = AddFlowOutput("输出");
		AddValueOutput("攻击者", () => _attacker);
		AddValueOutput("受击目标", () => _target);
		AddValueOutput("技能ID", () => _abilityID);
		AddValueOutput("抛掷物唯一ID", () => _thrownID);
		AddValueOutput("第几次判定", () => _hitIndex);
		AddValueOutput("是否是最后一次判定", () => _isLastHit);
		AddValueOutput("攻击者黑板ID", "attributeIDOfCaster", () => m_attributeIDOfAttacker);
		AddValueOutput("受击目标黑板ID", "attributeIDOfTarget", () => m_attributeIDOfTarget);
		AddValueOutput("命中部位", () => _targetPartID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mBeforeCalcDamageEvent = (Action<DamageEventParam>)Delegate.Combine(simInterface.mBeforeCalcDamageEvent, new Action<DamageEventParam>(OnBeforeCalcDamageEventHandler));
	}

	private void OnBeforeCalcDamageEventHandler(DamageEventParam param)
	{
		int casterID = param.casterID;
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
		m_attributeIDOfTarget = AttributeProcessor.GetAttributeIDByEntityID(targetID);
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(_abilityID);
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
