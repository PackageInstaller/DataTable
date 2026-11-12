using System.Collections;
using TrueSync;

namespace AIScript.Monster._16021GuangNiao;

public class Skill_AttackShoot : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly string lightbullet = "Weapon_15520XiaoFengNiao_AttackBullet";

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
		LogicEntity target = GetAttackTarget(isUpToDate: true);
		BeginLookAt_NotWait(target, 0.6, 240);
		yield return WaitTime(0.6);
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		target = GetAttackTarget(isUpToDate: true);
		BeginLookAt_NotWait(target, 1.2, 120);
		yield return WaitTime(1.6);
		TSVector2 shootPosition = _actor.tsTransform.Position + TSVector2.Rotate(new TSVector2(0, 1.5f), _actor.tsTransform.Rotation);
		TSVector2 entityForward = GetEntityForward(_actor);
		TSVector2 position = target.tsTransform.Position;
		FP radius = _actor.DistanceWithRadius(target);
		FanMultipleShoot(lightbullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, shootPosition, 0.9, entityForward, 0, AimType.Position, BulletDirectionType.BulletToTarget, 10, radius, 0, position);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
