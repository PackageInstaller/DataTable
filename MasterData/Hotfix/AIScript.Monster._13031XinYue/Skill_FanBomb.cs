using System.Collections;
using TrueSync;

namespace AIScript.Monster._13031XinYue;

public class Skill_FanBomb : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly FP MaxDistance = 10;

	private static readonly FP MinDistance = 4;

	private TSVector2 TargetPosition;

	private FP AttackDistance;

	private int BulletAmount;

	protected override IEnumerator DoMainLogic()
	{
		TargetPosition = GetEntityPositionObsoleted(GetAttackTarget());
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Shoot");
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			TargetPosition = GetEntityPositionObsoleted(GetAttackTarget());
		}
		AttackDistance = Distance(TargetPosition, GetPosition());
		if (AttackDistance >= MaxDistance)
		{
			AttackDistance = MaxDistance;
		}
		else if (AttackDistance <= MinDistance)
		{
			AttackDistance = MinDistance;
		}
		BulletAmount = (int)(long)TSMath.Clamp(AttackDistance - 2, 4, 6);
		FanMultipleShoot("Weapon_13031XinYue_Bomb", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, 0, BulletAmount, 0.1, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0.2, 0.4)), 1.9, GetForward(), 0, AimType.Default, BulletDirectionType.BulletToTarget, 100, AttackDistance, 0, TargetPosition);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
