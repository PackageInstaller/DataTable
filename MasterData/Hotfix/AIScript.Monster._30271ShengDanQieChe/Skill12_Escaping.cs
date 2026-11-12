using System.Collections;

namespace AIScript.Monster._30271ShengDanQieChe;

public class Skill12_Escaping : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Die = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	private long Emoji;

	protected override void OnSkillDisable()
	{
		StopEffect(Emoji);
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		SetSuperArmorEnable();
		Emoji = PlayEffect("fx_m50801_loop_QiEBaoXiang_Cry");
		BeginAttack(1, Die, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(3);
		StopEffect(Emoji);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
