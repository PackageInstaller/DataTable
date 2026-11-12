using System.Collections;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class Skill06_ActivateSandArea : SkillSimpleBase
{
	private static readonly string QuickCasting = "QuickCasting";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, QuickCasting, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Call");
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
