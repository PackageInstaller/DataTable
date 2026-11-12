using System.Collections;
using TrueSync;

namespace AIScript.Monster._50311DaWuGui;

public class DaWuGui_Born : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Born = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
		AddBuffToTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (currentPlayer != null)
		{
			TargetPosition = GetEntityPositionObsoleted(currentPlayer);
		}
		while (Distance(TargetPosition, GetPosition()) >= 15)
		{
			yield return WaitFrame(3);
			currentPlayer = GetCurrentPlayer();
			if (currentPlayer != null)
			{
				TargetPosition = GetEntityPositionObsoleted(currentPlayer);
			}
		}
		RemoveBuffFromTarget(_actor, 990020140);
		SetBattleOutDisable();
		ShowCenterHpBar();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
