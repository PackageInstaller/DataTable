using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12301;

public class SkillScript_Dodge_old : SkillAdvancedBase
{
	private ComboInputBuffer.ActionKey actionKey = ComboInputBuffer.ActionKey.D;

	private FP duration = 0.3;

	private FP distance = 0.01;

	private int perkId_10 = 512310;

	private int skillId_Strike = 12356000;

	protected Dodge _dodge;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		Clear();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void Clear()
	{
		comboAttack?.Clear();
	}

	private void DoMainLogic()
	{
		ComboInputBuffer.ActionKey key = actionKey;
		System.Action onActivationEnd = OnActivationEnd;
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(key, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
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
		int perkLevel;
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
		else if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId_10, out perkLevel))
		{
			AdventurRebindSkill adventurRebindSkill = AdventurRebindSkill.Generate();
			adventurRebindSkill.sender = _actor;
			adventurRebindSkill.slotKey = ActionKey.A;
			adventurRebindSkill.skillId = skillId_Strike;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurRebindSkill);
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
