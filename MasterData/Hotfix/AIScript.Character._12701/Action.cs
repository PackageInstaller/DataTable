using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12701;

public class Action : ActorActionBase
{
	private int normalPhaseCount = 4;

	private PlayerSkillCd _skillManage;

	private ActorSearchTarget actorSearchInfo;

	private IState curState;

	private IdleState idleState = new IdleState();

	private AimState aimState = new AimState();

	private NormalAttackState normalAttackState = new NormalAttackState();

	private SkillState skillState;

	private AimTarget _aimTarget = new AimTarget();

	private int curNormalPhase;

	protected override void OnActionEnable()
	{
		_skillManage = _actor.GetLogicComponent<PlayerSkillCd>();
		actorSearchInfo = _actor.GetLogicComponent<ActorSearchTarget>();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		idleState.Init(_actor, _skillManage, _aimTarget);
		aimState.Init(_actor, _skillManage, _aimTarget);
		normalAttackState.Init(_actor, _skillManage, _aimTarget);
		curNormalPhase = 0;
	}

	protected override void OnActionDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
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
			if (key == ActionKey.D)
			{
				ResetNormalPharse();
			}
			curState.Exit();
			curState = skillState;
		}
		return skillState.CanCast;
	}

	private void DoMainLogic()
	{
		if (curState == null)
		{
			curState = idleState;
			curState.Enter();
		}
	}

	private void MainLoop()
	{
		_actor.attackTarget = actorSearchInfo.GetLockingConfrontActor(useInputDirection: true);
		curState.Update();
		if (curState.IsEnd)
		{
			curState = GetNextState();
			curState.Enter();
		}
	}

	private IState GetNextState()
	{
		if (_actor.attackTarget != null)
		{
			FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
			bool isObstacleBetweenActorAndTargetAndPreventNormalAttack = IsObstacleBetweenActorAndTargetAndPreventNormalAttack;
			if (CommonUtils.GetAttackRange(_actor) > fP && !isObstacleBetweenActorAndTargetAndPreventNormalAttack)
			{
				curNormalPhase = curNormalPhase % normalPhaseCount + 1;
				_actor.logicVariable.SetLogicTagValue("curNormalPhase", curNormalPhase);
				return normalAttackState;
			}
		}
		ResetNormalPharse();
		return idleState;
	}

	private void ResetNormalPharse()
	{
		curNormalPhase = 0;
	}
}
