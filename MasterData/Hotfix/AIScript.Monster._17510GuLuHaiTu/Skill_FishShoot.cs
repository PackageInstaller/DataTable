#define LOG_DEBUG
using System.Collections;

namespace AIScript.Monster._17510GuLuHaiTu;

public class Skill_FishShoot : SkillSimpleBase
{
	private int waveIndex;

	private string waveKey = "Wave";

	private string actionStateTagName = "AcitonFinish";

	private int skillId_Clone = 1751012;

	private bool sentEvent;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("咕噜海兔.鱼群冲击.开始");
		SetLogicTagToggleValue(_actor, actionStateTagName, value: false);
		sentEvent = false;
	}

	protected override void OnSkillDisable()
	{
		if (!sentEvent)
		{
			SetLogicTagToggleValue(_actor, actionStateTagName, value: true);
		}
		NovaLogger.Debug("咕噜海兔.鱼群冲击.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(waveIndex, waveKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		UseMonsterCloneActorCastSkill(skillId_Clone);
		sentEvent = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
