using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._FanRong_Wind._10012FanRongZhiShiTi;

public class FanRong_Wind_Death : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	protected override IEnumerator DoMainLogic()
	{
		SetCloseBlockEnable();
		SendDeclareDeadEvent();
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(1);
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		ClearActors(targetByTeammateIndex);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
