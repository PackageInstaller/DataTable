using System;
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._12701;

public class SkillScript_Support : SkillAdvancedBase
{
	private string key_base = "127_B2_Skill";

	private string evt_water = "127WaterArea";

	private FP loopTime = 6.4;

	private const int perkId_23 = 512723;

	private FP loopTime_23 = 10.4;

	private int shieldEvent = CommonHelper.StringToHash("127SupportAddShield");

	private int castAreaEvent = CommonHelper.StringToHash("CastArea");

	private CoroutineNode corMain;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCoroutine(ref corMain);
	}

	public void OnStart()
	{
		StartCoroutine(ref corMain, DoMainLogic());
	}

	private void SkillFinish()
	{
		_skill?.Clear();
	}

	private void SkillInterrupt()
	{
		_skill?.Clear();
	}

	private IEnumerator DoMainLogic()
	{
		bool perkLv = GetPerkLv(512723, out var _);
		string actionTag = key_base;
		LogicEntity assistantAttackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		if (assistantAttackTarget != null)
		{
			_actor.LookAt(assistantAttackTarget.tsTransform.Position, 0);
		}
		SkillScript_Support skillScript_Support = this;
		Action<string> action = onCustomEvent;
		System.Action onComboFinish = SkillFinish;
		System.Action onInterrupt = SkillInterrupt;
		skillScript_Support.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		yield return _actor.WaitTime(perkLv ? loopTime_23 : loopTime);
		_actor.CancelAttack();
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_water))
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = shieldEvent;
			_actor.DispatchEvent(adventureActorCustomEvent);
			adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventHashCode = castAreaEvent;
			_actor.DispatchEvent(adventureActorCustomEvent);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
