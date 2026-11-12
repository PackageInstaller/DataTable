using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15501;

public class Action_L : AIBase
{
	private int skill_1 = 15510013;

	private int skill_2 = 15510023;

	private int skill_3 = 15510014;

	private int skill_4 = 15510024;

	private int atkEvt = CommonHelper.StringToHash("atkEvt");

	private int rushBeginEvt = CommonHelper.StringToHash("Rush_Begin");

	private int rushEndEvt = CommonHelper.StringToHash("Rush_End");

	private int relaxBeginEvt = CommonHelper.StringToHash("Relax_Begin");

	private int skillEvt = CommonHelper.StringToHash("skillEvt");

	private PlayerAdventureActor _summoner;

	private PlayerAdventureActor mainCtrActor;

	private AimTarget aimTarget = new AimTarget();

	private IState_UAV curState;

	private RelaxState_L relaxState = new RelaxState_L();

	private BattleState_L battleState = new BattleState_L();

	private BattleIdleState_L battleIdleState = new BattleIdleState_L();

	private TraceState_L traceState = new TraceState_L();

	private RushState_L traceRushState = new RushState_L();

	private PlayFX playFx_Rush = new PlayFX();

	private PlayFX playFx_Rush2 = new PlayFX();

	private PlayFX playFx_Idle = new PlayFX();

	private PlayFX playFx_Idle2 = new PlayFX();

	private PlayFX playFx_Relax = new PlayFX();

	private PlayFX playFx_Relax2 = new PlayFX();

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		relaxState.Init(_actor, _summoner, aimTarget, playFx_Rush, playFx_Rush2, playFx_Idle, playFx_Idle2, playFx_Relax, playFx_Relax2);
		battleState.Init(_actor, _summoner, aimTarget, playFx_Rush, playFx_Rush2, playFx_Idle, playFx_Idle2, playFx_Relax, playFx_Relax2);
		battleIdleState.Init(_actor, _summoner, aimTarget, playFx_Rush, playFx_Rush2, playFx_Idle, playFx_Idle2, playFx_Relax, playFx_Relax2);
		traceState.Init(_actor, _summoner, aimTarget, playFx_Rush, playFx_Rush2, playFx_Idle, playFx_Idle2, playFx_Relax, playFx_Relax2);
		traceRushState.Init(_actor, _summoner, aimTarget, playFx_Rush, playFx_Rush2, playFx_Idle, playFx_Idle2, playFx_Relax, playFx_Relax2);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		_summoner = null;
		curState = null;
		playFx_Rush.Stop();
		playFx_Rush2.Stop();
		playFx_Idle.Stop();
		playFx_Idle2.Stop();
		playFx_Relax.Stop();
		playFx_Relax2.Stop();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnStop()
	{
		_ = curState;
	}

	public void OnUpdate()
	{
		MainLoop();
	}

	private void DoMainLogic()
	{
		curState = curState ?? GetNextState();
		if (curState != null)
		{
			curState.Enter();
		}
	}

	private void MainLoop()
	{
		_actor.monsterTarget = GetAttackTarget();
		_actor.attackTarget = _actor.monsterTarget;
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

	private IState_UAV GetNextState()
	{
		FP fP = TSVector2.Distance(_actor.tsTransform.Position, mainCtrActor.tsTransform.Position);
		if (fP > Config_L.trace_first && _summoner != null && !_actor.isHide)
		{
			traceState.target = _summoner;
			traceState.isTeleport = fP > Config_L.trace_second;
			return traceState;
		}
		if (_actor.monsterTarget != null && _actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget)
		{
			return battleIdleState;
		}
		return null;
	}

	private LogicEntity GetAttackTarget()
	{
		return _summoner.aimLockedTarget ?? _summoner.attackTarget;
	}

	private void OnCustomEvent(IEvent evt)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = evt as AdventureActorCustomEvent;
		if (!(adventureActorCustomEvent.sender as AdventureActor == _summoner))
		{
			return;
		}
		if (adventureActorCustomEvent.eventHashCode == atkEvt)
		{
			int num = 0;
			if (_actor.dataID == Config_L.uavAtkW_dataId)
			{
				switch (adventureActorCustomEvent.intParam)
				{
				case 1:
					num = skill_1;
					break;
				case 3:
					num = skill_3;
					break;
				}
			}
			else
			{
				switch (adventureActorCustomEvent.intParam)
				{
				case 2:
					num = skill_2;
					break;
				case 4:
					num = skill_4;
					break;
				}
			}
			if (num != 0)
			{
				curState?.ForceExit(keepAim: true);
				if (_actor.aimMode != AdventureActor.AimMode.AimAtAttackTarget)
				{
					aimTarget.Aim(_actor, _actor.monsterTarget as AdventureActor);
				}
				battleState.skillId = num;
				battleState.Enter();
				curState = battleState;
			}
		}
		else if (adventureActorCustomEvent.eventHashCode == rushBeginEvt)
		{
			curState?.ForceExit();
			traceRushState.target = _summoner;
			traceRushState.Enter();
			curState = traceRushState;
		}
		else if (adventureActorCustomEvent.eventHashCode == rushEndEvt)
		{
			if (curState is RushState_L)
			{
				curState.ForceExit();
			}
		}
		else if (adventureActorCustomEvent.eventHashCode == relaxBeginEvt)
		{
			curState?.ForceExit();
			relaxState.Enter();
			curState = relaxState;
		}
		else if (adventureActorCustomEvent.eventHashCode == skillEvt && curState is RelaxState_L relaxState_L)
		{
			relaxState_L.ForceExitBySkill();
		}
	}
}
