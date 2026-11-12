using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_FlyUp : SimpleAPI_FengNiao
{
	private static readonly ComboInputBuffer.ActionKey[] Fly_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private static readonly ComboInputBuffer.ActionKey[] Null_Combo = new ComboInputBuffer.ActionKey[0];

	private TSVector2 BlinkPosition;

	private FP Phase;

	private int AddBuffID1;

	private int AddBuffID2;

	private LogicEntity AttackTarget;

	private int BirdCount;

	private List<LogicEntity> Bird;

	private int BirdCountIndex;

	protected override void OnSkillEnable()
	{
		Phase = GetLogicTagFpValue(_actor, "BattleStage");
		BirdCountIndex = 0;
		Bird = new List<LogicEntity>();
		if (Phase == 1)
		{
			AddBuffID1 = 155109370;
			AddBuffID2 = 155109390;
		}
		else
		{
			AddBuffID1 = 155109380;
			AddBuffID2 = 155109400;
		}
	}

	protected override void OnSkillDisable()
	{
		Bird.Clear();
		RemoveBuffFromTarget(AttackTarget, 155100210);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (Phase >= 2)
		{
			yield return StartCor(SummonBeforeSkillForFengNiao("CastFlyUpSkill"));
			Bird.AddRange(GetTargetByTeammateIndexes(new List<int> { 3, 4 }));
			BirdCount = Bird.Count;
			foreach (LogicEntity item in Bird)
			{
				SetLogicTagToggleValue(item, "StartSkill", value: true);
			}
		}
		BeginAttack(1, Fly_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		AddBuffToTarget(_actor, AddBuffID1);
		yield return WaitCustomEvent("LeaveBattle");
		SetBattleOutEnable();
		SetCloseBlockEnable();
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("减益"));
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.35);
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (Phase >= 2)
		{
			while (BirdCountIndex < BirdCount)
			{
				if (BirdCountIndex % 2 == 0)
				{
					SetLogicTagFpValue(Bird.get_Item(BirdCountIndex), "AimMode", 1);
				}
				else
				{
					SetLogicTagFpValue(Bird.get_Item(BirdCountIndex), "AimMode", 2);
				}
				SetLogicTagFpValue(Bird.get_Item(BirdCountIndex), "WaitAttackTime", 0.15 * (double)BirdCountIndex);
				SetLogicTagToggleValue(Bird.get_Item(BirdCountIndex), "StartAttack", value: true);
				BirdCountIndex++;
			}
			yield return WaitTime(0.15 * (double)BirdCountIndex + 0.5);
		}
		else
		{
			AddBuffToTarget(AttackTarget, 155100210);
			yield return WaitTime(1);
			RemoveBuffFromTarget(AttackTarget, 155100210);
		}
		AttackTarget = GetAttackTarget(isUpToDate: true);
		BlinkPosition = GetEntityPositionObsoleted(AttackTarget);
		Blink_NotWait(Null_Combo, BlinkPosition, 0, null, 0, null, 0, AttackTarget);
		PlayEarlyWarningEffect("FlyDownWarning_3", 0.8f, 0, BlinkPosition);
		PlayWwiseSound("mon_15510_gold_circle");
		yield return WaitTime(0.8);
		CancelAttack();
		AddBuffToTarget(_actor, AddBuffID2);
		FlowerShootStart();
		yield return WaitCustomEvent("JoinBattle");
		SetBattleOutDisable();
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
