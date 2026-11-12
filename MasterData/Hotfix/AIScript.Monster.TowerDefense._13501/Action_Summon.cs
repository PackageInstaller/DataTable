using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Monster.TowerDefense._13501;

public class Action_Summon : AIBase
{
	private int skillId_Trace = 8013505;

	private SummonState curState;

	private SummonTraceAndSkillState traceAndSkillState = new SummonTraceAndSkillState();

	private PlayerSkillCd skillMgr;

	public void OnEnable()
	{
		skillMgr = _actor.GetLogicComponent<PlayerSkillCd>();
		traceAndSkillState.Init(_actor, skillMgr);
	}

	public void OnDisable()
	{
		curState = null;
	}

	public void OnStart()
	{
		_actor.monsterTarget = GetAttackTarget();
	}

	public void OnStop()
	{
		if (curState is SummonTraceAndSkillState)
		{
			curState.ForceExit();
		}
	}

	public void OnUpdate()
	{
		MainLoop();
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

	private SummonState GetNextState()
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
