using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense._12301;

public class Action_Summon : AIBase
{
	private int skillId_Skill = 8012305;

	private FP searchRange = 7.5;

	private IState curState;

	private SkillState skillState = new SkillState();

	private PlayerSkillCd skillMgr;

	private AdventureActor _summoner;

	public void OnEnable()
	{
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		_summoner = logicComponent.SummonActor;
		skillState.Init(_actor, skillMgr);
	}

	public void OnDisable()
	{
		_summoner = null;
		curState = null;
	}

	public void OnStart()
	{
	}

	public void OnStop()
	{
		curState?.ForceExit();
	}

	public void OnUpdate()
	{
		MainLoop();
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

	private IState GetNextState()
	{
		if (_actor.monsterTarget != null)
		{
			skillState.skillId = skillId_Skill;
			skillState.target = _actor.monsterTarget;
			return skillState;
		}
		return null;
	}

	private LogicEntity GetAttackTarget()
	{
		return CommonUtils.SearchNearTargetByCircle(_actor, searchRange);
	}
}
