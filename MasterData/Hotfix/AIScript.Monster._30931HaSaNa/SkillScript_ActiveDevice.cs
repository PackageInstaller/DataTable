using System.Collections;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_ActiveDevice : SkillSimpleBase
{
	private readonly string comboTag = "Skill_1";

	protected override IEnumerator DoMainLogic()
	{
		SetLockToughnessEnable();
		BeginAttack(1, comboTag, flushInputedKeys: true);
		yield return WaitCustomEvent("ActiveLiuShaZhu");
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventName = "HaSaNaActiveDevice";
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		AdventureActorCustomEvent adventureActorCustomEvent2 = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent2.sender = _actor;
		adventureActorCustomEvent2.eventName = "HaSaNaRestoreDevice";
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent2);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
