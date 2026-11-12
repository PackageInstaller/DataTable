using System;
using AdventureBehaviour;

namespace AIScript.Monster.Soldier._135._135BoomGhost;

public class SummonSkill : SkillAdvancedBase
{
	private const string actionKey = "ComboSummonSkill";

	private const string eventName_AreaEffect = "Fire";

	private const string areaEffectAlias = "AreaEffect";

	public static readonly int broadcastEvt_SkillEnd = CommonHelper.StringToHash("135BoomGhost_SkillEnd");

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
	}

	private void OnFinish()
	{
		DispatchSkillEnd();
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		DispatchSkillEnd();
		_skill.Clear();
	}

	private void DoMainLogic()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("ComboSummonSkill", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "Fire"))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect", _actor.tsTransform.Position, _actor.tsTransform.Rotation);
		}
	}

	private void DispatchSkillEnd()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.eventHashCode = broadcastEvt_SkillEnd;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}
}
