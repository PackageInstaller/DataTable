using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11101;

public class Action_Support : ActorActionBase
{
	private FP contineTime = 5;

	private bool inAI;

	private FP timer;

	private IState curState;

	private MoveState moveState = new MoveState();

	private SkillState skillState;

	private NormalAttackState normalAttackState = new NormalAttackState();

	private PlayerSkillCd skillMgr;

	private AimTarget aimTarget = new AimTarget();

	private LogicEntity attackTarget;

	protected override void OnActionEnable()
	{
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		moveState.Init(_actor, skillMgr, aimTarget);
		normalAttackState.Init(_actor, skillMgr, aimTarget);
	}

	protected override void OnActionDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_TRY_CAST_SKILL", OnTrCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_FINISH", OnAreaEffectFinish);
		aimTarget.Cancel();
		_actor.movementMode = AdventureActor.MovementMode.Run;
	}

	public override void OnStart()
	{
		base.OnStart();
		inAI = false;
		timer = 0;
	}

	public override void OnStop()
	{
		base.OnStop();
		_actor.InterruptAttack(force: true);
		curState?.Exit();
		curState = null;
		inAI = false;
		timer = 0;
	}

	public void OnUpdate()
	{
		MainLoop();
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
		skillState.Init(_actor, skillMgr, aimTarget);
		skillState.actionKey = key;
		skillState.specialSkill = skillId;
		skillState.skillPhaseFeatureFlag = skillPhaseFeatureFlag;
		skillState.isInterruptAttack = isInterruptAttack;
		skillState.Enter();
		if (skillState.CanCast)
		{
			curState?.Exit();
			curState = skillState;
		}
	}

	private void MainLoop()
	{
		attackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		if (inAI)
		{
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
	}

	private IState GetNextState()
	{
		if (attackTarget != null)
		{
			FP fP = _actor.DistanceWithRadius(attackTarget);
			if (_actor.actorSearchTargetInfo.visionAttackRange > fP)
			{
				bool isObstacleBetweenActorAndTargetAndPreventNormalAttack = IsObstacleBetweenActorAndTargetAndPreventNormalAttack;
				bool flag = fP <= CommonUtils.GetAimRange(_actor);
				if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
				{
					if (isObstacleBetweenActorAndTargetAndPreventNormalAttack || !flag)
					{
						aimTarget.Cancel();
					}
				}
				else if (flag && !(_actor as PlayerAdventureActor).dodgeButtonHold && !isObstacleBetweenActorAndTargetAndPreventNormalAttack)
				{
					aimTarget.Aim(_actor, attackTarget as AdventureActor);
				}
				return normalAttackState;
			}
			return moveState;
		}
		if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
		{
			aimTarget.Cancel();
		}
		return null;
	}

	protected override void OnCastUltimate()
	{
		base.OnCastUltimate();
	}

	private void OnAreaEffectFinish(IEvent evt)
	{
		AdventureAreaEffectFinishEvent adventureAreaEffectFinishEvent = evt as AdventureAreaEffectFinishEvent;
		if (_actor != null && adventureAreaEffectFinishEvent.owner.Id == _actor.Id)
		{
			AreaEffectEntity areaEffect = ILRuntimeAPI.GetAreaEffect(adventureAreaEffectFinishEvent.entityID);
			if (areaEffect != null && areaEffect.CheckTag(ParallelScript.areaTag_A))
			{
				inAI = false;
				(_actor as PlayerAdventureActor).isAssistAIFinish = true;
			}
		}
	}
}
