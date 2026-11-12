using System.Collections;

namespace AIScript.Character._16101.Summoned.FangWeiBiao;

public class Skill_Spawn_FangWeiBiao : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Sup_Brith";

	private string evt_area = "Area";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(keyIndex, key, flushInputedKeys: true);
		yield return WaitCustomEvent(evt_area);
		RequestCeHuiArea();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill?.Clear();
	}

	protected void RequestCeHuiArea()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventHashCode = Config.playCeHuiEvt;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}
}
