#define LOG_DEBUG
using System;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Character._11001;

public class SkillScript_NormalAttack : SkillAdvancedBase
{
	private readonly Dictionary<int, string> actionTags = new Dictionary<int, string>
	{
		[0] = "Atk1",
		[1] = "Atk2",
		[2] = "Atk3",
		[3] = "Atk4"
	};

	private readonly string zhFsTag = "110_NrmAtk_ZhaoHuanFenShen";

	private readonly string fsCcTag = "110_FenShen_ChongCi";

	private int attackCount;

	private readonly FP saveComboIndexTime = 3;

	protected override void OnSkillDisable()
	{
		Parallel.normalComboTime = _actor.LogicTime;
		_actor.movementFSM.runtimeIgonreRootMotion = false;
		NovaLogger.Debug("_11001 Skill_NormalAttack OnDisable");
		base.OnSkillDisable();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_11001 Skill_NormalAttack OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_11001 Skill_NormalAttack OnStart");
		if (_actor.attackTarget != null)
		{
			if (_actor.LogicTime > Parallel.normalComboTime + saveComboIndexTime)
			{
				attackCount = 0;
			}
			else
			{
				attackCount = (int)(long)_actor.logicVariable.GetLogicTagValue("normalCount");
			}
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
		if (attackCount >= actionTags.Count)
		{
			attackCount = 0;
		}
		_actor.logicVariable.SetLogicTagValue("normalCount", attackCount);
	}

	protected void OnRecoveryBegin()
	{
		NovaLogger.Debug("_11001 onRecoveryBegin:");
	}

	protected void OnCustomEvent(string eventName)
	{
		if (zhFsTag.Equals(eventName))
		{
			_actor.logicVariable.SetLogicTagValue("110_skill", 0);
			if (Parallel.fsEntitys.Count == 0)
			{
				_actor.logicVariable.SetLogicTagValue("fenSheng", 1);
			}
		}
		else if (fsCcTag.Equals(eventName))
		{
			_actor.logicVariable.SetLogicTagValue("110_skill", 1);
			AdventurActorNormalEvent adventurActorNormalEvent = AdventurActorNormalEvent.Generate();
			adventurActorNormalEvent.sender = _actor;
			adventurActorNormalEvent.stateID = 1;
			adventurActorNormalEvent.enventTag = "fsSkill";
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurActorNormalEvent);
		}
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_11001Skill1 onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_11001Skill1 onInterrupt");
		OnFinish();
	}

	public virtual void OnUpdate()
	{
		LockDirection();
		if (SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() != TSVector2.zero)
		{
			_actor.movementFSM.runtimeIgonreRootMotion = true;
		}
		else
		{
			_actor.movementFSM.runtimeIgonreRootMotion = false;
		}
	}
}
