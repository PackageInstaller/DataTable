using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10019BanShenHua;

public class Skill_Death : SkillSimpleBase
{
	private static List<LogicEntity> KillTarget = new List<LogicEntity>();

	private static CoroutineNode TimeLimit;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		if (Skill_NormalAttack.ringFxIndex != null && Skill_NormalAttack.ringFxIndex.Count > 0)
		{
			for (int i = 0; i < Skill_NormalAttack.ringFxIndex.Count; i++)
			{
				StopEffect(Skill_NormalAttack.ringFxIndex.get_Item(i));
			}
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		KillTarget.Add(_actor);
		KillActors(KillTarget);
		yield return WaitTime(1.5);
	}
}
