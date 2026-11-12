#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Earth;

public class Skill_EarthShatter : SkillScript_Base
{
	private readonly string playWarningEvent = "PlayWarningFx";

	private readonly string stopWarningEvent = "StopWarningFx";

	private long warningFxID;

	private readonly string warningFx = "fx_m50011_base_skill3_atk_ground_crack_earth";

	private LogicEntity target;

	private TSVector2 movePos;

	protected override void OnSkillEnable()
	{
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected override void OnSkillDisable()
	{
		SetCloseBlockDisable();
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
		StartCor(UltimateSkillEffect());
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

	private IEnumerator UltimateSkillEffect()
	{
		for (int i = 0; i < 2; i++)
		{
			switch (i)
			{
			case 0:
			{
				TSVector2 spawnPos = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(1.5, 1.5));
				TSVector2 spawnForward = RotateTo(GetForward(), -30);
				int bulletcount = 3;
				switch (GetPlayerJobType((AdventureActor)GetCurrentPlayer()))
				{
				case 1:
					bulletcount = 3;
					break;
				case 2:
					bulletcount = 5;
					spawnForward = RotateTo(GetForward(), -30 - i * 10);
					break;
				}
				UltimateGroundAttack(spawnPos, spawnForward, bulletcount);
				break;
			}
			case 1:
			{
				NovaLogger.Debug("猩猩土属性.左手拍地产生地刺");
				TSVector2 spawnPos = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-1.4, 2));
				TSVector2 spawnForward = RotateTo(GetForward(), 30);
				int bulletcount = 3;
				switch (GetPlayerJobType((AdventureActor)GetCurrentPlayer()))
				{
				case 1:
					bulletcount = 3;
					break;
				case 2:
					bulletcount = 5;
					spawnForward = RotateTo(GetForward(), 30 + i * 20);
					break;
				}
				UltimateGroundAttack(spawnPos, spawnForward, bulletcount);
				break;
			}
			}
			yield return WaitTime(2);
		}
	}
}
