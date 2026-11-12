#define LOG_DEBUG
using System;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._11201;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private readonly Dictionary<int, string> actionTags = new Dictionary<int, string>
	{
		[0] = "Attack_New_1",
		[1] = "Attack_New_2",
		[2] = "Attack_New_3",
		[3] = "Attack_New_4"
	};

	private readonly string actionTag_p4 = "Attack_JianQi";

	private readonly string actionTag_p5 = "Attack_New_4_T5";

	private readonly FP saveComboIndexTime = 5;

	private int attackCount;

	private bool specialSkill;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_11201 Skill_NormalAttack OnDisable");
		base.OnSkillDisable();
		Parallel.normalComboTime = _actor.LogicTime;
		_actor.movementFSM.runtimeIgonreRootMotion = false;
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_11201 Skill_NormalAttack OnEnable");
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, Parallel.personalPerkId_8, out var _) && _actor.logicVariable.GetLogicTagToggle("p8_trigger"))
		{
			_actor.buffComponent.AddBuff(11250811, _actor);
		}
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_11201 Skill_NormalAttack OnStart");
		if (_actor.attackTarget != null)
		{
			specialSkill = false;
			if (_actor.LogicTime > Parallel.normalComboTime + saveComboIndexTime)
			{
				attackCount = 0;
			}
			else
			{
				attackCount = (int)(long)_actor.logicVariable.GetLogicTagValue("normalCount");
			}
			string value;
			if (_actor.logicVariable.GetLogicTagToggle("ChenShaZaDi_Skill"))
			{
				specialSkill = true;
				string actionTag = actionTag_p4;
				System.Action onComboFinish = OnFinish;
				System.Action onInterrupt = OnInterrupt;
				System.Action onAnticipationEnd = OnAnticipationEnd;
				BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
			}
			else if (actionTags.TryGetValue(attackCount, out value))
			{
				if (attackCount == 3 && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511205, out var _))
				{
					value = actionTag_p5;
				}
				string actionTag2 = value;
				System.Action onAnticipationEnd = OnFinish;
				System.Action onInterrupt = OnInterrupt;
				System.Action onComboFinish = OnAnticipationEnd;
				Action<string> onCustomEvent = OnCustomEvent;
				BeginAttack(actionTag2, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onComboFinish, null, onAnticipationEnd, onInterrupt, onCustomEvent);
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
			_actor.logicVariable.ToggleLogicTag("DogeReset", value: true);
			_actor.logicVariable.ToggleLogicTag("m2_SkillAtkTag", value: true);
			attackCount = 0;
		}
		_actor.logicVariable.SetLogicTagValue("normalCount", attackCount);
	}

	protected void OnRecoveryBegin()
	{
		NovaLogger.Debug("_11201 onRecoveryBegin:");
	}

	protected void OnCustomEvent(string eventName)
	{
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("Skill1 onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("Skill1 onInterrupt");
		OnFinish();
	}

	public void OnUpdate()
	{
		if (SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() != TSVector2.zero)
		{
			_actor.movementFSM.runtimeIgonreRootMotion = true;
		}
		else
		{
			_actor.movementFSM.runtimeIgonreRootMotion = false;
		}
		LockDirection();
	}
}
