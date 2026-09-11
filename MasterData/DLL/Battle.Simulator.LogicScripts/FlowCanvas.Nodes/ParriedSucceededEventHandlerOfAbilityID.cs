using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[格挡]格挡成功事件(行为ID)", 0)]
[Category("Common/事件/格挡")]
[Description("格挡成功时候,抛出来的事件;\n位置:目标身上作为判定的碰撞盒位置;")]
public class ParriedSucceededEventHandlerOfAbilityID : EventNode
{
	private int _attackerID;

	private int _targetID;

	private int _abilityID;

	private int _hitIndex;

	private Int3 _position = Int3.zero;

	private Int3 _direction = Int3.forward;

	private int _delay;

	private int _thrownID;

	private ValueInput<int> _specifyAbilityID;

	private FlowOutput _output;

	private ValueInput<bool> _isRenderInput;

	private Stack<Flow.ReturnData> returnData = new Stack<Flow.ReturnData>(16);

	protected override void RegisterPorts()
	{
		_specifyAbilityID = AddValueInput<int>("攻击者AbilityID", "abilityID");
		_output = AddFlowOutput("Out");
		AddValueOutput("攻击者ID", "attackerID", () => _attackerID);
		AddValueOutput("受击者ID", "targetID", () => _targetID);
		AddValueOutput("攻击者AbilityID", "abilityID", () => _abilityID);
		AddValueOutput("第几次判定", "hitIndex", () => _hitIndex);
		AddValueOutput("受击碰撞盒位置", "position", () => _position);
		AddValueOutput("判定来源方向", "direction", () => _direction);
		AddValueOutput("延迟(毫秒)", "delay", () => _delay);
		AddValueOutput("抛掷物ID", "thrownID", () => _thrownID);
		_isRenderInput = AddValueInput<bool>("是否渲染");
	}

	public override void OnGraphStarted()
	{
		if (!_isRenderInput.value)
		{
			base.mSimContext.SimEventSystem.AddHandler<EntityParrySucceededEvent>(onEventHandler);
		}
		else
		{
			base.mSimContext.SimToPresentationEventSystem.AddHandler<EntityParrySucceededEvent>(onEventHandler);
		}
	}

	private void onEventHandler(EntityParrySucceededEvent evt)
	{
		_attackerID = evt.mAttackerID;
		_targetID = evt.mTargetID;
		_abilityID = evt.mTimelineID;
		_hitIndex = evt.mHitIndex;
		_position = evt.mPosition;
		_direction = evt.mDirection;
		_delay = evt.mDelayTime;
		_thrownID = evt.mThrownID;
		if (_abilityID == _specifyAbilityID.value)
		{
			Flow f = new Flow
			{
				returnData = returnData
			};
			_output.Call(f);
		}
	}
}
