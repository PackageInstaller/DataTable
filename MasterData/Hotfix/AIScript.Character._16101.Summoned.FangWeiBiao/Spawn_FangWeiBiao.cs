using AdventureBehaviour;

namespace AIScript.Character._16101.Summoned.FangWeiBiao;

public class Spawn_FangWeiBiao : AIBase
{
	public void OnStart()
	{
		int spawnSkillId = (_actor as MonsterAdventureActor).monsterAIInfo.spawnSkillId;
		if (spawnSkillId != 0)
		{
			ILRuntimeAPI.CreateSkill(spawnSkillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
			{
				_actor.Action();
			});
		}
		else
		{
			_actor.Action();
		}
	}
}
