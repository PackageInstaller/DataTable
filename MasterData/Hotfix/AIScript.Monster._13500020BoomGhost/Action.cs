using System.Collections.Generic;

namespace AIScript.Monster._13500020BoomGhost;

public class Action : AIBase
{
	private static Dictionary<int, SkillInfo> skillDic = new Dictionary<int, SkillInfo> { [0] = new SkillInfo(13532001, 0, 2, -1, -1) };

	private PlayerAdventureActor _summoner;

	private PlayerAdventureActor mainCtrActor;

	private IState curState;

	private IdleState idleState = new IdleState();

	private TraceState traceState = new TraceState();

	private TraceAndSkillState traceAndSkillState = new TraceAndSkillState();

	private PlayerSkillCd skillMgr;

	public void OnEnable()
	{
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		idleState.Init(_actor, skillMgr);
		traceState.Init(_actor, skillMgr);
		traceAndSkillState.Init(_actor, skillMgr);
	}

	public void OnDisable()
	{
		_summoner = null;
		curState = null;
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnStop()
	{
		if (curState != null && (curState is TraceAndSkillState || curState is TraceState))
		{
			curState.ForceExit();
		}
	}

	public void OnUpdate()
	{
		MainLoop();
	}

	private void DoMainLogic()
	{
		if (curState == null)
		{
			curState = traceState;
			traceState.target = mainCtrActor;
			curState.Enter();
		}
	}

	private void MainLoop()
	{
		_actor.monsterTarget = GetAttackTarget();
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
		if (_actor.monsterTarget != null)
		{
			SkillInfo skillInfo = ChooseSkill();
			traceAndSkillState.skillInfo = skillInfo;
			traceAndSkillState.target = _actor.monsterTarget;
			return traceAndSkillState;
		}
		traceState.target = mainCtrActor;
		return traceState;
	}

	private LogicEntity GetAttackTarget()
	{
		if (mainCtrActor == null)
		{
			return _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
		}
		if (mainCtrActor.attackTarget == null)
		{
			return _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: false);
		}
		return mainCtrActor.attackTarget;
	}

	private SkillInfo ChooseSkill()
	{
		return skillDic.get_Item(0);
	}
}
