#define LOG_ERROR
using Nova.Client;
using Nova.Hotfix;
using TrueSync;
using Unity.Mathematics;

public class BuffEffect_DotBase : BuffEffectBase
{
	protected HitDamage hitDamageConfigTemp;

	protected long onceDamage;

	protected HotfixEnum.elementType _elementType;

	protected int _hudColorIndexTemp;

	protected long CalculateDamage(int hitDamageId)
	{
		hitDamageConfigTemp = Singleton<HotfixDataController>.Instance.GetHitDamage(hitDamageId);
		if (hitDamageConfigTemp == null)
		{
			NovaLogger.Error($"hitDamageId not exist, id:{hitDamageId}, actor name:{owner.name}");
			return 0L;
		}
		PlayerSkillCd logicComponent = fromActor.GetLogicComponent<PlayerSkillCd>();
		int num = CommonHelper.GetLevelByLevelType(fromActor.dataID, (HotfixEnum.levelTypeData)hitDamageConfigTemp.LevelTypeData, logicComponent, hitDamageConfigTemp.LevelData);
		int levelTypeData = hitDamageConfigTemp.LevelTypeData;
		if (levelTypeData == 3 || levelTypeData == 2 || levelTypeData == 1)
		{
			num--;
		}
		AdventureActor.fromAdditionalAttrInfo.CopyFrom(fromActor.attributeList, fromActor.actorInfo.attributeWithElementOrDamageTypeDict);
		AdventureActor.toAdditionalAttrInfo.CopyFrom(owner.attributeList, owner.actorInfo.attributeWithElementOrDamageTypeDict);
		FDP skillPercentAmend;
		FDP talentGroupPercentAmend;
		FDP skillAbsAmend;
		FDP talentGroupAbsAmend;
		FDP perkIntensityRatio;
		FDP slotDmgRatio;
		FDP fromEE;
		FDP erAmend;
		FDP defAmend;
		FDP rcdSlotDmgRatio;
		FDP toEERCD;
		FDP skillIntensityRatio;
		FDP toughnessBrokenDmgRatio;
		FDP critRatio;
		FDP envAmendRatio;
		return CommonHelper.CalculateNormalDamage(fromActor, owner, hitDamageConfigTemp, num, isCrit: false, isDot: true, out _hudColorIndexTemp, out skillPercentAmend, out talentGroupPercentAmend, out skillAbsAmend, out talentGroupAbsAmend, out perkIntensityRatio, out slotDmgRatio, out fromEE, out erAmend, out defAmend, out rcdSlotDmgRatio, out toEERCD, out skillIntensityRatio, out toughnessBrokenDmgRatio, out critRatio, out envAmendRatio);
	}

