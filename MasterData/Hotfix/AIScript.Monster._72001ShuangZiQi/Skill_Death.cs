using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Death : SkillSimpleBase
{
	private int phase;

	private bool isRed;

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		isRed = GetLogicTagToggleValue(_actor, "Red");
		SendDeclareDeadEvent();
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(6);
		if (targetByTeammateIndex.Count > 0)
		{
			CommonUtils_MonsterAPI.SetBattleOutEnable(targetByTeammateIndex.get_Item(0) as AdventureActor);
		}
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		if (phase == 3)
		{
			BeginAttack(1, "Death", flushInputedKeys: true, forceInterruptAttack: true);
			SendDeclareDeadEvent();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(1, "ChangeState", flushInputedKeys: true, forceInterruptAttack: true);
			RanSe();
			yield return WaitTime(2);
			MonoSingleton<LuaManager>.Instance.FireEvent("JointDrill_BattleLvsToggle_Type2");
		}
	}

	private void RanSe()
	{
		List<int> intParamList = new List<int>
		{
			0, 2, 4, 6, 8, 10, 12, 14, 16, 18,
			20, 22, 24
		};
		List<int> intParamList2 = new List<int>
		{
			1, 3, 5, 7, 9, 11, 13, 15, 17, 19,
			21, 23
		};
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventHashCode = Config.ranseEvt;
		adventureActorCustomEvent.intParamList = intParamList;
		adventureActorCustomEvent.intParam = (isRed ? 1 : 2);
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent2.sender = _actor;
		adventureActorCustomEvent2.eventHashCode = Config.ranseEvt;
		adventureActorCustomEvent2.intParamList = intParamList2;
		adventureActorCustomEvent2.intParam = 0;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent2);
	}
}
