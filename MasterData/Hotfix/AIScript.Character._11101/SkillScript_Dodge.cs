using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11101;

public class SkillScript_Dodge : SkillAdvancedBase
{
	private ComboInputBuffer.ActionKey[] actionKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	private ComboInputBuffer.ActionKey[] actionKey2 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.C };

	private int cdInner = 10;

	private FP duration = 0.3;

	private FP distance = 0.01;

	private int proba = 10;

	private Dodge dodge = new Dodge();

	private bool flage;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableInvincible();
		Clear();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_skill.Clear();
	}

	private void Clear()
	{
		dodge.Interrupte();
		if (flage)
		{
			((PlayerAdventureActor)_actor).dodgeButtonHold = false;
		}
	}

	public void OnStart()
	{
		FP logicTagValue = _actor.logicVariable.GetLogicTagValue("cdInner");
		if (TSRandom.Range(0, 100) < proba && _actor.LogicTime - logicTagValue > cdInner)
		{
			_actor.GetLogicComponent<PlayerSkillCd>().AddSkillSection(ActionKey.A);
			flage = true;
			_actor.logicVariable.SetLogicTagValue("cdInner", _actor.LogicTime);
			_actor.logicVariable.ToggleLogicTag("dodge", value: true);
			ComboInputBuffer.ActionKey[] keys = actionKey2;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
		else
		{
			flage = false;
			_actor.logicVariable.ToggleLogicTag("dodge", value: false);
			ComboInputBuffer.ActionKey[] keys2 = actionKey1;
			Action onInterrupt = OnActivationEnd;
			Action onComboFinish = OnFinish;
			Action onInterrupt2 = OnInterrupt;
			BeginAttack(keys2, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt2, null, onInterrupt);
		}
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward.normalized;
		}
		dodge.Begin(_actor, tSVector, duration, distance, null, comboWithAttack: true);
	}

	private void OnActivationEnd()
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
}
