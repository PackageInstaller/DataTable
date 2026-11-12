using System.Collections;
using TrueSync;

namespace AIScript.Monster._16001JinZhanFengCao;

public class Skill_VineShoot : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Start_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private static readonly string windbullet = "Weapon_16001JinZhanFengCao";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		BeginLookAt_NotWait(target, 0.4, 120);
		yield return WaitTime(0.4);
		BeginAttack(1, Start_Combo, flushInputedKeys: true);
		SetBlockPriorityToStatic();
		yield return WaitTime(2.1);
		TSVector2 startPosition = GetEntityPositionObsoleted(_actor) + TSVector2.Rotate(new TSVector2(0, 0.5f), GetEntityAngle(_actor));
		TSVector2 entityForward = GetEntityForward(_actor);
		TSVector2 targetPosition = GetEntityPositionObsoleted(_actor) + TSVector2.Rotate(new TSVector2(0, -2f), GetEntityAngle(_actor));
		FP distance = _actor.DistanceWithRadius(target) - 2f;
		StartCoroutine(Shoot2(startPosition, entityForward, distance, targetPosition));
		yield return WaitTime(2.2);
		CancelAttack();
		ResetBlockPriority();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator Shoot2(TSVector2 startPosition1, TSVector2 shootDirection, FP distance2, TSVector2 targetPosition2)
	{
		if (_actor.buffComponent.CheckBuffByBuffID(160210120))
		{
			FanMultipleShoot(windbullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, startPosition1, 0, shootDirection, 0, AimType.Position, BulletDirectionType.BulletToTarget, 10, distance2, 0, targetPosition2);
			yield return WaitTime(0.2);
		}
	}
}