	protected override void Execute()
	{
		base.Execute();
		if (onceDamage <= 0)
		{
			return;
		}
		AdventureActor target = owner;
		AdventureActor attacker = fromActor;
		HitDamage hitCfg = hitDamageConfigTemp;
		long dmg = onceDamage;
		if (!target.actorHealthInfo.isAlive || target is PlayerAdventureActor { isAssist: not false })
		{
			return;
		}
		long damageToHp;
		long damageToShield;
		long damageToToughness;
		if (target.IsCanNotBeHit)
		{
			if (target.isInvincible)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("HudDefence", target.Id, 2);
			}
		}
		else
		{
			if (!ModuleController<AdventureModuleController>.Instance.InBattleState || target.CheckHitIdImmunity(hitCfg))
			{
				return;
			}
			bool flag = false;
			damageToHp = dmg;
			damageToShield = 0L;
			damageToToughness = 0L;
			long a = dmg;
			long value = dmg;
			bool flag2 = false;
			int bossLevel = 0;
			long num = target.actorHealthInfo.hp;
			long num2 = dmg;
			if (target.actorShield != null)
			{
				num2 = target.actorShield.DamageToShield(dmg, attacker);
				damageToShield = dmg - num2;
			}
			if (num2 > 0)
			{
				num -= num2;
				if (target.isHpLocked)
				{
					if (target.actorHealthInfo.hp > target.lockedHp)
					{
						num = ((num >= target.lockedHp) ? num : target.lockedHp);
						damageToHp = (int)(target.actorHealthInfo.hp - num);
					}
					else
					{
						num = target.actorHealthInfo.hp;
						damageToHp = 0L;
					}
					a = damageToHp + damageToShield;
					value = damageToHp + damageToShield;
				}
			}
			if (num <= 0)
			{
				if (target is MonsterAdventureActor { HasBattleLevelUp: not false } monsterAdventureActor)
				{
					int num3 = 0;
					while (num <= 0)
					{
						monsterAdventureActor.BattleLevel++;
						num = monsterAdventureActor.actorHealthInfo.hp + num;
						num3++;
					}
					if (num3 > 100)
					{
						NovaLogger.Error($"bossrush怪物单次伤害导致升级过快，升了:{num3}级");
					}
					flag2 = true;
					bossLevel = monsterAdventureActor.BattleLevel;
				}
				else
				{
					flag = true;
					damageToHp = (int)target.actorHealthInfo.hp;
				}
			}
			if (flag)
			{
				AdventureActorReceiveDamageCanCauseDeadEvent adventureActorReceiveDamageCanCauseDeadEvent = AdventureActorReceiveDamageCanCauseDeadEvent.Generate();
				adventureActorReceiveDamageCanCauseDeadEvent.sender = this;
				adventureActorReceiveDamageCanCauseDeadEvent.from = attacker;
				adventureActorReceiveDamageCanCauseDeadEvent.to = target;
				adventureActorReceiveDamageCanCauseDeadEvent.weapon = null;
				adventureActorReceiveDamageCanCauseDeadEvent.attackType = DamageType.DOT;
				adventureActorReceiveDamageCanCauseDeadEvent.value = dmg;
				adventureActorReceiveDamageCanCauseDeadEvent.isCrit = false;
				adventureActorReceiveDamageCanCauseDeadEvent.isDodge = false;
				adventureActorReceiveDamageCanCauseDeadEvent.elementType = _elementType;
				adventureActorReceiveDamageCanCauseDeadEvent.uniqueAttackId = -2L;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorReceiveDamageCanCauseDeadEvent);
			}
			if (flag && target.isDeadImmunity)
			{
				target.ExcuteDeadImmunity(attacker, target, null, DamageType.DOT, dmg, isCrit: false, isDodge: false, _elementType);
				flag = false;
				num = target.actorHealthInfo.hp;
				damageToHp = 0L;
			}
			ModuleController<AdventureModuleController>.Instance.RecordEffectDamage(target, (int)damageToHp, Recorder.Types.DamageType.Dot, target.isHpLocked, damageToShield > 0);
			if (flag2)
			{
				ModuleController<AdventureModuleController>.Instance.RecordBossRushBossLevelUp(target, target.actorHealthInfo.hp, target.actorHealthInfo.hpMax, bossLevel);
			}
			int a2 = _hudColorIndexTemp;
			if (target is SoldierActor soldierActor)
			{
				a2 = (soldierActor.isEnemyCamp ? 3 : 2);
			}
			MonoSingleton<LuaManager>.Instance.FireEvent("HudDotDamage", target.Id, a, a3: false, hitCfg, attacker.Id, a2);
			MonsterAdventureActor monsterAdventureActor2 = target as MonsterAdventureActor;
			if (monsterAdventureActor2 != null)
			{
				damageToToughness = (FDP.FromLong(value) * attacker.actorInfo.toughnessDamageRatio).AsLong();
				damageToToughness = math.max(0L, damageToToughness);
				monsterAdventureActor2.monsterToughnessInfo.DamageToToughness(attacker, damageToToughness, hitCfg.DamageTag);
			}
			if (flag)
			{
				target.actorHealthInfo.hp = 0L;
				SendMessage();
				target.Death(attacker, hitCfg.DamageTag, null, 0, DeadType.NormalDmgkill);
			}
			else
			{
				target.actorHealthInfo.hp = num;
				SendMessage();
			}
		}
		void SendMessage()
		{
			AdventureActorDotDamageEvent adventureActorDotDamageEvent = AdventureActorDotDamageEvent.Generate();
			adventureActorDotDamageEvent.sender = this;
			adventureActorDotDamageEvent.from = attacker;
			adventureActorDotDamageEvent.to = target;
			adventureActorDotDamageEvent.attackType = DamageType.DOT;
			adventureActorDotDamageEvent.damage = dmg;
			adventureActorDotDamageEvent.damageToShieldAndHp = damageToShield + damageToHp;
			adventureActorDotDamageEvent.damageToHp = damageToHp;
			adventureActorDotDamageEvent.elementType = _elementType;
			adventureActorDotDamageEvent.hitDamageId = hitCfg.Id;
			adventureActorDotDamageEvent.hitDamageTag = hitCfg.DamageTag;
			adventureActorDotDamageEvent.damageToughness = damageToToughness;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorDotDamageEvent);
			if (damageToHp != 0L)
			{
				AdventureActorHpChangedEvent adventureActorHpChangedEvent = AdventureActorHpChangedEvent.Generate();
				adventureActorHpChangedEvent.sender = target;
				adventureActorHpChangedEvent.currentHp = target.actorHealthInfo.hp;
				adventureActorHpChangedEvent.maxHp = target.actorHealthInfo.hpMax;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorHpChangedEvent);
			}
		}
	}
}
