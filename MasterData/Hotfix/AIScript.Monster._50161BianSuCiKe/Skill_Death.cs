#define LOG_ERROR
using System.Collections;

namespace AIScript.Monster._50161BianSuCiKe;

public class Skill_Death : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] actionKeys_die = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Z };

	protected override void OnSkillEnable()
	{
		SetSuperArmorEnable();
	}

	protected override void OnSkillDisable()
	{
		SetSuperArmorDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		SendDeclareDeadEvent();
		if (GetLogicTagToggleValue(_actor, "BattleInterrupted"))
		{
			if (!ModuleController<AdventureModuleController>.Instance.CheckAchievementFinished(_actor, HotfixEnum.questCompleteCondClient.SanJianKe_001))
			{
				ModuleController<AdventureModuleController>.Instance.SetAchievementFinish(HotfixEnum.questCompleteCondClient.SanJianKe_001);
				NovaLogger.Error("完成成就1");
			}
			Singleton<InteractiveManager>.Instance.triggerOpListener("BattleInterrupted");
		}
		InterruptHideModel();
		SetCloseBlockEnable();
		BeginAttack(1, actionKeys_die, flushInputedKeys: true);
		yield return WaitTime(4);
		CancelAttack();
	}
}
