using System.Collections;

namespace AIScript.Monster._30931HaSaNa;

public class SkillScript_SkillScript_SandStorm : SkillSimpleBase
{
	protected override IEnumerator DoMainLogic()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventName = "HaSaNaTriggerSandStorm";
		PlaySceneEffect("Actor/Monster/30931HaSaNa/FX/fx_m30931_loop_screen_sendwind");
		AddBuffToTarget(_actor, 309310030);
		SetLogicTagToggleValue(_actor, "MeleeAttackUpdated", value: true);
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		yield break;
	}
}
