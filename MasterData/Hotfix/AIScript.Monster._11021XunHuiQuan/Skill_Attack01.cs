using System.Collections;

namespace AIScript.Monster._11021XunHuiQuan;

public class Skill_Attack01 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] A1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1
	};

	protected readonly ComboInputBuffer.ActionKey[] A2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._2
	};

	protected override void OnSkillEnable()
	{
		SetSuperArmorEnable(autoDisableWhenSkillDisable: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
		BeginAttack(1, A1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(21);
		BeginLookAt_NotWait(Targetenemy, 0.1, 720);
		yield return WaitFrame(20);
		BeginTrace(Targetenemy, 2, -1, 5);
		yield return WaitTraceFinish();
		PlayAreaEffect("Area_11021_Warning", GetPosition());
		PlayAreaEffect("Area_11021_Light", GetPosition());
		yield return WaitFrame(45);
		BeginAttack(2, A2, flushInputedKeys: true, forceInterruptAttack: true);
		SetCloseBlockEnable();
		SetUnparalleledEnable();
		SetSearchedImmunityEnable();
		yield return WaitFrame(31);
		SetHideModelEnable();
		yield return WaitFrame(45);
		_actor.ClearSelf();
	}
}
