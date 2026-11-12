using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._13051GaoDa;

public class Skill_SmashFloor_Prologue : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_1 = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_daze = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.X };

	private string warningFxAlias = "Warning";

	private string HitFxAliasL = "PunchHitEffectL";

	private string HitFxAliasR = "PunchHitEffectR";

	private string customEventName_FlyDown = "FlyDown";

	private string customEventName_HitEffect = "HitEffect";

	private string customEventName_FlyUp = "FlyUp";

	private string customEventName_HideSelf = "HideSelf";

	private FP hand2Delay = 0.25;

	private FP blinkDuration = 0.8;

	private FP loopTime = 2;

	private FP backSpeed = 30;

	private FP TimeBetween2Hands = 0;

	private FP TimeBeforeFirstHand = 0;

	private FP searchOriginalAngle = 15;

	private FP searchIncreaseAngle = 15;

	private FP searchOutterRadius = 10;

	private FP searchInnerRadius = 6;

	private FP bodyDistance = 7;

	private static readonly FP TimeBetween2Hands_strafe = 2;

	private static readonly FP TimeBeforeFirstHand_strafe = 0;

	private static readonly FP TimeBetween2Hands_laser = 1.5;

	private static readonly FP TimeBeforeFirstHand_laser = 0;

	private int skillType;

	private int cooperateType;

	private int handCount;

	private long bodyId;

	private string HitFxAlias;

	private TSVector2 originalPosition;

	private TSVector2 originalForward;

	private TSVector2 originalLookAtPostion;

	private TSVector2 TargetPosition;

	private TSVector2 SelectPosition;

	private TSVector2 Fandirection;

	private bool anotherHandSelectPositionFinish;

	private TSVector2 anotherHandSelectPosition;

	private bool canBreak;

	private CoroutineNode GetPositionNode;

	private FP ControlPointXOffset;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		StartCoroutine(ref GetPositionNode, GetAttackTargetPosition());
		anotherHandSelectPositionFinish = false;
		skillType = (int)(long)_actor.logicVariable.GetLogicTagValue("skillType");
		cooperateType = (int)(long)_actor.logicVariable.GetLogicTagValue("cooperateType");
		handCount = (int)(long)_actor.logicVariable.GetLogicTagValue("handCount");
		bodyId = (int)(long)_actor.logicVariable.GetLogicTagValue("bodyId");
		originalPosition = new TSVector2(_actor.logicVariable.GetLogicTagValue("actorPositionX"), _actor.logicVariable.GetLogicTagValue("actorPositionY"));
		originalForward = new TSVector2(_actor.logicVariable.GetLogicTagValue("actorForwardX"), _actor.logicVariable.GetLogicTagValue("actorForwardY"));
		originalLookAtPostion = originalPosition + originalForward * 100;
		if (cooperateType == 1)
		{
			TimeBetween2Hands = TimeBetween2Hands_strafe;
			TimeBeforeFirstHand = TimeBeforeFirstHand_strafe;
		}
		else if (cooperateType == 2)
		{
			TimeBetween2Hands = TimeBetween2Hands_laser;
			TimeBeforeFirstHand = TimeBeforeFirstHand_laser;
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_GAMDAM_MESSAGE", OnReceiveMessage);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_GAMDAM_MESSAGE", OnReceiveMessage);
		SendSkillSelectPositionFinishMessage(TargetPosition);
		StopCoroutine(ref GetPositionNode);
		CancelBezierPathMove();
	}

	protected override IEnumerator DoMainLogic()
	{
		canBreak = true;
		yield return WaitTime(0.5);
		BeginAttack(1, actionKeys_1, flushInputedKeys: true);
		yield return WaitCustomEvent(customEventName_FlyUp);
		canBreak = false;
		SetCloseBlockEnable();
		SetBattleOutEnable();
		yield return WaitCustomEvent(customEventName_HideSelf);
		SetHideModelEnable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (cooperateType == 0)
		{
			SelectPosition = TargetPosition;
			if (skillType == 2)
			{
				LogicEntity body = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(bodyId);
				LogicEntity attackTargetWithOwnerTauntFrom = GetAttackTargetWithOwnerTauntFrom((long)GetLogicTagFpValue(_actor, "bodyId"));
				if (!CheckTargetIsValid(attackTargetWithOwnerTauntFrom))
				{
					Fandirection = new TSVector2(0, 1);
				}
				else
				{
					Fandirection = GetEntityForward(attackTargetWithOwnerTauntFrom);
				}
				if (SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput())
				{
					Fandirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
				}
				TSQuaternion tSQuaternion = TSQuaternion.LookRotation(new TSVector(Fandirection.x, 0f, Fandirection.y));
				FP rotation = -tSQuaternion.eulerAngles.y;
				if (tSQuaternion.eulerAngles.x < 0f)
				{
					rotation = tSQuaternion.eulerAngles.y + 180f;
				}
				SelectPosition = GetRandomPoint(SelectPosition, searchOriginalAngle, rotation, body);
			}
		}
		else
		{
			yield return WaitTime(TimeBeforeFirstHand);
			if (skillType == 2)
			{
				yield return WaitTime(TimeBetween2Hands);
			}
			SelectPosition = TargetPosition;
		}
		SendSkillSelectPositionFinishMessage(SelectPosition);
		TSVector2 blinkPosition = SelectPosition;
		if (cooperateType == 0)
		{
			bool needDelay = false;
			if (handCount == 2)
			{
				while (!anotherHandSelectPositionFinish)
				{
					yield return null;
				}
				if (skillType == 1)
				{
					if (SelectPosition.x > anotherHandSelectPosition.x)
					{
						blinkPosition = anotherHandSelectPosition;
						anotherHandSelectPosition = SelectPosition;
					}
				}
				else if (SelectPosition.x < anotherHandSelectPosition.x)
				{
					blinkPosition = anotherHandSelectPosition;
					anotherHandSelectPosition = SelectPosition;
				}
				if (blinkPosition.y < anotherHandSelectPosition.y)
				{
					needDelay = true;
				}
			}
			if (needDelay)
			{
				yield return WaitTime(hand2Delay);
			}
		}
		long fxToken = PlayLoopFx(warningFxAlias, 1f, new Vector3((float)blinkPosition.x, (float)_actor.tsTransform.PositionY, (float)blinkPosition.y), _actor.transform.rotation, null, 2.4f);
		yield return Blink(null, blinkPosition, blinkDuration, "", 0, "", 0, SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor);
		BeginLookAtByPos(originalPosition, 0, 999);
		StopLoopFx(fxToken);
		yield return WaitTime(0.2);
		BeginAttack(2, actionKeys_2, flushInputedKeys: true);
		SetHideModelDisable();
		yield return WaitCustomEvent(customEventName_FlyDown);
		SetCloseBlockDisable();
		SetBattleOutDisable();
		yield return WaitCustomEvent(customEventName_HitEffect);
		if (skillType == 1)
		{
			HitFxAlias = HitFxAliasR;
		}
		else
		{
			HitFxAlias = HitFxAliasL;
		}
		long fxToken2 = PlayLoopFx(HitFxAlias, 1f, new Vector3((float)_actor.tsTransform.Position.x, (float)_actor.tsTransform.PositionY, (float)_actor.tsTransform.Position.y), _actor.transform.rotation, null, 1.2f);
		yield return WaitTime(loopTime);
		BeginAttack(3, actionKeys_2);
		StopLoopFx(fxToken2);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (GetPosition().x >= GetEntityPositionObsoleted(GetTargetByID(bodyId)).x)
		{
			ControlPointXOffset = -0.7;
		}
		else
		{
			ControlPointXOffset = 0.7;
		}
		BeginBezierPathMove(1, originalPosition, 0.8, ControlPointXOffset, comboWithAttack: true, 7, AdventureActor.MovementMode.Run, 20);
		AimAtPosition(originalLookAtPostion, 150);
		yield return WaitBezierPathMoveFinish();
		yield return WaitTime(0.5f);
		CancelAim();
		StopCoroutine(ref GetPositionNode);
	}

	private TSVector2 GetRandomPoint(TSVector2 position, FP angle, FP rotation, LogicEntity body)
	{
		DeterministicShape deterministicFanShape = CommonUtils.GetDeterministicFanShape(searchOutterRadius, searchInnerRadius, angle, position, rotation);
		TSVector2 selectPoint = ILRuntimeAPI.GetRandomPointInShape(SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor, deterministicFanShape);
		if (body != null)
		{
			if (selectPoint == position)
			{
				return tryAgain();
			}
			if (TSVector2.Distance(new TSVector2(body.tsTransform.Position.x, body.tsTransform.Position.y), selectPoint) > bodyDistance)
			{
				return selectPoint;
			}
			return tryAgain();
		}
		return selectPoint;
		TSVector2 tryAgain()
		{
			angle += searchIncreaseAngle;
			if (angle > 360)
			{
				return selectPoint;
			}
			return GetRandomPoint(position, angle, rotation, body);
		}
	}

	private void OnReceiveMessage(IEvent evt)
	{
		if (evt is AdventureMonsterGundamMessage adventureMonsterGundamMessage)
		{
			if (adventureMonsterGundamMessage.operationType == "skillSelectPositionFinish" && adventureMonsterGundamMessage.monsterId != _actor.Id)
			{
				anotherHandSelectPositionFinish = true;
				anotherHandSelectPosition = adventureMonsterGundamMessage.selectPosition;
			}
			if (adventureMonsterGundamMessage.operationType == "masterBeControl" && adventureMonsterGundamMessage.monsterId == _actor.Id && canBreak)
			{
				_actor.tsTransform.Position = originalPosition;
				_actor.tsTransform.Forward = originalForward;
				_actor.InterruptAttack(force: true);
				BeginAttack(99, actionKeys_daze, flushInputedKeys: true, forceInterruptAttack: true);
				_skill.Clear();
			}
		}
	}

	protected override void OnActorDied(IEvent evt)
	{
		if (_actor != null && evt is AdventureActorDiedEvent adventureActorDiedEvent && _actor == adventureActorDiedEvent.actor && _skill != null)
		{
			_skill.Clear();
		}
	}

	private void SendSkillSelectPositionFinishMessage(TSVector2 selectPosition)
	{
		AdventureMonsterGundamMessage adventureMonsterGundamMessage = AdventureMonsterGundamMessage.Generate();
		adventureMonsterGundamMessage.monsterId = _actor.Id;
		adventureMonsterGundamMessage.operationType = "skillSelectPositionFinish";
		adventureMonsterGundamMessage.selectPosition = selectPosition;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterGundamMessage);
	}

	private IEnumerator GetAttackTargetPosition()
	{
		TargetPosition = new TSVector2(0, -32.2);
		while (true)
		{
			LogicEntity attackTargetWithOwnerTauntFrom = GetAttackTargetWithOwnerTauntFrom((long)GetLogicTagFpValue(_actor, "bodyId"));
			if (CheckTargetIsValid(attackTargetWithOwnerTauntFrom))
			{
				TargetPosition = GetEntityPositionObsoleted(attackTargetWithOwnerTauntFrom);
			}
			yield return null;
		}
	}
}
