using System.Collections;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill1_Burst_Turn : SkillSimpleBase
{
	private string fxAlias = "fx_m13061_base_skill1";

	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		yield return WaitTime(0.3);
		RemoveBuffFromTarget(_actor, 130610110);
		yield return WaitTime(0.25);
		AddBuffToTarget(_actor, 130610310);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
