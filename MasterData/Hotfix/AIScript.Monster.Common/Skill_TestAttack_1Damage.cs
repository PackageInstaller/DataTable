using System.Collections;

namespace AIScript.Monster.Common;

public class Skill_TestAttack_1Damage : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		while (true)
		{
			SetSuperArmorEnable();
			DirectDamage(GetCurrentPlayer(), 1, null);
			yield return WaitTime(1);
		}
	}
}
