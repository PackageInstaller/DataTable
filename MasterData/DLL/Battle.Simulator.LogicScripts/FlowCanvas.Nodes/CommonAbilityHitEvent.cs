using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中实体成功（通用）", 0)]
[Category("Common/事件")]
[Description("当攻击命中时触发。输入参数为0时则表示该项不为筛选条件\n过滤起始/结束时间：指攻击方技能的执行范围区间，单位ms，开区间。两个值均为0时才不会作为筛选条件\n如果不是抛掷物，则抛掷物ID为0")]
public class CommonAbilityHitEvent : EventNode
{
	private int _attacker;

	private int _target;

	private int _abilityID;

	private int _thrownID;

	private int _hitIndex;

	private bool _isLastHit;

	private Int3 _position;

	private int _targetPartID;

	private FlowOutput _hitTarget;

	private ValueInput<bool> _isRenderInput;

	private ValueInput<int> _entityIDInput;

	private ValueInput<int> _targetIDInput;

	private ValueInput<int> _abilityIDIDInput;

	private ValueInput<int> _minTime;

	private ValueInput<int> _maxTime;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		_hitTarget = AddFlowOutput("输出");
		AddValueOutput("攻击者", () => _attacker);
		AddValueOutput("受击目标", () => _target);
		AddValueOutput("技能ID", () => _abilityID);
		AddValueOutput("抛掷物ID", () => _thrownID);
		AddValueOutput("第几次判定", () => _hitIndex);
		AddValueOutput("是否是最后一次判定", () => _isLastHit);
		AddValueOutput("判定发生位置", () => _position);
		AddValueOutput("命中部位", () => _targetPartID);
		_isRenderInput = AddValueInput<bool>("是否渲染");
		_entityIDInput = AddValueInput<int>("实体类型ID", "角色ID");
		_targetIDInput = AddValueInput<int>("目标实体类型ID", "目标角色ID");
		_abilityIDIDInput = AddValueInput<int>("技能");
		_minTime = AddValueInput<int>("过滤起始时间");
		_maxTime = AddValueInput<int>("过滤结束时间");
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
		if (entityWithEntityID == null)
		{
			return;
		}
		SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(triggerEvent.mTargetID);
		if (entityWithEntityID2 != null && (_entityIDInput.value == 0 || !(entityWithEntityID.ENTITY_CONFIG_ID != _entityIDInput.value)) && (_targetIDInput.value == 0 || !(entityWithEntityID2.ENTITY_CONFIG_ID != _targetIDInput.value)) && (_abilityIDIDInput.value == 0 || triggerEvent.mAbilityID == _abilityIDIDInput.value) && ((_minTime.value == 0 && _maxTime.value == 0) || (entityWithEntityID.entityActionAbility.mLogicTime >= _minTime.value && entityWithEntityID.entityActionAbility.mLogicTime <= _maxTime.value)))
		{
			_attacker = triggerEvent.mAttackerID;
			_target = triggerEvent.mTargetID;
			_abilityID = triggerEvent.mAbilityID;
			_thrownID = triggerEvent.mThrownID;
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
