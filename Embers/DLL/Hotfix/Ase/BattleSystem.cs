#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.ECS;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using GameFramework;
using UnityEngine;

namespace Ase;

public class BattleSystem : BaseSystem, IObserverHandler
{
	private class BattleGMInfo
	{
		public BattleGMEnum gmEnum;

		public bool isOpen;

		public bool isInter = true;

		public object[] args;
	}

	private int _killMonsterNumber;

	private int actorKillCount;

	private GlobalStatInfo globalStatInfo;

	private Dictionary<int, EntityStatInfo> entityStatInfoDic = new Dictionary<int, EntityStatInfo>();

	private AutoFightStatistics autoFightStatistics;

	public bool IsShieldChange;

	private BattleWorldMode _battleMode;

	private MonsterEntity _monsterEntity;

	private int _teamRebornNumber;

	private int _teamKillNumber;

	private long gameScore;

	private BattleWindow _battleWindow;

	private bool levelBossMode;

	private int enterCavernId;

	private BattleViewModel viewModel;

	private bool teachShowHp;

	private bool teachAIXp;

	private bool isOpenBattleDS = true;

	private SceneSystem _sceneSystem;

	private bool resetAutoFightTimer;

	private Transform taoTieBoneTrans;

	private Vector3 taoTieHeadPos;

	private float taoTieHeadLerpSpeed = 5f;

	private int battleTime;

	private float globalBattleTime;

	private bool monsterBarDelay;

	private bool battleTimeDelay;

	private bool monsterNameDelay;

	private float monsterBarDelayTime;

	private float battleTimeDelayTime;

	private float monsterNameDelayTime;

	private bool battleTimeSettledExternally;

	private Dictionary<BattleGMEnum, BattleGMInfo> gmDic;

	private float AUTO_CLEAR_STAT_TIMER = 7f;

	private bool isOpenAutoClearStat;

	private float temp_autoClearStatTime;

	private float waitSceneLoadDelay = 0.2f;

	private float speicalModeDelay = 1f;

	private float READY_TIME = 4f;

	private bool isSpecialModeReady;

	private bool isSpecialModeStart;

	private float temp_readyTimer;

	private float temp_check_dps_time = 1f;

	private float temp_specialTimer;

	private BattleSpecialModeEnum specialModeEnum;

	public int KillMonsterNumber => _killMonsterNumber;

	public int ActorKillCount => actorKillCount;

	public GlobalStatInfo BattleGlobalStatInfo => globalStatInfo;

	protected override bool IsLogicSystem => false;

	public int TeamRebornNumber => _teamRebornNumber;

	public int TeamKillNumber => _teamKillNumber;

	public BattleWorldMode BattleMode => _battleMode;

	public bool LevelBossMode => levelBossMode;

	public int BattleTime => battleTime;

