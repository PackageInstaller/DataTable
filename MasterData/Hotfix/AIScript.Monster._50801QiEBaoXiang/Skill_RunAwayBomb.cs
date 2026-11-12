using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._50801QiEBaoXiang;

public class Skill_RunAwayBomb : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Run_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly TSVector2 FixedPoints1 = new TSVector2(0, 6.5);

	private static readonly TSVector2 FixedPoints2 = new TSVector2(0, -6.5);

	private static readonly TSVector2 FixedPoints3 = new TSVector2(6.5, 0);

	private static readonly TSVector2 FixedPoints4 = new TSVector2(-6.5, 0);

	private List<LogicEntity> FixedPoints;

	private int PositionIndex;

	private long PresentFX;

	private long Emoji;

	private int[] BombWeights;

	private int RandomBomb;

	private string BombName;

	private DeterministicShape AttackShape;

	private TSVector2 AttackPosition;

	private CoroutineNode PresentShootNode;

	private LogicEntity NextAimTarget;

	protected override void OnSkillEnable()
	{
		//IL_002b: Field data (rva=0x5f8) could not be found in any section!
		//IL_002b: Field data (rva=0x5f8) could not be found in any section!
		FixedPoints = GetTargetByDataID(6100402);
		Shuffle(FixedPoints);
		int[] array = new int[4];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._1B897DDDD4C151E2A2E6E3E91B7EA0F7FC4FD5ED00EF1C9669E8566393A02586));
		BombWeights = array;
		PositionIndex = 0;
	}

	protected override void OnSkillDisable()
	{
		FixedPoints.Clear();
		StopEffect(PresentFX);
		StopEffect(Emoji);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Run_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		PresentFX = PlayEffect("PresentFX");
		Emoji = PlayEffect("RunBomb_Emoji");
		NextAimTarget = GetTargetNearOrFar(iNear: false, FixedPoints);
		FixedPoints.Remove(NextAimTarget);
		FixedPoints.Insert(0, NextAimTarget);
		BeginLookAt_NotWait(NextAimTarget, 0, 360);
		yield return WaitTime(1.25);
		StartCor(ref PresentShootNode, PresentShoot());
		yield return StartCor(GoToPositions());
		StopCor(PresentShootNode);
		StopEffect(PresentFX);
		StopEffect(Emoji);
		CancelAttack();
		yield return WaitTime(1);
	}

	private void Shuffle(List<LogicEntity> List)
	{
		int num = List.Count;
		while (num > 1)
		{
			num--;
			int index = TSRandom.Range(0, num + 1);
			LogicEntity value = List.get_Item(index);
			List.set_Item(index, List.get_Item(num));
			List.set_Item(num, value);
		}
	}

	private IEnumerator GoToPositions()
	{
		while (PositionIndex <= 3)
		{
			BeginDash(1, GetForward(), 12, Distance(GetEntityPositionObsoleted(NextAimTarget), GetPosition()) - 1, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
			PositionIndex++;
			if (PositionIndex == 4 || PositionIndex >= FixedPoints.Count)
			{
				NextAimTarget = GetCurrentPlayer();
			}
			else
			{
				NextAimTarget = FixedPoints.get_Item(PositionIndex);
			}
			BeginDash(2, GetForward(), 8, 4, 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			PlayWwiseSound("mon_50801_attack_shoot_brake");
			yield return WaitLookAt(NextAimTarget, 0.5, 360);
			yield return WaitTime(0.3);
		}
	}

	private IEnumerator PresentShoot()
	{
		while (true)
		{
			RandomBomb = randomWeight(BombWeights);
			switch (RandomBomb)
			{
			case 1:
				BombName = "GiftBomb_1";
				break;
			case 2:
				BombName = "GiftBomb_2";
				break;
			case 3:
				BombName = "GiftBomb_3";
				break;
			case 4:
				BombName = "GiftBomb_4";
				break;
			}
			Skill_RunAwayBomb skill_RunAwayBomb = this;
			Skill_RunAwayBomb skill_RunAwayBomb2 = this;
			TSVector2 position = GetPosition();
			FP radius = 5;
			FP innerRadius = 3;
			FP angle = 240;
			FP rotation = GetRotation();
			skill_RunAwayBomb.AttackShape = skill_RunAwayBomb2.GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation);
			AttackPosition = GetShapeRandomPoint(AttackShape, _actor, isReachable: true);
			PlayEffect("RunBomb_Shoot");
			FanMultipleShoot(BombName, alignShootDelay: 0, duration: 0, shootPosition: TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 2)), shootPositionY: 2, bulletDirectionOffset: 0, multipleShootStyle: AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: false, bulletCount: 1, multiShootDirection: GetPosition(), aimType: AimType.Position, bulletDirectionType: BulletDirectionType.BulletToTarget, angle: 1, radius: 1, innerRadius: 0, targetPosition: AttackPosition);
			yield return WaitTime(0.15);
		}
	}
}
