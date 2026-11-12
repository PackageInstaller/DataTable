#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._16021GuangNiao;

public class Skill_SupporShoot : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly string lightbullet = "Weapon_15520XiaoFengNiao_SupportBullet";

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
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		TSVector2 position = GetPosition();
		Skill_SupporShoot skill_SupporShoot = this;
		FP radius = 12;
		FP innerRadius = 3;
		FP angle = 360;
		FP rotation = 0;
		DeterministicShape shapeData = skill_SupporShoot.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
		List<LogicEntity> friends = GetTargetsFromShape(shapeData, targetsByFaction);
		if (friends.Count == 0)
		{
			LogicEntity targetNearOrFar = GetTargetNearOrFar(iNear: false, targetsByFaction);
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(targetNearOrFar);
			MoveToPosition(entityPositionObsoleted, 2f);
			yield return WaitMoveStatus();
			_skill?.Clear();
		}
		LogicEntity target = GetTargetNearOrFar(iNear: false, friends);
		BeginLookAt_NotWait(target, 0.6, 240);
		yield return WaitTime(0.6);
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 1.2, 120);
		yield return WaitTime(1.6);
		TSVector2 shootPosition = _actor.tsTransform.Position + TSVector2.Rotate(new TSVector2(0, 1.5f), _actor.tsTransform.Rotation);
		TSVector2 entityForward = GetEntityForward(_actor);
		TSVector2 position2 = target.tsTransform.Position;
		FP radius2 = _actor.DistanceWithRadius(target);
		FanMultipleShoot(lightbullet, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 0, 1, 0, shootPosition, 0.9, entityForward, 0, AimType.Position, BulletDirectionType.BulletToTarget, 10, radius2, 0, position2);
		NovaLogger.Debug("发射强化子弹");
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
