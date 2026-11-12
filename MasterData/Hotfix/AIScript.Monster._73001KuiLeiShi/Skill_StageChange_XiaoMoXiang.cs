using System.Collections;

namespace AIScript.Monster._73001KuiLeiShi;

public class Skill_StageChange_XiaoMoXiang : SkillSimpleBase
{
	private const string combo_StageChange = "";

	private bool finished;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (!finished)
		{
			ClearOwnerBullet();
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "", flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		DispatchCustomEvent(Common_73001.evt_Phase2Enter);
		finished = true;
	}
}
