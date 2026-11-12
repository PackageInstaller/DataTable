using System.Collections;
using TrueSync;

namespace AIScript.Monster._11031FaMuXie;

public class Skill_Spawn : SkillSimpleBase
{
	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
		AddBuffToTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		TargetPosition = GetEntityPosition(currentPlayer);
		while (Distance(TargetPosition, GetPosition()) >= 14)
		{
			yield return WaitFrame(3);
			currentPlayer = GetCurrentPlayer();
			TargetPosition = GetEntityPosition(currentPlayer);
		}
		RemoveBuffFromTarget(_actor, 990020140);
		SetBattleOutDisable();
		ShowCenterHpBar();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
