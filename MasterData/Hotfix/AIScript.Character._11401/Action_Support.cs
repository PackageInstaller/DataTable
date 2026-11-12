using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11401;

public class Action_Support : ActorActionBase
{
	private FP randomRadius_Teleport = 2;

	private bool inAI;

	private FP timer;

	private IState curState;

	private MoveState moveState = new MoveState();

	private NormalAttackState normalAttackState = new NormalAttackState();

	private PlayerSkillCd skillMgr;

	private AimTarget aimTarget = new AimTarget();

	private LogicEntity attackTarget;

	private bool firstIn;

	protected override void OnActionEnable()
	{
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		moveState.Init(_actor, skillMgr, aimTarget);
		normalAttackState.Init(_actor, skillMgr, aimTarget);
		firstIn = true;
		timer = 0;
		inAI = false;
		PlayerAdventureActor playerAdventureActor = _actor as PlayerAdventureActor;
		if (playerAdventureActor != null && playerAdventureActor.status == ActorStatus.Special && playerAdventureActor.specialStatusTime > 0)
		{
			timer = playerAdventureActor.specialStatusTime;
			inAI = true;
			(_actor as PlayerAdventureActor).isAssistAIFinish = true;
			((PlayerAdventureActor)_actor).isResidentAssist = true;
		}
	}

	protected override void OnActionDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		aimTarget.Cancel();
	}

	public override void OnStart()
	{
		base.OnStart();
		if (firstIn)
		{
			firstIn = false;
			return;
		}
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

	private void MainLoop()
	{
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
		if (!inAI)
		{
			return;
		}
		if (timer > 0)
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
		else
		{
			(_actor as PlayerAdventureActor).isAssistAIFinish = true;
			((PlayerAdventureActor)_actor).isResidentAssist = false;
			inAI = false;
		}
		timer -= _actor.LogicDeltaTime;
	}

	private IState GetNextState()
	{
		if (_actor.attackTarget != null)
		{
			FP fP = _actor.DistanceWithRadius(_actor.attackTarget);
			if (!(_actor.actorSearchTargetInfo.visionAttackRange > fP))
			{
				return moveState;
			}
			bool isObstacleBetweenActorAndTargetAndPreventNormalAttack = IsObstacleBetweenActorAndTargetAndPreventNormalAttack;
			bool flag = fP <= CommonUtils.GetAimRange(_actor);
			if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
			{
				if (isObstacleBetweenActorAndTargetAndPreventNormalAttack || !flag)
				{
					aimTarget.Cancel();
				}
			}
			else if (flag && !isObstacleBetweenActorAndTargetAndPreventNormalAttack)
			{
				aimTarget.Aim(_actor, _actor.attackTarget as AdventureActor);
			}
			if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget && CommonUtils.GetAttackRange(_actor) > fP)
			{
				return normalAttackState;
			}
		}
		else if (_actor.aimMode == AdventureActor.AimMode.AimAtAttackTarget)
		{
			aimTarget.Cancel();
		}
		return null;
	}

	protected override void OnCastUltimate()
	{
		CastBindSkill(() =>
		{
			PlayerAdventureActor playerAdventureActor = _actor as PlayerAdventureActor;
			if (playerAdventureActor != null && playerAdventureActor.status == ActorStatus.Special && playerAdventureActor.specialStatusTime > 0)
			{
				timer = playerAdventureActor.specialStatusTime;
				inAI = true;
				(_actor as PlayerAdventureActor).isAssistAIFinish = true;
				((PlayerAdventureActor)_actor).isResidentAssist = true;
			}
		});
	}

	private void OnBattleReady(IEvent _)
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		TSVector2 result = ILRuntimeAPI.GetRandomPointInShape(_actor, new DeterministicShape
		{
			shapeType = DeterministicShape.ShapeType.Circle,
			position = activedPlayerActor.tsTransform.Position,
			innerRadius = activedPlayerActor.GetRadius(),
			radius = randomRadius_Teleport
		});
		if (!_actor.QueryPositionWalkable(result))
		{
			_actor.QueryClosestPositionWalkable(result, out result);
		}
		_actor.Teleport(result);
	}
}
