using System;
using System.Collections;
using TrueSync;

namespace AIScript.Character._14201;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private string key_Base = "Skill_Mian_ShengLong";

	private string key_P1 = "Skill_Mian_ShengLong_P1";

	private string evt_second = "ShengLongOK";

	private const int perkId_1 = 514201;

	private const int perkId_3 = 514203;

	private int buff_3 = 14203011;

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
		string text = key_Base;
		if (GetPerkLv(514201, out var _))
		{
			text = key_P1;
		}
		SkillScript_MainControl skillScript_MainControl = this;
		string actionTag = text;
		Action<string> action = onCustomEvent;
		System.Action onInterrupt = SkillInterrupt;
		System.Action onComboFinish = SkillFinish;
		skillScript_MainControl.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, action);
		yield break;
	}

	private void onCustomEvent(string evt)
	{
		if (evt.Equals(evt_second) && GetPerkLv(514203, out var _))
		{
			_actor.buffComponent.AddBuff(buff_3, _actor);
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
