using System.Collections.Generic;
using System.Text;
using Ase.ECS;
using GameFramework;

namespace Ase;

public class EntityStatInfo : IReference
{
	public class EntityGlobalStatData
	{
		public int lastHitSkillId;

		public int lastHitDamage;

		public int lastHitTenacity;

		private bool isKeepingLastHit;

		public void AddReleaseSkillTimingInfo(ObserverReleaseSkillParams releaseSkillParams)
		{
			if (releaseSkillParams.ExecuteState == SkillExecuteState.AttackStart || releaseSkillParams.ExecuteState == SkillExecuteState.SkillStart)
			{
				if (lastHitSkillId != releaseSkillParams.SkillId)
				{
					lastHitDamage = 0;
					lastHitTenacity = 0;
				}
				lastHitSkillId = releaseSkillParams.SkillId;
				isKeepingLastHit = true;
			}
			if (releaseSkillParams.SkillId != lastHitSkillId || releaseSkillParams.ExecuteState == SkillExecuteState.AttackEnd || releaseSkillParams.ExecuteState == SkillExecuteState.SkillEnd)
			{
				isKeepingLastHit = false;
				lastHitDamage = 0;
				lastHitTenacity = 0;
			}
		}

		public void AddSkillDamageInfo(ObserverDamageProgressParams damageProgressParams)
		{
			int num = damageProgressParams.Get<int>("Damage");
			int num2 = damageProgressParams.Get<int>("Tenacity");
			if (isKeepingLastHit)
			{
				lastHitDamage += num;
				lastHitTenacity += num2;
			}
			else
			{
				lastHitDamage = num;
				lastHitTenacity = num2;
			}
		}

		public void Reset()
		{
			lastHitSkillId = 0;
			lastHitDamage = 0;
			lastHitTenacity = 0;
			isKeepingLastHit = false;
		}
	}

	public class SecondStatData
	{
		public Dictionary<int, int> releaseSkillCount;

		public Dictionary<int, SkillStatData> skillDic;

		public EnergyStatData energyData;

		public WeaponStatData weaponData;

		public HeroStatData heroData;

		public MonsterStatData monsterData;

		public SecondStatData()
		{
			releaseSkillCount = new Dictionary<int, int>();
			skillDic = new Dictionary<int, SkillStatData>();
			energyData = new EnergyStatData();
			weaponData = new WeaponStatData();
			heroData = new HeroStatData();
			monsterData = new MonsterStatData();
		}

		public override string ToString()
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendLine("-------------------一秒的统计数据--------------------");
			foreach (KeyValuePair<int, int> item in releaseSkillCount)
			{
				stringBuilder.AppendLine($"{item.Key} : {item.Value}");
			}
			foreach (KeyValuePair<int, SkillStatData> item2 in skillDic)
			{
				stringBuilder.AppendLine($"{item2.Key} : {item2.Value}");
			}
			stringBuilder.AppendLine(energyData.ToString());
			stringBuilder.AppendLine(weaponData.ToString());
			stringBuilder.AppendLine(heroData.ToString());
			return stringBuilder.ToString();
		}

		public void AddReleaseSkillCount(int skillId, int count = 1)
		{
			if (releaseSkillCount.ContainsKey(skillId))
			{
				releaseSkillCount[skillId] += count;
			}
			else
			{
				releaseSkillCount.Add(skillId, count);
			}
		}

		public void AddReleaseSkillConsume(HeroSkillData skillData)
		{
			SkillStatData skillStatData = GetSkillStatData(skillData.Id);
			float skillPropertyConsume = skillData.SkillCoolingData.GetSkillPropertyConsume("Energy");
			skillStatData.energyConsume += skillPropertyConsume;
		}

