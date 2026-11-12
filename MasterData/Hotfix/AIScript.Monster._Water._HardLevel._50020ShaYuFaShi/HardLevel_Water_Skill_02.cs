using System.Collections;
using TrueSync;

namespace AIScript.Monster._Water._HardLevel._50020ShaYuFaShi;

public class HardLevel_Water_Skill_02 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.B,
		ComboInputBuffer.ActionKey._0
	};

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetAttackTarget(), 1, 360);
		yield return WaitTime(6.5);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "Spawn")
		{
			TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetAttackTarget());
			TSVector2 spawnDirection = new TSVector2(0, 0);
			SummonTeammate(4, entityPositionObsoleted, spawnDirection);
		}
	}
}
