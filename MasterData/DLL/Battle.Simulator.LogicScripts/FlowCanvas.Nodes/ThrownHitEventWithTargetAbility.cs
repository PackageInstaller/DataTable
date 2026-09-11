using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("抛掷物命中实体成功（指定行为）", 0)]
[Category("Common/事件/抛掷物")]
[Description("抛掷物命中实体成功额外抛出来的事件")]
public class ThrownHitEventWithTargetAbility : EventNode
{
	private int m_thrownID;

	private int _target;

	private int _abilityID;

	private int _hitIndex;

	private bool _isLastHit;

	private int _targetPartID;

	private FlowOutput _hitTarget;

	private ValueInput<bool> _isRenderInput;

	private ValueInput<int> _ablityIDInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	protected override void RegisterPorts()
	{
		_hitTarget = AddFlowOutput("输出");
		AddValueOutput("抛掷物ID", () => m_thrownID);
		AddValueOutput("受击目标", () => _target);
		AddValueOutput("技能ID", () => _abilityID);
		AddValueOutput("第几次判定", () => _hitIndex);
		AddValueOutput("是否是最后一次判定", () => _isLastHit);
		AddValueOutput("命中部位", () => _targetPartID);
		_isRenderInput = AddValueInput<bool>("是否渲染");
		_ablityIDInput = AddValueInput<int>("技能ID");
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<HitTargetByThrownEvent>(OnHitTargetEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<HitTargetByThrownEvent>(OnHitTargetEventHandler);
		}
	}

	private void OnHitTargetEventHandler(HitTargetByThrownEvent triggerEvent)
	{
		_abilityID = triggerEvent.mAbilityID;
		if (_ablityIDInput.GetValue() == 0 || _abilityID == _ablityIDInput.GetValue())
		{
			m_thrownID = triggerEvent.mThrownID;
			_target = triggerEvent.mTargetID;
			_hitIndex = triggerEvent.mHitIndex;
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
