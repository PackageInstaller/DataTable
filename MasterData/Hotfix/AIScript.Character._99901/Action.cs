using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._99901;

public class Action : ActorActionBase
{
	private PlayerSkillCd _skillManage;

	private ActorSearchTarget actorSearchInfo;

	private IState curState;

	private readonly NormalAttackState normalAttackState = new NormalAttackState();

	private readonly AimTarget _aimTarget = new AimTarget();

	private ClassObjectPool<SkillState> skillPool;

	private int normalPhaseCount = 2;

	private int curNormalPhase;

	protected override void OnActionEnable()
	{
		_skillManage = _actor.GetLogicComponent<PlayerSkillCd>();
		actorSearchInfo = _actor.GetLogicComponent<ActorSearchTarget>();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		normalAttackState.Init(_actor, _skillManage, _aimTarget);
		skillPool = new ClassObjectPool<SkillState>(() => new SkillState(_actor, _skillManage, _aimTarget), 2);
		curNormalPhase = 0;
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
	}

	protected override void OnButtonBPress()
	{
		CastSkill(ActionKey.B, SkillPhaseFeatureFlag.Skill1);
	}

	protected override void OnButtonBCancel()
	{
	}

	protected override void OnButtonAPress()
	{
		if ((curState == null || curState.IsEnd) && _actor.attackTarget != null)
		{
			FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
			if (CommonUtils.GetAttackRange(_actor) > fP)
			{
				curNormalPhase = curNormalPhase % normalPhaseCount + 1;
				_actor.logicVariable.SetLogicTagValue("curNormalPhase", curNormalPhase);
				curState = normalAttackState;
				curState?.Enter();
			}
		}
	}

	protected override bool CastIndependentRushSkill()
	{
		return false;
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
				curNormalPhase = 0;
			}
			curState?.Exit();
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
			if (ModuleController<AdventureModuleController>.Instance.SemiAutoBattle && _actor.attackTarget != null)
			{
				FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
				if (CommonUtils.GetAttackRange(_actor) > fP)
				{
					curNormalPhase = curNormalPhase % normalPhaseCount + 1;
					_actor.logicVariable.SetLogicTagValue("curNormalPhase", curNormalPhase);
					curState = normalAttackState;
					curState?.Enter();
				}
			}
		}
		else
		{
			curState.Update();
		}
	}

	private SkillState SkillPop()
	{
		SkillState skillState = skillPool.Rent();
		skillState.SetSkill(ActionKey.None, SkillPhaseFeatureFlag.None, 0, isInterruptAttack: false);
		return skillState;
	}
}
