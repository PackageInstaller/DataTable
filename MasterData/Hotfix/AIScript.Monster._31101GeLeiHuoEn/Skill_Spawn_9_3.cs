using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Skill_Spawn_9_3 : SkillSimpleBase
{
	private readonly string combo_key1 = "Maline_9_3";

	private readonly string fx_Alias = "fx_m31101_base_Skill1_fenshen";

	private string tag1 = "Small";

	protected TSVector2 TargetPosition;

	private LogicEntity Targetenemy;

	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		InitListenEvent(MonsterEventType.MonsterDie, true, InterruptStrong, 1900307);
	}

	private void InterruptStrong(IEvent evt)
	{
		KillActors(new List<LogicEntity> { _actor });
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayEffect(fx_Alias, 1f, default, GetPosition(), GetEntityAngle(_actor));
		if (GetMonsterTagValue(_actor, 1) != tag1)
		{
			yield return WaitTime(1);
		}
		else
		{
			yield return WaitTime(5);
		}
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 0.5, 7200);
		yield return WaitTime(0.5);
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		Skill_Spawn_9_3 skill_Spawn_9_ = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Spawn_9_.PlayEarlyWarningEffect("fx_warning_square_3side_2x17.5", 1.4f, default, position, rotation, 1.5f);
		yield return WaitTime(0.9);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.1);
		PlayEffect(fx_Alias, 1f, default, GetPosition(), GetEntityAngle(_actor));
		yield return WaitTime(0.1);
		ClearActors(new List<LogicEntity> { _actor });
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
