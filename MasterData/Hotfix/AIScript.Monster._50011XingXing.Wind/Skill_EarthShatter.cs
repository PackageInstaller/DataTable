using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Wind;

public class Skill_EarthShatter : SkillScript_Base
{
	private List<long> warningFxList = new List<long>();

	private List<TSVector2> rectangleShoot01 = new List<TSVector2>();

	private List<TSVector2> rectangleShoot02 = new List<TSVector2>();

	private readonly string playWarningEvent = "PlayWarningFx";

	private readonly string stopWarningEvent = "StopWarningFx";

	private long warningFxID;

	private readonly string warningFx = "fx_m50011_base_skill3_atk_ground_crack_wind";

	private LogicEntity target;

	private TSVector2 movePos;

	protected override void OnSkillEnable()
	{
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected override void OnSkillDisable()
	{
		if (warningFxList != null && warningFxList.Count > 0)
		{
			for (int i = 0; i < warningFxList.Count; i++)
			{
				StopEffect(warningFxList.get_Item(i));
			}
		}
		warningFxList.Clear();
		rectangleShoot01.Clear();
		rectangleShoot02.Clear();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == SkillScript_Base.ESJumpIndex && eventName == "JumpStart")
		{
			StartCor(Dash());
		}
		if (comboIndex == SkillScript_Base.ESATKIndex && eventName == playWarningEvent)
		{
			string fxAlias = warningFx;
			TSVector2 position = GetPosition();
			FP entityAngle = GetEntityAngle(_actor);
			warningFxID = PlayEffect(fxAlias, 1f, default, position, entityAngle);
		}
		if (comboIndex == SkillScript_Base.ESATKIndex && eventName == stopWarningEvent)
		{
			StopEffect(warningFxID);
			StartCor(ShootingProcedure());
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetTarget();
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, GetEntityPositionObsoleted(target), default, default, 12, 7.5);
		if (GetDestination(shapeData, out var destination))
		{
			movePos = destination;
			yield return StartCor(Jump());
		}
		yield return StartCor(Attack());
	}

	private bool GetDestination(DeterministicShape shape, out TSVector2 destination)
	{
		bool result = false;
		destination = TSVector2.zero;
		TSVector2 position = GetPosition();
		FP fP = 15;
		for (int i = 0; i <= 10; i++)
		{
			destination = GetShapeRandomPoint(shape, _actor, isReachable: true);
			if (fP <= Distance(position, destination))
			{
				result = true;
				break;
			}
		}
		return result;
	}

	private IEnumerator Jump()
	{
		SetCloseBlockEnable();
		BeginAttack(SkillScript_Base.ESJumpIndex, SkillScript_Base.ESJumpKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetCloseBlockDisable();
	}

	private IEnumerator Dash()
	{
		TSVector2 position = GetPosition();
		FP fP = Distance(position, movePos);
		BeginDash(SkillScript_Base.jumpIndex, movePos - position, fP / 0.4, fP, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 0.3);
		yield return WaitTime(0.2);
		BeginLookAt_NotWait(target, 0.2, 675);
		yield return WaitDashFinish();
		DispatchCustomEvent("XingXingDashFinish");
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && string.Equals(adventureActorCustomEvent.eventName, "XingXingDashFinish"))
		{
			CancelAttack();
		}
	}

	private IEnumerator Attack()
	{
		BeginAttack(SkillScript_Base.ESATKIndex, SkillScript_Base.ESATKKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 0.3, 200);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator ShootingProcedure()
	{
		TSVector2 position = GetPosition();
		TSVector2 forward = GetForward();
		FP fP = 4;
		int num = 4;
		bool flag = false;
		for (int i = 0; i < num; i++)
		{
			TSVector2 item = TransLocalPosToWorldPos(position, forward, new TSVector2(0, fP + i * fP));
			if (flag)
			{
				rectangleShoot01.Add(item);
			}
			else
			{
				rectangleShoot02.Add(item);
			}
			flag = !flag;
		}
		for (int j = 0; j < rectangleShoot01.Count; j++)
		{
			if (QueryPositionReachable(GetCurrentPlayer(), rectangleShoot01.get_Item(j)))
			{
				OneShoot(rectangleShoot01.get_Item(j), rectangleShoot01.get_Item(j) - position, 120);
			}
			if (QueryPositionReachable(GetCurrentPlayer(), rectangleShoot02.get_Item(j)))
			{
				OneShoot(rectangleShoot02.get_Item(j), rectangleShoot02.get_Item(j) - position, -120);
			}
		}
		yield break;
	}

	private void OneShoot(TSVector2 shootPos, TSVector2 shootDirection, FP directionOffset)
	{
		FanMultipleShoot("CycloneBullet", AdventureWeapon.MultipleShootStyle.FromCenterToSide, alignShoot: true, 1, 1, 0, shootPos, default, shootDirection, directionOffset, AimType.Default, BulletDirectionType.ActorToBullet, 1, 0, 0);
	}
}
