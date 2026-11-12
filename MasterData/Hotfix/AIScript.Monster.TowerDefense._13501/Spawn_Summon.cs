using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense._13501;

public class Spawn_Summon : AIBase
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
