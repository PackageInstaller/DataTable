#define LOG_DEBUG
using System;
using System.Collections.Generic;

namespace AIScript.Character._12301;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private readonly Dictionary<int, string> actionTags = new Dictionary<int, string>
	{
		[0] = "Attack1",
		[1] = "Attack2",
		[2] = "Attack3",
		[3] = "Attack4"
	};

	private int attackCount;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_12301 Skill_NormalAttack OnDisable");
		base.OnSkillDisable();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_12301 Skill_NormalAttack OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_12301 Skill_NormalAttack OnStart");
		if (_actor.attackTarget != null)
		{
			attackCount = (int)(long)_actor.logicVariable.GetLogicTagValue("normalCount");
			if (actionTags.TryGetValue(attackCount, out var value))
			{
				string actionTag = value;
				System.Action onComboFinish = OnFinish;
				System.Action onInterrupt = OnInterrupt;
				System.Action onAnticipationEnd = OnAnticipationEnd;
				Action<string> onCustomEvent = OnCustomEvent;
				BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
			}
			else
			{
				OnInterrupt();
			}
		}
		else
		{
			OnInterrupt();
		}
	}

	protected void OnAnticipationEnd()
	{
		attackCount++;
		if (attackCount > 3)
		{
			attackCount = 0;
		}
		_actor.logicVariable.SetLogicTagValue("normalCount", attackCount);
	}

	protected void OnRecoveryBegin()
	{
		NovaLogger.Debug("_12301 onRecoveryBegin:");
	}

	protected void OnCustomEvent(string eventName)
	{
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_12301Skill1 onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_12301Skill1 onInterrupt");
		OnFinish();
	}

	public void OnUpdate()
	{
		LockDirection();
	}
}
