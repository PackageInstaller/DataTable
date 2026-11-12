using System;
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13301;

public class SkillScript_Skill : TowerCharacterSkillBase
{
	private string key_base = "Skill_Base";

	private string key_P1 = "Skill_Base_P1";

	private string key_P4 = "Skill_Base_P4";

	private string key_P1_4 = "Skill_Base_P14";

	private FP loopTime = 3;

	private const int perkId_1 = 1330101;

	private const int perkId_3 = 1330103;

	private FP addLoopTime_3 = 1.5;

	private const int perkId_4 = 1330104;

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
		bool perk = GetPerk(1330101);
		bool perk2 = GetPerk(1330104);
		string text = key_base;
		if (perk & perk2)
		{
			text = key_P1_4;
		}
		else if (perk)
		{
			text = key_P1;
		}
		else if (perk2)
		{
			text = key_P4;
		}
		SkillScript_Skill skillScript_Skill = this;
		string actionTag = text;
		Action<string> action = onCustomEvent;
		Action onComboFinish = SkillFinish;
		Action onInterrupt = SkillInterrupt;
		skillScript_Skill.BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, action);
		FP seconds = (GetPerk(1330103) ? (loopTime + addLoopTime_3) : loopTime);
		yield return _actor.WaitTime(seconds);
		_actor.CancelAttack();
	}

	private void onCustomEvent(string evt)
	{
	}
}
