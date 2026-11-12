using System.Collections;

namespace AIScript.Monster._14700011DevilSpeaker;

public class Skill_NormalAttack : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key_base = "Atk1";

	private string key_P4 = "Atk2";

	private string evt_P3 = "P3RingAtk";

	private int castAreaEvt = CommonHelper.StringToHash("castAreaEvt");

	private const int perkId_4 = 514704;

	private PlayerAdventureActor summoner;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		summoner = logicComponent.SummonActor as PlayerAdventureActor;
	}

	protected override IEnumerator DoMainLogic()
	{
		string actionKey = key_base;
		if (GetPerkLv(514704, out var _))
		{
			actionKey = key_P4;
		}
		BeginAttack(keyIndex, actionKey, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(summoner.dataID, perkId, out lv);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName.Equals(evt_P3) && summoner != null)
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = castAreaEvt;
			summoner.DispatchEvent(adventureActorCustomEvent);
		}
	}
}
