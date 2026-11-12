using System.Collections;

namespace AIScript.Monster._50171BingXiangGuai_V3;

public class Spawn : SkillSimpleBase
{
	private string ShowLong = "ShowLong";

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
		AddBuffToTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, ShowLong, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		RemoveBuffFromTarget(_actor, 990020140);
		SetBattleOutDisable();
		ShowCenterHpBar();
		yield return WaitTime(0.5);
	}
}
