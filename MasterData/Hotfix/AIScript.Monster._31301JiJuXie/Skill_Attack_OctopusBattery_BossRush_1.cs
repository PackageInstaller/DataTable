using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Attack_OctopusBattery_BossRush_1 : SkillSimpleBase
{
	private static readonly string combo_Attack = "Attack1";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAtByPos_NotWait(new TSVector2(0, -0.1), 0.2, 900);
		yield return WaitTime(0.2);
		BeginAttack(1, combo_Attack, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.8);
		yield return WaitTime(0.2);
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config.evt_SprayEnterLoop;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		BeginRotateAngle_NotWait(80, 50);
		yield return WaitTime(3);
		BeginRotateAngle_NotWait(-160, 50);
		yield return WaitTime(3.5);
		CancelAttack();
		CancelAim();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
