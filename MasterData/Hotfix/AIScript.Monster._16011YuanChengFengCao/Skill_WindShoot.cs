#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._16011YuanChengFengCao;

public class Skill_WindShoot : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly string windbullet = "Weapon_16011YuanChengFengCao_throw";

	private static readonly string prfx = "fx_common_base_Wind_YuJing_circular_4";

	private static readonly string Explodefx = "fx_16011YuanChengFengCao_base_Bomb";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		if (!(attackTarget == null))
		{
			BeginLookAt_NotWait(attackTarget, 0.4, 240);
			yield return WaitTime(0.4);
			BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Shoot");
			attackTarget = GetAttackTarget(isUpToDate: true);
			if (!(attackTarget == null))
			{
				TSVector2 tSVector = GetEntityPositionObsoleted(_actor) + TSVector2.Rotate(new TSVector2(0, 0.5f), GetEntityAngle(_actor));
				TSVector2 entityForward = GetEntityForward(_actor);
				TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(attackTarget);
				TSVector2 targetPosition = GetEntityPositionObsoleted(attackTarget) + TSVector2.Rotate(new TSVector2(0, -5f), GetEntityAngle(_actor));
				FP fP = _actor.DistanceWithRadius(attackTarget);
				FP distance = fP - 5f;
				FanMultipleShoot(windbullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, tSVector, 1.5, entityForward, 0, AimType.Position, BulletDirectionType.BulletToTarget, 10, fP, 0, entityPositionObsoleted);
				StartCoroutine(Shoot2(tSVector, entityForward, distance, targetPosition));
				yield return WaitTime(fP / 10);
				yield return WaitCombo(ComboAttackType.isComboFinish);
			}
		}
	}

	private IEnumerator Shoot2(TSVector2 startPosition1, TSVector2 shootDirection, FP distance2, TSVector2 targetPosition2)
	{
		if (!(_actor == null) && _actor.buffComponent.CheckBuffByBuffID(160210120))
		{
			FanMultipleShoot(windbullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, startPosition1, 1.5, shootDirection, 0, AimType.Position, BulletDirectionType.BulletToTarget, 10, distance2, 0, targetPosition2);
			NovaLogger.Debug("强化技能");
			yield return WaitTime(distance2 / 10);
		}
	}
}
