using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._144;

public class NormalSkill : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[6];

	private readonly ComboInputBuffer.ActionKey[] actionKeys_Potential1 = new ComboInputBuffer.ActionKey[6]
	{
		(ComboInputBuffer.ActionKey)1767333733,
		(ComboInputBuffer.ActionKey)1916888174,
		(ComboInputBuffer.ActionKey)1663983973,
		(ComboInputBuffer.ActionKey)115,
		ComboInputBuffer.ActionKey.B,
		(ComboInputBuffer.ActionKey)1933663279
	};

	private readonly int buffId_Check_Potential1 = 250101801;

	private readonly ComboInputBuffer.ActionKey[] actionKeys_Potential3 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private readonly FP loopDuration_Potential3 = 99;

	private readonly string eventName_GenerateAreaEffect_Potential3 = "Fire";

	private readonly string areaEffectKey_Potential3 = "AreaEffect_Skill_1";

	private int _potentialLv;

	private bool _beginLoop;

	private FP _loopDuration;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
	}

	public void OnStart()
	{
		ComboInputBuffer.ActionKey[] array = actionKeys;
		if (_potentialLv >= 3)
		{
			array = actionKeys_Potential3;
		}
		else if (_potentialLv >= 1 && _actor.buffComponent.CheckBuffByBuffID(buffId_Check_Potential1))
		{
			array = actionKeys_Potential1;
		}
		ComboInputBuffer.ActionKey[] keys = array;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		if (_potentialLv >= 3)
		{
			_loopDuration = loopDuration_Potential3;
			_beginLoop = true;
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (_potentialLv >= 3 && string.Equals(eventName, eventName_GenerateAreaEffect_Potential3))
		{
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey_Potential3, position);
		}
	}

	public void OnUpdate()
	{
		if (_potentialLv < 3)
		{
			return;
		}
		LockDirection();
		if (_beginLoop)
		{
			if (_loopDuration > 0)
			{
				_loopDuration -= _actor.LogicDeltaTime;
				return;
			}
			_beginLoop = false;
			comboAttack.CancelAttack();
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_beginLoop = false;
		_loopDuration = 0;
	}
}
