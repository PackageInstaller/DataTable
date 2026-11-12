using System.Collections;
using TrueSync;

namespace AIScript.Monster._50101YinYing;

public class Skill_Attack_Light : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack_Combo = new ComboInputBuffer.ActionKey[1];

	private static readonly FP AttackRadius = 0.7;

	private static readonly string BulletName = "Weapon_50101YinYing_Attack_Light";

	private bool IsShootEnd;

	private CoroutineNode AttackCorNode1;

	private CoroutineNode AttackCorNode2;

	private long SingFXL;

	private long SingFXR;

	private long AttackFX;

	private long AttackFX2;

	private long LoopFX;

	private int BulletIndex;

	private int BulletEndIndex;

	protected override void OnSkillEnable()
	{
		IsShootEnd = false;
		BulletIndex = 1;
		BulletEndIndex = 1;
	}

	protected override void OnSkillDisable()
	{
		StopEffect(SingFXL, stopSubFx: true);
		StopEffect(SingFXR, stopSubFx: true);
		StopEffect(AttackFX, stopSubFx: true);
		StopEffect(AttackFX2, stopSubFx: true);
		StopEffect(LoopFX, stopSubFx: true);
		RemoveBuffFromTarget(_actor, 990020010);
		ResetBlockPriority();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override IEnumerator DoMainLogic()
	{
		SetBlockPriorityToStatic();
		BeginAttack(1, Attack_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		SingFXL = PlayEffect("AttackSing_L");
		SingFXR = PlayEffect("AttackSing_R");
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Skill_Attack_Light skill_Attack_Light = this;
		Skill_Attack_Light skill_Attack_Light2 = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Attack_Light.LoopFX = skill_Attack_Light2.PlayEffect("AttackLoopFX", 1f, default, position, rotation);
		AddBuffToTarget(_actor, 990020010);
		Skill_Attack_Light skill_Attack_Light3 = this;
		string bulletName = BulletName;
		FP alignShootDelay = 0;
		FP duration = 0;
		TSVector2 shootPosition = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2.5));
		FP shootPositionY = 0;
		TSVector2 forward = GetForward();
		FP bulletDirectionOffset = 0;
		FP angle = 150;
		FP radius = 2;
		FP innerRadius = 0;
		LogicEntity attackTarget = GetAttackTarget(isUpToDate: true);
		skill_Attack_Light3.FanMultipleShoot(bulletName, AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, alignShootDelay, 2, duration, shootPosition, shootPositionY, forward, bulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, angle, radius, innerRadius, default, attackTarget);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		while (!IsShootEnd)
		{
			yield return null;
		}
		yield return WaitTime(0.5);
		CancelAttack();
		yield return WaitTime(0.6);
		StopEffect(LoopFX);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void OnBulletFinish(IEvent e)
	{
		if (!(e is AdventureBulletFinishEvent { tag: "50101Bullet" } adventureBulletFinishEvent) || !(adventureBulletFinishEvent.owner == _actor))
		{
			return;
		}
		TSVector2 bulletPosition = adventureBulletFinishEvent.bulletPosition;
		FP attackRadius = AttackRadius;
		FP innerRadius = 0;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, bulletPosition, default, default, attackRadius, innerRadius);
		if (GetTargetsFromShape(shapeData, GetTargetsByFaction(isFriend: false)).Count > 0)
		{
			if (BulletIndex == 1)
			{
				StartCor(ref AttackCorNode1, BulletAttack(bulletPosition, shapeData, BulletIndex));
			}
			else
			{
				StartCor(ref AttackCorNode2, BulletAttack(bulletPosition, shapeData, BulletIndex));
			}
		}
		else
		{
			IsShootEnd = true;
		}
		BulletIndex++;
	}

	private IEnumerator BulletAttack(TSVector2 Position, DeterministicShape AttackShape, int Index)
	{
		if (Index == 1)
		{
			AttackFX = PlayEffect("BulletAttack", 1f, default, Position);
		}
		else
		{
			AttackFX2 = PlayEffect("BulletAttack", 1f, default, Position);
		}
		yield return WaitTime(0.95);
		Skill_Attack_Light skill_Attack_Light = this;
		FP knockOutForce = 15;
		FP stiffDuration = 0.75;
		FP hitStrenth = 4;
		HitFeatureData hitFeatureData = skill_Attack_Light.GetHitFeatureData(HitBox.FeatureFlag.AirBorne | HitBox.FeatureFlag.Stiff, default, default, UseAtttackForward: false, knockOutForce, null, null, stiffDuration, default, default, default, default, default, default, default, default, null, null, null, null, hitStrenth);
		AreaHit_Simple(_actor, AttackShape, hitFeatureData, 50101011, 0, HitBox.HurtAnimType.Large, "HittedFX");
		yield return WaitTime(1.5);
		if (Index == 1)
		{
			StopEffect(AttackFX, stopSubFx: true);
		}
		else
		{
			StopEffect(AttackFX2, stopSubFx: true);
		}
		PlayEffect("BulletBroken", 1f, default, Position);
		IsShootEnd = true;
	}
}
