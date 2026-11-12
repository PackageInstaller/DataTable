using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._16101;

public class Action : ActorActionBase
{
	protected PlayerSkillCd _skillManage;

	protected int _reloadLoading;

	private ActorSearchTarget actorSearchInfo;

	private AmmoInfo ammoInfo;

	private IState curState;

	private NormalAttackState normalAttackState = new NormalAttackState();

	private AimTarget _aimTarget = new AimTarget();

	private ClassObjectPool<SkillState> skillPool;

	private FP normalAtkBreakTime = 2;

	private FP lastNormalTime;

	private int curNormalPhase;

	private int normalPhaseCount = 3;

	protected override void OnActionEnable()
	{
		_skillManage = _actor.GetLogicComponent<PlayerSkillCd>();
		actorSearchInfo = _actor.GetLogicComponent<ActorSearchTarget>();
		ammoInfo = ActorHelper.GetFlowAmmoInfo(_actor.gameObject);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnActorBeControlled);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		normalAttackState.Init(_actor, _skillManage, _aimTarget);
		skillPool = new ClassObjectPool<SkillState>(() => new SkillState(_actor, _skillManage, _aimTarget), 4);
		curNormalPhase = 0;
	}

	protected override void OnActionDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_BE_CONTROLLED", OnActorBeControlled);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL_END", OnCastEndSkill);
		_actor.logicVariable.SetLogicTagValue("lastSkillPhase", 0);
		skillPool.Clear(clearUsed: true);
		Clear();
	}

	public override void OnStart()
	{
		base.OnStart();
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

	private void OnActorBeControlled(IEvent evt)
	{
		if (_actor != null && evt is AdventureActorBeControlledEvent adventureActorBeControlledEvent)
		{
			_ = _actor == adventureActorBeControlledEvent.actor;
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

	protected override void OnButtonAPress()
	{
		CastSkill(ActionKey.A, SkillPhaseFeatureFlag.Dodge);
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

	private bool CastSkill(ActionKey key, SkillPhaseFeatureFlag skillPhaseFeatureFlag, int skillId = 0, bool isInterruptAttack = true, bool isRushJoinDodge = true)
	{
		SkillState skillState = SkillPop();
		skillState.SetSkill(key, skillPhaseFeatureFlag, skillId, isInterruptAttack, ingoreCDAndEnergy: false, isRushJoinDodge);
		skillState.Enter();
		bool canCast = skillState.CanCast;
		if (canCast)
		{
			curState?.Exit();
			if (curState is SkillState instance)
			{
				skillPool.Return(instance);
			}
			curState = skillState;
			return canCast;
		}
		skillPool.Return(skillState);
		return canCast;
	}

	private void MainLoop()
	{
		_actor.attackTarget = actorSearchInfo.GetLockingConfrontActor(useInputDirection: true);
		if (curState == null || curState.IsEnd)
		{
			if (curState is SkillState instance)
			{
				skillPool.Return(instance);
			}
			curState = GetNextState();
			curState?.Enter();
		}
		else
		{
			curState.Update();
		}
	}

	private IState GetNextState()
	{
		if (_actor.attackTarget != null)
		{
			FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
			bool isObstacleBetweenActorAndTargetAndPreventNormalAttack = IsObstacleBetweenActorAndTargetAndPreventNormalAttack;
			bool flag = fP <= CommonUtils.GetAimRange(_actor);
			if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
			{
				if (isObstacleBetweenActorAndTargetAndPreventNormalAttack || !flag)
				{
					_aimTarget.Cancel();
				}
			}
			else if (flag && !(_actor as PlayerAdventureActor).dodgeButtonHold && !isObstacleBetweenActorAndTargetAndPreventNormalAttack && !_actor.forceControl)
			{
				_aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
			if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget && CommonUtils.GetAttackRange(_actor) > fP)
			{
				if (_actor.LogicTime - lastNormalTime > normalAtkBreakTime)
				{
					curNormalPhase = 0;
				}
				curNormalPhase = curNormalPhase % normalPhaseCount + 1;
				_actor.logicVariable.SetLogicTagValue("curNormalPhase", curNormalPhase);
				lastNormalTime = _actor.LogicTime;
				return normalAttackState;
			}
		}
		else if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
		{
			_aimTarget.Cancel();
		}
		ResetNormalPharse();
		return null;
	}

	private void ResetNormalPharse()
	{
		curNormalPhase = 0;
	}

	private SkillState SkillPop()
	{
		SkillState skillState = skillPool.Rent();
		skillState.SetSkill(ActionKey.None, SkillPhaseFeatureFlag.None, 0, isInterruptAttack: false);
		return skillState;
	}
}
