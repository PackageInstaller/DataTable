#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50071ZhongShiLaiMu;

public class Skill_Move_LD : SkillSimpleBase
{
	private LogicEntity master;

	private readonly string mSlimeCountTag = "mSlimeCount";

	private readonly string FxAlias = "fx_50071_base_birth";

	private readonly string FxAlias02 = "fx_50071_base_die";

	private readonly float PlayBackSpeed = 0.7f;

	private readonly FP FxPositionY = 0;

	private TSVector2 FxPosition;

	private readonly FP FxAngle = 0;

	private readonly string BulletAlias = "SummonBullet_DaShiLaiMuOnly_Boss";

	private readonly bool AlignShoot;

	private readonly FP AlignShootDelay = 0;

	private readonly int BulletCount = 1;

	private readonly FP Duration = 1;

	private TSVector2 ShootPosition;

	private TSVector2 MultiShootDirection;

	private readonly FP ShootPositionY = 0;

	private readonly FP BulletDirectionOffset = 0;

	private readonly FP Angle = 1;

	private FP Radius;

	private readonly FP InnerRadius = 0;

	private FP DIST;

	protected override void OnSkillEnable()
	{
		List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
		if (targetsByFaction == null || targetsByFaction.Count <= 0)
		{
			return;
		}
		foreach (LogicEntity item in targetsByFaction)
		{
			if (GetLogicTagToggleValue(item, "isMaster"))
			{
				master = item;
			}
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(0.3);
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(master);
		MoveToPosition(entityPositionObsoleted, 0.1, AdventureActor.MovementMode.Run, 20);
		CoroutineNode distanceDetectionCor = StartCor(DistanceDetection());
		yield return WaitMoveStatus();
		SetLogicTagToggleValue(master, "IsBurst", value: true);
		StopCor(distanceDetectionCor);
		yield return StartCor(Integrationprocess());
	}

	private IEnumerator DistanceDetection()
	{
		for (int i = 0; i < 500; i++)
		{
			TSVector2 position = GetPosition();
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(master);
			FP fP = Distance(position, entityPositionObsoleted);
			FP fP2 = fP;
			NovaLogger.Debug("中史莱姆.分裂移动.与目的地相距" + fP2.ToString());
			if (fP <= 2.7 || GetLogicTagToggleValue(master, "IsBurst"))
			{
				StopMove();
			}
			yield return WaitTime(0.1);
		}
	}

	private IEnumerator Integrationprocess()
	{
		ShootPosition = GetPosition();
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(master);
		MultiShootDirection = entityPositionObsoleted - GetPosition();
		DIST = Distance(GetPosition(), entityPositionObsoleted);
		Radius = DIST;
		FxPosition = GetPosition();
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		PlayEffect(FxAlias, PlayBackSpeed, FxPositionY, FxPosition, FxAngle);
		SetHideModelEnable();
		SetUnparalleledEnable();
		FanMultipleShoot(BulletAlias, AdventureWeapon.MultipleShootStyle.FromCenterToSide, AlignShoot, AlignShootDelay, BulletCount, Duration, ShootPosition, ShootPositionY, MultiShootDirection, BulletDirectionOffset, AimType.Default, BulletDirectionType.ActorToBullet, Angle, Radius, InnerRadius, entityPositionObsoleted);
		PlayEffect(FxAlias02, 1f, default, GetPosition(), GetRotation());
		yield return WaitTime(DIST / 3);
		ClearActors(new List<LogicEntity> { _actor });
	}
}
