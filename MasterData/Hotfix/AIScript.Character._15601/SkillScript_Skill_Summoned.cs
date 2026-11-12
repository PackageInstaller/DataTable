using System;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._15601;

public class SkillScript_Skill_Summoned : SkillAdvancedBase
{
	private FP _duration;

	private AdventureActor _summoner;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_duration = Config_MainControl.duration_Tarce_Summoned_Skill;
		_summoner = ((MonsterAdventureActor)_actor).monsterSummonInfo.SummonActor;
	}

	public void OnStart()
	{
		string text = "Run";
		if (CommonUtils.HavePersonalPerk(_summoner.dataID, 515602, out var _))
		{
			text = "Run_P2";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "PenguinDoll_Healing") && CommonUtils.HavePersonalPerk(_summoner.dataID, 515602, out var _))
		{
			_summoner.buffComponent.AddBuff(15602011, _summoner);
		}
	}

	public void OnUpdate()
	{
		if (_duration > 0)
		{
			_duration -= _actor.LogicDeltaTime;
		}
		else
		{
			_actor.DestroySelf();
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_duration = 0;
	}
}
