using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Skill7_PerfumeBoom : SkillSimpleBase
{
	private const string ComboKey = "Skill7_1_PerfumeBoom";

	private const string Phase3ComboKey = "Skill7_2_PerfumeBoom_Fly";

	private const string BombBulletAlias = "Weapon_70061WuYu_Skill7_Bullet_Big";

	private const string BombBulletAliasP3 = "Weapon_70061WuYu_Skill7_Bullet_Fly_Big";

	private const int BombCountP1 = 3;

	private static readonly FP BombTotalDurationP1 = 2;

	private static readonly FP BombShootHeight = 7;

	private const int BombCountP2 = 5;

	private static readonly FP BombTotalDurationP2 = 2;

	private static readonly FP BombDropDistanceP3 = 2.5;

	private static readonly FP Phase3DashSpeed = 20;

	private static readonly FP Phase3DashDistance = 48;

	private static readonly FP Phase3TurnDuration = 0.5;

	private static readonly FP Phase3TurnSpeed = 720;

	private static readonly FP Phase3TurnWaitTime = 0.5;

	private const int Phase3DashCount = 3;

	private const int Phase3FanBulletCount = 2;

	private static readonly FP Phase3FanAngle = 220;

	private static readonly FP Phase3FanRadius = 3;

	private static readonly FP Phase3FanInnerRadius = 0;

	private const AdventureWeapon.MultipleShootStyle Phase3FanShootStyle = AdventureWeapon.MultipleShootStyle.FromLeftToRight;

	private static readonly FP BombShootHeightP3 = 3;

	private readonly HashSet<long> _pendingBombBulletIds = new HashSet<long>();

	private CoroutineNode _phase3DropBombCoroutine;

	private TSVector2 _phase3LastDropPosition;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_pendingBombBulletIds.Clear();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
	}

	protected override void OnSkillDisable()
	{
		StopCor(_phase3DropBombCoroutine);
		StopWaitLookAt();
		StopDash();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		_pendingBombBulletIds.Clear();
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		int phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		if (phase >= 3)
		{
			yield return StartCor(DoPhase3Logic());
			yield return WaitUntil(() => _pendingBombBulletIds.Count == 0);
			yield break;
		}
		BeginAttack(0, "Skill7_1_PerfumeBoom", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		int bombCount = ((phase >= 2) ? 5 : 3);
		FP fP = ((phase >= 2) ? BombTotalDurationP2 : BombTotalDurationP1);
		FP bombShootInterval = fP / bombCount;
		for (int i = 0; i < bombCount; i++)
		{
			ShootBombPerfume();
			if (i < bombCount - 1)
			{
				yield return WaitTime(bombShootInterval);
			}
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitUntil(() => _pendingBombBulletIds.Count == 0);
	}

	private IEnumerator DoPhase3Logic()
	{
		BeginAttack(0, "Skill7_2_PerfumeBoom_Fly", flushInputedKeys: true, forceInterruptAttack: true);
		FacePhase3DashDirection();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		_phase3LastDropPosition = GetPosition();
		DropPhase3Bomb(_phase3LastDropPosition);
		StartCor(ref _phase3DropBombCoroutine, DropPhase3Bombs());
		for (int i = 0; i < 3; i++)
		{
			BeginDashActorForward(i + 1, Phase3DashSpeed, Phase3DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
			yield return WaitDashFinish();
			if (i < 2)
			{
				yield return StartCor(TurnToPlayer());
			}
		}
		StopCor(_phase3DropBombCoroutine);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator TurnToPlayer()
	{
		StopWaitLookAt();
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (!(currentPlayer == null))
		{
			yield return BeginLookAt(currentPlayer, 0, Phase3TurnSpeed);
			StopWaitLookAt();
			yield return WaitTime(Phase3TurnWaitTime);
		}
	}

	private void FacePhase3DashDirection()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (!(currentPlayer == null))
		{
			BeginLookAt_NotWait(currentPlayer, Phase3TurnDuration, Phase3TurnSpeed);
		}
	}

	private IEnumerator DropPhase3Bombs()
	{
		while (true)
		{
			yield return null;
			TSVector2 position = GetPosition();
			if (!(Distance(_phase3LastDropPosition, position) < BombDropDistanceP3))
			{
				DropPhase3Bomb(position);
				_phase3LastDropPosition = position;
			}
		}
	}

	private void ShootBombPerfume()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (!(currentPlayer == null))
		{
			ShootBombPerfume(GetPlaceHolderPosition("BigPerfumePosition"), currentPlayer.tsTransform.Position, "Weapon_70061WuYu_Skill7_Bullet_Big", BombShootHeight);
		}
	}

	private void DropPhase3Bomb(TSVector2 position)
	{
		ClearShootBulletIdList();
		FanMultipleShoot("Weapon_70061WuYu_Skill7_Bullet_Fly_Big", AdventureWeapon.MultipleShootStyle.FromLeftToRight, alignShoot: false, 0, 2, 0, position, BombShootHeightP3, GetForward(), 0, AimType.Default, BulletDirectionType.ActorToBullet, Phase3FanAngle, Phase3FanRadius, Phase3FanInnerRadius);
		foreach (long shootBulletId in GetShootBulletIdList())
		{
			AdventureBulletBase bulletByID = GetBulletByID(shootBulletId);
			if (!(bulletByID == null))
			{
				bulletByID.ModifyBulletTag("Weapon_70061WuYu_Skill7_Bullet_Fly_Big");
				_pendingBombBulletIds.Add(bulletByID.Id);
			}
		}
	}

	private void ShootBombPerfume(TSVector2 startPosition, TSVector2 targetPosition, string bulletAlias, FP shootHeight)
	{
		AdventureBulletBase adventureBulletBase = ILRuntimeAPI.Shoot(bulletAlias, _actor, default, startPosition, shootHeight, targetPosition, null, AimType.Position, BulletDirectionType.BulletToTarget);
		if (!(adventureBulletBase == null))
		{
			adventureBulletBase.ModifyBulletTag(bulletAlias);
			_pendingBombBulletIds.Add(adventureBulletBase.Id);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent)
		{
			_pendingBombBulletIds.Remove(adventureBulletFinishEvent.id);
		}
	}
}
