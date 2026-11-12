using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11601;

public class ActionScript_Summoned : AIBase
{
	private FP _useSkillInterval;

	public void OnEnable()
	{
	}

	public void OnStart()
	{
		_useSkillInterval = 0;
		_actor.monsterTarget = null;
	}

	public void OnUpdate()
	{
		_actor.monsterTarget = GetAttackTarget();
		if (_useSkillInterval > 0)
		{
			_useSkillInterval -= _actor.LogicDeltaTime;
			return;
		}
		ILRuntimeAPI.CreateSkill(11601121, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false);
		_useSkillInterval = Config_MainControl.useSkillInterval_Summoned_P2;
	}

	private LogicEntity GetAttackTarget()
	{
		FP currentAttackRange = _actor.actorSearchTargetInfo.GetCurrentAttackRange();
		List<LogicEntity> list = ILRuntimeAPI.SearchByRange(_actor, currentAttackRange, null, isConfront: true);
		if (list != null && list.Count > 0)
		{
			LogicEntity logicEntity = (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as PlayerAdventureActor)?.attackTarget;
			if (logicEntity != null && list.Contains(logicEntity))
			{
				return logicEntity;
			}
			return ILRuntimeAPI.GetTargetNearOrFar(_actor, iNear: true, list);
		}
		return null;
	}

	public void OnStop()
	{
		_useSkillInterval = 0;
		_actor.monsterTarget = null;
	}

	public void OnDisable()
	{
	}
}
