using System.Collections;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill11_Spawn : SkillSimpleBase
{
	private string Spawn = "Spawn";

	protected override IEnumerator DoMainLogic()
	{
		SetSuperArmorEnable();
		GetAttackTarget(isUpToDate: true);
		while (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 10 && _actor.actorHealthInfo.hpPercentage == 1)
		{
			yield return null;
		}
		SetSuperArmorDisable();
		BeginAttack(1, Spawn, flushInputedKeys: true, forceInterruptAttack: true);
		ShowCenterHpBar();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
