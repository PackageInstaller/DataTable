using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._70061WuYu.BoomGhost;

public class Skill_Born_ExplodeGhost : SkillSimpleBase
{
	private static readonly string BornKey = "Spawn";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, BornKey, flushInputedKeys: true, forceInterruptAttack: true);
		AdventureActor target = _actor.GetLogicComponent<MonsterSummonInfo>()?.SummonActor;
		foreach (KeyValuePair<int, int> item in Config.SummonerSyncBuffMap)
		{
			int buffNum = GetBuffNum(target, item.Key);
			if (buffNum > 0)
			{
				AddBuffToTarget(_actor, item.Value, buffNum);
				List<BuffEntity> buffFromTarget = GetBuffFromTarget(target, item.Key);
				List<BuffEntity> buffFromTarget2 = GetBuffFromTarget(_actor, item.Value);
				if (buffFromTarget != null && buffFromTarget.Count > 0 && buffFromTarget2 != null && buffFromTarget2.Count > 0)
				{
					buffFromTarget2.get_Item(0).SetTime(buffFromTarget.get_Item(0).LeftTime);
				}
			}
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
