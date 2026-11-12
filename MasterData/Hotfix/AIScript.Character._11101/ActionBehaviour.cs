using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11101;

public class ActionBehaviour : ActorActionBase
{
	private PlayerSkillCd _skillManage;

	private ActorSearchTarget actorSearchInfo;

	private IState curState;

	private NormalAttackState normalAttackState = new NormalAttackState();

	private SkillState skillState;

	private AimTarget _aimTarget = new AimTarget();

	protected override void OnActionEnable()
	{
		_skillManage = _actor.GetLogicComponent<PlayerSkillCd>();
		actorSearchInfo = _actor.GetLogicComponent<ActorSearchTarget>();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		normalAttackState.Init(_actor, _skillManage, _aimTarget);
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
		curState?.Exit();
		curState = null;
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
			curState?.Exit();
			curState = skillState;
		}
		return skillState.CanCast;
	}

	private void DoMainLogic()
	{
	}

	private void MainLoop()
	{
		_actor.attackTarget = actorSearchInfo.GetLockingConfrontActor(useInputDirection: true);
		if (curState == null || curState.IsEnd)
		{
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
			else if (flag && !(_actor as PlayerAdventureActor).dodgeButtonHold && !isObstacleBetweenActorAndTargetAndPreventNormalAttack)
			{
				_aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
			if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget && CommonUtils.GetAttackRange(_actor) > fP)
			{
				return normalAttackState;
			}
		}
		else if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
		{
			_aimTarget.Cancel();
		}
		return null;
	}
}
