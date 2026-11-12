using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15501;

public class Action_MW : AIBase
{
	private FP startDistance = 5;

	private FP stopDistance = 3;

	private FP cancleDistance = -1;

	private FP traceDuration = -1;

	private static Dictionary<int, SkillInfo> skillDic = new Dictionary<int, SkillInfo> { [0] = new SkillInfo(15532004, 1, 10, -1, -1) };

	private TSVector2 leftLocalPos = new TSVector2(-4, 0);

	private TSVector2 rightLocalPos = new TSVector2(4, 0);

	private PlayerAdventureActor _summoner;

	private PlayerAdventureActor mainCtrActor;

	private IState_UAV curState;

	private BattleState_M battleState = new BattleState_M();

	private TraceTarget traceTarget = new TraceTarget();

	private LogicEntity lastTarget;

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
		traceTarget.Clear();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		MainLoop();
	}

	private void DoMainLogic()
	{
	}

	private void MainLoop()
	{
		_actor.monsterTarget = GetAttackTarget();
		DoMove();
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

	private void DoMove()
	{
		if (_actor.monsterTarget == null)
		{
			_actor.AimAtTarget(mainCtrActor);
		}
		if (TSVector2.Distance(_actor.tsTransform.Position, mainCtrActor.tsTransform.Position) > startDistance)
		{
			TSVector2 point = (_actor.logicVariable.GetLogicTagToggle("isLeft") ? leftLocalPos : rightLocalPos);
			point = mainCtrActor.tsTransform.TransformLocalPointToWorldSpace(point);
			_actor.MoveTo(point, 0.1f, enableNavigation: true);
		}
	}

	private void TraceUpdate()
	{
		if (_actor.monsterTarget == null)
		{
			_actor.AimAtTarget(mainCtrActor);
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
