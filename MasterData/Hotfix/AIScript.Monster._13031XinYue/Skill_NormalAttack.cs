using System.Collections;
using TrueSync;

namespace AIScript.Monster._13031XinYue;

public class Skill_NormalAttack : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private TSVector2 TargetPosition;

	protected override IEnumerator DoMainLogic()
	{
		TargetPosition = GetEntityPositionObsoleted(GetAttackTarget());
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Shoot");
		FanMultipleShoot("Weapon_13031XinYue_Bomb", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, 1, 0, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.2, 0.4)), 1.9, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 1, 0, 0, TargetPosition);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
