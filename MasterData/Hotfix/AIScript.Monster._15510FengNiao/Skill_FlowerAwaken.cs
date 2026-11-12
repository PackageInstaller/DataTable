using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_FlowerAwaken : SimpleAPI_FengNiao
{
	private static readonly ComboInputBuffer.ActionKey[] CallFlowerNormal_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private static readonly ComboInputBuffer.ActionKey[] CallFlowerPlus_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	private FP TmpDistance;

	private TSVector2 ChosenPoint;

	private TSVector2 SelfPosition;

	private ComboInputBuffer.ActionKey[] CallFlower_Combo;

	private FP Phase;

	private FP Difficulty;

	private FP LightDistance;

	private bool IsTwice;

	private List<TSVector2> ChosenPointList;

	private bool IsBossRush;

	private bool IsUpgrade;

	protected override void OnSkillEnable()
	{
		ChosenPointList = new List<TSVector2>
		{
			GetPlaceHolderPosition("WakeUpFlowerPoints1"),
			GetPlaceHolderPosition("WakeUpFlowerPoints2"),
			GetPlaceHolderPosition("WakeUpFlowerPoints3"),
			GetPlaceHolderPosition("WakeUpFlowerPoints4"),
			GetPlaceHolderPosition("WakeUpFlowerPoints5")
		};
		Phase = GetLogicTagFpValue(_actor, "BattleStage");
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		IsBossRush = GetLogicTagToggleValue(_actor, "IsBossRush");
		SetLogicTagToggleValue(_actor, "InFlowerAwakenSkill", value: true);
		if (IsBossRush)
		{
			if (Phase == 1 || Phase == 2)
			{
				IsUpgrade = false;
			}
			else
			{
				IsUpgrade = true;
			}
		}
		else if (Phase == 1)
		{
			IsUpgrade = false;
		}
		else
		{
			IsUpgrade = true;
		}
		if (!IsUpgrade)
		{
			CallFlower_Combo = CallFlowerNormal_Combo;
			LightDistance = 11;
			IsTwice = false;
		}
		else
		{
			CallFlower_Combo = CallFlowerPlus_Combo;
			LightDistance = 16;
			IsTwice = true;
		}
		(GetCurrentPlayer() as AdventureActor).InPerfectDodge = true;
	}

	protected override void OnSkillDisable()
	{
		SetLogicTagToggleValue(_actor, "FastRecoverFlower", value: false);
		SetLogicTagToggleValue(_actor, "FlowerAwakening", value: false);
		SetLogicTagToggleValue(_actor, "InFlowerAwakenSkill", value: false);
		(GetCurrentPlayer() as AdventureActor).InPerfectDodge = false;
	}

	protected override IEnumerator DoMainLogic()
	{
		ChooseNearestPoint();
		yield return StartCor(FlashBeforeAttackForFengNiaoToFixedPosition(ChosenPoint));
		BeginAttack(1, CallFlower_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("FastRecover");
		SetLogicTagToggleValue(_actor, "FastRecoverFlower", value: true);
		SetLogicTagToggleValue(_actor, "FlowerAwakening", value: true);
		yield return null;
		SetLogicTagFpValue(_actor, "LightDistance", LightDistance);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetLogicTagToggleValue(_actor, "FastRecoverFlower", value: false);
		SetLogicTagToggleValue(_actor, "FlowerAwakening", value: false);
		if (IsTwice)
		{
			ChosenPoint = ChosenPointList.get_Item((int)(long)GetRandomValue(0, 3.99, isInt: true));
			yield return StartCor(FlashBeforeAttackForFengNiaoToFixedPosition(ChosenPoint));
			BeginAttack(1, CallFlower_Combo, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("FastRecover");
			SetLogicTagToggleValue(_actor, "FastRecoverFlower", value: true);
			SetLogicTagToggleValue(_actor, "FlowerAwakening", value: true);
			yield return null;
			SetLogicTagFpValue(_actor, "LightDistance", LightDistance);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			SetLogicTagToggleValue(_actor, "FastRecoverFlower", value: false);
			SetLogicTagToggleValue(_actor, "FlowerAwakening", value: false);
		}
		if (Difficulty == 1)
		{
			yield return WaitTime(4);
		}
		else
		{
			yield return WaitTime(1.5);
		}
	}

	private void ChooseNearestPoint()
	{
		SelfPosition = GetPosition();
		TmpDistance = 99;
		foreach (TSVector2 chosenPoint in ChosenPointList)
		{
			FP fP = Distance(chosenPoint, SelfPosition);
			if (fP < TmpDistance && fP >= 2)
			{
				ChosenPoint = chosenPoint;
				TmpDistance = fP;
			}
		}
		ChosenPointList.Remove(ChosenPoint);
	}
}