	public float GlobalBattleTime => globalBattleTime;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		_killMonsterNumber = 0;
		actorKillCount = 0;
		BattleObserverSystem system = GetSystem<BattleObserverSystem>();
		if (system != null)
		{
			system.Attach(BattleObserverEventEnum.Attack, this);
			system.Attach(BattleObserverEventEnum.Damage, this);
			system.Attach(BattleObserverEventEnum.Recover, this);
			system.Attach(BattleObserverEventEnum.ReleaseSkill, this);
			system.Attach(BattleObserverEventEnum.WeaknessBar, this);
			system.Attach(BattleObserverEventEnum.ChangeState, this);
			system.Attach(BattleObserverEventEnum.AttackBossWeak, this);
			system.Attach(BattleObserverEventEnum.InteractiveSuccess, this);
			system.Attach(BattleObserverEventEnum.InteractiveBreak, this);
			system.Attach(BattleObserverEventEnum.ActorAddEnergy, this);
		}
		globalStatInfo = new GlobalStatInfo();
	}

	public void InitEntityStat(int entityId)
	{
		if (!entityStatInfoDic.ContainsKey(entityId))
		{
			EntityStatInfo entityStatInfo = ReferencePool.Acquire<EntityStatInfo>();
			entityStatInfo.OnInit();
			entityStatInfoDic.Add(entityId, entityStatInfo);
		}
	}

	public void Account(AccountType type, float value, int entityId)
	{
		entityStatInfoDic.TryGetValue(entityId, out var value2);
		if (value2 != null)
		{
			switch (type)
			{
			case AccountType.Damage:
				value2.AccountDamage(value);
				break;
			case AccountType.Tenacity:
				value2.AccountTenacity(value);
				break;
			case AccountType.CurativeDose:
				value2.AccountCurativeDose(value);
				break;
			}
			viewModel.RefreshDS(entityId, value2, entityStatInfoDic);
			viewModel.RefreshStatInfo(GetSpeicalTime(), entityId, value2, entityStatInfoDic);
			OnRefreshDamageAction(entityId);
		}
	}

	public void ResetAllDS()
	{
		viewModel?.ResetAllDS();
	}

	public Dictionary<int, Dictionary<int, BSData>> GetBSDatasByHeroSeat()
	{
		if (entityStatInfoDic == null)
		{
			return null;
		}
		Dictionary<int, Dictionary<int, BSData>> dictionary = new Dictionary<int, Dictionary<int, BSData>>();
		foreach (KeyValuePair<int, EntityStatInfo> item in entityStatInfoDic)
		{
			BaseEntity hero = GetSystem<EntitySystem>().GetEntity(item.Key);
			if (!(hero is HeroEntity heroEntity))
			{
				continue;
			}
			Dictionary<int, BSData> dictionary2 = new Dictionary<int, BSData>();
			BSData bSData = new BSData();
			dictionary2.Add(-1, bSData);
			foreach (EntityStatInfo.SecondStatData value in item.Value.SecondStatDic.Values)
			{
				DRHeroSKillInfo[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroSKillInfo p) => p.HeroId == hero.EntityId);
				foreach (KeyValuePair<int, EntityStatInfo.SkillStatData> item2 in value.skillDic)
				{
					int num = item2.Key;
					if (GetHeroSkillInfo(dataRows, num) == null && GetHeroBattleProp(num) == null)
					{
						if (item2.Value.damage <= 0 && item2.Value.tenacity <= 0 && item2.Value.recover <= 0 && item2.Value.recoverOther <= 0 && item2.Value.recoverSelf <= 0)
						{
							continue;
						}
						num = -2;
					}
					if (!dictionary2.ContainsKey(num))
					{
						dictionary2.Add(num, new BSData(num, heroEntity.BattleHeroData));
					}
					dictionary2[num].AddSkillStatData(item2.Value);
					bSData.AddSecondTotalData1(item2.Value);
				}
				foreach (KeyValuePair<int, int> item3 in value.releaseSkillCount)
				{
					if (!dictionary2.ContainsKey(item3.Key))
					{
						dictionary2.Add(item3.Key, new BSData(item3.Key, heroEntity.BattleHeroData));
					}
					dictionary2[item3.Key].AddReleaseSkillData(item3.Value);
				}
				bSData.AddSecondTotalDataDown(value.heroData.down);
				foreach (KeyValuePair<int, int> item4 in value.heroData.skillHitDic)
				{
					bSData.AddSecondTotalDataInjureCount(item4.Value);
				}
				foreach (KeyValuePair<int, int> item5 in value.heroData.skillHitDamage)
				{
					bSData.AddSecondTotalDataInjureDamage(item5.Value);
				}
			}
			dictionary.Add(heroEntity.BattleHeroData.MemberId, dictionary2);
		}
		return dictionary;
	}

	private DRHeroSKillInfo GetHeroSkillInfo(DRHeroSKillInfo[] sKillInfos, int skillId)
	{
		for (int i = 0; i < sKillInfos.Length; i++)
		{
			if (sKillInfos[i].CommandBindSkillGroup.Contains(skillId))
			{
				return sKillInfos[i];
			}
		}
		return null;
	}

	private DRBattlePropInfo GetHeroBattleProp(int battlePropId)
	{
		return GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.PropSkillID == battlePropId);
	}

	private void OnGameSettlementStat()
	{
		foreach (EntityStatInfo value in entityStatInfoDic.Values)
		{
			value.OnRecordGlobalBattleTime(globalBattleTime);
		}
	}

	public void OnEnergyChangeStat(int entityId, EnergyConmuseEnum conmuseEnum, float value)
	{
		GetEntityStatInfo(entityId)?.OnRecordEnergyStat(GetBattleTime(), conmuseEnum, value);
	}

	public void OnEnergyChangeStat(int entityId, EnergyRecoverEnum recoverEnum, float value)
	{
		GetEntityStatInfo(entityId)?.OnRecordEnergyStat(GetBattleTime(), recoverEnum, value);
	}

	public void OnWeaponChangeStat(int entityId, WeaponStatEnum weaponStatEnum, params object[] values)
	{
		GetEntityStatInfo(entityId)?.OnRecordWeaponInfo(GetBattleTime(), weaponStatEnum, values);
	}

	public void OnNotify(IObserverParams param)
	{
		if (param.ObserverEventType == BattleObserverEventEnum.ReleaseSkill)
		{
			OnStatReleaseSkill(param as ObserverReleaseSkillParams);
		}
		else if (param.ObserverEventType == BattleObserverEventEnum.Attack)
		{
			OnStatAttack(param as ObserverDamageProgressParams);
		}
		else if (param.ObserverEventType == BattleObserverEventEnum.Damage)
		{
			OnStatHit(param as ObserverDamageProgressParams);
		}
		else if (param.ObserverEventType == BattleObserverEventEnum.Recover)
		{
			OnStatRecover(param as ObserverRecoverParams);
		}
		else if (param.ObserverEventType == BattleObserverEventEnum.WeaknessBar)
		{
			OnStatWeaknessBar(param as ObserverWeaknessBarParams);
		}
		else if (param.ObserverEventType == BattleObserverEventEnum.ChangeState)
		{
			OnStatEntityDown(param as ObserverChangeStateParams);
		}
		else if (param.ObserverEventType == BattleObserverEventEnum.AttackBossWeak)
		{
			OnAttackBoss(param as ObserverAttackBossWeakParams);
		}
		else if (param.ObserverEventType == BattleObserverEventEnum.InteractiveSuccess)
		{
			OnInteractive(param as ObserverInteractiveParams);
		}
		else if (param.ObserverEventType == BattleObserverEventEnum.InteractiveBreak)
		{
			OnInteractiveBreak(param as ObserverInteractiveParams);
		}
		else if (param.ObserverEventType == BattleObserverEventEnum.ActorAddEnergy)
		{
			OnActorAddEnergy(param as ObserverActorAddEenergyParams);
		}
	}

	private void OnStatReleaseSkill(ObserverReleaseSkillParams releaseSkillParams)
	{
		if (releaseSkillParams == null)
		{
			return;
		}
		EntityStatInfo entityStatInfo = GetEntityStatInfo(releaseSkillParams.Trigger.Id);
		if (entityStatInfo != null)
		{
			int num = GetBattleTime();
			entityStatInfo.OnRecordReleaseSkillTiming(num, releaseSkillParams);
			if (releaseSkillParams.ExecuteState == SkillExecuteState.SkillRelease)
			{
				entityStatInfo.OnRecordReleaseSkillInfo(num, releaseSkillParams.SkillData);
			}
		}
	}

	private void OnStatAttack(ObserverDamageProgressParams damageProgressParams)
	{
		if (damageProgressParams != null)
		{
			int id = damageProgressParams.Trigger.Id;
			GetEntityStatInfo(id)?.OnRecordDamageInfo(GetBattleTime(), damageProgressParams);
		}
	}

	private void OnStatHit(ObserverDamageProgressParams damageProgressParams)
	{
		if (damageProgressParams.Get<bool>("IsKillDown") && damageProgressParams.Defender.GetEntityType() == EntityType.HERO)
		{
			globalStatInfo?.AddKillHeroEntityInfo(GetBattleTime(), damageProgressParams);
		}
		GetEntityStatInfo(damageProgressParams.Trigger.Id)?.OnRecordHitInfo(GetBattleTime(), damageProgressParams);
	}

	public void ActorEnergyAdd(HeroEntity heroEntity)
	{
		heroEntity.BattleHeroData.HeroEntityAddEnergy();
	}

	private void OnStatRecover(ObserverRecoverParams recoverParams)
	{
		if (recoverParams != null)
		{
			int num = GetBattleTime();
			GetEntityStatInfo(recoverParams.DoctorEntity.Id)?.OnRecordRecoverFromInfo(num, recoverParams);
			if (recoverParams.DoctorEntity.Id != recoverParams.CureEntity.Id)
			{
				GetEntityStatInfo(recoverParams.CureEntity.Id)?.OnRecordRecoverToInfo(num, recoverParams);
			}
		}
	}

	private void OnStatWeaknessBar(ObserverWeaknessBarParams weaknessBarParams)
	{
		if (weaknessBarParams == null || weaknessBarParams.WeaknessData == null)
		{
			return;
		}
		foreach (KeyValuePair<int, List<WeaknessHitInfo>> weaknessHitInfo in weaknessBarParams.WeaknessData.GetWeaknessHitInfos())
		{
			EntityStatInfo entityStatInfo = GetEntityStatInfo(weaknessHitInfo.Key);
			if (entityStatInfo == null)
			{
				return;
			}
			entityStatInfo.OnRecordWeaknessInfo(GetBattleTime(), weaknessHitInfo.Value);
		}
		if (weaknessBarParams.IsShow)
		{
			globalStatInfo.weaknessShowCount++;
		}
	}

	private void OnStatEntityDown(ObserverChangeStateParams changeStateParams)
	{
		EntityStatInfo entityStatInfo = GetEntityStatInfo(changeStateParams.ChangeEntity.Id);
		if (entityStatInfo != null && changeStateParams.ChangeEntity.GetComponent<StateComponent>().IsNearDeathState())
		{
			entityStatInfo.OnRecordEntityDown(GetBattleTime());
		}
	}

	private void OnAttackBoss(ObserverAttackBossWeakParams attackBossWeakParams)
	{
		viewModel.BossInfoViewModel.AttackBoss(attackBossWeakParams.IsAttackWeak, attackBossWeakParams.ReduceHp, attackBossWeakParams.ReduceTenacity);
	}

	private void OnInteractive(ObserverInteractiveParams interactiveParams)
	{
		if (interactiveParams != null)
		{
			GetEntityStatInfo(interactiveParams.Trigger.Id)?.OnRecordInteractive(GetBattleTime(), interactiveParams);
		}
	}

	private void OnInteractiveBreak(ObserverInteractiveParams interactiveBreakParams)
	{
		if (interactiveBreakParams != null)
		{
			GetEntityStatInfo(interactiveBreakParams.Trigger.Id)?.OnRecordInteractiveBreak(GetBattleTime(), interactiveBreakParams);
		}
	}

	private void OnActorAddEnergy(ObserverActorAddEenergyParams addEnergyParams)
	{
		if (addEnergyParams != null)
		{
			_ = addEnergyParams.Trigger;
			ActorEnergyAdd(addEnergyParams.Trigger as HeroEntity);
		}
	}

	public EntityStatInfo GetEntityStatInfo(int entityId)
	{
		if (entityStatInfoDic != null && entityStatInfoDic.TryGetValue(entityId, out var value))
		{
			return value;
		}
		return null;
	}

	private float GetActorEntityDamage()
	{
		if (world == null)
		{
			return 0f;
		}
		return GetEntityStatInfo(world.ActorId)?.Damage ?? 0f;
	}

	public int GetBattleTime()
	{
		return (int)MathF.Ceiling(globalBattleTime);
	}

	private void ResetStat()
	{
		globalStatInfo?.Reset();
		if (entityStatInfoDic != null)
		{
			foreach (EntityStatInfo value in entityStatInfoDic.Values)
			{
				value.Reset();
			}
		}
		isSpecialModeStart = false;
		temp_specialTimer = 0f;
		viewModel.UpdateStatTime(0f);
		autoFightStatistics.Clear();
	}

	public void ClearStat()
	{
		globalStatInfo?.Clear();
		_killMonsterNumber = 0;
		actorKillCount = 0;
		autoFightStatistics.Clear();
		if (entityStatInfoDic == null)
		{
			return;
		}
		foreach (EntityStatInfo value in entityStatInfoDic.Values)
		{
			value.Clear();
		}
		entityStatInfoDic.Clear();
	}

	public void BattleStartSetAutoFight(bool isOpen)
	{
		if (isOpen)
		{
			autoFightStatistics.OpenAutoFightTime = "0";
		}
		autoFightStatistics.AutoFightState = isOpen;
	}

	public void ChangeAutoFightState(bool isOpen, uint tick)
	{
		int num = (int)((float)tick * 0.033f);
		if (isOpen)
		{
			autoFightStatistics.OpenAutoFightTime = num.ToString();
			autoFightStatistics.OpenCount++;
		}
		else
		{
			autoFightStatistics.CloseAutoFightTime = num.ToString();
		}
		autoFightStatistics.AutoFightState = isOpen;
	}

	public void TimeOutOpenAutoFight()
	{
		autoFightStatistics.TimerOutAutoOpen = true;
	}

	public AutoFightStatistics GetBattleFinishAutoFightData()
	{
		CommandSystem system = GetSystem<CommandSystem>();
		autoFightStatistics.AutoFightTimer = (int)((float)system.OpenAutoFightTimer * 0.033f);
		autoFightStatistics.OpenUseProp = GameEntry.Setting.GetBool("自动战斗时使用战斗道具");
		autoFightStatistics.UseLastAutoFightState = GameEntry.Setting.GetBool("沿用自动战斗设置");
		return autoFightStatistics;
	}

	public void RecodeKillMonsterNumber(BaseEntity baseEntity, BaseEntity killer)
	{
		if (baseEntity is MonsterEntity monsterEntity)
		{
			if (monsterEntity.IsBoss)
			{
				_killMonsterNumber++;
			}
			else
			{
				DRMonster monsterTypeConfig = monsterEntity.MonsterTypeConfig;
				if (monsterTypeConfig != null && monsterTypeConfig.MobPower > 0)
				{
					_killMonsterNumber++;
				}
			}
		}
		if (killer != null && killer.Id == world.ActorId)
		{
			actorKillCount++;
		}
	}

	public List<GlobalStatInfo.KillHeroEntityInfo> GetKillHeroEntityInfoList()
	{
		return globalStatInfo?.killHeroEntityInfoList ?? null;
	}

	public Dictionary<int, BattleRecordPointInfo> GetAllBattleRecordPointInfo()
	{
		Dictionary<int, BattleRecordPointInfo> dictionary = new Dictionary<int, BattleRecordPointInfo>();
		List<HeroEntity> list = GetSystem<EntitySystem>()?.GetTeamHero();
		if (list.IsNullOrEmpty())
		{
			return null;
		}
		for (int i = 0; i < list.Count; i++)
		{
			HeroEntity heroEntity = list[i];
			if (heroEntity == null || heroEntity.BattleHeroData == null)
			{
				Log.Error("实体数据错误.");
			}
			else
			{
				dictionary.Add(list[i].BattleHeroData.MemberId, GetBattleRecordPointInfo(list[i].Id));
			}
		}
		return dictionary;
	}

	public BattleRecordPointInfo GetBattleRecordPointInfo(int entityId)
	{
		EntityStatInfo entityStatInfo = GetEntityStatInfo(entityId);
		if (entityStatInfo == null)
		{
			return null;
		}
		BattleRecordPointInfo battleRecordPointInfo = new BattleRecordPointInfo();
		Dictionary<string, object> dictionary = new Dictionary<string, object>();
		float num = 0f;
		float num2 = 0f;
		float num3 = 0f;
		float num4 = 0f;
		float num5 = 0f;
		float num6 = 0f;
		float num7 = 0f;
		float num8 = 0f;
		float num9 = 0f;
		float num10 = 0f;
		float num11 = 0f;
		float num12 = 0f;
		float num13 = 0f;
		float num14 = 0f;
		float num15 = 0f;
		float num16 = 0f;
		float num17 = 0f;
		float num18 = 0f;
		float num19 = 0f;
		float num20 = 0f;
		float num21 = 0f;
		float num22 = 0f;
		float num23 = 0f;
		float num24 = 0f;
		float num25 = 0f;
		float num26 = 0f;
		float num27 = 0f;
		float num28 = 0f;
		float num29 = 0f;
		float num30 = 0f;
		float num31 = 0f;
		float num32 = 0f;
		Dictionary<int, Dictionary<string, float>> skill_detaill = new Dictionary<int, Dictionary<string, float>>();
		foreach (KeyValuePair<int, EntityStatInfo.SecondStatData> item in entityStatInfo.SecondStatDic)
		{
			foreach (KeyValuePair<int, int> item2 in item.Value.releaseSkillCount)
			{
				GetSkillDic(item2.Key)["times"] += item2.Value;
			}
			foreach (KeyValuePair<int, EntityStatInfo.SkillStatData> item3 in item.Value.skillDic)
			{
				num3 += (float)item3.Value.damage;
				num7 += (float)item3.Value.tenacity;
				num11 += (float)item3.Value.recover;
				num16 += (float)item3.Value.weaknessLevel2Count;
				num17 += (float)item3.Value.weaknessLevel3Count;
				num5 += item3.Value.weaknessLevel2Damage;
				num4 += item3.Value.weaknessLevel2Damage;
				num4 += item3.Value.weaknessLevel3Damage;
				num9 += item3.Value.weaknessLevel2Tenacity;
				num8 += item3.Value.weaknessLevel2Tenacity;
				num8 += item3.Value.weaknessLevel3Tenacity;
				num6 += item3.Value.knockDownDamage;
				num6 += item3.Value.bossDownDamage;
				num10 += item3.Value.knockDownTenacity;
				num10 += item3.Value.bossDownTenacity;
				num20 += (float)item3.Value.siteLevel2Count;
				num19 += (float)item3.Value.siteLevel3Count;
				Dictionary<string, float> dictionary2 = GetSkillDic(item3.Key);
				dictionary2["damage"] += item3.Value.damage;
				dictionary2["tenacy"] += item3.Value.tenacity;
				dictionary2["heal"] += item3.Value.recover;
				dictionary2["break2"] += item3.Value.weaknessLevel2Count;
				dictionary2["break3"] += item3.Value.weaknessLevel3Count;
				dictionary2["b_hit"] += item3.Value.siteLevel2Count;
				dictionary2["hb_hit"] += item3.Value.siteLevel3Count;
			}
			foreach (KeyValuePair<WeaponStatEnum, object> item4 in item.Value.weaponData.weaponDataDic)
			{
				if (item4.Key == WeaponStatEnum.SwordLayer)
				{
					num21 += (float)item4.Value;
				}
				else if (item4.Key == WeaponStatEnum.SwordKeennessTime)
				{
					num22 += (float)item4.Value;
				}
				else if (item4.Key == WeaponStatEnum.Anger)
				{
					num23 += (float)item4.Value;
				}
				else if (item4.Key == WeaponStatEnum.AngerByFight)
				{
					num24 += (float)item4.Value;
				}
				else if (item4.Key == WeaponStatEnum.Fight)
				{
					num25 += (float)item4.Value;
				}
				else if (item4.Key == WeaponStatEnum.Bullet)
				{
					List<WeaponGunBulletData> list = item4.Value as List<WeaponGunBulletData>;
					num26 += (float)list.Count;
					foreach (WeaponGunBulletData item5 in list)
					{
						if (item5.BulletType == WeaponGunBulletType.Normal)
						{
							num27++;
						}
						else
						{
							num28++;
						}
					}
				}
				else if (item4.Key == WeaponStatEnum.HeroHeat)
				{
					num29 += (float)item4.Value;
				}
				else if (item4.Key == WeaponStatEnum.Awaken)
				{
					num30 += (float)item4.Value;
				}
				else if (item4.Key == WeaponStatEnum.AwakenTime)
				{
					num31 += (float)item4.Value;
				}
				else if (item4.Key == WeaponStatEnum.Cast)
				{
					num32 += (float)item4.Value;
				}
			}
			foreach (KeyValuePair<int, int> item6 in item.Value.heroData.skillHitDic)
			{
				num12 += (float)item6.Value;
			}
			foreach (KeyValuePair<int, int> item7 in item.Value.heroData.skillHitDamage)
			{
				num13 += (float)item7.Value;
			}
			foreach (KeyValuePair<int, int> item8 in item.Value.heroData.weaknessSpeicalHitDic)
			{
				if (item8.Key == 2)
				{
					num16 += (float)item8.Value;
					num14 += (float)item8.Value;
				}
				else if (item8.Key == 3)
				{
					num17 += (float)item8.Value;
					num14 += (float)item8.Value;
				}
			}
			foreach (KeyValuePair<int, int> item9 in item.Value.heroData.siteHitDic)
			{
				num18 += (float)item9.Value;
			}
			foreach (KeyValuePair<MonsterPhaseEnum, int> item10 in item.Value.heroData.monsterPhaseDamageDic)
			{
				if (item10.Key == MonsterPhaseEnum.Break)
				{
					num6 += (float)item10.Value;
				}
			}
			foreach (KeyValuePair<MonsterPhaseEnum, int> item11 in item.Value.heroData.monsterPhaseTenacityDic)
			{
				if (item11.Key == MonsterPhaseEnum.Break)
				{
					num10 += (float)item11.Value;
				}
			}
			num15 = globalStatInfo.weaknessShowCount;
			num += (float)item.Value.heroData.interactiveUseCount;
			num2 += (float)item.Value.heroData.interactiveBreakCount;
		}
		foreach (Dictionary<string, float> value2 in skill_detaill.Values)
		{
			if (num3 != 0f)
			{
				value2["damage"] /= num3;
			}
			if (num7 != 0f)
			{
				value2["tenacy"] /= num7;
			}
			if (num11 != 0f)
			{
				value2["heal"] /= num11;
			}
		}
		dictionary.Add("revive_use_time", num);
		dictionary.Add("revive_disturb_time", num2);
		dictionary.Add("total_damage", num3);
		dictionary.Add("damage_over2", num4);
		dictionary.Add("damage2", num5);
		dictionary.Add("damage_control", num6);
		dictionary.Add("total_tenacy_reduce", num7);
		dictionary.Add("tenacy_reduce_over2", num8);
		dictionary.Add("tenacy_reduce2", num9);
		dictionary.Add("tenacy_reduce_control", num10);
		dictionary.Add("total_heal", num11);
		dictionary.Add("total_hit", num12);
		dictionary.Add("total_behitdamage", num13);
		dictionary.Add("total_break_times", num14);
		dictionary.Add("total_break_appear_times", num15);
		dictionary.Add("break2_times", num16);
		dictionary.Add("break3_times", num17);
		dictionary.Add("total_weak_times", num18);
		dictionary.Add("total_hb_hit", num19);
		dictionary.Add("total_b_bit", num20);
		dictionary.Add("blade_amount", num21);
		dictionary.Add("blade_time_length", num22);
		dictionary.Add("rage_amount", num23);
		dictionary.Add("rage_convert_times", num24);
		dictionary.Add("courage_amount", num25);
		dictionary.Add("bullet_num", num26);
		dictionary.Add("common_bullet_num", num27);
		dictionary.Add("special_bullet_num", num28);
		dictionary.Add("sprit_amount", num29);
		dictionary.Add("awake_amount", num30);
		dictionary.Add("awake_time_length", num31);
		dictionary.Add("empower_amount", num32);
		battleRecordPointInfo.recordPointDic = dictionary;
		battleRecordPointInfo.skill_detaill = skill_detaill;
		return battleRecordPointInfo;
		Dictionary<string, float> GetSkillDic(int skillId)
		{
			if (!skill_detaill.TryGetValue(skillId, out var value))
			{
				value = new Dictionary<string, float>
				{
					{ "id", skillId },
					{ "times", 0f },
					{ "damage", 0f },
					{ "tenacy", 0f },
					{ "heal", 0f },
					{ "break2", 0f },
					{ "break3", 0f },
					{ "b_hit", 0f },
					{ "hb_hit", 0f }
				};
				skill_detaill.Add(skillId, value);
			}
			return value;
		}
	}

	public int GetKilledMonsterId()
	{
		if (globalStatInfo == null || globalStatInfo.killHeroEntityInfoList.IsNullOrEmpty())
		{
			return 0;
		}
		return globalStatInfo.killHeroEntityInfoList[globalStatInfo.killHeroEntityInfoList.Count - 1].entityConfigId;
	}

	public void HeroTeamInvincible()
	{
		List<HeroEntity> list = GetSystem<EntitySystem>()?.GetTeamHero();
		if (list == null)
		{
			return;
		}
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i] != null && list[i].IsSurvival)
			{
				list[i].GetComponent<StateComponent>()?.AddImmuneBuff(3);
			}
		}
	}

	public void MonsterInvincible()
	{
		if (_monsterEntity != null && _monsterEntity.IsSurvival)
		{
			_monsterEntity.GetComponent<StateComponent>()?.AddImmuneBuff(3);
		}
	}

	public void SetAIToActor(int entityId, bool isForce)
	{
		if (GetSystem<EntitySystem>().GetEntity(entityId) is HeroEntity heroEntity)
		{
			SetAIToActor(heroEntity.BattleHeroData, isForce);
		}
	}

	private void SetAIToActor(BattleHeroData battleHeroData, bool isForce)
	{
		if (!IsShieldChange || isForce)
		{
			HeroEntity obj = (HeroEntity)GetSystem<EntitySystem>().GetEntity(world.ActorId);
			obj.SetAi(memberIsAi: true);
			HeroEntity heroEntity = (HeroEntity)battleHeroData.Entity;
			heroEntity.SetAi(memberIsAi: false);
			world.SetActorId(heroEntity);
			obj.BattleHeroData.SetSelf();
			heroEntity.BattleHeroData.SetSelf();
		}
	}

	public void SetHeroData(int index, HeroEntity newHero)
	{
		if (newHero != null && newHero.BattleHeroData != null)
		{
			viewModel.SetHeroData(index, newHero.BattleHeroData);
			HeroRegisterTeam(newHero);
			InitEntityStat(newHero.Id);
		}
		else
		{
			viewModel.SetHeroData(index, null);
		}
		if (newHero != null && newHero.IsActorEntity && _battleWindow != null)
		{
			_battleWindow.SetBattleCameraEnergyFollowRoot(GetSystem<CameraSystem>().BattleCamera, newHero.GetComponent<EntityBoneComponent>().GetBoneRoot("EnergyBar"), newHero.Config.EneryUIOffset.ToVector2());
		}
	}

	public void UpdateTeamMateOnlineState(int entityId, bool isOffline)
	{
		BaseEntity entity = GetSystem<EntitySystem>().GetEntity(entityId);
		if (entity != null)
		{
			entity.EntityViewModel.IsOffLine = isOffline;
		}
	}

	public List<EntityPositionData> GetEntityPositionDatas()
	{
		List<EntityPositionData> list = new List<EntityPositionData>();
		List<HeroEntity> teamHero = GetSystem<EntitySystem>().GetTeamHero();
		for (int i = 0; i < 3; i++)
		{
			if (i < teamHero.Count)
			{
				HeroEntity heroEntity = teamHero[i];
				list.Add(EntityPositionData.Create(heroEntity.transform.position, Vector3.zero, Vector3.one));
			}
			else if (teamHero.Count > 0)
			{
				list.Add(EntityPositionData.Create(teamHero[0].transform.position, Vector3.zero, Vector3.one));
			}
			else
			{
				list.Add(EntityPositionData.Create(Vector3.zero, Vector3.zero, Vector3.one));
			}
		}
		return list;
	}

	public List<EntityPositionData> GetEntityPositionDatas(int count)
	{
		List<EntityPositionData> list = new List<EntityPositionData>(count);
		List<HeroEntity> teamHero = GetSystem<EntitySystem>().GetTeamHero();
		if (count <= teamHero.Count)
		{
			for (int i = 0; i < teamHero.Count; i++)
			{
				HeroEntity heroEntity = teamHero[i];
				list.Add(EntityPositionData.Create(heroEntity.transform.position, Vector3.zero, Vector3.one));
			}
		}
		else
		{
			string lastActiveBornPointKey = GetSystem<SceneSystem>().GetLevelMapData().lastActiveBornPointKey;
			for (int j = 0; j < count; j++)
			{
				ScenePoint heroBornPoint = GetSystem<SceneSystem>().GetHeroBornPoint(lastActiveBornPointKey, j);
				_ = heroBornPoint == null;
				EntityPositionData item = EntityPositionData.Create(heroBornPoint.transform.position, (heroBornPoint == null) ? Vector3.zero : heroBornPoint.transform.eulerAngles, Vector3.one);
				list.Add(item);
			}
		}
		return list;
	}

	private async UniTask<HeroEntity> CreateHero(PeripheryHeroData peripheryHeroData, EntityPositionData entityPositionDatas, DRHero drHero)
	{
		GameObject entityObject = await GetSystem<EntityViewCacheSystem>().AsyncLoadEntityView(peripheryHeroData.Id, world.GetSkinAssetPath(peripheryHeroData, drHero));
		await GetSystem<ParadoxSystem>().PreLoadParadoxGraph(drHero.AIParadoxId);
		return GetSystem<EntitySystem>().CreateEntity<HeroEntity>(peripheryHeroData.Id, new EntityData
		{
			pointData = entityPositionDatas,
			entityObject = entityObject,
			updateType = EntityUpdateType.Local,
			logicType = EntityLogicType.None,
			collisionLayer = CollisionSetting.CollisionLayer.Hero,
			collisionMass = 2,
			userData = peripheryHeroData
		});
	}

	public async UniTask SwitchTeam(List<PeripheryHeroData> heroConfigIdList, bool useBornFire, bool changeOriginTeam)
	{
		_ = _battleMode;
		if (heroConfigIdList.Count == 0)
		{
			return;
		}
		List<EntityPositionData> entityPositionDatas = (useBornFire ? GetEntityPositionDatas(heroConfigIdList.Count) : GetEntityPositionDatas());
		GetSystem<SceneSystem>().SwitchTeamClearData(changeOriginTeam);
		GetSystem<SceneSystem>().SwitchTeamVirCameraFollowNull();
		List<HeroEntity> teamHero = GetSystem<EntitySystem>().GetTeamHero();
		for (int i = 0; i < teamHero.Count; i++)
		{
			teamHero[i].DoEntityDead(isRelease: true, isNormalDead: false);
			if (heroConfigIdList.Count <= i)
			{
				GetSystem<BattleSystem>().SetHeroData(1 + i, null);
			}
		}
		GetSystem<EntitySystem>()?.ClearTeam();
		for (int j = 0; j < heroConfigIdList.Count; j++)
		{
			PeripheryHeroData peripheryHeroData = heroConfigIdList[j];
			DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(peripheryHeroData.Id);
			await LoadEntity(peripheryHeroData, j, entityPositionDatas[j], dataRow, changeOriginTeam);
		}
		GetSystem<BattleSystem>().InitHeroComplete();
		await UniTask.WaitUntil(() => !GetSystem<VirtualCameraSystem>().IsBlendState());
	}

	private async UniTask LoadEntity(PeripheryHeroData heroModel, int i, EntityPositionData posData, DRHero heroConfig, bool changeOriginTeam)
	{
		if (heroConfig == null)
		{
			return;
		}
		await UniTask.Delay(100);
		HeroEntity heroEntity = await CreateHero(heroModel, posData, heroConfig);
		if (i == 0)
		{
			world.SetActorId(heroEntity);
			GetSystem<SceneSystem>().SwitchTeamVirCameraFollowSet(heroEntity.GetEntityObject().transform);
			GetSystem<VirtualCameraSystem>().SwitchBingTargetEntity(heroEntity);
			int skinId = 0;
			if (heroModel.IsSkin)
			{
				skinId = heroModel.SkinConfigId;
			}
			GetSystem<SkillIndicatorSystem>().ChangeEntityLoadIndicators(heroModel.Id, skinId);
		}
		heroEntity.SetAi(i != 0);
		heroEntity.BattleHeroData.IsSelf = i == 0;
		GetSystem<BattleSystem>().SetHeroData(1 + i, heroEntity);
		GetSystem<SceneSystem>().SwitchTeamAddData(heroEntity, changeOriginTeam);
	}

	public async UniTask SwitchTeam(List<int> heroConfigIdList, bool useBornFire, bool changeOriginTeam)
	{
		_ = _battleMode;
		if (heroConfigIdList.Count == 0)
		{
			return;
		}
		List<EntityPositionData> entityPositionDatas = (useBornFire ? GetEntityPositionDatas(heroConfigIdList.Count) : GetEntityPositionDatas());
		GetSystem<SceneSystem>().SwitchTeamClearData(changeOriginTeam);
		GetSystem<SceneSystem>().SwitchTeamVirCameraFollowNull();
		GetSystem<VirtualCameraSystem>().SwitchBingTargetEntity(null);
		List<HeroEntity> teamHero = GetSystem<EntitySystem>().GetTeamHero();
		for (int i = 0; i < teamHero.Count; i++)
		{
			teamHero[i].DoEntityDead(isRelease: true, isNormalDead: false);
			if (heroConfigIdList.Count <= i)
			{
				GetSystem<BattleSystem>().SetHeroData(1 + i, null);
			}
		}
		teamHero.Clear();
		ObserverChangeTeamParams param = ReferencePool.Acquire<ObserverChangeTeamParams>();
		GetSystem<BattleObserverSystem>().Notify(BattleObserverEventEnum.ChangeTeam, param);
		for (int j = 0; j < heroConfigIdList.Count; j++)
		{
			PeripheryHeroData peripheryHeroData = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroConfigIdList[j], emptyCreateNew: true, saveNew: false).GetPeripheryHeroData(0L);
			DRHero dataRow = GameEntry.DataTable.GetDataRow<DRHero>(peripheryHeroData.Id);
			await LoadEntity(peripheryHeroData, j, entityPositionDatas[j], dataRow, changeOriginTeam);
		}
		GetSystem<BattleSystem>().InitHeroComplete();
		await UniTask.WaitUntil(() => !GetSystem<VirtualCameraSystem>().IsBlendState());
		await UniTask.WaitForEndOfFrame();
	}

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_battleMode = world.BattleWorldMode;
		_sceneSystem = GetSystem<SceneSystem>();
	}

	public override async UniTask<bool> OnEnter(object data = null)
	{
		viewModel = new BattleViewModel(world.BattleConfig.BattleTime, enterCavernId, world.BattleWorldMode);
		viewModel.AddQuitGame(QuitGame, SetResetAutoFightTimer, ShowBattleTipsWindow);
		viewModel.AddLoadOtherWorld(LoadOtherWorld);
		AddTimeOver(TimeOver, ClickAutoFightBtn);
		_battleWindow = await GameEntry.UI.LoadWindow<BattleWindow>(AssetUtility.GetUIFormAsset("Battle/BattleWindow"), "DEFAULT", viewModel);
		OnEnterSpecialMode(data);
		viewModel.AddWorldModeParam(specialModeEnum, isOpenBattleDS);
		return true;
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		CreateCopyData mapData = world.GetMapData();
		if (mapData != null && mapData.IsMonsterMapData())
		{
			viewModel?.AddMonsterCopyView();
		}
		if (_battleWindow != null)
		{
			_battleWindow.BingChildUI();
			_battleWindow.Show();
		}
		globalBattleTime = 0f;
		InitBattleAction();
		InitMapData();
		SetIsGuideLevel();
		SetSystemShowInfo();
		OnInitBattleGM();
	}

	private void InitBattleAction()
	{
		if (viewModel != null)
		{
			viewModel.AddProcessOperation(OnProcessOperation);
			viewModel.AddTeleportAction(OnTeleport);
			viewModel.AddRevertAction(OnRevert);
			viewModel.AddBattleStatGMAction(OnBattleGMAction);
			viewModel.AddHeroChange(SetAIToActor);
			viewModel.AddReleaseSkill4(ReleaseHeroSkill4);
			viewModel.AddTeachEnergyGuide(ObserverTeachEnergyGuide);
			viewModel.AddTeachAIXpEnergyGuide(ObserverTeachAIXpGuide);
		}
	}

	public override void OnUpdate(float deltaTime)
	{
		base.OnUpdate(deltaTime);
		viewModel?.OnUpdate(deltaTime, world.GameMs);
		viewModel?.SystemInfoViewModel?.SetBattlePing(world.GameMs);
		UpdateNPCPos();
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		viewModel?.OnFixedUpdate(updateType, deltaTime);
		OnTimeElapse(deltaTime);
		OnGMActionFixedUpdate(deltaTime);
		OnFixedUpdateSpecialMode(deltaTime);
	}

	public override void OnFixedUpdateAfter(WorldUpdateType updateType)
	{
		base.OnFixedUpdateAfter(updateType);
		UpdateTaotiePos();
	}

	public async Task<bool> GameSettlement(GameSettlementType gameSettlementType)
	{
		OnGameSettlementStat();
		float bossHpLeft = -1f;
		if (gameSettlementType != GameSettlementType.MonsterDead && gameSettlementType != GameSettlementType.GoldLevelOver && viewModel != null)
		{
			bossHpLeft = viewModel.GetBossHpLeft(gameSettlementType);
		}
		await SendAchievement2Server();
		int mode = ((gameSettlementType != GameSettlementType.PlayerQuit) ? 1 : 2);
		return await (viewModel?.GameOver(TeamKillNumber, bossHpLeft, mode, KillMonsterNumber, GetActorEntityDamage(), actorKillCount, gameScore));
	}

	private async Task<bool> SendAchievement2Server()
	{
		List<Achievement> list = new List<Achievement>();
		foreach (AchievementProcessor value in GetSystem<AchievementSystem>().AchievementActionDataDic.Values)
		{
			foreach (Achievement item in value.GetAchievementAccomplishProgress())
			{
				list.Add(item);
			}
		}
		return await Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().SendBattleAchievement(list);
	}

	public void GoldGameSettlement()
	{
		world.GameSettlement(GameSettlementType.GoldLevelOver);
	}

	private void QuitGame()
	{
		world.GameSettlement(GameSettlementType.PlayerQuit);
	}

	private void LoadOtherWorld(LoadingToOtherLevelViewModel loadingToOtherLevelViewModel)
	{
		world.LoadOtherWorld(loadingToOtherLevelViewModel);
	}

	private void TimeOver()
	{
		world.GameSettlement(GameSettlementType.TimeOver);
	}

	public override void OnDispose()
	{
		base.OnDispose();
		_monsterEntity = null;
		if (viewModel != null)
		{
			viewModel.Close();
			viewModel = null;
			_battleWindow = null;
		}
		foreach (EntityStatInfo value in entityStatInfoDic.Values)
		{
			ReferencePool.Release(value);
		}
		entityStatInfoDic.Clear();
		entityStatInfoDic = null;
		ClearStat();
		BattleProgressLog.Clear();
		BattleProgressPropertyMonitor.Clear();
	}

	public bool OnProcessOperation(ProcessOperationEnum operationType)
	{
		switch (operationType)
		{
		case ProcessOperationEnum.GamePause:
			if (BattleMode != BattleWorldMode.SyncBattle)
			{
				world.GamePause();
			}
			return true;
		case ProcessOperationEnum.GameResume:
			world?.GameResume();
			return true;
		case ProcessOperationEnum.GameOver:
			world.GameOver();
			return true;
		default:
			return false;
		}
	}

	public async void OnTeleport(string bornPointKey, Action callback)
	{
		BlackScreen blackScreen = await BlackScreen.Show();
		await UniTask.WaitForSeconds(1);
		callback?.Invoke();
		await _sceneSystem.Teleport(bornPointKey);
		_sceneSystem.TeleportIsExitCaves();
		_sceneSystem.ResetMovingPlatform();
		await UniTask.WaitForEndOfFrame();
		await UniTask.WaitUntil(() => !GetSystem<VirtualCameraSystem>().IsBlendState());
		GetSystem<VirtualCameraSystem>().RestBlendTime();
		blackScreen?.Dispose();
		_sceneSystem.ForceRefrshRoomArea();
	}

	private void OnRevert()
	{
		if (enterCavernId != 0)
		{
			_sceneSystem.LeaveCaves();
		}
	}

	public void SetIsInCaves(int cavernId)
	{
		enterCavernId = cavernId;
		viewModel?.SetCavernId(cavernId);
	}

	public bool GetIsInCaves()
	{
		return enterCavernId != 0;
	}

	public void SetGameScore(long score)
	{
		gameScore = score;
	}

	public void AddTimeOver(Action timeover, Action<bool> clickAutoFight)
	{
		if (viewModel != null)
		{
			_ = viewModel.SystemInfoViewModel;
		}
		viewModel?.SystemInfoViewModel?.AddAction(null, timeover, clickAutoFight);
	}

	private async void OnTimeOver()
	{
		if (world.IsStoryWorld)
		{
			OnLevelFailed(entityDead: false);
		}
		else
		{
			viewModel.GameOver(TeamKillNumber, viewModel.GetBossHpLeft(GameSettlementType.TimeOver), 1, KillMonsterNumber, GetActorEntityDamage(), actorKillCount, gameScore);
		}
	}

	public async void OnLevelFailed(bool entityDead)
	{
		await ShowLevelFailWindow();
		if (entityDead)
		{
			_sceneSystem.GetLevelMapData()?.ForceBattleEnd(GetKillHeroEntityInfoList());
		}
		if (levelBossMode && _battleMode != BattleWorldMode.LevelBattle)
		{
			viewModel.GameOver(TeamKillNumber, viewModel.GetBossHpLeft(GameSettlementType.HeroDead), 1, KillMonsterNumber, GetActorEntityDamage(), actorKillCount, gameScore);
			SetBossMode(bossModel: false);
		}
		await _sceneSystem.RevertLevel(rebornHero: true, teleport: true, null, blackOpen: true, isResetTeam: true, forceEnterRoom: true);
		SetBpDataMax();
		ClearStat();
	}

	public async UniTask ShowLevelFailWindow()
	{
		LevelFailViewModel userData = new LevelFailViewModel();
		LevelFailWindow levelFailWindow = await GameEntry.UI.LoadWindow<LevelFailWindow>("Level/LevelFailWindow", userData);
		if (levelFailWindow == null)
		{
			return;
		}
		await levelFailWindow.DoShow();
		world.GamePause(transition: true);
		await UniTask.WaitForSeconds(1.5f);
		if (!(levelFailWindow == null))
		{
			await levelFailWindow.DoHide();
			levelFailWindow.Dismiss();
			Singleton<AudioSystem>.Instance.StopCurBgm((STOP_MODE)0, clearCache: true);
			world.GameResume();
			await UniTask.WaitUntil(() => levelFailWindow.Dismissed);
		}
	}

	public void SetLockMiniMap(bool lockMiniMap)
	{
		viewModel?.SetLockMiniMap(lockMiniMap);
	}

	public void SetMiniMapVisible(bool visible)
	{
		viewModel?.SetMiniMapVisible(visible);
	}

	public void InitMapData()
	{
		MapConfigData mapConfigData = null;
		if (_sceneSystem.GetCavesId() > 0)
		{
			DRCavern dataRow = GameEntry.DataTable.GetDataRow<DRCavern>(_sceneSystem.GetCavesId());
			mapConfigData = ((dataRow == null) ? null : new MapConfigData(dataRow));
		}
		else if (_sceneSystem.GetLevelId() > 0)
		{
			DRMap dataRow2 = GameEntry.DataTable.GetDataRow<DRMap>(_sceneSystem.GetLevelId());
			mapConfigData = ((dataRow2 == null) ? null : new MapConfigData(dataRow2));
		}
		viewModel?.InitMapData(mapConfigData, _sceneSystem.GetIsInTeachGuideLevel());
	}

	public void SetMiniMapData(MapConfigData mapConfigData)
	{
		viewModel?.SetMiniMapData(mapConfigData);
	}

	public void OpenBonfireMenu(Action<bool> menuResult)
	{
		int levelId = _sceneSystem.GetLevelId();
		int selfHeroId = 0;
		List<PeripheryHeroData> list = new List<PeripheryHeroData>();
		List<HeroEntity> playerTeamList = GetSystem<EntitySystem>().PlayerTeamList;
		if (playerTeamList != null)
		{
			foreach (HeroEntity item in playerTeamList)
			{
				if (!item.IsAi)
				{
					selfHeroId = item.GetHeroConfigId();
				}
				list.Add(item.BattleHeroData.HeroModel);
			}
		}
		viewModel?.OpenBonfireMenuWindow(levelId, selfHeroId, list, delegate(BonfireRestViewModel restVm)
		{
			menuResult?.Invoke(restVm != null);
			if (restVm != null)
			{
				List<int> list2 = null;
				if (restVm.SelectIndex != 3)
				{
					if (restVm.HeroConfigIdList != null)
					{
						list2 = new List<int>(3);
						foreach (PeripheryHeroData heroConfigId in restVm.HeroConfigIdList)
						{
							list2.Add(heroConfigId.Id);
						}
					}
					_sceneSystem.TransPointInteract(restVm.SelectIndex, list2);
				}
				if (restVm.HeroConfigIdList != null)
				{
					SwitchTeamAndRestInLevel(restVm.HeroConfigIdList, restVm.Ready2Close);
				}
				else
				{
					RestInLevel(restVm.Ready2Close, isResetTeam: true);
				}
			}
			GetSystem<TouchSystem>().ShowTouchInput(isShow: true);
		});
		GetSystem<TouchSystem>().ShowTouchInput(isShow: false);
	}

	private async void SwitchTeamAndRestInLevel(List<PeripheryHeroData> heroConfigIdList, Action callback)
	{
		Dictionary<int, List<float>> teamKeepPropertys = SwitchTeamBeforeGetProperty();
		await SwitchTeam(heroConfigIdList, useBornFire: true, changeOriginTeam: true);
		SwitchTeamAfterSetProperty(teamKeepPropertys);
		await Task.Delay(100);
		SetBpDataMax();
		callback?.Invoke();
	}

	private Dictionary<int, List<float>> SwitchTeamBeforeGetProperty()
	{
		List<HeroEntity> playerTeamList = GetSystem<EntitySystem>().PlayerTeamList;
		List<string> switchTeamProertyConfig = _sceneSystem.GetSwitchTeamProertyConfig();
		if (switchTeamProertyConfig == null || switchTeamProertyConfig.Count == 0)
		{
			return null;
		}
		Dictionary<int, List<float>> dictionary = new Dictionary<int, List<float>>(playerTeamList.Count);
		for (int i = 0; i < playerTeamList.Count; i++)
		{
			List<float> list = new List<float>(switchTeamProertyConfig.Count);
			for (int j = 0; j < switchTeamProertyConfig.Count; j++)
			{
				float propertyCur = playerTeamList[i].GetPropertyCur(switchTeamProertyConfig[j]);
				list.Add(propertyCur);
			}
			dictionary.Add(playerTeamList[i].EntityId, list);
		}
		return dictionary;
	}

	private void SwitchTeamAfterSetProperty(Dictionary<int, List<float>> teamKeepPropertys)
	{
		if (teamKeepPropertys == null)
		{
			return;
		}
		List<HeroEntity> playerTeamList = GetSystem<EntitySystem>().PlayerTeamList;
		List<string> switchTeamProertyConfig = _sceneSystem.GetSwitchTeamProertyConfig();
		for (int i = 0; i < playerTeamList.Count; i++)
		{
			if (teamKeepPropertys.TryGetValue(playerTeamList[i].EntityId, out var value))
			{
				for (int j = 0; j < switchTeamProertyConfig.Count; j++)
				{
					playerTeamList[i].SetProperty(switchTeamProertyConfig[j], value[j]);
				}
			}
		}
	}

	private async void RestInLevel(Action callback, bool isResetTeam)
	{
		await _sceneSystem.RevertLevel(rebornHero: true, teleport: false, null, blackOpen: false, isResetTeam, forceEnterRoom: true);
		SetBpDataMax();
		callback?.Invoke();
	}

	private void SetBpDataMax()
	{
		List<HeroEntity> playerTeamList = GetSystem<EntitySystem>().PlayerTeamList;
		if (playerTeamList == null)
		{
			return;
		}
		foreach (HeroEntity item in playerTeamList)
		{
			item?.BattleHeroData?.SetBpDataMax();
			item?.GetComponent<SkillComponent>()?.ResetPropSkillNumber();
		}
	}

	public void OpenShopWindow(int tabIndex = 0, int subTabIndex = 0)
	{
		viewModel?.OpenShopWindow(tabIndex, subTabIndex);
	}

	public void UpdateBossBloodBarData(BattleMonsterData data)
	{
		if (viewModel == null)
		{
			return;
		}
		HeroAttributeEnum heroAttributeEnum = HeroAttributeEnum.Wind;
		List<HeroEntity> playerTeamList = GetSystem<EntitySystem>().PlayerTeamList;
		for (int i = 0; i < playerTeamList.Count; i++)
		{
			if (playerTeamList[i].Id == world.ActorId)
			{
				if (playerTeamList[i].BattleHeroData != null && playerTeamList[i].BattleHeroData.HeroModel != null)
				{
					heroAttributeEnum = playerTeamList[i].BattleHeroData.Attribute;
				}
				break;
			}
		}
		viewModel?.UpdateBossBloodBarData(data, heroAttributeEnum);
	}

	public void ChangeBossStage(MonsterPhaseEnum stage)
	{
		if (viewModel != null && viewModel.BossInfoViewModel != null)
		{
			viewModel.BossInfoViewModel.ChangeBossStage(stage);
		}
	}

	public void GetBossBreakPercent(float per)
	{
		if (viewModel != null && viewModel.BossInfoViewModel != null)
		{
			viewModel.BossInfoViewModel.GetBossBreakPercent(per);
		}
	}

	public void SetBossDownFillMax(float downFill)
	{
		if (viewModel != null && viewModel.BossInfoViewModel != null)
		{
			viewModel.BossInfoViewModel.SetBossDownFillMax(downFill);
		}
	}

	public void ShowBossBarWindow(bool isShow)
	{
		if (viewModel != null && viewModel.BossInfoViewModel != null)
		{
			viewModel.SetBossShowUp(isShow);
		}
	}

	public void SetBossMode(bool bossModel)
	{
		if (viewModel != null)
		{
			levelBossMode = bossModel;
			if (!bossModel)
			{
				viewModel.SetBossShowUp(showUp: false);
				viewModel.StopBattleTime();
			}
			else
			{
				_ = viewModel.BossInfoViewModel;
				viewModel.SetBossShowUp(showUp: true);
			}
		}
	}

	public void SetMonsterCopyFinish()
	{
		if (_monsterEntity != null)
		{
			_monsterEntity.GetComponent<AIParadoxComponent>()?.SetVariableValues("e_successorTask", paramValue: true);
		}
	}

	public void RefreshMonsterCopyData(string content, string killCount)
	{
		if (viewModel != null)
		{
			viewModel.RefreshMonsterCopyData(content, killCount);
		}
	}

	public void HideTaotieEatUI()
	{
		viewModel?.HideTaotieEatUI();
		taoTieBoneTrans = null;
	}

	public void ShowTaotieEatUI(List<HeroEntity> heroEntities, Transform taoTieBone)
	{
		if (!(taoTieBone == null))
		{
			taoTieBoneTrans = taoTieBone;
			viewModel?.ShowTaotieEatUI(heroEntities);
			taoTieHeadPos = UIUtilly.ScenePosToScreenPos(world.GetSystem<CameraSystem>()?.BattleCamera, taoTieBoneTrans.position);
		}
	}

	private void UpdateTaotiePos()
	{
		if (viewModel != null && !(taoTieBoneTrans == null))
		{
			Vector3 b = UIUtilly.ScenePosToScreenPos(world.GetSystem<CameraSystem>()?.BattleCamera, taoTieBoneTrans.position);
			taoTieHeadPos = Vector3.Lerp(taoTieHeadPos, b, taoTieHeadLerpSpeed * Time.deltaTime);
			viewModel.UpdateTaotiePos(taoTieHeadPos);
		}
	}

	public void InitHeroData(int index, HeroEntity heroEntity, int teamRebornNumber)
	{
		if (viewModel != null)
		{
			viewModel.InitHeroData(index, heroEntity.BattleHeroData);
			HeroRegisterTeam(heroEntity);
			InitEntityStat(heroEntity.Id);
			if (heroEntity.IsActorEntity && _battleWindow != null)
			{
				_battleWindow.SetBattleCameraEnergyFollowRoot(GetSystem<CameraSystem>().BattleCamera, heroEntity.GetComponent<EntityBoneComponent>().GetBoneRoot("EnergyBar"), heroEntity.Config.EneryUIOffset.ToVector2());
			}
			if (!heroEntity.IsActorEntity && !heroEntity.IsAi)
			{
				viewModel.SetHaveRealPeople();
			}
		}
	}

	public MonsterEntity GetMonsterEntity()
	{
		return _monsterEntity;
	}

	public void HeroRegisterTeam(HeroEntity heroEntity)
	{
		if (heroEntity.IsActorEntity)
		{
			viewModel?.UpdateHeroEntities(heroEntity);
			bool streamerMode = StreamerMode.GetStreamerMode();
			string castingPath = heroEntity.GetCastingPath(heroEntity.Config.CastingPath, streamerMode);
			world.GetSystem<ParadoxTimelineSystem>()?.LoadCastingWindow(castingPath);
		}
	}

	public void InitMonsterEntity(MonsterEntity monsterEntity, bool refreshBattleTimeConfig = true)
	{
		_monsterEntity = monsterEntity;
		if (refreshBattleTimeConfig)
		{
			SetBattleTimeConfig(monsterEntity?.MonsterAttrConfig.BattleDuration ?? 360);
		}
	}

	public void InitHeroComplete()
	{
		if (viewModel != null)
		{
			viewModel.UserInfoViewModel.FixHeroData();
			_teamRebornNumber = world.BattleConfig.TeamRebornValue;
			viewModel.AddHeroRebornNumber(world.BattleConfig.TeamRebornValue);
			if (_battleMode != BattleWorldMode.LevelBattle)
			{
				GetSystem<TouchSystem>().OpenBattleSkillDesc(viewModel.UserInfoViewModel.BattleUsers);
			}
			if (_battleMode == BattleWorldMode.SyncBattle && world.IsNeedExecuteViewSystem)
			{
				Dictionary<int, string> playerNames = Singleton<ServiceSystem>.Instance?.GetService<IMultiRoomService>()?.heroNames();
				viewModel.UserInfoViewModel.SetPlayerNames(playerNames);
			}
			viewModel.BattleDSComplete(entityStatInfoDic);
		}
	}

	public void InitMutilHeroComplete()
	{
		if (viewModel != null)
		{
			viewModel.UserInfoViewModel.FixHeroData();
			_teamRebornNumber = world.BattleConfig.TeamRebornValue;
			viewModel.AddHeroRebornNumber(world.BattleConfig.TeamRebornValue);
			if (_battleMode != BattleWorldMode.LevelBattle)
			{
				GetSystem<TouchSystem>().OpenBattleSkillDesc(viewModel.UserInfoViewModel.BattleUsers);
			}
			viewModel.BattleDSComplete(entityStatInfoDic);
		}
	}

	public void UpdateTeamKillNumber()
	{
		_teamKillNumber++;
	}

	public void ReleaseHeroSkill4(int entityId)
	{
		EntitySystem system = GetSystem<EntitySystem>();
		if (system != null && system.GetEntity(entityId) != null)
		{
			GetSystem<CommandSystem>()?.CollectAiSkill(entityId, "AiButtonReleaseSkill", 1);
		}
	}

	public void ObserverTeachEnergyGuide()
	{
		ObserverTeachGuideParams observerTeachGuideParams = ReferencePool.Acquire<ObserverTeachGuideParams>();
		observerTeachGuideParams.Init(null, null);
		GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.TeachEnergy, observerTeachGuideParams);
		ReferencePool.Release(observerTeachGuideParams);
	}

	public void ObserverTeachAIXpGuide(Transform frameTrans)
	{
		if (teachAIXp)
		{
			teachAIXp = false;
			ObserverTeachGuideParams observerTeachGuideParams = ReferencePool.Acquire<ObserverTeachGuideParams>();
			observerTeachGuideParams.Init(null, frameTrans);
			GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.TeachAIXpEnergy, observerTeachGuideParams);
			ReferencePool.Release(observerTeachGuideParams);
		}
	}

	public void ControlView(bool isShow, bool xpCastingWindow = false, bool touchInputMaskState = false)
	{
		if (viewModel != null)
		{
			GetSystem<TouchSystem>().ShowTouchInput(isShow, xpCastingWindow, touchInputMaskState);
			viewModel.HidePanel(isShow, xpCastingWindow);
		}
	}

	public void RefreshUserLayout(TouchLayout layout)
	{
		if (!(_battleWindow == null))
		{
			_battleWindow.RefreshUserLayout(layout);
		}
	}

	public void OnSkillDerive(HeroEntity heroEntity, HeroSkillTypeEnum skillType, HeroSkillData deriveSkillData)
	{
	}

	public void ApplyTeamRebornNumber()
	{
		_teamRebornNumber--;
		viewModel?.RefreshUserRebornCount(_teamRebornNumber);
	}

	public bool HeroIsCanReborn()
	{
		if (_teamRebornNumber == 0)
		{
			return false;
		}
		return true;
	}

	public void HideInteractiveView()
	{
		viewModel?.HideInteractiveView();
	}

	public void InitAddTaskTarget()
	{
		if (world.IsStoryWorld && !_sceneSystem.GetIsInTeachGuideLevel())
		{
			bool entityBattleState = GetSystem<BattleStateSystem>().GetEntityBattleState(world.ActorId);
			viewModel?.InitAddTaskTarget(_sceneSystem.GetLevelId(), entityBattleState);
		}
	}

	public void SetTaskTime(int time)
	{
		viewModel?.SetTaskTime(time);
	}

	public void ShowTaskTime(bool isShow)
	{
		viewModel?.ShowTaskTime(isShow);
	}

	public void SetSystemShowInfo()
	{
		CommandSystem system = GetSystem<CommandSystem>();
		viewModel?.SetSystemShowInfo(world.IsStoryWorld && !_sceneSystem.GetIsInTeachGuideLevel(), !world.IsStoryWorld, system.GetAutoFightBtnState());
	}

	private void ClickAutoFightBtn(bool isOpen)
	{
		GetSystem<CommandSystem>()?.SwitchAutoFightToogle(isOpen);
	}

	public void AutoFightTip(AutoFightTipEnum autoFightTipEnum)
	{
		switch (autoFightTipEnum)
		{
		case AutoFightTipEnum.OpenAutoFight:
			ShowBattleTipsWindow(1f, "检测到您长时间未操作，已为您打开自动战斗");
			break;
		case AutoFightTipEnum.InputBreakAutoFight:
			ShowBattleTipsWindow(1f, "检测到按键输入,已关闭自动战斗");
			break;
		case AutoFightTipEnum.FrequentSwitch:
			ShowBattleTipsWindow(1f, "操作频繁，请稍后再试");
			break;
		}
	}

	public void AutoFightBtnStateChange(AutoFightToogleEnum autoFightToogleEnum)
	{
		if (viewModel != null)
		{
			viewModel.SystemInfoViewModel.AutoFightToogleEnum = autoFightToogleEnum;
		}
	}

	public void TaskBtnCanClick(bool lockLick)
	{
		if (viewModel != null)
		{
			viewModel?.TaskBtnCanClick(lockLick);
		}
	}

	public void UpdateNPCPos()
	{
		viewModel?.NpcPopDialogVM?.UpdateAllPos(world.GetSystem<CameraSystem>()?.BattleCamera);
	}

	public void ShowNPCBubble(int npcId, int bubbleId, Vector3 pos)
	{
		viewModel?.NpcPopDialogVM.ShowBubbles(npcId, bubbleId, pos, UIUtilly.ScenePosToScreenPos(world.GetSystem<CameraSystem>()?.BattleCamera, pos));
	}

	public void CloseNPCBubble(int npcId)
	{
		viewModel?.NpcPopDialogVM.CloseBubbles(npcId);
	}

	private void SetIsGuideLevel()
	{
		viewModel?.SetIsGuideLevel(world.IsGuideWorld || _sceneSystem.GetIsInTeachGuideLevel());
	}

	public void ShowBattleTipsWindow(float time, string content)
	{
		if (_battleWindow != null)
		{
			_battleWindow.ShowBattleTipFloatingWindow(time, content);
		}
	}

	public void SetBattleTimeConfig(int time)
	{
		battleTime = time;
		viewModel?.SetBattleTimeConfig(time);
		world.GetSystem<BattleInfoSystem>()?.SetBattleTimeConfig(time);
	}

	public void SetBattleReverseTime(bool reverse)
	{
		viewModel?.SetReverseTime(reverse);
	}

	public void StopBattleTime()
	{
		if (battleTimeSettledExternally)
		{
			battleTimeDelay = false;
		}
		battleTimeSettledExternally = false;
		viewModel?.StopBattleTime(isRefreshTime: false);
		viewModel?.SetTriggerTimeOverOnCountDownEnd(triggerTimeOver: true);
	}

	public void SetBattleTimeDelay(float time)
	{
		if (!battleTimeSettledExternally)
		{
			battleTimeDelay = true;
			battleTimeDelayTime = time + globalBattleTime;
			viewModel?.SetTriggerTimeOverOnCountDownEnd(triggerTimeOver: true);
			viewModel?.StartBattleTime(isStart: false);
		}
	}

	public void SetBattleTimeDelayWithoutTimeOver(float time)
	{
		battleTimeSettledExternally = true;
		battleTimeDelay = true;
		battleTimeDelayTime = time + globalBattleTime;
		viewModel?.SetTriggerTimeOverOnCountDownEnd(triggerTimeOver: false);
		viewModel?.StartBattleTime(isStart: false);
	}

	public int GetCheckPassTime()
	{
		return viewModel?.GetBattleTime() ?? (-1);
	}

	public void SetMonsterBloodDelay(float time)
	{
		monsterBarDelay = true;
		monsterBarDelayTime = time + globalBattleTime;
		viewModel?.ShowBossBar(isShow: false);
	}

	public void SetMonsterNameDelay(float time)
	{
		monsterNameDelay = true;
		monsterNameDelayTime = time + globalBattleTime;
		viewModel?.ShowBossName(isShow: false);
	}

	private void OnTimeElapse(float deltaTime)
	{
		if (viewModel == null)
		{
			return;
		}
		globalBattleTime += deltaTime;
		if (battleTimeDelay && battleTimeDelayTime <= globalBattleTime)
		{
			battleTimeDelay = false;
			viewModel.SetTriggerTimeOverOnCountDownEnd(!battleTimeSettledExternally);
			viewModel.StartBattleTime(isStart: true);
		}
		if (monsterBarDelay && monsterBarDelayTime <= globalBattleTime)
		{
			monsterBarDelay = false;
			viewModel.ShowBossBar(isShow: true);
			SetBossMode(bossModel: true);
			if (teachShowHp)
			{
				teachShowHp = false;
				ObserverTeachGuideParams observerTeachGuideParams = ReferencePool.Acquire<ObserverTeachGuideParams>();
				observerTeachGuideParams.Init(null, null);
				GetSystem<BattleObserverSystem>()?.Notify(BattleObserverEventEnum.TeachBossShowUI, observerTeachGuideParams);
				ReferencePool.Release(observerTeachGuideParams);
			}
		}
		if (monsterNameDelay && monsterNameDelayTime <= globalBattleTime)
		{
			monsterNameDelay = false;
		}
		if (!world.BattleSettlement)
		{
			viewModel.BattleTimeElapse(deltaTime);
		}
	}

	public void OpenTeachShowHp()
	{
		teachShowHp = true;
	}

	public void OpenTeachAIXp()
	{
		teachAIXp = true;
	}

	public override void OnPause()
	{
		base.OnPause();
		viewModel?.SetPause(isPause: true);
	}

	public override void OnResume()
	{
		base.OnResume();
		viewModel?.SetPause(isPause: false);
	}

	public void SetBossDown(bool enterDown, string damageRatio)
	{
		if (viewModel != null)
		{
			viewModel?.SetBossDownState(enterDown, damageRatio);
		}
	}

	public void ActorBattleStateChange(bool battleStateResult)
	{
		viewModel?.ActorBattleStateChange(battleStateResult);
	}

	public void HideSetWindowQuitBtn()
	{
		viewModel?.HideSetWindowQuitBtn();
	}

	private void SetResetAutoFightTimer()
	{
		resetAutoFightTimer = true;
	}

	public bool GetResetAutoFightTimer()
	{
		bool result = resetAutoFightTimer;
		resetAutoFightTimer = false;
		return result;
	}

	public int AddDirUI(string iconName, Vector3 pos)
	{
		return viewModel.AddDirUI(iconName, pos);
	}

	public void RemoveDirUIById(int index)
	{
		viewModel.RemoveDirUIById(index);
	}

	public void RemoveAllDirUI()
	{
		viewModel.RemoveAllDirUI();
	}

	private void OnInitBattleGM()
	{
		gmDic = new Dictionary<BattleGMEnum, BattleGMInfo>
		{
			{
				BattleGMEnum.InfiniteEnergy,
				new BattleGMInfo
				{
					gmEnum = BattleGMEnum.InfiniteEnergy
				}
			},
			{
				BattleGMEnum.InfiniteSp,
				new BattleGMInfo
				{
					gmEnum = BattleGMEnum.InfiniteSp
				}
			},
			{
				BattleGMEnum.AutoWeakness,
				new BattleGMInfo
				{
					gmEnum = BattleGMEnum.AutoWeakness
				}
			},
			{
				BattleGMEnum.AI,
				new BattleGMInfo
				{
					gmEnum = BattleGMEnum.AI,
					isOpen = true
				}
			},
			{
				BattleGMEnum.TeamAI,
				new BattleGMInfo
				{
					gmEnum = BattleGMEnum.TeamAI,
					isOpen = true
				}
			},
			{
				BattleGMEnum.TenacityLevel,
				new BattleGMInfo
				{
					gmEnum = BattleGMEnum.TenacityLevel
				}
			},
			{
				BattleGMEnum.BossDown,
				new BattleGMInfo
				{
					gmEnum = BattleGMEnum.BossDown
				}
			}
		};
		foreach (BattleGMInfo value in gmDic.Values)
		{
			viewModel.UpdateGMState(value.gmEnum, value.isOpen);
		}
	}

	private void OnStartGM()
	{
		OnGM_AI();
		BattleGMInfo battleGMInfo = gmDic[BattleGMEnum.TeamAI];
		EntitySystem system = GetSystem<EntitySystem>();
		battleGMInfo.isInter = system != null && system.PlayerTeamList.Count > 1;
		viewModel.SetGMInteractable(BattleGMEnum.TeamAI, battleGMInfo.isInter);
		OnGM_TeamAI();
	}

	public void OnBattleGMAction(BattleGMEnum gmEnum)
	{
		switch (gmEnum)
		{
		case BattleGMEnum.RefreshCD:
			OnGM_RefreshCD();
			break;
		case BattleGMEnum.InfiniteEnergy:
			OnGM_InfiniteEnergy();
			break;
		case BattleGMEnum.InfiniteSp:
			OnGM_InfiniteSp();
			break;
		case BattleGMEnum.ResetState:
			OnGM_ResetState();
			break;
		case BattleGMEnum.AutoWeakness:
			OnGM_AutoWeakness();
			break;
		case BattleGMEnum.AI:
			OnGM_AI();
			break;
		case BattleGMEnum.ClearData:
			OnGM_ClearData();
			break;
		case BattleGMEnum.AutoClear:
			OnGM_AutoClear();
			break;
		case BattleGMEnum.TeamAI:
			OnGM_TeamAI();
			break;
		case BattleGMEnum.TenacityLevel:
			OnGM_TenacityLevel();
			break;
		case BattleGMEnum.BossDown:
			OnGM_BossDown();
			break;
		}
	}

	private void OnGM_RefreshCD()
	{
		viewModel.SelfEntity.GetComponent<CoolingComponent>().RefreshAllSkillCD();
		viewModel.UpdateGMState(BattleGMEnum.RefreshCD, isOpen: true);
	}

	private void OnGM_InfiniteEnergy()
	{
		BattleGMInfo battleGmInfo = GetBattleGmInfo(BattleGMEnum.InfiniteEnergy);
		if (battleGmInfo == null)
		{
			return;
		}
		List<HeroEntity> playerTeamList = GetSystem<EntitySystem>().PlayerTeamList;
		if (playerTeamList.IsNullOrEmpty())
		{
			return;
		}
		foreach (HeroEntity item in playerTeamList)
		{
			if (!battleGmInfo.isOpen)
			{
				item.GetComponent<CoolingComponent>().OpenEnergyConsume = false;
				item.ChangeProperty("Energy", 2000f);
			}
			else
			{
				item.GetComponent<CoolingComponent>().OpenEnergyConsume = true;
			}
		}
		battleGmInfo.isOpen = !battleGmInfo.isOpen;
		viewModel.UpdateGMState(battleGmInfo.gmEnum, battleGmInfo.isOpen);
	}

	private void OnGM_InfiniteSp()
	{
		BattleGMInfo battleGmInfo = GetBattleGmInfo(BattleGMEnum.InfiniteSp);
		if (battleGmInfo == null)
		{
			return;
		}
		List<HeroEntity> playerTeamList = GetSystem<EntitySystem>().PlayerTeamList;
		if (playerTeamList.IsNullOrEmpty())
		{
			return;
		}
		foreach (HeroEntity item in playerTeamList)
		{
			if (!battleGmInfo.isOpen)
			{
				item.GetComponent<CoolingComponent>().OpenSpRelease = false;
				item.GetPropertyData("XpEnergy")?.ResetValue(toMax: true, isExecuteValueChanged: false);
			}
			else
			{
				item.GetComponent<CoolingComponent>().OpenSpRelease = true;
			}
		}
		battleGmInfo.isOpen = !battleGmInfo.isOpen;
		viewModel.UpdateGMState(battleGmInfo.gmEnum, battleGmInfo.isOpen);
	}

	private void OnGM_ResetState()
	{
		BaseEntity selfEntity = viewModel.SelfEntity;
		List<BaseEntity> list = GetSystem<EntitySystem>().FindAllRelationEntities(selfEntity);
		BuffSystem system = GetSystem<BuffSystem>();
		for (int i = 0; i < list.Count; i++)
		{
			BaseEntity baseEntity = list[i];
			system.FinishEntityAllBuff(baseEntity.Id);
			baseEntity.SetProperty("Hp", baseEntity.GetPropertyMax("Hp"));
			baseEntity.SetProperty("Tenacity", baseEntity.GetPropertyMax("Tenacity"));
		}
		viewModel.UpdateGMState(BattleGMEnum.ResetState, isOpen: true);
	}

	private void OnGM_AutoWeakness()
	{
		BattleGMInfo battleGmInfo = GetBattleGmInfo(BattleGMEnum.AutoWeakness);
		if (battleGmInfo != null)
		{
			battleGmInfo.isOpen = !battleGmInfo.isOpen;
			BattleGMInfo battleGmInfo2 = GetBattleGmInfo(BattleGMEnum.AI);
			UpdateAIParadox(BattleGMEnum.AutoWeakness, battleGmInfo, battleGmInfo2);
		}
	}

	private void OnGM_AI()
	{
		BattleGMInfo battleGmInfo = GetBattleGmInfo(BattleGMEnum.AI);
		if (battleGmInfo != null)
		{
			battleGmInfo.isOpen = !battleGmInfo.isOpen;
			BattleGMInfo battleGmInfo2 = GetBattleGmInfo(BattleGMEnum.AutoWeakness);
			UpdateAIParadox(BattleGMEnum.AI, battleGmInfo2, battleGmInfo);
		}
	}

	private void UpdateAIParadox(BattleGMEnum modifyGMEnum, BattleGMInfo awInfo, BattleGMInfo aiInfo)
	{
		BaseEntity selfEntity = viewModel.SelfEntity;
		List<BaseEntity> list = GetSystem<EntitySystem>().FindAllRelationEntities(selfEntity);
		if (aiInfo.isOpen && awInfo.isOpen)
		{
			switch (modifyGMEnum)
			{
			case BattleGMEnum.AutoWeakness:
				aiInfo.isOpen = false;
				viewModel.UpdateGMState(BattleGMEnum.AutoWeakness, isOpen: true);
				viewModel.UpdateGMState(BattleGMEnum.AI, isOpen: false);
				break;
			case BattleGMEnum.AI:
				awInfo.isOpen = false;
				viewModel.UpdateGMState(BattleGMEnum.AutoWeakness, isOpen: false);
				viewModel.UpdateGMState(BattleGMEnum.AI, isOpen: true);
				break;
			}
		}
		else if (aiInfo.isOpen && !awInfo.isOpen)
		{
			viewModel.UpdateGMState(BattleGMEnum.AutoWeakness, isOpen: false);
			viewModel.UpdateGMState(BattleGMEnum.AI, isOpen: true);
		}
		else if (!aiInfo.isOpen && awInfo.isOpen)
		{
			viewModel.UpdateGMState(BattleGMEnum.AutoWeakness, isOpen: true);
			viewModel.UpdateGMState(BattleGMEnum.AI, isOpen: false);
		}
		else if (!aiInfo.isOpen && !awInfo.isOpen)
		{
			viewModel.UpdateGMState(BattleGMEnum.AutoWeakness, isOpen: false);
			viewModel.UpdateGMState(BattleGMEnum.AI, isOpen: false);
		}
		foreach (BaseEntity item in list)
		{
			item.GetComponent<AIParadoxComponent>()?.SetVariableValues("s_EnableTree", aiInfo.isOpen);
			item.GetComponent<AIParadoxComponent>()?.SetVariableValues("s_OpenWeakness", awInfo.isOpen);
		}
	}

	private void OnGM_ClearData()
	{
		ResetStat();
		viewModel.ResetStatInfo();
		viewModel.UpdateGMState(BattleGMEnum.ClearData, isOpen: true);
	}

	private void OnGM_AutoClear()
	{
		isOpenAutoClearStat = !isOpenAutoClearStat;
		if (isOpenAutoClearStat)
		{
			temp_autoClearStatTime = 0f;
		}
		viewModel.UpdateGMState(BattleGMEnum.AutoClear, isOpenAutoClearStat);
	}

	private void OnGM_TeamAI()
	{
		BattleGMInfo battleGmInfo = GetBattleGmInfo(BattleGMEnum.TeamAI);
		if (battleGmInfo == null)
		{
			return;
		}
		if (!battleGmInfo.isInter)
		{
			if (battleGmInfo.isOpen)
			{
				battleGmInfo.isOpen = false;
				viewModel.UpdateGMState(BattleGMEnum.TeamAI, isOpen: false);
			}
			return;
		}
		battleGmInfo.isOpen = !battleGmInfo.isOpen;
		if (battleGmInfo.isOpen)
		{
			foreach (HeroEntity playerTeam in GetSystem<EntitySystem>().PlayerTeamList)
			{
				if (playerTeam.Id != world.ActorId)
				{
					playerTeam.GetComponent<AIParadoxComponent>()?.SetVariableValues("IsAi", paramValue: true);
				}
			}
		}
		else
		{
			foreach (HeroEntity playerTeam2 in GetSystem<EntitySystem>().PlayerTeamList)
			{
				if (playerTeam2.Id != world.ActorId)
				{
					playerTeam2.GetComponent<AIParadoxComponent>()?.SetVariableValues("IsAi", paramValue: false);
				}
			}
		}
		viewModel.UpdateGMState(BattleGMEnum.TeamAI, battleGmInfo.isOpen);
	}

	private void OnGM_TenacityLevel()
	{
		viewModel.UpdateGMState(BattleGMEnum.TenacityLevel, isOpen: true);
	}

	private void OnGM_BossDown()
	{
		BattleGMInfo battleGmInfo = GetBattleGmInfo(BattleGMEnum.BossDown);
		if (battleGmInfo != null)
		{
			battleGmInfo.isOpen = !battleGmInfo.isOpen;
		}
		viewModel.UpdateGMState(BattleGMEnum.BossDown, battleGmInfo.isOpen);
	}

	private bool IsOpenGM(BattleGMEnum gmEnum)
	{
		if (gmDic.TryGetValue(gmEnum, out var value))
		{
			return value.isOpen;
		}
		return false;
	}

	private void ChangeGM(BattleGMEnum gmEnum, bool isOpen)
	{
		if (gmDic.TryGetValue(gmEnum, out var value))
		{
			value.isOpen = isOpen;
		}
		else
		{
			Log.Error("不存在当前GM指令绑定");
		}
	}

	private BattleGMInfo GetBattleGmInfo(BattleGMEnum gmEnum)
	{
		if (gmDic.TryGetValue(gmEnum, out var value))
		{
			return value;
		}
		Log.Error("不存在当前GM指令绑定");
		return null;
	}

	public BattleSpecialModeEnum GetSpecialModeEnum()
	{
		return specialModeEnum;
	}

	private void OnEnterSpecialMode(object data)
	{
		waitSceneLoadDelay = 0.2f;
		speicalModeDelay = 1f;
		specialModeEnum = BattleSpecialModeEnum.None;
		if (data is BattleWorldData battleWorldData)
		{
			DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(battleWorldData.CopyId);
			if (dataRow != null)
			{
				if (dataRow.CopyType == 99100)
				{
					specialModeEnum = BattleSpecialModeEnum.BattleStatTimer;
					viewModel.InitBattleStatView();
					isOpenBattleDS = false;
				}
				else if (dataRow.CopyType == 99000 || battleWorldData.IsOpenGM)
				{
					specialModeEnum = BattleSpecialModeEnum.BattleStatGM;
					viewModel.InitBattleStatView();
					isOpenBattleDS = false;
				}
				else
				{
					DRCopyType dataRow2 = GameEntry.DataTable.GetDataRow<DRCopyType>(dataRow.CopyType);
					if (dataRow2 != null)
					{
						isOpenBattleDS = dataRow2.ShowBattleDS;
					}
				}
			}
		}
		if (specialModeEnum != BattleSpecialModeEnum.None && viewModel != null && viewModel.SystemInfoViewModel != null)
		{
			viewModel.SystemInfoViewModel.SettingInteractable = false;
		}
	}

	private void OnEnterSpecialMode()
	{
		if (specialModeEnum != BattleSpecialModeEnum.None)
		{
			if (specialModeEnum == BattleSpecialModeEnum.BattleStatTimer)
			{
				OnGM_TeamAI();
				StopEntityBaseState(isStop: true);
			}
			else if (specialModeEnum == BattleSpecialModeEnum.BattleStatGM)
			{
				OnStartGM();
				OnHandleSpeicalModeProp();
			}
			if (_monsterEntity != null && _monsterEntity.IsBoss)
			{
				_monsterEntity.GetSystem<BattleStateSystem>().BossBattleStartHandle(_monsterEntity);
			}
		}
	}

	private async void OnReadySpecialMode()
	{
		if (specialModeEnum != BattleSpecialModeEnum.None)
		{
			List<HeroEntity> teamHero = GetSystem<EntitySystem>().GetTeamHero();
			await viewModel.OpenBattleStatWindow(specialModeEnum, teamHero);
			if (specialModeEnum == BattleSpecialModeEnum.BattleStatTimer)
			{
				SetBattleTimeConfig(60);
				viewModel.StartBattleStatTimer(isStart: true);
				temp_readyTimer = 0f;
				isSpecialModeReady = true;
				viewModel.UpdateStatTime(0f);
			}
			else if (specialModeEnum == BattleSpecialModeEnum.BattleStatGM)
			{
				viewModel.UpdateStatTime(0f);
				SetBattleTimeConfig(1);
				SetBattleReverseTime(reverse: false);
				viewModel.SelfEntity?.GetComponent<StateComponent>()?.AddImmuneBuff(17);
				OnStartSpeicalMode();
			}
		}
	}

	private void StopEntityBaseState(bool isStop)
	{
		BaseEntity selfEntity = viewModel.SelfEntity;
		if (selfEntity != null)
		{
			if (isStop)
			{
				selfEntity.GetComponent<AbnormalStateComponent>().AddAbnormalStateForce(3001);
			}
			else
			{
				selfEntity.GetComponent<AbnormalStateComponent>().RemoveAbnormalState(3001);
			}
		}
	}

	private void OnStartSpeicalMode()
	{
		if (specialModeEnum == BattleSpecialModeEnum.BattleStatTimer)
		{
			isSpecialModeStart = true;
		}
		else
		{
			_ = specialModeEnum;
			_ = 2;
		}
		SetBattleTimeDelay(0f);
		SetMonsterBloodDelay(0f);
		SetMonsterNameDelay(0f);
		SetBossMode(bossModel: true);
		if (viewModel != null && viewModel.SystemInfoViewModel != null)
		{
			viewModel.SystemInfoViewModel.SettingInteractable = true;
		}
	}

	private void OnHandleSpeicalModeProp()
	{
		viewModel.SelfEntity?.GetComponent<SkillComponent>()?.SetPropNumberToSpeicalMode();
	}

	private void OnFixedUpdateSpecialMode(float deltaTime)
	{
		if (waitSceneLoadDelay > 0f)
		{
			waitSceneLoadDelay -= deltaTime;
			if (waitSceneLoadDelay <= 0f)
			{
				OnEnterSpecialMode();
			}
			return;
		}
		if (speicalModeDelay > 0f)
		{
			speicalModeDelay -= deltaTime;
			if (speicalModeDelay <= 0f)
			{
				OnReadySpecialMode();
			}
			return;
		}
		if (isSpecialModeReady)
		{
			temp_readyTimer += deltaTime;
			if (temp_readyTimer >= READY_TIME)
			{
				isSpecialModeReady = false;
				viewModel.StartBattleStatTimer(isStart: false);
				StopEntityBaseState(isStop: false);
				OnGM_TeamAI();
				OnStartSpeicalMode();
			}
		}
		if (isSpecialModeStart)
		{
			temp_specialTimer += deltaTime;
			if (specialModeEnum == BattleSpecialModeEnum.BattleStatTimer)
			{
				viewModel.UpdateStatTime(temp_specialTimer);
			}
		}
	}

	private void OnGMActionFixedUpdate(float deltaTime)
	{
		if (isOpenAutoClearStat)
		{
			temp_autoClearStatTime += deltaTime;
			if (temp_autoClearStatTime >= AUTO_CLEAR_STAT_TIMER)
			{
				temp_autoClearStatTime -= AUTO_CLEAR_STAT_TIMER;
				ResetStat();
				viewModel.ResetStatInfo();
			}
		}
	}

	private void OnRefreshDamageAction(int entityId)
	{
		temp_autoClearStatTime = 0f;
		temp_check_dps_time = 0f;
		if (specialModeEnum == BattleSpecialModeEnum.BattleStatGM)
		{
			if (!isSpecialModeStart)
			{
				isSpecialModeStart = true;
			}
			viewModel.UpdateStatTime(temp_specialTimer);
		}
	}

	private int GetSpeicalTime()
	{
		return Mathf.Max(Mathf.CeilToInt(temp_specialTimer), 1);
	}
}
