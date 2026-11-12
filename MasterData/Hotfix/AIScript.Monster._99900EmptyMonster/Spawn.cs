using System.Collections;

namespace AIScript.Monster._99900EmptyMonster;

public class Spawn : SkillSimpleBase
{
	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(1);
		SetBattleOutDisable();
	}
}
