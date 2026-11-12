using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Monster.TowerDefense._15601;

public class Action_Summon : AIBase
{
	private int skillId_Trace = 8015605;

	private IState curState;

	private TraceAndSkillState traceAndSkillState = new TraceAndSkillState();

	private PlayerSkillCd skillMgr;

	public void OnEnable()
	{
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		_actor.GetLogicComponent<MonsterSummonInfo>();
		traceAndSkillState.Init(_actor, skillMgr);
	}

	public void OnDisable()
	{
		curState = null;
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnStop()
	{
		if (curState != null && curState is TraceAndSkillState)
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
		_actor.monsterTarget = GetAttackTarget();
		_ = curState;
	}

	private void MainLoop()
	{
		if (_actor.monsterTarget == null)
		{
			_actor.monsterTarget = GetAttackTarget();
		}
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
			traceAndSkillState.skillId = skillId_Trace;
			traceAndSkillState.target = _actor.monsterTarget;
			return traceAndSkillState;
		}
		return null;
	}

	private LogicEntity GetAttackTarget()
	{
		List<LogicEntity> targetsByFactionByTD = CommonUtils.GetTargetsByFactionByTD(_actor, isFriend: false);
		return CommonUtils_MonsterAPI.GetTargetNearOrFar(_actor, iNear: true, targetsByFactionByTD);
	}
}
