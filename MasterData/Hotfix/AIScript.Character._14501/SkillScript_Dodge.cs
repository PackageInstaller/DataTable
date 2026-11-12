using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14501;

public class SkillScript_Dodge : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey actionKey = ComboInputBuffer.ActionKey.D;

	private readonly FP duration = 0.3;

	private readonly FP distance = 0.01;

	private static readonly int _transitionRushSkillId = 0;

	private static readonly FP _realDodgeDistance = 3.156516f;

	private static readonly FP _crossDodgeAdditionDistance = 1.5f;

	private static readonly FP _crossDodgeKeepAwayNavmeshEdgeDistance = 0.1f;

	private const int perkId_11 = 514711;

	protected Dodge _dodge;

	private bool crossObstacle;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	private void DoMainLogic()
	{
		_actor.PlayFX("fx_10501_base_skill1_1_shadow");
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
		if (((PlayerAdventureActor)_actor).dodgeButtonHold && !_actor.forbiddenRush)
		{
			int specialSkillId = ((PlayerAdventureActor)_actor).playerAIInfo.SpecialSkillId;
			if (specialSkillId != 0)
			{
				ActorTryCastSkill actorTryCastSkill = ActorTryCastSkill.Generate();
				actorTryCastSkill.sender = _actor;
				actorTryCastSkill.skillId = specialSkillId;
				actorTryCastSkill.isInterruptAttack = false;
				actorTryCastSkill.flag = SkillPhaseFeatureFlag.Skill2;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(actorTryCastSkill);
				OnFinish();
			}
		}
		else if (SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput() && _transitionRushSkillId != 0)
		{
			ILRuntimeAPI.CreateSkill(_transitionRushSkillId, _actor, SkillPhaseFeatureFlag.Skill2, SkillLauncherType.Character, isInterruptAttack: false);
			OnFinish();
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
