using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._Wind._50301MaoDa;

public class Wind_Attack02_Nuji_Spawn : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.A,
		ComboInputBuffer.ActionKey._1
	};

	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		SetBattleOutEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(20);
		SetHideModelDisable();
		SetBattleOutDisable();
		yield return WaitFrame(15);
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(1);
		if (targetByTeammateIndex.Count > 2)
		{
			for (int i = 0; i < targetByTeammateIndex.Count; i++)
			{
				LogicEntity target = targetByTeammateIndex.get_Item(i);
				AddBuffToTarget(target, 503010005);
			}
			AddBuffToTarget(_actor, 503010005);
		}
	}
}
