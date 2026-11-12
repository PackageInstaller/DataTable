using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster._11901111Hanahara;

public class SkillScript_Boomerang : SkillSimpleBase
{
	private string key = "119FenShen_Skill_T10";

	private string evt_shoot = "119FenShen_ShootBoomerang";

	private string bullut = "Bullet_11901_Skill1_T10_BulltA";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, key, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName.Equals(evt_shoot))
		{
			ILRuntimeAPI.Shoot(bullut, _actor, _actor.tsTransform.Position, _actor.tsTransform.Forward);
		}
	}
}
