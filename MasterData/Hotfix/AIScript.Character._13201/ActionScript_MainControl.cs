using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13201;

public class ActionScript_MainControl : ActionScript
{
	private const int skillId_Stage1 = 13231001;

	private const int skillId_Stage2 = 13231002;

	private const int skillId_Stage3 = 13231003;

	private const int perkId_1 = 513201;

	private const int perkId_5 = 513205;

	private const int buffId_P5 = 13205011;

	private const int perkId_6 = 513206;

	private const int buffId_P6 = 13206011;

	private const int perkId_7 = 513207;

	private const int buffId_P7 = 13207011;

	private const int perkId_9 = 513209;

	private const int parameterId_P9 = 13209011;

	private const int buffId_P9 = 13209011;

	private const int perkId_10 = 513210;

	private const int buffId_P10 = 13210011;

	private static readonly int EventHashCode_NormalAttackHit = CommonHelper.StringToHash("13201_Normal_Attack_Hit");

	private static readonly int EventHashCode_SkillEnterRecovery = CommonHelper.StringToHash("13201_MainControl_Skill_EnterRecovery");

	private static readonly int EventHashCode_SkillHit = CommonHelper.StringToHash("13201_Skill_Hit");

	private int _nextStageSkillId;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513209, out var _))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 13209011);
			_playerSkillCd.ModifySectionResumeTimeAmend(-scriptValue, 13231001);
		}
		else
		{
			_playerSkillCd.ResetSectionResumeTimeAmend(13231001);
		}
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustonEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_SKILLUSEHINT_FINISH", OnSkillUseHintFinish);
	}

	protected override void OnButtonAPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge);
	}

	protected override void OnButtonBPress()
	{
		int currentBindSkillId = _playerSkillCd.GetCurrentBindSkillId(ActionKey.B);
		if (ILRuntimeAPI.CreateSkill(currentBindSkillId, _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnSkillFinish))
		{
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
			UpdateNextSkillId();
			if (currentBindSkillId == 13231001 && CommonUtils.HavePersonalPerk(_actor.dataID, 513207, out var perkLevel))
			{
				_actor.buffComponent?.RemoveBuffByBuffId(13207011);
			}
			if (currentBindSkillId == 13231001 && CommonUtils.HavePersonalPerk(_actor.dataID, 513209, out perkLevel))
			{
				_actor.buffComponent.AddBuff(13209011, _actor);
			}
		}
		_actor.logicVariable.ToggleLogicTag("HoldingKeyB", value: true);
	}

	private void OnSkillFinish(bool success)
	{
		if (success)
		{
			TryBindNextStageSkill();
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513205, out var perkLevel))
			{
				_actor.buffComponent?.AddBuff(13205011, _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513206, out perkLevel))
			{
				_actor.buffComponent?.RemoveBuffByBuffId(13206011);
			}
		}
	}

	protected override void OnButtonBCancel()
	{
		_actor.logicVariable.ToggleLogicTag("HoldingKeyB", value: false);
	}

	protected override void OnButtonDPress()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnUltraSkillFinish))
		{
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		}
	}

	private void OnUltraSkillFinish(bool success)
	{
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513210, out var _))
		{
			_actor.buffComponent?.AddBuff(13210011, _actor);
		}
	}

	public void OnUpdate()
	{
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		if (_actor.attackTarget != null && _actor.movementState != ActorState.Dash && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor))
		{
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
	}

	private void OnReceiveCustonEvent(IEvent evt)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = evt as AdventureActorCustomEvent;
		if (adventureActorCustomEvent.actor != _actor)
		{
			return;
		}
		int perkLevel;
		if (adventureActorCustomEvent.eventHashCode == EventHashCode_NormalAttackHit)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513206, out perkLevel))
			{
				_actor.buffComponent?.AddBuff(13206011, _actor);
			}
		}
		else if (adventureActorCustomEvent.eventHashCode == EventHashCode_SkillHit)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513207, out perkLevel))
			{
				_actor.buffComponent?.AddBuff(13207011, _actor);
			}
		}
		else if (adventureActorCustomEvent.eventHashCode == EventHashCode_SkillEnterRecovery)
		{
			TryBindNextStageSkill();
		}
	}

	private void UpdateNextSkillId()
	{
		switch (_playerSkillCd.GetCurrentBindSkillId(ActionKey.B))
		{
		case 13231001:
			_nextStageSkillId = 13231002;
			break;
		case 13231002:
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513201, out var _))
			{
				_nextStageSkillId = 13231003;
			}
			else
			{
				_nextStageSkillId = 13231001;
			}
			break;
		}
		default:
			_nextStageSkillId = 13231001;
			break;
		}
	}

	private void TryBindNextStageSkill()
	{
		if (_nextStageSkillId > 0 && _playerSkillCd.GetCurrentBindSkillId(ActionKey.B) != _nextStageSkillId)
		{
			_playerSkillCd.BindSkillIdToButton(ActionKey.B, _nextStageSkillId);
			_nextStageSkillId = 0;
		}
	}

	private void OnSkillUseHintFinish(IEvent evt)
	{
		if (evt is AdventureActorSkillUseHintFinishEvent adventureActorSkillUseHintFinishEvent && adventureActorSkillUseHintFinishEvent.sender as PlayerAdventureActor == _actor)
		{
			int skillId = adventureActorSkillUseHintFinishEvent.skillId;
			if (skillId == 13231002 || skillId == 13231003)
			{
				_playerSkillCd.BindSkillIdToButton(ActionKey.B, 13231001);
				_nextStageSkillId = 0;
			}
		}
	}

	private void Clear()
	{
		_playerSkillCd.BindSkillIdToButton(ActionKey.B, 13231001, resetSection: true);
		_nextStageSkillId = 0;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustonEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_SKILLUSEHINT_FINISH", OnSkillUseHintFinish);
		Clear();
	}
}
