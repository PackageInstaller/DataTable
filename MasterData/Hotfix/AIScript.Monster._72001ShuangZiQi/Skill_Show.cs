using System.Collections;
using System.Collections.Generic;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Show : SkillSimpleBase
{
	private bool finish;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("GROUPCONTROLLER_TO_MONSTER_MESSAGE", GroupMessageOperate);
		finish = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("GROUPCONTROLLER_TO_MONSTER_MESSAGE", GroupMessageOperate);
		SetLogicTagToggleValue(_actor, Config.Skill_Show_Finish, value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "AttackShow", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Link");
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(6);
		long AttackLink = 0L;
		if (targetByTeammateIndex.Count > 0)
		{
			Skill_Show skill_Show = this;
			LogicEntity target = targetByTeammateIndex.get_Item(0);
			AttackLink = skill_Show.PlayLinkEffect("skill06_link", useCustomSource: false, null, default, default, target);
		}
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitUntil(() => finish);
		CancelAttack();
		if (AttackLink != 0L)
		{
			StopEffect(AttackLink);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GroupMessageOperate(IEvent evt)
	{
		if (evt is AdventureGroupControllerToMonsterMessage adventureGroupControllerToMonsterMessage && adventureGroupControllerToMonsterMessage.monsterId == _actor.Id && adventureGroupControllerToMonsterMessage.operationType.Equals("Skill_Show_End"))
		{
			finish = true;
		}
	}
}
