using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("英雄命中实体成功（ID)(貌似没用)", 0)]
[Category("Common/事件")]
[Description("当攻击命中时触发")]
public class HeroAbilityHitEvent : EventNode
{
	private int _attacker;

	private int _target;

	private int _abilityID;

	private int _hitIndex;

	private bool _isLastHit;

	private Int3 _position;

	private int _targetPartID;

	private FlowOutput _hitTarget;

	private ValueInput<bool> _isRenderInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		_hitTarget = AddFlowOutput("输出");
		AddValueOutput("攻击者", () => _attacker);
		AddValueOutput("受击目标", () => _target);
		AddValueOutput("技能ID", () => _abilityID);
		AddValueOutput("第几次判定", () => _hitIndex);
		AddValueOutput("是否是最后一次判定", () => _isLastHit);
		AddValueOutput("判定发生位置", () => _position);
		AddValueOutput("受击目标", () => _targetPartID);
		_isRenderInput = AddValueInput<bool>("是否渲染");
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<HitTargetEvent>(OnHitTargetEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<HitTargetEvent>(OnHitTargetEventHandler);
		}
	}

	private void OnHitTargetEventHandler(HitTargetEvent triggerEvent)
	{
		SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(triggerEvent.mAttackerID);
		if (entityWithEntityID != null && !RoleCampProcessor.IsEnemy(entityWithEntityID.entityShape.mLayer))
		{
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
