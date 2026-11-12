using System.Collections;
using TrueSync;

namespace AIScript.Monster._HardLevel._50101YinYing;

public class HardLevel_Skill_03 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private readonly string Area_Effect = "AreaEffect_50101YinYing_HardLevel_Dark_Skill03";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true);
		yield return WaitCustomEvent("D");
		BoomArea();
		yield return WaitFrame(30);
		BoomArea();
		yield return WaitFrame(30);
		BoomArea();
		yield return WaitFrame(30);
		BoomArea();
		yield return WaitFrame(15);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void BoomArea()
	{
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetAttackTarget());
		PlayAreaEffect(Area_Effect, entityPositionObsoleted, 0);
	}
}
