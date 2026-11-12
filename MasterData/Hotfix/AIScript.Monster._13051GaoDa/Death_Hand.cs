using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._13051GaoDa;

public class Death_Hand : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Death_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	private static readonly ComboInputBuffer.ActionKey[] Burst_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private bool Dashing;

	private TSVector2 LookAtPosition;

	private TSVector2 DashDirection;

	private FP DashDistance;

	private string ExplodingFXName;

	private long ExplodingFX;

	private string ExplodeOverFXName;

	private int Difficulty;

	private FP DamageMagnification;

	protected override void OnSkillEnable()
	{
		if (_actor.dataID == GetTeammateIdByIndex(1))
		{
			ExplodingFXName = "Hand_ExplodingFX_L";
			ExplodeOverFXName = "Hand_ExplodeOverFX_L";
		}
		else
		{
			ExplodingFXName = "Hand_ExplodingFX_R";
			ExplodeOverFXName = "Hand_ExplodeOverFX_R";
		}
		LookAtPosition = GetPlaceHolderPosition("BossPositionPoint");
		Dashing = true;
		Difficulty = (int)(long)GetLogicTagFpValue(GetTargetByID((long)GetLogicTagFpValue(_actor, "bodyId")), "Difficulty");
		switch (Difficulty)
		{
		case 1:
			DamageMagnification = 0.45;
			break;
		case 2:
			DamageMagnification = 0.3;
			break;
		case 3:
			DamageMagnification = 0.6;
			break;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(0);
		if (targetByTeammateIndex.Count == 0)
		{
			BeginAttack(1, Burst_Combo, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Disappear");
			SetHideModelEnable();
			yield return WaitCombo(ComboAttackType.isComboFinish);
			yield break;
		}
		LogicEntity Target = targetByTeammateIndex.get_Item(0);
		BeginAttack(1, Death_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtByPos_NotWait(LookAtPosition, 0, 180);
		ExplodingFX = PlayEffect(ExplodingFXName);
		DashDirection = GetEntityPositionObsoleted(Target) - GetPosition();
		DashDistance = Distance(GetEntityPositionObsoleted(Target), GetPosition());
		yield return WaitTime(1);
		BeginDash(1, DashDirection, DashDistance / 1.5, DashDistance, 0, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		SetCloseBlockEnable();
		while (Dashing)
		{
			yield return null;
		}
		CancelAttack();
		PlayFeedbackEffect("Suicide");
		AddBuffToTarget(Target, 130519240);
		PlayEffect(ExplodeOverFXName, 1f, 2.8, TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0)), default, 2f);
		StopEffect(ExplodingFX);
		SetHideModelEnable();
		DirectDamage(Target, (int)(long)((Target as AdventureActor).actorHealthInfo.hpMax * DamageMagnification), null);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "Explode" && Distance(LookAtPosition, GetPosition()) <= 8.75)
		{
			StopDash();
			Dashing = false;
		}
	}
}
