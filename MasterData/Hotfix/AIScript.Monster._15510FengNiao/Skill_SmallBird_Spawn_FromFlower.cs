using System.Collections;
using TrueSync;

namespace AIScript.Monster._15510FengNiao;

public class Skill_SmallBird_Spawn_FromFlower : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Spawn_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey._1 };

	private TSVector2 GotoPoint;

	private TSVector2 WatchPoint;

	private FP DashDistance;

	protected override void OnSkillEnable()
	{
		SetLogicTagToggleValue(_actor, "SummonComplete", value: false);
		SetLogicTagToggleValue(_actor, "SpawnComplete", value: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		SetBattleOutEnable(autoDisableWhenSkillDisable: false);
		while (!GetLogicTagToggleValue(_actor, "SummonComplete"))
		{
			yield return null;
		}
		yield return null;
		SetHideModelDisable();
		GotoPoint = new TSVector2(GetLogicTagFpValue(_actor, "TargetPointX"), GetLogicTagFpValue(_actor, "TargetPointY"));
		WatchPoint = new TSVector2(GetLogicTagFpValue(_actor, "WatchPointX"), GetLogicTagFpValue(_actor, "WatchPointY"));
		DashDistance = Distance(GetPosition(), GotoPoint);
		BeginAttack(1, Spawn_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		CrossJump(GotoPoint, DashDistance / 0.6, 0.6);
		yield return WaitTime(0.45);
		BeginLookAtByPos_NotWait(WatchPoint, 0.15, 1200.0);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetLogicTagToggleValue(_actor, "SpawnComplete", value: true);
	}
}
