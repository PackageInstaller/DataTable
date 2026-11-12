using AdventureBehaviour;

namespace AIScript.Monster.Template;

public class Death : AIBase
{
	protected int _skillId;

	public void OnEnable()
	{
		_skillId = (_actor as MonsterAdventureActor).monsterAIInfo.deathSkillId;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DECLARE_DIED", MonsterDeclareDeath);
	}

	public void OnStart()
	{
		_actor.inDying = true;
		if (_skillId != 0)
		{
			_actor.EnableDyingSuperArmor();
			ILRuntimeAPI.CreateSkill(_skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
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

	protected void MonsterDeclareDeath(IEvent ievent)
	{
		if ((ievent as AdventureMonsterDeclareDiedEvent).id == _actor.Id)
		{
			OnThemSkill();
		}
	}

	private void OnThemSkill()
	{
		int themeSkillId = (_actor as MonsterAdventureActor).monsterAIInfo.themeSkillId;
		if (themeSkillId > 0)
		{
			ModuleController<AdventureModuleController>.Instance?.UseMonsterCloneActorCastSkill(_actor as MonsterAdventureActor, themeSkillId);
		}
	}
}
