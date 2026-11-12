using System.Collections;
using TrueSync;

namespace AIScript.Monster._50011XingXing.Water;

public class Skill_EarthShatter : SkillBaseXingXing
{
	private int count;

	private readonly string playWarningEvent = "PlayWarningFx";

	private readonly string stopWarningEvent = "StopWarningFx";

	private long warningFxID;

	private readonly string warningFx = "fx_m50011_base_skill3_atk_ground_crack_water";

	private LogicEntity target;

	private TSVector2 movePos;

	protected override void OnSkillEnable()
	{
		count = 0;
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected override void OnSkillDisable()
	{
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (comboIndex == SkillBaseXingXing.ESJumpIndex && eventName == "JumpStart")
		{
			StartCor(Dash());
		}
		if (comboIndex == SkillBaseXingXing.ESATKIndex && eventName == playWarningEvent)
		{
			string fxAlias = warningFx;
			TSVector2 position = GetPosition();
			FP entityAngle = GetEntityAngle(_actor);
			warningFxID = PlayEffect(fxAlias, 1f, default, position, entityAngle);
		}
		if (comboIndex == SkillBaseXingXing.ESATKIndex && eventName == stopWarningEvent)
		{
			StopEffect(warningFxID);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		target = GetCurrentPlayer();
		for (int i = 0; i < 2; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, GetEntityPositionObsoleted(target), default, default, 12, 7.5);
			if (GetDestination(shapeData, out var destination))
			{
				movePos = destination;
				yield return StartCor(Jump());
			}
			yield return StartCor(Attack());
			count++;
		}
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
		BeginAttack(SkillBaseXingXing.ESJumpIndex, SkillBaseXingXing.ESJumpKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetCloseBlockDisable();
	}

	private IEnumerator Dash()
	{
		TSVector2 position = GetPosition();
		FP fP = Distance(position, movePos);
		BeginDash(SkillBaseXingXing.jumpIndex, movePos - position, fP / 0.4, fP, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false, 0.3);
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
		StartCor(WaterArea());
		BeginAttack(SkillBaseXingXing.ESATKIndex, SkillBaseXingXing.ESATKKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(target, 0.3, 200);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		TriggerArea();
	}
}
