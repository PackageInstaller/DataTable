using AIScript.DynamicLevel;
using AdventureBehaviour;

namespace AIScript.Monster.TowerDefense;

public class TowerCharacterDeath : AIBase
{
	protected int skillId;

	public void OnEnable()
	{
		skillId = (_actor as TowerDefenseCharacterActor).deathSkillId;
	}

	public void OnDisable()
	{
	}

	public void OnStart()
	{
		_actor.inDying = true;
		if (skillId != 0)
		{
			_actor.EnableDyingSuperArmor();
			ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
			{
				_actor.DisableDyingSuperArmor();
				DeathFinish();
			});
		}
		else
		{
			DeathFinish();
		}
		void DeathFinish()
		{
			_actor.inDying = false;
		}
	}
}
