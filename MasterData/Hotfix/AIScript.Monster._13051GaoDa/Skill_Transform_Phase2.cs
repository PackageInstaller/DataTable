using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._13051GaoDa;

public class Skill_Transform_Phase2 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.V };

	private bool IsInterrupt;

	private bool IsSummonComplete;

	protected override void OnSkillEnable()
	{
		IsInterrupt = true;
		IsSummonComplete = false;
	}

	protected override void OnSkillDisable()
	{
		if (!IsSummonComplete)
		{
			SummonTeammate(4, GetPlaceHolderPosition("PhantomPoint1"), TSVector2.left, 4);
			SummonTeammate(5, GetPlaceHolderPosition("PhantomPoint2"), TSVector2.right, 4);
		}
		if (IsInterrupt)
		{
			AddBuff();
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, actionKeys, flushInputedKeys: true);
		ReplaceAnimationGroup(1);
		if (GetTeammateIdByIndex(4) != 0)
		{
			SwitchCameraSetting(active: true, "BattleCamera");
			yield return WaitTime(1);
			SummonTeammate(4, GetPlaceHolderPosition("PhantomPoint1"), TSVector2.left, 4);
			SummonTeammate(5, GetPlaceHolderPosition("PhantomPoint2"), TSVector2.right, 4);
			IsSummonComplete = true;
			yield return WaitTime(1);
			SwitchCameraSetting(active: true, "BattleCamera2");
		}
		yield return WaitTime(1);
		AddBuff();
		IsInterrupt = false;
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}

	private void AddBuff()
	{
		AddBuffToTarget(_actor, 130519210);
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		List<LogicEntity> targetByTeammateIndex2 = GetTargetByTeammateIndex(2);
		if (targetByTeammateIndex.Count > 0)
		{
			AddBuffToTarget(targetByTeammateIndex.get_Item(0), 130519220);
		}
		if (targetByTeammateIndex2.Count > 0)
		{
			AddBuffToTarget(targetByTeammateIndex2.get_Item(0), 130519230);
		}
	}
}
