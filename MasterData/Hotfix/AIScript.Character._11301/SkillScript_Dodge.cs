using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11301;

public class SkillScript_Dodge : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] key_main = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected readonly ComboInputBuffer.ActionKey[] key_support = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.W,
		ComboInputBuffer.ActionKey.D
	};

	private readonly FP duration = 0.3;

	private readonly FP distance = 0.01;

	protected Dodge _dodge;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	private void Clear()
	{
		comboAttack?.Clear();
	}

	private void DoMainLogic()
	{
		ComboInputBuffer.ActionKey[] array = key_main;
		if (_actor is PlayerAdventureActor { isAssist: not false })
		{
			array = key_support;
		}
		ComboInputBuffer.ActionKey[] keys = array;
		Action onActivationEnd = OnActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward.normalized;
		}
		if (_dodge == null)
		{
			_dodge = new Dodge();
		}
		_dodge.Begin(_actor, tSVector, duration, distance, null, comboWithAttack: true);
	}

	protected void OnActivationEnd()
	{
		if (((PlayerAdventureActor)_actor).dodgeButtonHold && !_actor.forbiddenRush)
		{
			int specialSkillId = ((PlayerAdventureActor)_actor).playerAIInfo.SpecialSkillId;
			if (specialSkillId != 0)
			{
				ActorTryCastSkill actorTryCastSkill = ActorTryCastSkill.Generate();
				actorTryCastSkill.sender = _actor;
				actorTryCastSkill.skillId = specialSkillId;
				actorTryCastSkill.flag = SkillPhaseFeatureFlag.Skill2;
				actorTryCastSkill.isInterruptAttack = false;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(actorTryCastSkill);
				OnFinish();
			}
		}
	}

	protected void OnFinish()
	{
		_dodge?.Interrupte();
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		_dodge?.Interrupte();
		_skill?.Clear();
	}
}
