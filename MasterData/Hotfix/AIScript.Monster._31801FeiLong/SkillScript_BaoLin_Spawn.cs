using System.Collections;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_BaoLin_Spawn : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		SetUnparalleledEnable();
		SetCloseBlockEnable();
		_actor.AddTag(Config.tag_BaoLin);
		BeginAttack(0, "");
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (((MonsterAdventureActor)_actor).monsterSummonInfo.SummonActor is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.buffComponent.CheckBuffByBuffID(318010010))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config.eventHashCode_BaoLin_Explosion;
			adventureActorCustomEvent.boolParam = true;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}
}
