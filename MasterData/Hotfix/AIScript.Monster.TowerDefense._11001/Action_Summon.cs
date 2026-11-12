using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.TowerDefense._11001;

public class Action_Summon : AIBase
{
	private int skillId_Normal = 8011005;

	private int skillId_Skill = 8011006;

	private FP searchRange = 3.5;

	protected AdventureActor _summoner;

	private int castSkillEvt = CommonHelper.StringToHash("castSkillEvt");

	private IState curState;

	private SkillState skillState = new SkillState();

	public void OnEnable()
	{
		MonsterSummonInfo logicComponent = _actor.GetLogicComponent<MonsterSummonInfo>();
		_summoner = logicComponent.SummonActor;
		skillState.Init(_actor);
	}

	public void OnDisable()
	{
		_summoner = null;
		curState = null;
	}

	public void OnStart()
	{
		_summoner?.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
	}

	public void OnStop()
	{
		_summoner?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
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
			skillState.skillId = skillId_Normal;
			skillState.target = _actor.monsterTarget;
			return skillState;
		}
		return null;
	}

	private void OnCustomEvent(IEvent evt)
	{
		if (evt is AdventureActorCustomEvent adventureActorCustomEvent && adventureActorCustomEvent.eventHashCode == castSkillEvt)
		{
			_actor.InterruptAttack(force: true);
			ILRuntimeAPI.CreateSkill(skillId_Skill, _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
		}
	}

	private LogicEntity GetAttackTarget()
	{
		return CommonUtils.SearchNearTargetByCircle(_actor, searchRange);
	}
}
