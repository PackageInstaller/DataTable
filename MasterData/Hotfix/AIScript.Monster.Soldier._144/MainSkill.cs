using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._144;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Skill_1";

	private readonly FP loopDuration = 0.66;

	private readonly string eventName_GenerateAreaEffect = "Fire";

	private readonly int buffId = 250101801;

	private readonly string areaEffectKey = "AreaEffect_Skill_1";

	private readonly string comboTag_Potential = "Skill_2";

	private int _potentialLv;

	private bool _beginLoop;

	private FP _loopDuration;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_beginLoop = false;
		_loopDuration = 0;
	}

	public void OnStart()
	{
		string text = comboTag;
		if (_potentialLv >= 3)
		{
			text = comboTag_Potential;
		}
		string actionTag = text;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnAnticipationEnd()
	{
		if (_potentialLv < 3)
		{
			_loopDuration = loopDuration;
			_beginLoop = true;
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_GenerateAreaEffect))
		{
			_actor.buffComponent.AddBuff(buffId, _actor);
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
			ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey, position);
		}
	}

	public void OnUpdate()
	{
		if (_potentialLv >= 3)
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
