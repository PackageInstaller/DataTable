using System.Collections;

namespace AIScript.Monster._50801QiEBaoXiang;

public class Skill_Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	protected override IEnumerator DoMainLogic()
	{
		SetSuperArmorEnable();
		GetAttackTarget(isUpToDate: true);
		while (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 10 && _actor.actorHealthInfo.hpPercentage == 1)
		{
			yield return null;
		}
		SetSuperArmorDisable();
		BeginAttack(1, Spawn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		ShowCenterHpBar();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
