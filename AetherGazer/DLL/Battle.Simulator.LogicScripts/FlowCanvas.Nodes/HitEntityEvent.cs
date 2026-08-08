using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中实体成功(不要用)", 0)]
[Category("Common/事件")]
[Description("当攻击命中时触发")]
public class HitEntityEvent : EventNode
{
	private SimEntity _attacker;

	private SimEntity _target;

	private int _abilityID;

	private int _hitIndex;

	private int _targetPartID;

	private FlowOutput _hitTarget;

	private ValueInput<bool> _isRenderInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	public override string name => $"{base.name}";

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		_attacker = null;
		_target = null;
	}

	protected override void RegisterPorts()
	{
		_hitTarget = AddFlowOutput("输出");
		AddValueOutput("攻击者", () => _attacker);
		AddValueOutput("受击目标", () => _target);
		AddValueOutput("技能ID", () => _abilityID);
		AddValueOutput("攻击次数", () => _hitIndex);
		AddValueOutput("命中部位", () => _targetPartID);
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
		_attacker = base.mSimContext.GetEntityWithEntityID(triggerEvent.mAttackerID);
		_target = base.mSimContext.GetEntityWithEntityID(triggerEvent.mTargetID);
		_abilityID = triggerEvent.mAbilityID;
		_hitIndex = triggerEvent.mHitIndex;
		_targetPartID = triggerEvent.mTargetPartID;
		Flow f = new Flow
		{
			returnData = returnData
		};
		_hitTarget.Call(f);
	}
}
