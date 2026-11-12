using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13001;

public class ActionScript_MainControl : ActionScript
{
	private int _summonedCount;

	private FP _additionalStrengthenTime;

	private bool _inStrengthen;

	private PlayFX _playFX;

	private bool InStrengthen
	{
		get
		{
			return _inStrengthen;
		}
		set
		{
			if (_inStrengthen != value)
			{
				_inStrengthen = value;
				OnStrengthenStateChange(_inStrengthen);
			}
		}
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_summonedCount = 0;
		_additionalStrengthenTime = 0;
		InStrengthen = false;
		(_actor as PlayerAdventureActor).searchType = PlayerActorSearchType.Range;
		(_actor as PlayerAdventureActor).moveControlType = PlayerActorMoveType.Melee;
		(_actor as PlayerAdventureActor).enableReload = false;
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
	}

	protected override void OnButtonAPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	protected override void OnButtonBPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	protected override void OnButtonDPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	private void OnReceiveCustomEvent(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent adventureActorCustomEvent) || adventureActorCustomEvent.eventHashCode != Config_MainControl.eventHashCode_DonutSummonedEvent)
		{
			return;
		}
		if (adventureActorCustomEvent.boolParam)
		{
			_summonedCount++;
			return;
		}
		_summonedCount--;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513001, out var _))
		{
			_additionalStrengthenTime = CommonUtils.GetScriptValue(_actor, 13001011);
		}
	}

	private void OnBattleReady(IEvent _)
	{
		_playerSkillCd.ResetSkillCD(ActionKey.B);
	}

	private void OnStrengthenStateChange(bool inStrengthen)
	{
		int currentBindSkillId = _playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal);
		if (inStrengthen)
		{
			(_actor as PlayerAdventureActor).moveControlType = PlayerActorMoveType.Range;
			if (currentBindSkillId != 13010002)
			{
				_playerSkillCd.BindSkillIdToButton(ActionKey.Normal, 13010002);
			}
			if (!string.IsNullOrEmpty("fx_13001_loop_B1_Skill_Weapon"))
			{
				if (_playFX == null)
				{
					_playFX = new PlayFX();
				}
				if (_playFX.fxInstance == null)
				{
					_playFX.Play(_actor, null, "fx_13001_loop_B1_Skill_Weapon", 0, _actor.tsTransform.Position, TSVector2.zero);
				}
			}
		}
		else
		{
			(_actor as PlayerAdventureActor).moveControlType = PlayerActorMoveType.Melee;
			if (currentBindSkillId != 13010001)
			{
				_playerSkillCd.BindSkillIdToButton(ActionKey.Normal, 13010001);
			}
			_playFX?.Stop();
			_playFX?.Clear();
		}
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		InStrengthen = _summonedCount > 0 || _additionalStrengthenTime > 0;
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		SceneSingleton<AdventurePlayerController>.Instance.MainActorCanAttack = InStrengthen || SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() == TSVector2.zero;
		if (CanNormalAttack())
		{
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
		if (_summonedCount <= 0 && _additionalStrengthenTime > 0)
		{
			_additionalStrengthenTime -= _actor.LogicDeltaTime;
		}
	}

	private bool CanNormalAttack()
	{
		if (_actor.attackTarget != null)
		{
			FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
			TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (InStrengthen)
			{
				if (_actor.movementState != ActorState.Dash)
				{
					return fP <= CommonUtils.GetAttackRange(_actor);
				}
				return false;
			}
			if (movementInputDirection == TSVector2.zero)
			{
				return fP <= CommonUtils.GetAttackRange(_actor);
			}
			return false;
		}
		return false;
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnReceiveCustomEvent);
		_playFX?.Stop();
		_playFX?.Clear();
		_summonedCount = 0;
		_additionalStrengthenTime = 0;
		InStrengthen = false;
		(_actor as PlayerAdventureActor).searchType = PlayerActorSearchType.Range;
		(_actor as PlayerAdventureActor).moveControlType = PlayerActorMoveType.Melee;
		(_actor as PlayerAdventureActor).enableReload = false;
	}
}
