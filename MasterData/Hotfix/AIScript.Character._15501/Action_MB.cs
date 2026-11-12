using System.Collections.Generic;

namespace AIScript.Character._15501;

public class Action_MB : AIBase
{
	private static Dictionary<int, SkillInfo> skillDic = new Dictionary<int, SkillInfo> { [0] = new SkillInfo(15532003, 1, 15, -1, -1) };

	private PlayerAdventureActor _summoner;

	private PlayerAdventureActor mainCtrActor;

	private IState_UAV curState;

	private BattleState_M battleState = new BattleState_M();

	public void OnEnable()
	{
		mainCtrActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		battleState.Init(_actor, _summoner, null);
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
		if (curState != null)
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
		curState = curState ?? GetNextState();
		if (curState != null)
		{
			curState.Enter();
		}
	}

	private void MainLoop()
	{
		_actor.monsterTarget = GetAttackTarget();
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
		if (_actor.monsterTarget != null)
		{
			SkillInfo skillInfo = ChooseSkill();
			battleState.skillId = skillInfo.skillId;
			return battleState;
		}
		return null;
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
