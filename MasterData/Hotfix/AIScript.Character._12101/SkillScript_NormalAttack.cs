using System;
using AdventureBehaviour;
using TrueSync;
using TrueSync.Physics2D;

namespace AIScript.Character._12101;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private int _attackCount;

	private string _attackTag;

	private int _hitIndex;

	private CommomAreaHitConfig _hitConfig;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			OnFinish();
			return;
		}
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("LastNormalAttackTime");
		if (_actor.LogicTime > logicTagValue + Config.SaveComboIndexTime)
		{
			_attackCount = 0;
		}
		else
		{
			_attackCount = (int)(long)_actor.logicVariable.GetLogicTagValue("NormalAttackCount");
		}
		_attackCount = MathUtils.Clamp(_attackCount, 0, Config.comboTagListNormalAttack.Count);
		_attackTag = Config.comboTagListNormalAttack.get_Item(_attackCount);
		_hitIndex = 0;
		string attackTag = _attackTag;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		BeginAttack(attackTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.logicVariable.SetLogicTagValue("LastNormalAttackTime", _actor.LogicTime);
	}

	protected void OnAnticipationEnd()
	{
		if (++_attackCount >= Config.comboTagListNormalAttack.Count)
		{
			_attackCount = 0;
		}
		_actor.logicVariable.SetLogicTagValue("NormalAttackCount", _attackCount);
	}

	private void OnCustomEvent(string eventName)
	{
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}
}