		public void AddDamageInfo(ObserverDamageProgressParams damageProgressParams)
		{
			int skillId = damageProgressParams.Get<int>("SkillId");
			SkillStatData skillStatData = GetSkillStatData(skillId);
			skillStatData.hitCount++;
			int num = damageProgressParams.Get<int>("Damage");
			int num2 = damageProgressParams.Get<int>("Tenacity");
			skillStatData.damage += num;
			skillStatData.tenacity += num2;
			MonsterPhaseEnum phaseEnum = damageProgressParams.Get<MonsterPhaseEnum>("MonsterPhase");
			heroData.AddMonsterPhaseDamage(phaseEnum, num);
			heroData.AddMonsterPhaseTenacity(phaseEnum, num2);
			if (damageProgressParams.Get<bool>("Critical"))
			{
				skillStatData.critCount++;
			}
			float num3 = damageProgressParams.Get<float>("EnergyChanged");
			if (num3 > 0f)
			{
				skillStatData.energyRecover += num3;
				energyData.OnRecordStat(EnergyRecoverEnum.Skill, num3);
			}
			else if (num3 < 0f)
			{
				skillStatData.energyConsume += num3;
				energyData.OnRecordStat(EnergyConmuseEnum.Skill, num3);
			}
			heroData.AddSkillDamageInfo(skillId, num, num2);
			switch (damageProgressParams.Get<int>("WeakNessLv"))
			{
			case 3:
			case 4:
				skillStatData.weaknessLevel3Count++;
				skillStatData.weaknessLevel3Damage += num;
				skillStatData.weaknessLevel3Tenacity += num2;
				heroData.AddWeaknessHitDic(3);
				break;
			case 2:
				skillStatData.weaknessLevel2Count++;
				skillStatData.weaknessLevel2Damage += num;
				skillStatData.weaknessLevel2Tenacity += num2;
				heroData.AddWeaknessHitDic(2);
				break;
			}
			if (damageProgressParams.Get<bool>("KnockDown"))
			{
				skillStatData.knockDownDamage += num;
				skillStatData.knockDownTenacity += num2;
			}
			if (damageProgressParams.Get<bool>("BossDownState"))
			{
				skillStatData.bossDownDamage += num;
				skillStatData.bossDownTenacity += num2;
			}
			int num4 = damageProgressParams.Get<int>("SiteLevel");
			switch (num4)
			{
			case 3:
				skillStatData.siteLevel3Count++;
				break;
			case 2:
				skillStatData.siteLevel2Count++;
				break;
			}
			heroData.AddSiteHitDic(num4);
			if (damageProgressParams.Get<bool>("KnockDown"))
			{
				monsterData.down++;
			}
			if (damageProgressParams.Get<bool>("BossDownState"))
			{
				monsterData.downDamage += num;
				monsterData.downTenacity += num2;
			}
		}

		public void AddHitInfo(ObserverDamageProgressParams damageProgressParams)
		{
			int skillId = damageProgressParams.Get<int>("SkillId");
			heroData.AddSkillHitDic(skillId);
			heroData.AddSkillHitDamage(skillId, damageProgressParams.Get<int>("Damage"));
			if (damageProgressParams.Get<bool>("IsKillDown"))
			{
				heroData.AddKillHeroEntityConfigId(damageProgressParams.Attacker.EntityId);
			}
		}

		public void AddRecoverFromInfo(ObserverRecoverParams recoverParams)
		{
			SkillStatData skillStatData = GetSkillStatData(recoverParams.SkillId);
			skillStatData.recover += recoverParams.Recover;
			if (recoverParams.DoctorEntity.Id == recoverParams.Trigger.Id)
			{
				skillStatData.recoverSelf += recoverParams.Recover;
			}
			else
			{
				skillStatData.recoverOther += recoverParams.Recover;
			}
		}

		public void AddRecoverToInfo(ObserverRecoverParams recoverParams)
		{
			GetSkillStatData(recoverParams.SkillId).recoverBeOther += recoverParams.Recover;
		}

		public void AddEnergyStat(EnergyConmuseEnum conmuseEnum, float value)
		{
			energyData.OnRecordStat(conmuseEnum, value);
		}

		public void AddEnergyStat(EnergyRecoverEnum recoverEnum, float value)
		{
			energyData.OnRecordStat(recoverEnum, value);
		}

		public void AddWeaponStat(WeaponStatEnum weaponStatEnum, params object[] values)
		{
			weaponData.OnRecordWeaponData(weaponStatEnum, values);
		}

		public void AddWeaknessStat(List<WeaknessHitInfo> hitInfoList)
		{
			if (hitInfoList.Count != 0)
			{
				WeaknessHitInfo weaknessHitInfo = hitInfoList[0];
				if (weaknessHitInfo.level == 3 || weaknessHitInfo.level == 4)
				{
					heroData.AddSpeicalWeaknessHitDic(3);
				}
				else if (weaknessHitInfo.level == 2)
				{
					heroData.AddSpeicalWeaknessHitDic(2);
				}
			}
		}

