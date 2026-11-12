using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._HardLevel._50101YinYing;

public class HardLevel_Skill_01 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly FP AttackRadius = 0.4;

	private static readonly string BulletName = "Bullet_50101YinYing_HardLevel_Dark_Skill01";

	private bool IsShootEnd;

	private CoroutineNode AttackCorNode;

	private long SingFXL;

	private long SingFXR;

	private long AttackFX;

	protected override void OnSkillEnable()
	{
		IsShootEnd = false;
	}

	protected override void OnSkillDisable()
	{
		StopEffect(SingFXL, stopSubFx: true);
		StopEffect(SingFXR, stopSubFx: true);
		StopEffect(AttackFX, stopSubFx: true);
		RemoveBuffFromTarget(_actor, 990020010);
		ResetBlockPriority();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBlockPriorityToStatic();
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		AddBuffToTarget(_actor, 990020010);
		HardLevel_Skill_01 hardLevel_Skill_ = this;
		string bulletName = BulletName;
		FP alignShootDelay = 0;
		FP duration = 0;
		TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2.5));
		FP shootPositionY = 0;
		TSVector2 forward = GetForward();
		FP bulletDirectionOffset = 0;
		FP angle = 1;
		FP radius = 0;
		FP innerRadius = 0;
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		hardLevel_Skill_.FanMultipleShoot(bulletName, AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, alignShootDelay, 1, duration, shootPosition, shootPositionY, forward, bulletDirectionOffset, AimType.Target, BulletDirectionType.ActorToBullet, angle, radius, innerRadius, default, attackTarget);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		while (!IsShootEnd)
		{
			yield return null;
		}
		yield return WaitTime(0.5);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void OnBulletFinish(IEvent e)
	{
		if (e is AdventureBulletFinishEvent { tag: "50101Bullet" } adventureBulletFinishEvent && adventureBulletFinishEvent.owner == _actor)
		{
			TSVector2 bulletPosition = adventureBulletFinishEvent.bulletPosition;
			FP attackRadius = AttackRadius;
			FP innerRadius = 0;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, bulletPosition, default, default, attackRadius, innerRadius);
			if (GetTargetsFromShape(shapeData, GetTargetsByFaction(isFriend: false)).Count > 0)
			{
				StartCor(ref AttackCorNode, BulletAttack(bulletPosition, shapeData));
			}
			else
			{
				IsShootEnd = true;
			}
		}
	}

	private IEnumerator BulletAttack(TSVector2 AttackPosition, DeterministicShape AttackShape)
	{
		AttackFX = PlayEffect("BulletAttack", 1f, default, AttackPosition);
		yield return WaitTime(0.8);
		HardLevel_Skill_01 hardLevel_Skill_ = this;
		List<int> buffIdsForTarget = new List<int> { 501010120 };
		HitFeatureData hitFeatureData = hardLevel_Skill_.GetHitFeatureData(HitBox.FeatureFlag.AddBuffForTarget, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, buffIdsForTarget);
		AreaHit_Simple(_actor, AttackShape, hitFeatureData, 50101011, 0, HitBox.HurtAnimType.Large, "HittedFX");
		if (GetTargetsFromShape(AttackShape, GetTargetsByFaction(isFriend: false)).Count > 0)
		{
			yield return WaitTime(2.8);
			StopEffect(AttackFX, stopSubFx: true);
			PlayEffect("BulletBroken", 1f, default, AttackPosition);
			IsShootEnd = true;
		}
		else
		{
			yield return WaitTime(1);
			StopEffect(AttackFX, stopSubFx: true);
			PlayEffect("BulletAttackEnd", 1f, default, AttackPosition);
			IsShootEnd = true;
		}
	}
}
