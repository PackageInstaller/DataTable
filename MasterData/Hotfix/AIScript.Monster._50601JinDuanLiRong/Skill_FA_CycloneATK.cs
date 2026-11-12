using System.Collections;
using TrueSync;

namespace AIScript.Monster._50601JinDuanLiRong;

public class Skill_FA_CycloneATK : JinDuanLiRongSkillBase
{
	protected override IEnumerator DoMainLogic()
	{
		yield return StartCor(SummonMate());
		if (GetAiType() != 3)
		{
			yield break;
		}
		FP mateCount = 4;
		SetLogicTagFpValue(_actor, "SummonsCount", mateCount);
		UseMonsterCloneActorCastSkill(5060135);
		for (int i = 0; i < 10; i++)
		{
			if (GetTargetByTeammateIndex(6) != null && GetTargetByTeammateIndex(6).Count == mateCount)
			{
				foreach (LogicEntity item in GetTargetByTeammateIndex(6))
				{
					SetLogicTagToggleValue(item, "Summons", value: true);
				}
				break;
			}
			yield return WaitTime(0.2);
		}
	}
}
