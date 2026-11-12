using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._17031ZhongNuJingYingQiShi;

public class Skill2_ParabolaArrow : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private long fx_start;

	private int ShootCount;

	protected override void OnSkillEnable()
	{
		ShootCount = 0;
	}

	protected override void OnSkillDisable()
	{
		StopEffect(fx_start);
	}

	protected override IEnumerator DoMainLogic()
	{
		while (true)
		{
			BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
			TSVector2 Startpos = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0));
			List<FP> shootradiusList = new List<FP> { 10, 22 };
			yield return WaitCustomEvent("fxevent");
			fx_start = PlayEffect("fx_17031_base_xuli_4", 1f, 1, default, default, 1f, actorScale: true);
			yield return WaitCustomEvent("Shoot");
			StopEffect(fx_start);
			TSVector2 targetPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, shootradiusList.get_Item(ShootCount % 2)));
			FanMultipleShoot("Bullet_BlastParabola", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, Startpos, 3, GetForward(), 0, AimType.Position, BulletDirectionType.BulletToTarget, 10, 2, 0, targetPosition);
			ShootCount++;
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(4f);
		}
	}
}
