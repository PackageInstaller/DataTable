using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._13500010BigHeadGhost;

public class Action : AIBase
{
	private Dictionary<int, SkillInfo> skillDic = new Dictionary<int, SkillInfo>
	{
		[0] = new SkillInfo(13531001, 0, 2, -1, -1),
		[1] = new SkillInfo(13531002, 0, 2, -1, -1),
		[2] = new SkillInfo(13531003, 0, 2, -1, -1)
	};

	private int casSkillEvt = CommonHelper.StringToHash("casSkillEvt");

	private PlayerAdventureActor _summoner;

	private PlayerAdventureActor mainCtrActor;

	private IState curState;

	private IdleState idleState = new IdleState();

	private TraceState traceState = new TraceState();

	private TraceAndSkillState traceAndSkillState = new TraceAndSkillState();

	public void OnEnable()
	{
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		idleState.Init(_actor);
		traceState.Init(_actor);
		traceAndSkillState.Init(_actor);
		foreach (KeyValuePair<int, SkillInfo> item in skillDic)
		{
			item.Value.Reset();
		}
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
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
		int key = TSRandom.Range(0, 2);
		return skillDic.get_Item(key);
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.sender as AdventureActor == _summoner && adventureActorCustomEvent.eventHashCode == casSkillEvt && !_actor.isDead && !_actor.inDying && (curState != traceAndSkillState || traceAndSkillState.skillInfo.skillId != skillDic.get_Item(2).skillId))
		{
			SkillInfo skillInfo = skillDic.get_Item(2);
			if (curState != null)
			{
				curState.ForceExit();
			}
			traceAndSkillState.skillInfo = skillInfo;
			traceAndSkillState.target = _actor.monsterTarget;
			traceAndSkillState.Enter();
			curState = traceAndSkillState;
		}
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_summoner.dataID, perkId, out lv);
	}
}
