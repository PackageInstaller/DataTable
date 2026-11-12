using System;
using AdventureBehaviour;

namespace AIScript.Monster.Soldier._117;

public class NormalSkill : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[3];

	private const string eventName_Hit1 = "1";

	private readonly int damageId_Hit1 = 1011701011;

	private readonly string fxAlias_Hit1 = "fx_11701_bullet_atk_2";

	private const string eventName_Hit2 = "2";

	private readonly int damageId_Hit2 = 1011701012;

	private readonly string fxAlias_Hit2 = "fx_11701_bullet_atk_1";

	private const string eventName_Hit3 = "3";

	private readonly int damageId_Hit3 = 1011701013;

	private readonly string fxAlias_Hit3 = "fx_11701_bullet_atk_3";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.isChangeAimLockedTargetWhenCurrentAttackTargetInValid = false;
	}

	public void OnStart()
	{
		ComboInputBuffer.ActionKey[] keys = actionKeys;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (!(_actor.aimLockedTarget is AdventureActor target))
		{
			comboAttack?.InterruptAttack();
			return;
		}
		int num = 0;
		string empty = string.Empty;
		switch (eventName)
		{
		default:
			return;
		case "1":
			num = damageId_Hit1;
			empty = fxAlias_Hit1;
			break;
		case "2":
			num = damageId_Hit2;
			empty = fxAlias_Hit2;
			break;
		case "3":
			num = damageId_Hit3;
			empty = fxAlias_Hit3;
			break;
		}
		ILRuntimeAPI.HitActor(_actor, target, num, null, empty, attackFxPlayOnTarget: true);
	}

	public void OnUpdate()
	{
		LockDirection();
		if (_actor.aimLockedTarget == null)
		{
			comboAttack?.InterruptAttack();
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
}
