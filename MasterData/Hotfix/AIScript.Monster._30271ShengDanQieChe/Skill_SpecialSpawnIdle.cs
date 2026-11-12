using System.Collections;
using TrueSync;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill_SpecialSpawnIdle : SkillSimpleBase
{
	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetUnparalleledEnable();
		SetSearchedImmunityEnable();
		SetBattleOutEnable();
		SetCloseBlockEnable();
		SetSuperArmorEnable(autoDisableWhenSkillDisable: false);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		TargetPosition = GetEntityPosition(GetCurrentPlayer());
		while (Distance(TargetPosition, GetPosition()) >= 14)
		{
			yield return WaitFrame(3);
			TargetPosition = GetEntityPosition(GetCurrentPlayer());
		}
		SetBattleOutDisable();
		yield return WaitTime(0.5);
	}
}
