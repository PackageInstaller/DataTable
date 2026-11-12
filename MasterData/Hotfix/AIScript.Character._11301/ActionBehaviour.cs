#define LOG_DEBUG
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11301;

public class ActionBehaviour : ActorActionBase
{
	private enum AIState
	{
		None,
		Normal,
		Special
	}

	private FP normalAtkBreakTime = 1;

	private int evt_strong = CommonHelper.StringToHash("StrongAtk");

	protected PlayerSkillCd _skillManage;

	private ActorSearchTarget actorSearchInfo;

	private IState curState;

	private readonly IdleState_1 idleState_1 = new IdleState_1();

	private readonly IdleState_2 idleState_2 = new IdleState_2();

	private readonly AimState aimState = new AimState();

	private readonly NormalAttackState normalAttackState = new NormalAttackState();

	private SkillState skillState;

	private readonly AimTarget _aimTarget = new AimTarget();

	private AIState curAIState = AIState.Normal;

	private AIState lastAIState = AIState.Normal;

	private FP lastNormalTime;

	private int curNormalPhase;

	private int normalPhaseCount = 3;

	protected override void OnActionEnable()
	{
		_skillManage = _actor.GetLogicComponent<PlayerSkillCd>();
		actorSearchInfo = _actor.GetLogicComponent<ActorSearchTarget>();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		idleState_1.Init(_actor, _skillManage, _aimTarget);
		idleState_2.Init(_actor, _skillManage, _aimTarget);
		aimState.Init(_actor, _skillManage, _aimTarget);
		normalAttackState.Init(_actor, _skillManage, _aimTarget);
		curNormalPhase = 0;
	}

	protected override void OnActionDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		_actor.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		Clear();
	}

	public override void OnStart()
	{
		base.OnStart();
		DoMainLogic();
	}

	public void OnUpdate()
	{
		MainLoop();
	}

	public override void OnStop()
	{
		base.OnStop();
		Clear();
	}

	private void Clear()
	{
		_aimTarget.Cancel();
		_actor.movementMode = AdventureActor.MovementMode.Run;
	}

	protected override void OnButtonAPress()
	{
		CastSkill(ActionKey.A, SkillPhaseFeatureFlag.Dodge);
	}

	protected override void OnButtonAClickOrCancel()
	{
	}

	protected override void OnButtonBPress()
	{
		CastSkill(ActionKey.B, SkillPhaseFeatureFlag.Skill1);
		_actor.logicVariable.ToggleLogicTag("HoldingKeyD", value: true);
	}

	protected override void OnButtonBCancel()
	{
		_actor.logicVariable?.ToggleLogicTag("HoldingKeyD", value: false);
	}

	protected override bool CastIndependentRushSkill()
	{
		return CastSkill(ActionKey.C, SkillPhaseFeatureFlag.Skill2, 0, isInterruptAttack: true, isRushJoinDodge: false);
	}

	protected override void OnButtonDPress()
	{
		CastSkill(ActionKey.D, SkillPhaseFeatureFlag.Ultimate);
	}

	private void OnTrCastSkill(IEvent _evt)
	{
		ActorTryCastSkill actorTryCastSkill = _evt as ActorTryCastSkill;
		if (actorTryCastSkill.sender as AdventureActor == _actor)
		{
			CastSkill(ActionKey.None, actorTryCastSkill.flag, actorTryCastSkill.skillId, actorTryCastSkill.isInterruptAttack);
		}
	}

	private void OnCastEndSkill(IEvent evt)
	{
		AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = evt as AdventureActorCastSkillEndEvent;
		if (_actor != null && adventureActorCastSkillEndEvent.sender as AdventureActor == _actor && adventureActorCastSkillEndEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NORMAL)
		{
			lastNormalTime = _actor.LogicTime;
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent)
		{
			_ = adventureActorCustomEvent.eventHashCode;
			_ = evt_strong;
		}
	}

	private bool CastSkill(ActionKey key, SkillPhaseFeatureFlag skillPhaseFeatureFlag, int skillId = 0, bool isInterruptAttack = true, bool isRushJoinDodge = true)
	{
		skillState = new SkillState();
		skillState.Init(_actor, _skillManage, _aimTarget);
		skillState.actionKey = key;
		skillState.specialSkill = skillId;
		skillState.skillPhaseFeatureFlag = skillPhaseFeatureFlag;
		skillState.isInterruptAttack = isInterruptAttack;
		skillState.isRushJoinDodge = isRushJoinDodge;
		skillState.Enter();
		if (skillState.CanCast)
		{
			curState.Exit();
			curState = skillState;
		}
		else
		{
			NovaLogger.Debug($"释放失败 {skillId}");
		}
		return skillState.CanCast;
	}

	private void DoMainLogic()
	{
		if (curState == null)
		{
			if (_actor.logicVariable.GetLogicTagToggle("switch_state"))
			{
				curState = idleState_2;
			}
			else
			{
				curState = idleState_1;
			}
			curState.Enter();
		}
	}

	private void MainLoop()
	{
		_actor.attackTarget = actorSearchInfo.GetLockingConfrontActor(useInputDirection: true);
		if (curState.IsEnd)
		{
			curState = GetNextState();
			curState.Enter();
		}
		else
		{
			curState.Update();
		}
	}

	private IState GetNextState()
	{
		if (curAIState == AIState.Normal)
		{
			return GetNextState_Normal();
		}
		return GetNextState_Special();
	}

	private bool CheckSwitchState()
	{
		curAIState = ((!_actor.logicVariable.GetLogicTagToggle("switch_state")) ? AIState.Normal : AIState.Special);
		bool result = lastAIState != curAIState;
		lastAIState = curAIState;
		return result;
	}

	private void ResetNormalPharse()
	{
		curNormalPhase = 0;
	}

	private IState GetNextState_Normal()
	{
		if (_actor.attackTarget != null)
		{
			FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
			bool isObstacleBetweenActorAndTargetAndPreventNormalAttack = IsObstacleBetweenActorAndTargetAndPreventNormalAttack;
			if (CommonUtils.GetAttackRange(_actor) > fP && !isObstacleBetweenActorAndTargetAndPreventNormalAttack)
			{
				if (_actor.LogicTime - lastNormalTime > normalAtkBreakTime)
				{
					ResetNormalPharse();
				}
				curNormalPhase = curNormalPhase % normalPhaseCount + 1;
				_actor.logicVariable.SetLogicTagValue("curNormalPhase", curNormalPhase);
				lastNormalTime = _actor.LogicTime;
				return normalAttackState;
			}
		}
		return idleState_1;
	}

	private IState GetNextState_Special()
	{
		if (_actor.attackTarget != null)
		{
			if (_actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget && !(_actor as PlayerAdventureActor).dodgeButtonHold)
			{
				return aimState;
			}
			if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
			{
				FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
				if (CommonUtils.GetAttackRange(_actor) > fP)
				{
					return normalAttackState;
				}
			}
		}
		return idleState_2;
	}
}
