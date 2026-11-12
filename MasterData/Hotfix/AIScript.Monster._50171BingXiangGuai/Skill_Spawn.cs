using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai;

public class Skill_Spawn : SkillSimpleBase
{
	private FP waiTime = 2;

	private readonly string key = "";

	protected override IEnumerator DoMainLogic()
	{
		if (!string.IsNullOrEmpty(key))
		{
			BeginAttack(1, key, flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		yield return WaitTime(waiTime);
	}
}
