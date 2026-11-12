#define LOG_DEBUG
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12301;

public class ActionOld : ActorActionBase
{
	private FP normalAtkBreakTime = 5;

	private int normalPhaseCount = 4;

	private FP attackDistance = 10;

	private int curNormalPhase;

	private FP lastNormalTime;

	protected PlayerSkillCd _skillManage;

	private ActorSearchTarget actorSearchInfo;

	private IState curState;

	private readonly IdleState idleState = new IdleState();

	private readonly AimState aimState = new AimState();

	private readonly NormalAttackState normalAttackState = new NormalAttackState();

	private SkillState skillState;

	private readonly AimTarget _aimTarget = new AimTarget();

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

	private void CastSkill(ActionKey key, SkillPhaseFeatureFlag skillPhaseFeatureFlag, int skillId = 0, bool isInterruptAttack = true)
	{
		skillState = new SkillState();
		skillState.Init(_actor, _skillManage, _aimTarget);
		skillState.actionKey = key;
		skillState.specialSkill = skillId;
		skillState.skillPhaseFeatureFlag = skillPhaseFeatureFlag;
		skillState.isInterruptAttack = isInterruptAttack;
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
		else
		{
			NovaLogger.Debug($"释放失败 {skillId}");
		}
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

	private void ResetNormalPharse()
	{
		curNormalPhase = 0;
	}

	private IState GetNextState()
	{
		if (_actor.attackTarget != null)
		{
			FP fP = ((curNormalPhase == 3) ? attackDistance : CommonUtils.GetAttackRange(_actor));
			FP fP2 = _actor.DistanceWithRadius(_actor.attackTarget);
			if (fP > fP2)
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
		return idleState;
	}
}
