using System.Collections;
using TrueSync;

namespace AIScript.Monster._13051GaoDa;

public class Skill_Rocket_InUltra : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_Dash = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_FlyUp = new ComboInputBuffer.ActionKey[1];

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_PunchDown = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private static readonly ComboInputBuffer.ActionKey[] actionKeys_Resume = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly string lookAtFxAlias1 = "RocketPunchAim";

	private static readonly string lookAtFxAlias2 = "RocketPunchAim2";

	private static readonly string DashFxAlias1 = "RocketPunchDash1";

	private static readonly string DashFxAlias2 = "RocketPunchDash2";

	private static readonly string HitFxAlias = "Hit";

	private static readonly FP lookAtSpeed = 150;

	private static readonly FP dashSpeed = 30;

	private static readonly FP dashDistance = 50;

	private static readonly string customEventName_FlyDown_Dash = "FlyDown";

	private static readonly string customEventName_FlyUp_Dash = "FlyUp";

	private static readonly string customEventName_HideSelf_Dash = "HideSelf";

	private static readonly FP lookAtDuration_1 = 0.3;

	private static readonly FP lookAtDuration_2 = 1.3;

	private static readonly FP waitTimeByDashFriend = 0.5;

	private static readonly TSVector2 regionCenterPositon = new TSVector2(0, -24);

	private static readonly FP regionWidth = 30;

	private static readonly FP regionHeight = 12;

	private int skillType;

	private TSVector2 originalPosition;

	private TSVector2 originalForward;

	private TSVector2 originalLookAtPostion;

	private TSVector2 TargetPosition;

	private TSVector2 SelectPosition;

	private TSVector2 Fandirection;

	private bool anotherHandLookAtFinish;

	private bool dashFinishByFriend;

	private CoroutineNode hitCoroutine;

	private CoroutineNode GetPositionNode;

	private bool canBreak;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		StartCoroutine(ref GetPositionNode, GetAttackTargetPosition());
		anotherHandLookAtFinish = false;
		dashFinishByFriend = false;
		skillType = (int)(long)_actor.logicVariable.GetLogicTagValue("skillType");
		originalPosition = _actor.tsTransform.Position;
		originalForward = _actor.tsTransform.Forward;
		originalLookAtPostion = originalPosition + originalForward * 100;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_GAMDAM_MESSAGE", OnReceiveMessage);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_GAMDAM_MESSAGE", OnReceiveMessage);
		SendSkillLookAtFinishMessage();
		SendSkillSelectPositionFinishMessage(TargetPosition);
		StopCoroutine(ref hitCoroutine);
		StopCoroutine(ref GetPositionNode);
	}

	protected override IEnumerator DoMainLogic()
	{
		canBreak = true;
		yield return WaitTime(0.5);
		long RocketPunchAim1 = PlayLoopFx(lookAtFxAlias1, 1f, _actor.transform.position, _actor.transform.rotation);
		long RocketPunchAim2 = PlayLoopFx(lookAtFxAlias2, 1f, _actor.transform.position, _actor.transform.rotation);
		BeginAttack(1, actionKeys_Dash);
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
		Skill_Rocket_InUltra skill_Rocket_InUltra = this;
		TSVector2 position = GetPosition();
		FP rotation = GetRotation();
		skill_Rocket_InUltra.PlayEffect("RocketWarning", 1f, default, position, rotation, 2f);
		yield return WaitTime(0.2);
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
			blinkDuration = 0;
			BeginAttack(2, actionKeys_Dash);
			PlayFx(HitFxAlias, 1f, 2.8, TransLocalPosToWorldPos(_actor.tsTransform.Position, _actor.tsTransform.Forward, new TSVector2(0, 2.7)), _actor.tsTransform.Rotation, null, 4f);
			BeginDash(3, _actor.tsTransform.Forward * -1, 9, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield return WaitTime(waitTimeByDashFriend);
			BeginAttack(3, actionKeys_FlyUp, flushInputedKeys: true);
			yield return WaitCustomEvent(customEventName_FlyUp_Dash);
			SetCloseBlockEnable();
			SetBattleOutEnable();
			yield return WaitCustomEvent(customEventName_HideSelf_Dash);
			SetHideModelEnable();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginDashActorForward(4, dashSpeed * 2, dashDistance * 0.5, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			yield return WaitDashFinish();
			SetCloseBlockEnable();
			SetBattleOutEnable();
			BeginAttack(4, actionKeys_Dash);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			SetHideModelEnable();
		}
		SendSkillLoopFinishMessage();
		yield return WaitTime(4);
		yield return Blink(null, originalPosition, blinkDuration, "", 0, "", 0, GetAttackTargetWithOwnerTauntFrom((long)GetLogicTagFpValue(_actor, "bodyId")));
		BeginLookAtByPos(originalLookAtPostion, 0, 999);
		BeginAttack(5, actionKeys_Resume);
		SetHideModelDisable();
		yield return WaitCustomEvent(customEventName_FlyDown_Dash);
		SetCloseBlockDisable();
		SetInvincibleDisable();
		SetBattleOutDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(2);
		StopCoroutine(ref GetPositionNode);
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
				_actor.PlayLostControlAnim();
				_actor.InterruptAttack(force: true);
				SendSkillLoopFinishMessage();
				_skill.Clear();
			}
		}
	}

	protected override void OnActorDied(IEvent evt)
	{
		if (_actor != null && evt is AdventureActorDiedEvent adventureActorDiedEvent && _actor == adventureActorDiedEvent.actor && _skill != null)
		{
			SendSkillLoopFinishMessage();
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

	private void SendSkillSelectPositionFinishMessage(TSVector2 selectPosition)
	{
		AdventureMonsterGundamMessage adventureMonsterGundamMessage = AdventureMonsterGundamMessage.Generate();
		adventureMonsterGundamMessage.monsterId = _actor.Id;
		adventureMonsterGundamMessage.operationType = "skillSelectPositionFinish";
		adventureMonsterGundamMessage.selectPosition = selectPosition;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterGundamMessage);
	}

	private void SendSkillLoopFinishMessage()
	{
		AdventureMonsterGundamMessage adventureMonsterGundamMessage = AdventureMonsterGundamMessage.Generate();
		adventureMonsterGundamMessage.monsterId = _actor.Id;
		adventureMonsterGundamMessage.operationType = "skillRocketAndSmashFloorFinish";
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
