using System;
using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中实体成功触发器事件（ID）", 0)]
[Category("Logic/事件")]
[Description("当攻击命中时触发")]
public class AbilityHitTriggerEvent : EventNode
{
	private int _attacker;

	private int _target;

	private int _targetPartID;

	private int _abilityID;

	private int _hitIndex;

	private bool _isLastHit;

	private Int3 _position;

	private int _triggerID;

	private FlowOutput _hitTarget;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		_hitTarget = AddFlowOutput("输出");
		AddValueOutput("触发器ID", "触发器ID", () => _triggerID);
		AddValueOutput("攻击者", () => _attacker);
		AddValueOutput("受击目标", () => _target);
		AddValueOutput("技能ID", () => _abilityID);
		AddValueOutput("第几次判定", () => _hitIndex);
		AddValueOutput("是否是最后一次判定", () => _isLastHit);
		AddValueOutput("判定发生位置", () => _position);
		AddValueOutput("命中部位", () => _targetPartID);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simulatorInferface = base.mLogicEvent;
		simulatorInferface.mHitTargetTriggerEvent = (Action<int, HitTargetEvent>)Delegate.Combine(simulatorInferface.mHitTargetTriggerEvent, new Action<int, HitTargetEvent>(OnHitTargetEventHandler));
	}

	private void OnHitTargetEventHandler(int triggerID, HitTargetEvent triggerEvent)
	{
		SimEntity simEntityByTriggerID = CommonProcessor.GetSimEntityByTriggerID(triggerID);
		if (simEntityByTriggerID != null && simEntityByTriggerID.entityTrigger.mEnabled)
		{
			_triggerID = triggerID;
			_attacker = triggerEvent.mAttackerID;
			_target = triggerEvent.mTargetID;
			_abilityID = triggerEvent.mAbilityID;
			_hitIndex = triggerEvent.mHitIndex;
			_position = triggerEvent.mPosition;
			_targetPartID = triggerEvent.mTargetPartID;
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
}
