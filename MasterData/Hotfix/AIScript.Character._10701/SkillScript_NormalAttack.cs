using System;
using System.Collections.Generic;

namespace AIScript.Character._10701;

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

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		attackCount = (int)(long)_actor.logicVariable.GetLogicTagValue("normalCount");
		if (actionTags.TryGetValue(attackCount, out var value))
		{
			string actionTag = value;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			System.Action onAnticipationEnd = OnAnticipationEnd;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
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

	public void OnUpdate()
	{
		LockDirection();
	}

	protected void OnBeforeHit(IEvent evt)
	{
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
