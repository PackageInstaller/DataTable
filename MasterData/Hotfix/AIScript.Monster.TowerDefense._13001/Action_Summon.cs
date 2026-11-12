using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense._13001;

public class Action_Summon : AIBase
{
	private int skillId_Skill = 8013005;

	private FP searchRange = 7.5;

	private FP attackCd = 3;

	private int perkId_2 = 1300102;

	private FP attackCd_2 = 1;

	private IState curState;

	private SkillState skillState = new SkillState();

	private PlayerSkillCd skillMgr;

	private AdventureActor _summoner;

	private FP curCd;

	private FP _attackCd;

	private int cdModifyEvt = CommonHelper.StringToHash("cdModifyEvt");

	public void OnEnable()
	{
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		_summoner = logicComponent.SummonActor;
		skillState.Init(_actor, skillMgr);
		curCd = 0;
		_attackCd = attackCd;
		if (_summoner != null && GetPerk(perkId_2))
		{
			_summoner.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
			_attackCd = attackCd_2;
		}
	}

	public void OnDisable()
	{
		if (_summoner != null)
		{
			_summoner.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		}
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
		if (_actor.monsterTarget != null && (_actor.LogicTime - curCd > _attackCd || curCd <= 0))
		{
			curCd = _actor.LogicTime;
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

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.eventHashCode == cdModifyEvt)
		{
			_attackCd = attackCd_2;
		}
	}
}