		public void AddEntityDownStat()
		{
			heroData.down++;
		}

		public void AddSkillDamageTimingStat(ObserverReleaseSkillParams releaseSkillParams)
		{
			heroData.AddReleaseSkillTimingInfo(releaseSkillParams);
		}

		public void AddInteractiveData(ObserverInteractiveParams interactiveParams)
		{
			if (interactiveParams.ObserverEventType == BattleObserverEventEnum.InteractiveSuccess && interactiveParams.InteractiveEntity != null)
			{
				heroData.interactiveUseCount++;
			}
		}

		public void AddInteractiveBreakData(ObserverInteractiveParams interactiveBreakParams)
		{
			if (interactiveBreakParams.ObserverEventType == BattleObserverEventEnum.InteractiveBreak && interactiveBreakParams.InteractiveEntity != null)
			{
				heroData.interactiveBreakCount++;
			}
		}

		private SkillStatData GetSkillStatData(int skillId)
		{
			if (!skillDic.TryGetValue(skillId, out var value))
			{
				value = new SkillStatData();
				skillDic.Add(skillId, value);
			}
			return value;
		}
	}

	public class SkillStatData
	{
		public int hitCount;

		public int damage;

		public int tenacity;

		public int recover;

		public int recoverSelf;

		public int recoverOther;

		public int recoverBeOther;

		public int critCount;

		public float energyConsume;

		public float energyRecover;

		public int weaknessLevel2Count;

		public int weaknessLevel3Count;

		public float weaknessLevel2Damage;

		public float weaknessLevel3Damage;

		public float weaknessLevel2Tenacity;

		public float weaknessLevel3Tenacity;

		public float knockDownDamage;

		public float knockDownTenacity;

		public float bossDownDamage;

		public float bossDownTenacity;

		public int siteLevel2Count;

		public int siteLevel3Count;

		public float siteLevel2Damage;

		public int siteLevel3Damage;

		public override string ToString()
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendLine($"命中次数({hitCount}) 伤害({damage}) 削韧({tenacity}) 回复({recover}) 耗耐({energyConsume}) 回耐({energyRecover})");
			stringBuilder.AppendLine($"命中黄破次数({weaknessLevel2Count}) 黄破伤害({weaknessLevel2Damage}) 黄破削韧({weaknessLevel2Tenacity})");
			stringBuilder.AppendLine($"命中红破次数({weaknessLevel3Count}) 红破伤害({weaknessLevel3Damage}) 红破削韧({weaknessLevel3Tenacity})");
			stringBuilder.AppendLine($"Boss倒地输出({bossDownDamage}) Boss倒地削韧({bossDownTenacity})");
			stringBuilder.AppendLine($"命中部位B次数({siteLevel2Count}) 命中部位B伤害({siteLevel2Damage})");
			stringBuilder.AppendLine($"命中部位HB次数({siteLevel3Count}) 命中部位HB伤害({siteLevel3Damage})");
			return stringBuilder.ToString();
		}
	}

	public class EnergyStatData
	{
		public Dictionary<EnergyConmuseEnum, float> consumeDic;

		public Dictionary<EnergyRecoverEnum, float> recoverDic;

		public EnergyStatData()
		{
			consumeDic = new Dictionary<EnergyConmuseEnum, float>();
			recoverDic = new Dictionary<EnergyRecoverEnum, float>();
		}

		public override string ToString()
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendLine("--------------------耐力统计数据--------------------\n");
			foreach (KeyValuePair<EnergyConmuseEnum, float> item in consumeDic)
			{
				stringBuilder.AppendLine($"消耗类型({item.Key}) : 消耗值({item.Value})");
			}
			stringBuilder.AppendLine();
			foreach (KeyValuePair<EnergyRecoverEnum, float> item2 in recoverDic)
			{
				stringBuilder.AppendLine($"回复类型({item2.Key}) : 回复值({item2.Value})");
			}
			return stringBuilder.ToString();
		}

		public void OnRecordStat(EnergyConmuseEnum conmuseEnum, float value)
		{
			if (consumeDic.ContainsKey(conmuseEnum))
			{
				consumeDic[conmuseEnum] += value;
			}
			else
			{
				consumeDic.Add(conmuseEnum, value);
			}
		}

		public void OnRecordStat(EnergyRecoverEnum recoverEnum, float value)
		{
			if (recoverDic.ContainsKey(recoverEnum))
			{
				recoverDic[recoverEnum] += value;
			}
			else
			{
				recoverDic.Add(recoverEnum, value);
			}
		}
	}

	public class WeaponStatData
	{
		public Dictionary<WeaponStatEnum, object> weaponDataDic;

		public WeaponStatData()
		{
			weaponDataDic = new Dictionary<WeaponStatEnum, object>();
		}

		public override string ToString()
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendLine("--------------------武器统计数据--------------------\n");
			foreach (KeyValuePair<WeaponStatEnum, object> item in weaponDataDic)
			{
				if (item.Key == WeaponStatEnum.Bullet)
				{
					foreach (WeaponGunBulletData item2 in item.Value as List<WeaponGunBulletData>)
					{
						stringBuilder.Append(item2.ToString() + ",");
					}
					stringBuilder.AppendLine();
				}
				else
				{
					stringBuilder.AppendLine($"{item.Key} = {item.Value}");
				}
			}
			return stringBuilder.ToString();
		}

		public void OnRecordWeaponData(WeaponStatEnum weaponStatEnum, params object[] values)
		{
			if (weaponStatEnum == WeaponStatEnum.None || values == null || values.Length == 0)
			{
				return;
			}
			if (weaponStatEnum == WeaponStatEnum.Bullet)
			{
				List<WeaponGunBulletData> list = new List<WeaponGunBulletData>(values[0] as List<WeaponGunBulletData>);
				if (list != null)
				{
					if (!weaponDataDic.TryGetValue(weaponStatEnum, out var value))
					{
						weaponDataDic.Add(weaponStatEnum, list);
					}
					else
					{
						((List<WeaponGunBulletData>)value).AddRange(list);
					}
				}
			}
			else
			{
				float num = (float)values[0];
				if (weaponDataDic.ContainsKey(weaponStatEnum))
				{
					float num2 = (float)weaponDataDic[weaponStatEnum];
					num2 += num;
					weaponDataDic[weaponStatEnum] = num2;
				}
				else
				{
					weaponDataDic.Add(weaponStatEnum, num);
				}
			}
		}
	}

	public class HeroStatData
	{
		public Dictionary<int, int> skillHitDic;

		public Dictionary<int, int> skillHitDamage;

		public Dictionary<int, int> weaknessSpeicalHitDic;

		public Dictionary<int, int> weaknessHitDic;

		public Dictionary<int, int> siteHitDic;

		public Dictionary<MonsterPhaseEnum, int> monsterPhaseDamageDic;

		public Dictionary<MonsterPhaseEnum, int> monsterPhaseTenacityDic;

		public int down;

		public int interactiveUseCount;

		public int interactiveBreakCount;

		public List<int> killHeroEntityIdList;

		public HeroStatData()
		{
			weaknessHitDic = new Dictionary<int, int>();
			weaknessSpeicalHitDic = new Dictionary<int, int>();
			siteHitDic = new Dictionary<int, int>();
			skillHitDic = new Dictionary<int, int>();
			skillHitDamage = new Dictionary<int, int>();
			monsterPhaseDamageDic = new Dictionary<MonsterPhaseEnum, int>();
			monsterPhaseTenacityDic = new Dictionary<MonsterPhaseEnum, int>();
			killHeroEntityIdList = new List<int>();
		}

		public override string ToString()
		{
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.AppendLine("--------------------Hero技能受击数据--------------------\n");
			foreach (KeyValuePair<int, int> item in skillHitDic)
			{
				stringBuilder.AppendLine($"{item.Key} = {item.Value}");
			}
			stringBuilder.AppendLine("--------------------数值需要的破绽条命中数据--------------------\n");
			foreach (KeyValuePair<int, int> item2 in weaknessHitDic)
			{
				stringBuilder.AppendLine($"{item2.Key} = {item2.Value}");
			}
			stringBuilder.AppendLine($"倒地次数 : {down}");
			return stringBuilder.ToString();
		}

		public void AddSkillHitDic(int skillId, int count = 1)
		{
			if (skillHitDic.ContainsKey(skillId))
			{
				skillHitDic[skillId] += count;
			}
			else
			{
				skillHitDic.Add(skillId, count);
			}
		}

		public void AddSkillHitDamage(int skillId, int damage)
		{
			if (skillHitDamage.ContainsKey(skillId))
			{
				skillHitDamage[skillId] += damage;
			}
			else
			{
				skillHitDamage.Add(skillId, damage);
			}
		}

		public void AddWeaknessHitDic(int level, int count = 1)
		{
			if (weaknessHitDic.ContainsKey(level))
			{
				weaknessHitDic[level] += count;
			}
			else
			{
				weaknessHitDic.Add(level, count);
			}
		}

		public void AddSpeicalWeaknessHitDic(int level, int count = 1)
		{
			if (weaknessSpeicalHitDic.ContainsKey(level))
			{
				weaknessSpeicalHitDic[level] += count;
			}
			else
			{
				weaknessSpeicalHitDic.Add(level, count);
			}
		}

		public void AddSiteHitDic(int level, int count = 1)
		{
			if (siteHitDic.ContainsKey(level))
			{
				siteHitDic[level] += count;
			}
			else
			{
				siteHitDic.Add(level, count);
			}
		}

		public void AddReleaseSkillTimingInfo(ObserverReleaseSkillParams releaseSkillParams)
		{
		}

		public void AddSkillDamageInfo(int skillId, int damage, int tenacity)
		{
		}

		public void AddMonsterPhaseDamage(MonsterPhaseEnum phaseEnum, int damage)
		{
			if (monsterPhaseDamageDic.ContainsKey(phaseEnum))
			{
				monsterPhaseDamageDic[phaseEnum] += damage;
			}
			else
			{
				monsterPhaseDamageDic.Add(phaseEnum, damage);
			}
		}

		public void AddMonsterPhaseTenacity(MonsterPhaseEnum phaseEnum, int tenacity)
		{
			if (monsterPhaseTenacityDic.ContainsKey(phaseEnum))
			{
				monsterPhaseTenacityDic[phaseEnum] += tenacity;
			}
			else
			{
				monsterPhaseTenacityDic.Add(phaseEnum, tenacity);
			}
		}

		public void AddKillHeroEntityConfigId(int monsterId)
		{
			if (!killHeroEntityIdList.Contains(monsterId))
			{
				killHeroEntityIdList.Add(monsterId);
			}
		}
	}

	public class MonsterStatData
	{
		public int down;

		public int downDamage;

		public int downTenacity;
	}

	private float _curativeDose;

	private float _damage;

	private float _tenacity;

	public List<IStatDataChanged> dataChangedList;

	public float Damage => _damage;

	public float Tenacity => _tenacity;

	public float CurativeDose => _curativeDose;

	public float TotalGameTime { get; private set; }

	public EntityGlobalStatData EntityGlobalStatDataInfo { get; private set; }

	public Dictionary<int, SecondStatData> SecondStatDic { get; private set; }

	public static EntityStatInfo Copy(EntityStatInfo a)
	{
		return new EntityStatInfo
		{
			_damage = a.Damage,
			_tenacity = a.Tenacity,
			_curativeDose = a.CurativeDose
		};
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine("------------------------实体统计数据-------------------------");
		stringBuilder.AppendLine($"游戏总时间 : {TotalGameTime}");
		foreach (KeyValuePair<int, SecondStatData> item in SecondStatDic)
		{
			stringBuilder.AppendLine($"{item.Key} : {item.Value}");
		}
		return stringBuilder.ToString();
	}

	public void OnInit()
	{
		EntityGlobalStatDataInfo = new EntityGlobalStatData();
		SecondStatDic = new Dictionary<int, SecondStatData>();
		dataChangedList = new List<IStatDataChanged>();
	}

	public void AddDataChanged(IStatDataChanged dataChanged)
	{
		dataChangedList.Add(dataChanged);
	}

	public void RemoveDataChanged(IStatDataChanged dataChanged)
	{
		dataChangedList.Remove(dataChanged);
	}

	public void OnDataChanged()
	{
		foreach (IStatDataChanged dataChanged in dataChangedList)
		{
			dataChanged.OnChanged(this);
		}
	}

	public void OnRecordGlobalBattleTime(float globalBattleTime)
	{
		TotalGameTime = globalBattleTime;
		OnDataChanged();
	}

	public void OnRecordReleaseSkillTiming(int battleTime, ObserverReleaseSkillParams releaseSkillParams)
	{
		GetSecondStatData(battleTime);
		EntityGlobalStatDataInfo.AddReleaseSkillTimingInfo(releaseSkillParams);
	}

	public void OnRecordReleaseSkillInfo(int battleTime, HeroSkillData skillData)
	{
		SecondStatData secondStatData = GetSecondStatData(battleTime);
		secondStatData.AddReleaseSkillCount(skillData.Id);
		secondStatData.AddReleaseSkillConsume(skillData);
		OnDataChanged();
	}

	public void OnRecordDamageInfo(int battleTime, ObserverDamageProgressParams damageProgressParams)
	{
		GetSecondStatData(battleTime).AddDamageInfo(damageProgressParams);
		EntityGlobalStatDataInfo.AddSkillDamageInfo(damageProgressParams);
		OnDataChanged();
	}

	public void OnRecordHitInfo(int battleTime, ObserverDamageProgressParams damageProgressParams)
	{
		GetSecondStatData(battleTime).AddHitInfo(damageProgressParams);
		OnDataChanged();
	}

	public void OnRecordRecoverFromInfo(int battleTime, ObserverRecoverParams recoverParams)
	{
		GetSecondStatData(battleTime).AddRecoverFromInfo(recoverParams);
		OnDataChanged();
	}

	public void OnRecordRecoverToInfo(int battleTime, ObserverRecoverParams recoverParams)
	{
		GetSecondStatData(battleTime).AddRecoverToInfo(recoverParams);
		OnDataChanged();
	}

	public void OnRecordEnergyStat(int battleTime, EnergyConmuseEnum conmuseEnum, float value)
	{
		GetSecondStatData(battleTime).AddEnergyStat(conmuseEnum, value);
		OnDataChanged();
	}

	public void OnRecordEnergyStat(int battleTime, EnergyRecoverEnum recoverEnum, float value)
	{
		GetSecondStatData(battleTime).AddEnergyStat(recoverEnum, value);
		OnDataChanged();
	}

	public void OnRecordWeaponInfo(int battleTime, WeaponStatEnum weaponStatEnum, params object[] values)
	{
		GetSecondStatData(battleTime).AddWeaponStat(weaponStatEnum, values);
		OnDataChanged();
	}

	public void OnRecordWeaknessInfo(int battleTime, List<WeaknessHitInfo> hitInfoList)
	{
		GetSecondStatData(battleTime).AddWeaknessStat(hitInfoList);
		OnDataChanged();
	}

	public void OnRecordEntityDown(int battleTime)
	{
		GetSecondStatData(battleTime).AddEntityDownStat();
		OnDataChanged();
	}

	public void OnRecordInteractive(int battleTime, ObserverInteractiveParams interactiveParams)
	{
		GetSecondStatData(battleTime).AddInteractiveData(interactiveParams);
	}

	public void OnRecordInteractiveBreak(int battleTime, ObserverInteractiveParams interactiveBreakParams)
	{
		GetSecondStatData(battleTime).AddInteractiveBreakData(interactiveBreakParams);
	}

	private SecondStatData GetSecondStatData(int battleTime)
	{
		if (!SecondStatDic.TryGetValue(battleTime, out var value))
		{
			value = new SecondStatData();
			SecondStatDic.Add(battleTime, value);
		}
		return value;
	}

	public void Reset()
	{
		_damage = 0f;
		_tenacity = 0f;
		_curativeDose = 0f;
		EntityGlobalStatDataInfo.Reset();
		SecondStatDic.Clear();
	}

	public void Clear()
	{
		Reset();
		dataChangedList.Clear();
	}

	public void AccountDamage(float damage)
	{
		_damage += damage;
	}

	public void AccountTenacity(float tenacity)
	{
		_tenacity += tenacity;
	}

	public void AccountCurativeDose(float curativeDose)
	{
		_curativeDose += curativeDose;
	}
}
