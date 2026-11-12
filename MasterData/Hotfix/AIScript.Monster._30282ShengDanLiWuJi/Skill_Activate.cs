using System.Collections;
using TrueSync;

namespace AIScript.Monster._30282ShengDanLiWuJi;

public class Skill_Activate : SkillSimpleBase
{
	private string Attack1 = "Born";

	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetBlockPriorityToStatic(autoDisableWhenSkillDisable: false);
		SetBattleOutEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		TargetPosition = GetEntityPosition(currentPlayer);
		while (Distance(TargetPosition, GetPosition()) >= 5)
		{
			yield return WaitFrame(3);
			currentPlayer = GetCurrentPlayer();
			TargetPosition = GetEntityPosition(currentPlayer);
		}
		SetBattleOutDisable();
	}
}
