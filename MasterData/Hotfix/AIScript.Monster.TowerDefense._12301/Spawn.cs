using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._12301;

public class Spawn : AIBase
{
	public void OnStart()
	{
		int spawnSkillId = (_actor as MonsterAdventureActor).monsterAIInfo.spawnSkillId;
		if (spawnSkillId != 0)
		{
			ILRuntimeAPI.CreateSkill(spawnSkillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
			{
				_actor.Action(makeThreatAlert: false);
			});
		}
		else
		{
			_actor.Action(makeThreatAlert: false);
		}
	}
}
