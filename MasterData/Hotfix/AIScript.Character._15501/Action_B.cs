using AdventureBehaviour;

namespace AIScript.Character._15501;

public class Action_B : AIBase
{
	private int skillId_W = 15531003;

	private int skillId_B = 15531004;

	private int summonId_BB = 15531021;

	private int summonId_BW = 15531011;

	private PlayerAdventureActor _summoner;

	private AimTarget aimTarget = new AimTarget();

	private IState_UAV curState;

	private BattleState_B battleState = new BattleState_B();

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	public void OnEnable()
	{
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		_summoner = logicComponent.SummonActor as PlayerAdventureActor;
		battleState.Init(_actor, _summoner, aimTarget);
		_actor.logicVariable.ToggleLogicTag("firstSkill", value: true);
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
			int skillId = ((_actor.dataID == summonId_BB) ? skillId_B : skillId_W);
			battleState.skillId = skillId;
			return battleState;
		}
		return null;
	}

	private LogicEntity GetAttackTarget()
	{
		return _summoner.attackTarget;
	}
}
