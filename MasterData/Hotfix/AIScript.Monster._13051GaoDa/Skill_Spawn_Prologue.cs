using System.Collections;

namespace AIScript.Monster._13051GaoDa;

public class Skill_Spawn_Prologue : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		ShowCenterHpBar();
		if (_actor.dataID == GetTeammateIdByIndex(0))
		{
			yield return WaitTime(0.1);
		}
	}
}
