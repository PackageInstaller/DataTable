using System.Collections;
using TrueSync;

namespace AIScript.Monster._13051GaoDa;

public class Skill_Rocket_Prologue : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_3 = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_daze = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.X };

	private static readonly string lookAtFxAlias1 = "RocketPunchAim";

	private static readonly string lookAtFxAlias2 = "RocketPunchAim2";

	private static readonly string DashFxAlias1 = "RocketPunchDash1";

	private static readonly string DashFxAlias2 = "RocketPunchDash2";

	private static readonly string HitFxAlias = "Hit";

	private static readonly string customEventName_FlyDown = "FlyDown";

	private static readonly string customEventName_FlyUp = "FlyUp";

	private static readonly string customEventName_HideSelf = "HideSelf";

	private static readonly FP lookAtSpeed = 150;

	private static readonly FP dashSpeed = 30;

	private static readonly FP dashDistance = 50;

	private FP lookAtDuration_1 = 1;

	private FP lookAtDuration_2 = 2;

	private TSVector2 regionCenterPositonOffset = new TSVector2(0, -7.6);

	private FP regionWidth = 30;

	private FP regionHeight = 12;

	private FP waitTimeByDashFriend = 0.5;

	private static readonly FP lookAtDuration_1_strafe = 1;

	private static readonly FP lookAtDuration_2_strafe = 4;

	private static readonly TSVector2 regionCenterPositonOffset_strafe = new TSVector2(0, -10.6);

	private static readonly FP regionWidth_strafe = 30;

	private static readonly FP regionHeight_strafe = 12;

	private FP waitTimeByDashFriend_strafe = 2;

	private static readonly FP lookAtDuration_1_laser = 0.5;

	private static readonly FP lookAtDuration_2_laser = 3;

	private static readonly TSVector2 regionCenterPositonOffset_laser = new TSVector2(0, -6.6);

	private static readonly FP regionWidth_laser = 30;

	private static readonly FP regionHeight_laser = 12;

	private FP waitTimeByDashFriend_laser = 1.5;

	private int skillType;

	private int cooperateType;

	private TSVector2 originalPosition;

	private TSVector2 originalForward;

	private TSVector2 originalLookAtPostion;

	private TSVector2 regionCenterPositon;

	private bool anotherHandLookAtFinish;

	private bool dashFinishByFriend;

	private CoroutineNode hitCoroutine;

	private bool canBreak;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		anotherHandLookAtFinish = false;
		dashFinishByFriend = false;
		skillType = (int)(long)_actor.logicVariable.GetLogicTagValue("skillType");
		cooperateType = (int)(long)_actor.logicVariable.GetLogicTagValue("cooperateType");
		originalPosition = _actor.tsTransform.Position;
		originalForward = _actor.tsTransform.Forward;
		originalLookAtPostion = originalPosition + originalForward * 100;
		regionCenterPositon = TransLocalPosToWorldPos(GetPosition(), GetForward(), regionCenterPositonOffset);
		if (cooperateType == 1)
		{
			lookAtDuration_1 = lookAtDuration_1_strafe;
			lookAtDuration_2 = lookAtDuration_2_strafe;
			regionCenterPositon = TransLocalPosToWorldPos(GetPosition(), GetForward(), regionCenterPositonOffset_strafe);
			regionWidth = regionWidth_strafe;
			regionHeight = regionHeight_strafe;
			waitTimeByDashFriend = waitTimeByDashFriend_strafe;
		}
		else if (cooperateType == 2)
		{
			lookAtDuration_1 = lookAtDuration_1_laser;
			lookAtDuration_2 = lookAtDuration_2_laser;
			regionCenterPositon = TransLocalPosToWorldPos(GetPosition(), GetForward(), regionCenterPositonOffset_laser);
			regionWidth = regionWidth_laser;
			regionHeight = regionHeight_laser;
			waitTimeByDashFriend = waitTimeByDashFriend_laser;
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_GAMDAM_MESSAGE", OnReceiveMessage);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_GAMDAM_MESSAGE", OnReceiveMessage);
		SendSkillLookAtFinishMessage();
		StopCoroutine(ref hitCoroutine);
	}

	protected override IEnumerator DoMainLogic()
	{
		canBreak = true;
		yield return WaitTime(0.5);
		long RocketPunchAim1 = PlayLoopFx(lookAtFxAlias1, 1f, _actor.transform.position, _actor.transform.rotation);
		long RocketPunchAim2 = PlayLoopFx(lookAtFxAlias2, 1f, _actor.transform.position, _actor.transform.rotation);
		BeginAttack(1, actionKeys_1);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (skillType == 1)
		{
			LogicEntity Target = GetAttackTargetWithOwnerTauntFrom((long)GetLogicTagFpValue(_actor, "bodyId"));
			FP Remain = lookAtDuration_1;
			BeginLookAt_NotWait(Target, lookAtDuration_1, lookAtSpeed);
			while (Remain > 0)
			{
				if (Target != GetAttackTargetWithOwnerTauntFrom((long)GetLogicTagFpValue(_actor, "bodyId")) && CheckTargetIsValid(Target))
				{
					Target = GetAttackTargetWithOwnerTauntFrom((long)GetLogicTagFpValue(_actor, "bodyId"));
					StopWaitLookAt();
					BeginLookAt_NotWait(Target, Remain, lookAtSpeed);
				}
				Remain -= (FP)0.1;
				yield return WaitTime(0.1);
			}
			SendSkillLookAtFinishMessage();
		}
		else
		{
			LogicEntity Target = GetAttackTargetWithOwnerTauntFrom((long)GetLogicTagFpValue(_actor, "bodyId"));
			WaitLookAt(Target, -1, lookAtSpeed);
			while (!anotherHandLookAtFinish)
			{
				if (Target != GetAttackTargetWithOwnerTauntFrom((long)GetLogicTagFpValue(_actor, "bodyId")) && CheckTargetIsValid(Target))
				{
					Target = GetAttackTargetWithOwnerTauntFrom((long)GetLogicTagFpValue(_actor, "bodyId"));
					StopWaitLookAt();
					WaitLookAt(Target, -1, lookAtSpeed);
				}
				yield return null;
			}
			if (CheckPlayerPosition())
			{
				StopWaitLookAt();
			}
			else
			{
				yield return WaitTime(lookAtDuration_2 - lookAtDuration_1);
				StopWaitLookAt();
			}
		}
		Skill_Rocket_Prologue skill_Rocket_Prologue = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Rocket_Prologue.PlayEffect("RocketWarning", 1f, default, position, rotation, 2f);
		yield return WaitTime(0.5);
		PlayEffect("RocketPunchDashStart");
		BeginDash(1, _actor.tsTransform.Forward * -1, 4, 1.5, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		StopLoopFx(RocketPunchAim1);
		StopLoopFx(RocketPunchAim2);
		canBreak = false;
		long DashFx1 = PlayLoopFx(DashFxAlias1, 1f, _actor.transform.position, _actor.transform.rotation);
		long DashFx2 = PlayLoopFx(DashFxAlias2, 1f, _actor.transform.position, _actor.transform.rotation);
		BeginDashActorForward(2, dashSpeed, dashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		StartCor(CheckHandsHitTogether());
		StartCoroutine(ref hitCoroutine, Hit());
		yield return WaitDashFinish();
		FP blinkDuration = lookAtDuration_2 - lookAtDuration_1;
		if (skillType == 2)
		{
			blinkDuration = 0;
		}
		StopCoroutine(ref hitCoroutine);
		StopLoopFx(DashFx1);
		StopLoopFx(DashFx2);
		if (dashFinishByFriend)
		{
			PlayFeedbackEffect("TwoPunch");
			blinkDuration = 0;
			BeginAttack(2, actionKeys_1);
			PlayFx(HitFxAlias, 1f, 2.8, TransLocalPosToWorldPos(_actor.tsTransform.Position, _actor.tsTransform.Forward, new TSVector2(0, 2.7)), _actor.tsTransform.Rotation, null, 4f);
			BeginDash(3, _actor.tsTransform.Forward * -1, 9, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(waitTimeByDashFriend);
			BeginAttack(3, actionKeys_3, flushInputedKeys: true);
			yield return WaitCustomEvent(customEventName_FlyUp);
			SetCloseBlockEnable();
			SetBattleOutEnable();
			yield return WaitCustomEvent(customEventName_HideSelf);
			SetHideModelEnable();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginDashActorForward(4, dashSpeed * 2, dashDistance * 0.5, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
			SetCloseBlockEnable();
			SetBattleOutEnable();
			BeginAttack(4, actionKeys_1);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			SetHideModelEnable();
		}
		yield return WaitTime(1);
		yield return Blink(null, originalPosition, blinkDuration, "", 0, "", 0, GetAttackTargetWithOwnerTauntFrom((long)GetLogicTagFpValue(_actor, "bodyId")));
		BeginLookAtByPos(originalLookAtPostion, 0, 999);
		BeginAttack(5, actionKeys_2);
		SetHideModelDisable();
		yield return WaitCustomEvent(customEventName_FlyDown);
		SetCloseBlockDisable();
		SetBattleOutDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private bool CheckPlayerPosition()
	{
		bool flag = false;
		LogicEntity attackTargetWithOwnerTauntFrom = GetAttackTargetWithOwnerTauntFrom((long)GetLogicTagFpValue(_actor, "bodyId"));
		if (!CheckTargetIsValid(attackTargetWithOwnerTauntFrom))
		{
			return true;
		}
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(attackTargetWithOwnerTauntFrom);
		flag = entityPositionObsoleted.x < regionCenterPositon.x + regionWidth / 2 && entityPositionObsoleted.x > regionCenterPositon.x - regionWidth / 2;
		if (flag)
		{
			flag = entityPositionObsoleted.y < regionCenterPositon.y + regionHeight / 2 && entityPositionObsoleted.y > regionCenterPositon.y - regionHeight / 2;
		}
		return flag;
	}

	private IEnumerator CheckHandsHitTogether()
	{
		int index = 2;
		if (_actor.dataID == GetTeammateIdByIndex(2))
		{
			index = 1;
		}
		if (GetTargetByTeammateIndex(index).Count != 0)
		{
			LogicEntity AnotherTeammate = GetTargetByTeammateIndex(index).get_Item(0);
			while (!CheckTargetIsValid(AnotherTeammate) || (Distance(GetEntityPositionObsoleted(AnotherTeammate), GetPosition()) >= 5 && CheckTargetIsValid(AnotherTeammate)))
			{
				yield return null;
			}
			StopDash();
			dashFinishByFriend = true;
		}
	}

	private IEnumerator Hit()
	{
		while (true)
		{
			TSVector2 position = _actor.tsTransform.Position;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, position, 3, 6, 0, 0, 0, _actor.tsTransform.Rotation);
			HitBox.FeatureFlag hitFlags = HitBox.FeatureFlag.KnockBack | HitBox.FeatureFlag.AirBorne | HitBox.FeatureFlag.DamageFreezeFrame;
			HitBox.HitBoxFeatureData hitFeatureData = new HitBox.HitBoxFeatureData
			{
				KnockBackForce = 90,
				KnockBackDistance = 20,
				KnockOutForce = 10,
				FreezeFrameWhenDamage = 0.3,
				FreezeFrameWhenCrit = 0.3,
				FreezeFrameWhenToughnessBroken = 0.3,
				hitStrenth = 5f
			};
			AreaHit(shapeData, hitFlags, hitFeatureData, "HitFxAlias", 0f, 1f, 1f, actorScale: true, default, default, HitBox.HurtAnimType.Large, 13052031, 0.7);
			yield return null;
		}
	}

	private void OnReceiveMessage(IEvent evt)
	{
		if (evt is AdventureMonsterGundamMessage adventureMonsterGundamMessage)
		{
			if (adventureMonsterGundamMessage.operationType == "skillLookAtFinish" && adventureMonsterGundamMessage.monsterId != _actor.Id)
			{
				anotherHandLookAtFinish = true;
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

	private void SendSkillLookAtFinishMessage()
	{
		AdventureMonsterGundamMessage adventureMonsterGundamMessage = AdventureMonsterGundamMessage.Generate();
		adventureMonsterGundamMessage.monsterId = _actor.Id;
		adventureMonsterGundamMessage.operationType = "skillLookAtFinish";
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterGundamMessage);
	}
}
