using System.Collections;
using TrueSync;

namespace AIScript.Monster._30281ShengDanTaLou;

public class Skill_08 : SkillSimpleBase
{
	private string Attack = "Skill08";

	private TSVector2 SpawnPos = new TSVector2(0, -3);

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtByDir_NotWait(new TSVector2(0, 10), 1, 360);
		yield return WaitCustomEvent("ChargeEnd");
		CancelAttack();
		SummonTeammate(1, SpawnPos, new TSVector2(0, 15));
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
