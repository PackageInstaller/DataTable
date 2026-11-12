using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15501;

public class Action : ActorActionBase
{
	private FP normalAtkBreakTime = 1;

	private int normalPhaseCount = 4;

	private FP Interval_EnterNoBattle = 10;

	private PlayerSkillCd _skillManage;

	private ActorSearchTarget actorSearchInfo;

	private IState curState;

	private NormalAttackState normalAttackState = new NormalAttackState();

	private RelaxState relaxState = new RelaxState();

	private AimTarget _aimTarget = new AimTarget();

	private int curNormalPhase;

	private FP noBattleTimeStart;

	private ClassObjectPool<SkillState> skillPool;

	private bool isTraceW;

	private bool isTraceB;

	protected override void OnActionEnable()
	{
		_skillManage = _actor.GetLogicComponent<PlayerSkillCd>();
		actorSearchInfo = _actor.GetLogicComponent<ActorSearchTarget>();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		normalAttackState.Init(_actor, _skillManage, _aimTarget);
		relaxState.Init(_actor, _skillManage, _aimTarget);
		skillPool = new ClassObjectPool<SkillState>(() => new SkillState(_actor, _skillManage, _aimTarget), 4);
		curNormalPhase = 0;
		noBattleTimeStart = _actor.LogicTime;
	}

	protected override void OnActionDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		skillPool.Clear(clearUsed: true);
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
			if (key == ActionKey.D || key == ActionKey.None)
			{
				ResetNormalPharse();
			}
			curState?.Exit();
			curState = skillState;
			return canCast;
		}
		skillPool.Return(skillState);
		return canCast;
	}

	private void DoMainLogic()
	{
	}

	private void MainLoop()
	{
		_actor.attackTarget = actorSearchInfo.GetLockingConfrontActor(useInputDirection: true);
		curState?.Update();
		if (curState == null || curState.IsEnd)
		{
			if (curState is SkillState instance)
			{
				skillPool.Return(instance);
			}
			curState = GetNextState();
			curState?.Enter();
			if (curState is NormalAttackState { CanCast: false } && curNormalPhase > 0)
			{
				curNormalPhase--;
				_actor.logicVariable.SetLogicTagValue("curNormalPhase", curNormalPhase);
			}
		}
		if (curState is SkillState || _actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
		{
			noBattleTimeStart = _actor.LogicTime;
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
				curNormalPhase = curNormalPhase % normalPhaseCount + 1;
				_actor.logicVariable.SetLogicTagValue("curNormalPhase", curNormalPhase);
				return normalAttackState;
			}
			return null;
		}
		if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
		{
			_aimTarget.Cancel();
		}
		isTraceB = _actor.logicVariable.GetLogicTagToggle("trace_b");
		isTraceW = _actor.logicVariable.GetLogicTagToggle("trace_w");
		if (_actor.LogicTime - noBattleTimeStart > Interval_EnterNoBattle && !isTraceB && !isTraceW)
		{
			return relaxState;
		}
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
