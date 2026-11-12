using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense;

public class TowerMonsterSpawn : AIBase
{
	protected int skillId;

	public void OnEnable()
	{
		skillId = (_actor as MonsterAdventureActor).monsterAIInfo.spawnSkillId;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_MONSTER_ACTION_EVT", OnTowerSimulate);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_MONSTER_ACTION_EVT", OnTowerSimulate);
	}

	public void OnStart()
	{
		if (skillId != 0)
		{
			ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
			{
				_actor.Action(makeThreatAlert: false);
			});
		}
		else
		{
			_actor.Action(makeThreatAlert: false);
		}
	}

	private void OnTowerSimulate(IEvent evt)
	{
		if (evt is TowerDefenseMonsterActionEvent towerDefenseMonsterActionEvent && towerDefenseMonsterActionEvent.monsterID == _actor.Id)
		{
			_actor.logicVariable.SetLogicTagTSVector2Value("nextPoint", towerDefenseMonsterActionEvent.nextPoint);
			_actor.logicVariable.SetLogicTagValue("actionIndex", towerDefenseMonsterActionEvent.actionIndex);
			_actor.logicVariable.SetLogicTagStringValue("actionParam", towerDefenseMonsterActionEvent.actionParam);
			_actor.logicVariable.SetLogicTagValue("nextGridIndex", towerDefenseMonsterActionEvent.nextGridIndex);
			_actor.logicVariable.SetLogicTagValue("routeID", towerDefenseMonsterActionEvent.routeID);
			_actor.logicVariable.SetLogicTagValue("leftRouteLen", towerDefenseMonsterActionEvent.leftRouteLen);
		}
	}
}
