using System.Collections;

namespace AIScript.Monster._Earth._50001DaShou;

public class Skill_Earth_Attack01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1];

	private static readonly string BulletName = "Weapon_DanZhuTouShou_Dark_Bullet01";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "T1" && CheckTargetIsValid(GetAttackTarget()))
		{
			BeginLookAt_NotWait(GetAttackTarget(), 0.5, 720);
		}
		else if (eventName == "T2")
		{
			StopWaitLookAt();
		}
	}
}
