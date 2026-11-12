using AdventureBehaviour;

namespace AIScript.Monster.Soldier;

public class Death : AIBase
{
	protected int _skillId;

	private SoldierActor soldierActor => _actor as SoldierActor;

	public void OnEnable()
	{
		int potentialLv = soldierActor.GetPotentialLv();
		if (potentialLv == 1)
		{
			_skillId = soldierActor.soldierChessAI.DeathSkill1;
		}
		else if (potentialLv == 2)
		{
			_skillId = soldierActor.soldierChessAI.DeathSkill2;
		}
		else if (potentialLv >= 3)
		{
			_skillId = soldierActor.soldierChessAI.DeathSkill3;
		}
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
