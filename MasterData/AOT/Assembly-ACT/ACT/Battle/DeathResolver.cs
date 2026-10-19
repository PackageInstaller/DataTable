using ACT.Battle.Configs;
using ACT.Event;
using ACT.EventTrack;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public static class DeathResolver
{
	public static void Resolve(AttackData attackData, Ability ability, int beforeHp, bool faceLeftFromCmd)
	{
		if (attackData.attackee.GetCompAbility().hp <= 0)
		{
			attackData.causedDeath = beforeHp > 0;
			if (attackData.attackee.IsMonster())
			{
				FireMonsterHpDownToZero(attackData);
			}
			FireKillEvents(attackData, ability, beforeHp);
			DispatchTrackEntityDie(attackData);
			ApplyDeathFacing(attackData, faceLeftFromCmd);
			ApplyTrapDeathTrigger(attackData);
			attackData.attackee.KillEntity();
		}
	}

	private static void FireMonsterHpDownToZero(AttackData attackData)
	{
		OnMonsterHpDownToZero evt = Singleton<EventManager>.instance.GetEvt<OnMonsterHpDownToZero>();
		evt.lastOnHitDirIsLeft = attackData.characterAttackDirFromLeft;
		evt.attacker = attackData.attacker;
		evt.attackee = attackData.attackee;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.MonsterHpHitDownToZero, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private static void FireKillEvents(AttackData attackData, Ability ability, int beforeHp)
	{
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtKillEntity evt = abilitySystem.GetEvt<EvtKillEntity>(attackData.directAttacker, ability);
		evt.mainEntity = attackData.attacker;
		evt.attackData = attackData;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
		OnKillEntity evt2 = Singleton<EventManager>.instance.GetEvt<OnKillEntity>();
		evt2.attackData = attackData;
		evt2.beforeKillHp = beforeHp;
		evt2.maxHp = attackData.attackee.GetCompAbility().maxHP;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.KillEntity, evt2);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
	}

	private static void DispatchTrackEntityDie(AttackData attackData)
	{
		TrackEntityDie evt = EventTrackSolver.Instance.GetEvt<TrackEntityDie>();
		evt.attackee = attackData.attackee;
		evt.attacker = attackData.attacker;
		evt.attackData = attackData;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	private static void ApplyDeathFacing(AttackData attackData, bool faceLeftFromCmd)
	{
		if (attackData.attackee.IsBattleBehaveNotCharacter())
		{
			MonsterWeigtType monsterWeigtType = attackData.attackee.GetConfig().monsterWeigtType;
			if (monsterWeigtType == MonsterWeigtType.Normal || monsterWeigtType == MonsterWeigtType.Small)
			{
				attackData.attackee.SetFaceLeft(!faceLeftFromCmd);
			}
		}
	}

	private static void ApplyTrapDeathTrigger(AttackData attackData)
	{
		if (attackData.attackee.IsBattleBehaveNotCharacter() && (attackData.adjust1AttackType.HasFlag(Adjust1AttackTypeTag.Trap) || attackData.attacker.GetEntityType() == EntityType.StateObject))
		{
			attackData.attackee.SetTrigger("trap_die");
		}
	}
}
