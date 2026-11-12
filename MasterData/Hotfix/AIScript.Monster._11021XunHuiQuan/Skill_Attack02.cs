using System.Collections;

namespace AIScript.Monster._11021XunHuiQuan;

public class Skill_Attack02 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] C1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.C,
		ComboInputBuffer.ActionKey._1
	};

	protected readonly ComboInputBuffer.ActionKey[] C2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.C,
		ComboInputBuffer.ActionKey._2
	};

	protected override void OnSkillEnable()
	{
		SetSuperArmorEnable(autoDisableWhenSkillDisable: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		BeginAttack(1, C1, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(logicEntity, 0.5, 720);
		yield return WaitFrame(15);
		PlayAreaEffect("Area_11021_Warning", GetPosition());
		PlayAreaEffect("Area_11021_Light", GetPosition());
		yield return WaitFrame(45);
		BeginAttack(2, C2, flushInputedKeys: true, forceInterruptAttack: true);
		SetCloseBlockEnable();
		SetUnparalleledEnable();
		SetSearchedImmunityEnable();
		yield return WaitFrame(31);
		SetHideModelEnable();
		yield return WaitFrame(45);
		_actor.ClearSelf();
	}
}
