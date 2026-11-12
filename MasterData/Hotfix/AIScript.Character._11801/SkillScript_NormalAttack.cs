#define LOG_DEBUG
using System;
using System.Collections.Generic;

namespace AIScript.Character._11801;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private readonly Dictionary<int, string> actionTags = new Dictionary<int, string>
	{
		[0] = "Atk1",
		[1] = "Atk2",
		[2] = "Atk3",
		[3] = "Atk4"
	};

	private readonly string specialActionTag = "ComboClip_118_Atk_P3";

	private readonly int perkId_3 = 511803;

	private static readonly int buffId_perk_3 = 11890001;

	private static readonly int maxBuffNum_perk_3 = 4;

	private readonly int perkId_4 = 511804;

	private int _attackCount;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11801 Skill_NormalAttack OnDisable");
		base.OnSkillDisable();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11801 Skill_NormalAttack OnEnable");
		base.OnSkillEnable();
	}

	public void OnUpdate()
	{
		LockDirection();
	}

	public void OnStart()
	{
		NovaLogger.Debug("11801 Skill_NormalAttack OnStart");
		_attackCount = (int)(long)_actor.logicVariable.GetLogicTagValue("normalCount");
		actionTags.TryGetValue(_attackCount, out var value);
		if ((ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_3, out var perkLevel) || ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_4, out perkLevel)) && _actor.buffComponent.GetBuffNumByID(buffId_perk_3) >= 2)
		{
			value = specialActionTag;
			_actor.buffComponent.RemoveBuffByBuffId(buffId_perk_3, 2);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_4, out perkLevel) && _attackCount == actionTags.Count - 1)
		{
			_actor.buffComponent.AddBuff(buffId_perk_3, _actor);
		}
		string actionTag = value;
		System.Action onAnticipationEnd = OnAnticipationEnd;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnAnticipationEnd()
	{
		_attackCount++;
		if (_attackCount > 3)
		{
			_attackCount = 0;
		}
		_actor.logicVariable.SetLogicTagValue("normalCount", _attackCount);
	}

	private void OnFinish()
	{
		NovaLogger.Debug("11801 Skill onFinish");
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		NovaLogger.Debug("11801 Skill onInterrupt");
		_skill.Clear();
	}
}
