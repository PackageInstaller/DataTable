using System;
using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("命中判定检查(含抛掷物)", 0)]
[Category("Logic/事件")]
[Description("一个命中就只走一次，在判定完后返回总个数，抛掷物的命中判定检查走这个节点时这个端口输出的是抛掷物的根源TimelineID")]
public class AbilityThrownHitCheckEvent : EventNode
{
	private FlowOutput _outOutput;

	private ValueInput<int> _roleIDInput;

	private Stack<Flow.ReturnData> _returnData = new Stack<Flow.ReturnData>(16);

	private int _attacker;

	private int _abilityID;

	private int _hitIndex;

	private int _hitCount;

	private int _thrownAbilityID;

	private int _curAbilityID;

	private bool _isThrown;

	protected override void RegisterPorts()
	{
		_roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		_outOutput = AddFlowOutput("OUT");
		AddValueOutput("攻击者", "attacker", () => _attacker);
		AddValueOutput("技能或根源TimelineID", "AbilityID", () => _abilityID);
		AddValueOutput("是否为抛掷物", "IsThrown", () => _isThrown);
		AddValueOutput("抛掷物TImelineID", "ThrownTImelineID", () => _thrownAbilityID);
		AddValueOutput("技能ID", "curAbilityID", () => _curAbilityID);
		AddValueOutput("第几次判定", "HitIndex", () => _hitIndex);
		AddValueOutput("命中个数", "HitCount", () => _hitCount);
	}

	public override void OnGraphStarted()
	{
		ISimulatorInferface simInterface = base.mSimContext.GetSimInterface();
		simInterface.mHitCheckEvent = (Action<int, int, int, int>)Delegate.Combine(simInterface.mHitCheckEvent, new Action<int, int, int, int>(OnHitCheckEventHandler));
	}

	private void OnHitCheckEventHandler(int creationIndex, int abilityID, int hitIndex, int hitCount)
	{
		if (hitCount <= 0)
		{
			return;
		}
		_isThrown = false;
		if (creationIndex < 0)
		{
			ThrownState thrownState = null;
			if (!ThrownProcessor.TryGetThrown(base.mSimContext, creationIndex, out thrownState))
			{
				return;
			}
			if (_roleIDInput.GetValue() != 0)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(thrownState.mCasterID);
				if (entityWithEntityID == null || _roleIDInput.GetValue() != entityWithEntityID.entityConfig.mId)
				{
					return;
				}
			}
			_isThrown = true;
			_attacker = thrownState.mCasterID;
			_abilityID = thrownState.mCreatedRootTimelineID;
			_hitIndex = hitIndex;
			_hitCount = hitCount;
			_thrownAbilityID = abilityID;
			_curAbilityID = thrownState.mAbilityID;
		}
		else
		{
			SimEntity entityWithEntityID2 = base.mSimContext.GetEntityWithEntityID(creationIndex);
			if (_roleIDInput.GetValue() != 0 && _roleIDInput.value != entityWithEntityID2.entityConfig.mId)
			{
				return;
			}
			_isThrown = false;
			_attacker = creationIndex;
			_abilityID = abilityID;
			_hitIndex = hitIndex;
			_hitCount = hitCount;
			_thrownAbilityID = 0;
			_curAbilityID = abilityID;
		}
		Flow f = new Flow
		{
			returnData = _returnData
		};
		_outOutput.Call(f);
	}
}
