using System;
using System.Collections.Generic;
using System.Linq;
using Google.Protobuf.Collections;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

public static class AdventureModuleHelper
{
	private static readonly List<long> _playerIds = new List<long>();

	private static readonly List<long> _monsterIds = new List<long>();

	private static readonly List<long> _trapIds = new List<long>();

	private static readonly List<long> _dynamicActorIds = new List<long>();

	private static AdventureTimeControlHandler _guideTimeControlHandler;

	public static bool showHPBar = true;

	public static bool showDMGNum = true;

	public static bool showDMG = true;

	public static bool showEffect = true;

	private static int _lastPanelId;

	public static int currentPanelid;

	public static long playerUid
	{
		get
		{
			return PlayerContext.PlayerUid;
		}
		set
		{
			PlayerContext.PlayerUid = value;
		}
	}

	public static int lastPanelId
	{
		get
		{
			return _lastPanelId;
		}
		set
		{
			_lastPanelId = value;
			AdventureStateProxy.LastPanelId = value;
		}
	}

	public static void SetSemiAutoBattleMode(bool enable)
	{
		ModuleController<AdventureModuleController>.Instance.SemiAutoBattle = enable;
		ModuleController<AdventureModuleController>.Instance.FullAutoBattle = enable;
		Screen.sleepTimeout = (enable ? (-1) : (-2));
	}

	public static void SetAutoCastUltimateSkill(bool enable)
	{
		ModuleController<AdventureModuleController>.Instance.AutoCastUltimateSkill = enable;
	}

	public static List<Lua2CSharpInfo_SummonMonsterInfo> GetSummonMonsterInfos()
	{
		if (ModuleController<AdventureModuleController>.Instance.monsterActors == null || ModuleController<AdventureModuleController>.Instance.monsterActors.Count == 0)
		{
			return null;
		}
		List<Lua2CSharpInfo_SummonMonsterInfo> list = new List<Lua2CSharpInfo_SummonMonsterInfo>();
		for (int i = 0; i < ModuleController<AdventureModuleController>.Instance.monsterActors.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.monsterActors.get_Item(i) as MonsterAdventureActor;
			if (!monsterAdventureActor.actorHealthInfo.isAlive || !(monsterAdventureActor.monsterSummonInfo.SummonActor != null) || !(monsterAdventureActor.monsterSummonInfo.SummonActor is PlayerAdventureActor) || !monsterAdventureActor.monsterSummonInfo.SummonCfg.retainWhenCrossLevel)
			{
				continue;
			}
			List<Lua2CSharpInfo_ResetBuffInfo> list2 = null;
			BuffCom logicComponent = monsterAdventureActor.GetLogicComponent<BuffCom>();
			if (logicComponent != null)
			{
				List<BuffEntity> buffList = logicComponent.BuffList;
				if (buffList != null && buffList.Count > 0)
				{
					list2 = new List<Lua2CSharpInfo_ResetBuffInfo>();
					foreach (BuffEntity buff in logicComponent.BuffList)
					{
						if (!buff.Removed && buff.buffConfig.NotRemove)
						{
							Lua2CSharpInfo_ResetBuffInfo item = new Lua2CSharpInfo_ResetBuffInfo
							{
								Id = buff.buffConfig.Id,
								buffNum = buff.GetBuffNum(),
								Cd = buff.GetBuffLeftTime().RawValue
							};
							list2.Add(item);
						}
					}
				}
			}
			Lua2CSharpInfo_SummonMonsterInfo item2 = new Lua2CSharpInfo_SummonMonsterInfo(monsterAdventureActor.monsterSummonInfo.SummonActor.dataID, monsterAdventureActor.dataID, (int)monsterAdventureActor.actorHealthInfo.hp, monsterAdventureActor.monsterSummonInfo.LeftTime.RawValue, monsterAdventureActor.monsterSummonInfo.SummonCfg, list2);
			list.Add(item2);
		}
		return list;
	}

	public static void SetSummonMonsters(List<Lua2CSharpInfo_SummonMonsterInfo> summonMonsterInfos)
	{
		ModuleController<AdventureModuleController>.Instance.SummonMonsters = summonMonsterInfos;
	}

	public static void ResetActorAttributes(Lua2CSharpInfo_ActorAttribute[] attributes)
	{
		if (attributes == null)
		{
			return;
		}
		for (int i = 0; i < attributes.Length; i++)
		{
			Lua2CSharpInfo_ActorAttribute lua2CSharpInfo_ActorAttribute = attributes[i];
			int actorID = lua2CSharpInfo_ActorAttribute.actorID;
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID(actorID);
			if (logicEntity is PlayerAdventureActor { actorHealthInfo: not null } playerAdventureActor)
			{
				if (lua2CSharpInfo_ActorAttribute.curHP == 0)
				{
					(logicEntity as AdventureActor).DestroySelf();
				}
				else if (lua2CSharpInfo_ActorAttribute.curHP > 0)
				{
					playerAdventureActor.actorHealthInfo.hp = lua2CSharpInfo_ActorAttribute.curHP;
				}
				else
				{
					playerAdventureActor.actorHealthInfo.hp = playerAdventureActor.actorHealthInfo.hpMax;
				}
			}
		}
	}

	public static int GetPlayerActorStatus(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0;
		}
		if (logicEntity is PlayerAdventureActor playerAdventureActor)
		{
			return (int)playerAdventureActor.status;
		}
		return 0;
	}

	public static long GetPlayerActorSpecialStatusTime(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0L;
		}
		if (logicEntity is PlayerAdventureActor playerAdventureActor)
		{
			return playerAdventureActor.specialStatusTime.RawValue;
		}
		return 0L;
	}

	public static string GetPlayerActorLocalDataJson(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		if (logicEntity is PlayerAdventureActor playerAdventureActor)
		{
			return playerAdventureActor.LocalDataToJson();
		}
		return null;
	}

	public static int GetPlayerActorAmmoType(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0;
		}
		if (logicEntity is PlayerAdventureActor playerAdventureActor)
		{
			if (playerAdventureActor.ammoInfo == null)
			{
				return 0;
			}
			return (int)playerAdventureActor.ammoInfo.ammoType;
		}
		return 0;
	}

	public static int[] GetPlayerActorAmmoCount(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		if (!(logicEntity is PlayerAdventureActor playerAdventureActor))
		{
			return null;
		}
		if (playerAdventureActor.ammoInfo != null)
		{
			return new int[6]
			{
				playerAdventureActor.ammoInfo.GetAmmoCount(HotfixEnum.AmmoType.Main),
				playerAdventureActor.ammoInfo.GetAmmoCount(HotfixEnum.AmmoType.Special1),
				playerAdventureActor.ammoInfo.GetAmmoCount(HotfixEnum.AmmoType.Special2),
				playerAdventureActor.ammoInfo.GetAmmoMax(HotfixEnum.AmmoType.Main),
				playerAdventureActor.ammoInfo.GetAmmoMax(HotfixEnum.AmmoType.Special1),
				playerAdventureActor.ammoInfo.GetAmmoMax(HotfixEnum.AmmoType.Special2)
			};
		}
		return null;
	}

	public static void ResetActorSkillInfo(MapField<int, RepeatedField<Lua2CSharpInfo_ResetSkillInfo>> skillInfos)
	{
		foreach (var (dataID, repeatedField2) in skillInfos)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID(dataID);
			if (logicEntity == null)
			{
				continue;
			}
			PlayerSkillCd logicComponent = logicEntity.GetLogicComponent<PlayerSkillCd>();
			if (logicComponent == null)
			{
				continue;
			}
			foreach (Lua2CSharpInfo_ResetSkillInfo item in repeatedField2)
			{
				logicComponent.ResetSkillInfo(item.skillId, item.cd, item.currentSectionAmount, item.currentResumeTime, item.currentUseTimeHint, item.energy);
			}
		}
	}

	public static List<SkillInfo> GetActorSkillInfos(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		return logicEntity.GetLogicComponent<PlayerSkillCd>()?.skillInfos;
	}

	public static void ResetBuff(MapField<int, RepeatedField<Lua2CSharpInfo_ResetBuffInfo>> buffInfo)
	{
		foreach (var (dataID, repeatedField2) in buffInfo)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID(dataID);
			if (logicEntity == null)
			{
				continue;
			}
			BuffCom logicComponent = logicEntity.GetLogicComponent<BuffCom>();
			if (logicComponent == null)
			{
				continue;
			}
			foreach (Lua2CSharpInfo_ResetBuffInfo item in repeatedField2)
			{
				logicComponent.ResetBuff(item.Id, item.buffNum, new FP(item.Cd));
			}
		}
	}

	public static List<BuffEntity> GetEntityBuffList(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		BuffCom logicComponent = logicEntity.GetLogicComponent<BuffCom>();
		if (logicComponent == null || logicComponent.BuffList == null)
		{
			return null;
		}
		List<BuffEntity> list = new List<BuffEntity>();
		int count = logicComponent.BuffList.Count;
		for (int i = 0; i < count; i++)
		{
			if (!logicComponent.BuffList.get_Item(i).Removed)
			{
				list.Add(logicComponent.BuffList.get_Item(i));
			}
		}
		return list;
	}

	public static void ResetShield(int actorId, List<Lua2CSharpInfo_ReseShieldInfo> ShieldInfo)
	{
		ActorShield logicComponent = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID(actorId).GetLogicComponent<ActorShield>();
		foreach (Lua2CSharpInfo_ReseShieldInfo item in ShieldInfo)
		{
			logicComponent.ResetShield(item.Id, new FP(item.leftTime), item.sheildValue, item.currentValue, item.shiledValueId);
		}
	}

	public static List<Lua2CSharpInfo_ReseShieldInfo> GetEntityShieldList(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		ActorShield logicComponent = logicEntity.GetLogicComponent<ActorShield>();
		if (logicComponent == null || logicComponent.shieldList == null)
		{
			return null;
		}
		List<Lua2CSharpInfo_ReseShieldInfo> list = new List<Lua2CSharpInfo_ReseShieldInfo>();
		int count = logicComponent.shieldList.Count;
		for (int i = 0; i < count; i++)
		{
			if (logicComponent.shieldList.get_Item(i).shieldConfig.NotRemove)
			{
				Lua2CSharpInfo_ReseShieldInfo item = new Lua2CSharpInfo_ReseShieldInfo
				{
					Id = logicComponent.shieldList.get_Item(i).shieldConfig.Id,
					leftTime = logicComponent.shieldList.get_Item(i).leftTime.RawValue,
					sheildValue = logicComponent.shieldList.get_Item(i).sheildValue.ToArray(),
					currentValue = logicComponent.shieldList.get_Item(i).GetCurrentNumShieldValue(),
					shiledValueId = logicComponent.shieldList.get_Item(i).shieldValueConfig.Id,
					actorDataId = (logicEntity as AdventureActor).dataID
				};
				list.Add(item);
			}
		}
		return list;
	}

	public static List<Lua2CSharpInfo_ReseShieldInfo> GetEntityShieldListForGM(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		ActorShield logicComponent = logicEntity.GetLogicComponent<ActorShield>();
		if (logicComponent == null || logicComponent.shieldList == null)
		{
			return null;
		}
		List<Lua2CSharpInfo_ReseShieldInfo> list = new List<Lua2CSharpInfo_ReseShieldInfo>();
		int count = logicComponent.shieldList.Count;
		for (int i = 0; i < count; i++)
		{
			Lua2CSharpInfo_ReseShieldInfo item = new Lua2CSharpInfo_ReseShieldInfo
			{
				Id = logicComponent.shieldList.get_Item(i).shieldConfig.Id,
				leftTime = logicComponent.shieldList.get_Item(i).leftTime.AsInt(),
				sheildValue = logicComponent.shieldList.get_Item(i).sheildValue.ToArray(),
				currentValue = logicComponent.shieldList.get_Item(i).GetCurrentNumShieldValue(),
				shiledValueId = logicComponent.shieldList.get_Item(i).shieldValueConfig.Id,
				actorDataId = (logicEntity as AdventureActor).dataID
			};
			list.Add(item);
		}
		return list;
	}

	public static void SetRglTheme(int[] themes)
	{
		ModuleController<AdventureModuleController>.Instance.PerkThemes = themes?.ToList();
	}

	public static void SetFateCardThemes(Lua2CSharpInfo_FateCardThemeInfo[] fateCardThemes)
	{
		ModuleController<AdventureModuleController>.Instance.SetFateCardThemes(fateCardThemes);
	}

	public static void SetFateCardInfos(Lua2CSharpInfo_FateCardInfo[] fateCardInfos)
	{
		ModuleController<AdventureModuleController>.Instance.SetFateCardInfos(fateCardInfos);
	}

	public static void UpdateFateCardInfos(Lua2CSharpInfo_FateCardInfo[] fateCardInfos)
	{
		ModuleController<AdventureModuleController>.Instance.UpdateFateCardInfos(fateCardInfos);
	}

	public static void ChangeThemePerkIds(Lua2CSharpInfo_TPPerkInfo[] infos)
	{
		ModuleController<AdventureModuleController>.Instance.SetThemePerks(infos);
	}

	public static void ChangePersonalPerkIds(Lua2CSharpInfo_TPPerkInfo[] infos, int actorId, bool change = false)
	{
		if (change)
		{
			ModuleController<AdventureModuleController>.Instance.UpdatePersonalPerks(actorId, infos);
		}
		else
		{
			ModuleController<AdventureModuleController>.Instance.SetPersonalPerks(actorId, infos);
		}
	}

	public static void SetDiscInfo(Lua2CSharpInfo_DiscInfo[] discInfos)
	{
		ModuleController<AdventureModuleController>.Instance.SetDiscInfos(discInfos);
	}

	public static void SetNoteInfo(Lua2CSharpInfo_NoteInfo[] noteInfos)
	{
		ModuleController<AdventureModuleController>.Instance.SetNoteInfos(noteInfos);
	}

	public static void SetUnFinishedAchievementInfo(List<int> achievementInfos)
	{
		ModuleController<AdventureModuleController>.Instance.SetUnFinishedAchievementInfo(achievementInfos);
	}

	public static void SetActorAttribute(int actorId, Lua2CSharpInfo_CharAttribute actorInfo)
	{
		ModuleController<AdventureModuleController>.Instance.SetActorLevelInfo(actorId, actorInfo.actorLevel);
		ModuleController<AdventureModuleController>.Instance.SetActorBreakCountInfo(actorId, actorInfo.breakCount);
		ModuleController<AdventureModuleController>.Instance.SetActorInitAttribute(actorId, actorInfo);
		ModuleController<AdventureModuleController>.Instance.SetActorTalentActiveInfo(actorId, actorInfo.activeTalentInfos);
	}

	public static void SetActorStatus(Lua2CSharpInfo_ActorStatus[] actorStatusInfos)
	{
		ModuleController<AdventureModuleController>.Instance.SetActorStatus(actorStatusInfos);
	}

	public static void SetBuildLevel(int level)
	{
		ModuleController<AdventureModuleController>.Instance.BuildLevel = level;
	}

	public static void SetActorAmmoInfos(Lua2CSharpInfo_ActorAmmoInfo[] actorAmmoInfos)
	{
		ModuleController<AdventureModuleController>.Instance.SetActorAmmoInfos(actorAmmoInfos);
	}

	public static int SetActorEffect(int actorDataId, int effectId, int takeEffectLimit, long initCD, bool shareCD = true, bool shareTimes = true)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID(actorDataId);
		if (logicEntity == null)
		{
			return 0;
		}
		ActorEffectManage actorEffectManage = (logicEntity as AdventureActor)?.effectManage;
		if (actorEffectManage == null)
		{
			return 0;
		}
		AddEffectInfo addEffectInfo = new AddEffectInfo(effectId, takeEffectLimit, initCD);
		return actorEffectManage.AddEffectByPerk(addEffectInfo, shareCD, shareTimes);
	}

	public static void RemoveActorEffect(int actorDataId, int effectUniqueId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID(actorDataId);
		if (!(logicEntity == null))
		{
			ActorEffectManage actorEffectManage = (logicEntity as AdventureActor)?.effectManage;
			if (!(actorEffectManage == null))
			{
				actorEffectManage.RemoveEffectByPerk(effectUniqueId);
			}
		}
	}

	public static List<AdventureEffect> GetEffectList(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		ActorEffectManage logicComponent = logicEntity.GetLogicComponent<ActorEffectManage>();
		if (!(logicComponent == null))
		{
			return logicComponent.effectsDict.Values.ToList();
		}
		return null;
	}

	public static void ResetBTalentAndStoneHeart()
	{
	}

	public static void SelectSupply(int effectId, bool revive)
	{
		if (revive)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor.effectManage.AddEffectByAI(effectId);
		}
		else
		{
			if (effectId <= 0)
			{
				return;
			}
			List<int> effectIds = new List<int> { effectId };
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				if (!SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).IsDead())
				{
					SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).effectManage.AddEffectByAI(effectIds);
				}
			}
		}
	}

	public static long GetEntityHp(long entityId)
	{
		return GetEntityHealthInfo(entityId)?.hp ?? 0;
	}

	public static int GetActorSkillCD(long id, int skillId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(id);
		if (logicEntity == null)
		{
			return 0;
		}
		SkillInfo skillInfo = logicEntity.GetLogicComponent<PlayerSkillCd>()?.GetSkillCD(skillId);
		if (skillInfo == null)
		{
			return 0;
		}
		return (int)(long)skillInfo.currentUseInterval;
	}

	public static int GetActorSkillEnergy(long id, int skillId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(id);
		if (logicEntity == null)
		{
			return 0;
		}
		SkillInfo skillInfo = logicEntity.GetLogicComponent<PlayerSkillCd>()?.GetSkillCD(skillId);
		if (skillInfo == null)
		{
			return 0;
		}
		return (int)(long)skillInfo.currentEnergy;
	}

	public static int GetActorSkillSectionAmount(long id, int skillId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(id);
		if (logicEntity == null)
		{
			return 0;
		}
		return (logicEntity.GetLogicComponent<PlayerSkillCd>()?.GetSkillCD(skillId))?.currentSectionAmount ?? 0;
	}

	public static bool CheckSkillAvailable(long id, int nSkillId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(id);
		if (logicEntity == null)
		{
			return false;
		}
		SkillInfo skillInfo = logicEntity.GetLogicComponent<PlayerSkillCd>()?.GetSkillCD(nSkillId);
		if (skillInfo == null)
		{
			return false;
		}
		if (skillInfo.totalSectionAmount > 1)
		{
			if (skillInfo.currentUseInterval <= 0 && skillInfo.currentSectionAmount > 0)
			{
				return skillInfo.currentEnergy >= skillInfo.totalEnergy;
			}
			return false;
		}
		if (skillInfo.currentUseInterval <= 0 && skillInfo.currentResumeTime <= 0)
		{
			return skillInfo.currentEnergy >= skillInfo.totalEnergy;
		}
		return false;
	}

	public static void ForceSyncSkillBtnToLua(long id)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(id);
		if (logicEntity == null)
		{
			return;
		}
		PlayerSkillCd logicComponent = logicEntity.GetLogicComponent<PlayerSkillCd>();
		if (logicComponent != null)
		{
			int count = logicComponent.skillInfos.Count;
			for (int i = 0; i < count; i++)
			{
				SkillInfo info = logicComponent.skillInfos.get_Item(i);
				logicComponent.DoSyncSkillBtnToLua(info);
			}
		}
	}

	public static List<long> GetCurrentGroupPlayers()
	{
		_playerIds.Clear();
		if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs == null)
		{
			return _playerIds;
		}
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i);
			_playerIds.Add(playerAdventureActor.Id);
		}
		return _playerIds;
	}

	public static long GetCurrentActivePlayer()
	{
		if (!(SceneSingleton<AdventurePlayerController>.Instance == null) && !(SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor == null))
		{
			return SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id;
		}
		return 0L;
	}

	public static List<long> GetCurrentMonsters()
	{
		_monsterIds.Clear();
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		if (monsterActors != null)
		{
			for (int i = 0; i < monsterActors.Count; i++)
			{
				LogicEntity logicEntity = monsterActors.get_Item(i);
				if (logicEntity != null)
				{
					_monsterIds.Add(logicEntity.Id);
				}
			}
		}
		return _monsterIds;
	}

	public static List<long> GetCurrentTraps()
	{
		_trapIds.Clear();
		List<LogicEntity> traps = ModuleController<AdventureModuleController>.Instance.traps;
		if (traps != null)
		{
			for (int i = 0; i < traps.Count; i++)
			{
				LogicEntity logicEntity = traps.get_Item(i);
				if (logicEntity != null)
				{
					_trapIds.Add(logicEntity.Id);
				}
			}
		}
		return _trapIds;
	}

	public static List<long> GetCurrentDynamicActors()
	{
		_dynamicActorIds.Clear();
		List<LogicEntity> dynamicActors = ModuleController<AdventureModuleController>.Instance.dynamicActors;
		if (dynamicActors != null)
		{
			for (int i = 0; i < dynamicActors.Count; i++)
			{
				LogicEntity logicEntity = dynamicActors.get_Item(i);
				if (!(logicEntity == null))
				{
					AdventureActor component = logicEntity.GetComponent<AdventureActor>();
					if (component != null && component.UseInheritElementOnHit && !component.isDead)
					{
						_dynamicActorIds.Add(logicEntity.Id);
					}
				}
			}
		}
		return _dynamicActorIds;
	}

	public static int GetCharacterId(long playerId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(playerId);
		if (logicEntity == null)
		{
			return 0;
		}
		PlayerAdventureActor component = logicEntity.GetComponent<PlayerAdventureActor>();
		if (!(component == null))
		{
			return component.dataID;
		}
		return 0;
	}

	public static int GetHudDamageSourceGroup(long fromEntityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(fromEntityId);
		if (logicEntity == null)
		{
			return 0;
		}
		PlayerAdventureActor component = logicEntity.GetComponent<PlayerAdventureActor>();
		if (component != null)
		{
			if (!component.isAssist)
			{
				return 1;
			}
			return 2;
		}
		if (logicEntity.IsPlayerSummoned(out var summoner, out var _) && summoner != null)
		{
			if (!summoner.isAssist)
			{
				return 1;
			}
			return 2;
		}
		return 0;
	}

	public static long GetCharacterDamage(int actorDataId, bool isStage)
	{
		return ModuleController<AdventureModuleController>.Instance.GetActorDamageInfo(actorDataId, isStage);
	}

	public static long GetCharacterTotalDamage(int actorDataId)
	{
		return ModuleController<AdventureModuleController>.Instance.GetActorTotalDamageInfo(actorDataId);
	}

	public static void ClearCharacterDamageRecord(bool isStage)
	{
		ModuleController<AdventureModuleController>.Instance.ClearActorDamageRecord(isStage);
	}

	public static long GetPlayerEntityId(int dataID)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID(dataID);
		if (logicEntity == null)
		{
			return 0L;
		}
		PlayerAdventureActor component = logicEntity.GetComponent<PlayerAdventureActor>();
		if (!(component == null))
		{
			return component.Id;
		}
		return 0L;
	}

	public static float GetPlayerAttributeValue(int dataID, HotfixEnum.playerAttributeType attributeType)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID(dataID);
		if (logicEntity == null)
		{
			return 0f;
		}
		return (float)(logicEntity as PlayerAdventureActor).GetAttributeValue(attributeType);
	}

	public static void SetPlayerAttributeValue(int dataID, HotfixEnum.playerAttributeType attributeType, int value, bool isIntFloat)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryPlayerEntityByDataID(dataID);
		if (!(logicEntity == null))
		{
			PlayerAdventureActor playerAdventureActor = logicEntity as PlayerAdventureActor;
			if (isIntFloat)
			{
				playerAdventureActor.SetOriginIntFloatValue(attributeType, value, FDP.One);
			}
			else
			{
				playerAdventureActor.SetOriginIntValue(attributeType, value, FDP.One);
			}
		}
	}

	public static int GetEntityId(long monsterId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterId);
		if (logicEntity == null)
		{
			return 0;
		}
		AdventureActor component = logicEntity.GetComponent<AdventureActor>();
		if (!(component == null))
		{
			return component.dataID;
		}
		return 0;
	}

	public static long GetMonsterToughness(long monsterId)
	{
		MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(monsterId) as MonsterAdventureActor;
		if (!(monsterAdventureActor == null))
		{
			return monsterAdventureActor.monsterToughnessInfo.toughness;
		}
		return 0L;
	}

	public static long GetMonsterToughnessMax(long monsterId)
	{
		MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(monsterId) as MonsterAdventureActor;
		if (!(monsterAdventureActor == null))
		{
			return monsterAdventureActor.monsterToughnessInfo.toughnessMax;
		}
		return 0L;
	}

	public static int GetCurrentActorBindSkillId(long id, int actionKey)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(id);
		if (logicEntity == null)
		{
			return 0;
		}
		return logicEntity.GetLogicComponent<PlayerSkillCd>()?.GetCurrentBindSkillId((ActionKey)actionKey) ?? 0;
	}

	public static ActorInfo GetEntityInfo(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		return logicEntity.GetLogicComponent<ActorInfo>();
	}

	public static ActorHealthInfo GetEntityHealthInfo(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		return logicEntity.GetLogicComponent<ActorHealthInfo>();
	}

	public static ActorElementInfo GetEntityElementInfo(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		return logicEntity.GetLogicComponent<ActorElementInfo>();
	}

	public static ActorShield GetEntityShieldInfo(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		return logicEntity.GetLogicComponent<ActorShield>();
	}

	public static AmmoInfo GetEntityAmmoInfo(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		return logicEntity.GetLogicComponent<AmmoInfo>();
	}

	public static MonsterToughnessInfo GetEntityToughnessInfo(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		return logicEntity.GetLogicComponent<MonsterToughnessInfo>();
	}

	public static List<int> GetEntityEffectList(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		ActorEffectManage logicComponent = logicEntity.GetLogicComponent<ActorEffectManage>();
		if (!(logicComponent == null))
		{
			return logicComponent.GetEffectIdList();
		}
		return null;
	}

	public static List<int> GetEntityEffectUniqueIdList(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return null;
		}
		ActorEffectManage logicComponent = logicEntity.GetLogicComponent<ActorEffectManage>();
		if (!(logicComponent == null))
		{
			return logicComponent.GetEffectUniqueIdList();
		}
		return null;
	}

	public static int AddEntityEffectById(long entityId, int effectId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0;
		}
		ActorEffectManage logicComponent = logicEntity.GetLogicComponent<ActorEffectManage>();
		if (!(logicComponent == null))
		{
			return logicComponent.AddEffectByBuff(effectId, logicEntity as AdventureActor);
		}
		return 0;
	}

	public static void RemoveEntityEffectById(long entityId, int effectId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null))
		{
			ActorEffectManage logicComponent = logicEntity.GetLogicComponent<ActorEffectManage>();
			if (!(logicComponent == null))
			{
				logicComponent.RemoveEffectByBuff(effectId);
			}
		}
	}

	public static void AddEntityBuffById(long entityId, int buffId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null))
		{
			BuffCom logicComponent = logicEntity.GetLogicComponent<BuffCom>();
			if (!(logicComponent == null))
			{
				logicComponent.AddBuff(buffId, logicEntity as AdventureActor);
			}
		}
	}

	public static void RemoveEntityBuffById(long entityId, int buffId, bool reduceNum)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null))
		{
			BuffCom logicComponent = logicEntity.GetLogicComponent<BuffCom>();
			if (!(logicComponent == null))
			{
				logicComponent.RemoveBuffByBuffId(buffId, reduceNum ? 1 : 0);
			}
		}
	}

	public static PlayerSkillCd GetPlayerSkillCd(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null))
		{
			return logicEntity.GetLogicComponent<PlayerSkillCd>();
		}
		return null;
	}

	public static long GetEntityMaxHp(long entityId)
	{
		return GetEntityHealthInfo(entityId)?.hpMax ?? 0;
	}

	public static bool GetEntityHaveBuffTimeReduce(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return false;
		}
		BuffCom logicComponent = logicEntity.GetLogicComponent<BuffCom>();
		if (logicComponent != null)
		{
			return logicComponent.CanReduceBuffTime;
		}
		return false;
	}

	public static void GetEntityShieldValue(long entityId, out long shiledValue, out long shieldMax)
	{
		shiledValue = 0L;
		shieldMax = 0L;
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null))
		{
			ActorShield component = logicEntity.GetComponent<ActorShield>();
			if (!(component == null))
			{
				shiledValue = component.shiledValue;
				shieldMax = component.maxShieldValue;
			}
		}
	}

	public static bool GetEntityAlive(long entityId)
	{
		return GetEntityHealthInfo(entityId)?.isAlive ?? false;
	}

	public static int GetEntityAmmoMax(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0;
		}
		return logicEntity.GetLogicComponent<AmmoInfo>()?.ammoCountMax ?? 0;
	}

	public static int GetEntityAmmoCount(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0;
		}
		return logicEntity.GetLogicComponent<AmmoInfo>()?.ammoCount ?? 0;
	}

	public static int GetEntityBulletType(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0;
		}
		return (int)(logicEntity.GetLogicComponent<AmmoInfo>()?.bulletT ?? HotfixEnum.bulletType.Null);
	}

	public static JointDrillBoss GetJointDrillBossData(long bossId, bool changeTeam, bool saveEnergy, bool saveResilience)
	{
		MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(bossId) as MonsterAdventureActor;
		if (monsterAdventureActor == null)
		{
			return default;
		}
		List<Lua2CSharpInfo_ResetBuffInfo> list = null;
		BuffCom logicComponent = monsterAdventureActor.GetLogicComponent<BuffCom>();
		if (logicComponent != null)
		{
			List<BuffEntity> buffList = logicComponent.BuffList;
			if (buffList != null && buffList.Count > 0)
			{
				list = new List<Lua2CSharpInfo_ResetBuffInfo>();
				foreach (BuffEntity buff in logicComponent.BuffList)
				{
					if (!buff.Removed && (changeTeam ? buff.buffConfig.ChangeTeamNotRemove : buff.buffConfig.NotRemove))
					{
						Lua2CSharpInfo_ResetBuffInfo item = new Lua2CSharpInfo_ResetBuffInfo
						{
							Id = buff.buffConfig.Id,
							buffNum = buff.GetBuffNum(),
							Cd = buff.GetBuffLeftTime().RawValue
						};
						list.Add(item);
					}
				}
			}
		}
		Debug.LogError("monster.actorHealthInfo.hp ===" + monsterAdventureActor.actorHealthInfo.hp);
		return new JointDrillBoss(monsterAdventureActor.dataID, monsterAdventureActor.actorHealthInfo.hp, monsterAdventureActor.actorHealthInfo.hpMax, saveResilience ? monsterAdventureActor.monsterToughnessInfo.toughness : 0, saveEnergy ? monsterAdventureActor.monsterInfo.currentEnergy : 0, list);
	}

	public static void SetJointDrillBossData(long bossId, JointDrillBoss data)
	{
		MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(bossId) as MonsterAdventureActor;
		if (!(monsterAdventureActor != null))
		{
			return;
		}
		Debug.LogError("SetJointDrillBossData ===" + data.nHp);
		monsterAdventureActor.actorHealthInfo.hp = data.nHp;
		if (data.nToughness != 0L)
		{
			monsterAdventureActor.monsterToughnessInfo.toughness = data.nToughness;
		}
		monsterAdventureActor.monsterInfo.currentEnergy = data.nEnergyValue;
		List<Lua2CSharpInfo_ResetBuffInfo> nbuffInfos = data.nbuffInfos;
		if (nbuffInfos == null || nbuffInfos.Count <= 0)
		{
			return;
		}
		BuffCom logicComponent = monsterAdventureActor.GetLogicComponent<BuffCom>();
		if (logicComponent == null)
		{
			return;
		}
		foreach (Lua2CSharpInfo_ResetBuffInfo nbuffInfo in data.nbuffInfos)
		{
			logicComponent.ResetBuff(nbuffInfo.Id, nbuffInfo.buffNum, new FP(nbuffInfo.Cd));
		}
	}

	public static void GetJointDrillBossEnergy(long bossId, out int mEnergy, out int cEnergy)
	{
		mEnergy = 0;
		cEnergy = 0;
		MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(bossId) as MonsterAdventureActor;
		if (!(monsterAdventureActor == null))
		{
			mEnergy = monsterAdventureActor.monsterInfo.maxEnergy;
			cEnergy = monsterAdventureActor.monsterInfo.currentEnergy;
		}
	}

	public static void SetRoguelikeChestData(Lua2CSharpInfo_RoguelikeChestInfo[] chests)
	{
		if (MonoSingleton<GameController>.Instance.metaData is AdventureModuleLevelLoadParams adventureModuleLevelLoadParams)
		{
			adventureModuleLevelLoadParams.rogueTreasureBoxInfos = chests;
		}
	}

	public static void Lua2CSharp_RoguelikeOpenTeleporter()
	{
		AdventureLevelOpenTeleporterEvent aEvent = AdventureLevelOpenTeleporterEvent.Generate();
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(aEvent);
	}

	public static void Lua2CSharp_ChangeVisionAttackRange(bool enabled)
	{
		if (!(SceneSingleton<AdventurePlayerController>.Instance == null))
		{
			SceneSingleton<AdventurePlayerController>.Instance.showVisionAttackRange = enabled;
		}
	}

	public static void EnterMainlineMap(int id, int[] team, int[] openedChest)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.Mainline
		};
		GameTeamConfig.ResetTeamConfigs(team);
		adventureModuleLevelLoadParams.Mainline_GenerateFloorData();
		adventureModuleLevelLoadParams.mainlineOpenedTreasureBoxs = openedChest;
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterBattleTestComboClipMap(int id, int[] team, int[] openedChest)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.BattleTestBedComboClip
		};
		GameTeamConfig.ResetTeamConfigs(team);
		adventureModuleLevelLoadParams.Mainline_GenerateFloorData();
		adventureModuleLevelLoadParams.mainlineOpenedTreasureBoxs = openedChest;
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterProloguelMap(int id)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.Prologue
		};
		adventureModuleLevelLoadParams.Mainline_GenerateFloorData();
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterProloguelBattleMap(int id, int[] team, int[] openedChest, bool isThreeP, Vector3 rPoint, List<string> btns, int boxID)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.PrologueBattleLevel
		};
		adventureModuleLevelLoadParams.Mainline_GenerateFloorData();
		adventureModuleLevelLoadParams.mainlineOpenedTreasureBoxs = openedChest;
		adventureModuleLevelLoadParams.isThreePlayer = isThreeP;
		adventureModuleLevelLoadParams.revivalPoint = rPoint;
		adventureModuleLevelLoadParams.btnNames.Clear();
		if (btns != null && btns.Count > 0)
		{
			for (int i = 0; i < btns.Count; i++)
			{
				adventureModuleLevelLoadParams.btnNames.Add(btns.get_Item(i));
			}
		}
		GameTeamConfig.ResetTeamConfigs(team);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.boxID = boxID;
	}

	public static void EnterDailyInstanceMap(int id, int[] team)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.DailyInstance_Formal
		};
		GameTeamConfig.ResetTeamConfigs(team);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterEquipmentInstanceMap(int id, int[] team)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.EquipmentInstance_Formal
		};
		GameTeamConfig.ResetTeamConfigs(team);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterInfinityTowerFloor(int id, int[] team, bool isContinue)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.InfinityTower_Fromal
		};
		adventureModuleLevelLoadParams.isInfinityContinueBattle = isContinue;
		GameTeamConfig.ResetTeamConfigs(team);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void InfinityTowerFloorEffects(int[] roomEffects)
	{
		RefreshRoomEffects(roomEffects.ToList());
	}

	public static void EnterVampireFloor(int id, int[] team, bool isFirstHalf, int[] specialEnemySet, int[] treasureSet, bool isHalfBattle, VampireDropData[] dropData, bool isRestart = false)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.VampireSurvivor_Fromal
		};
		if (!isFirstHalf && !isRestart)
		{
			MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearPlayerPool();
			MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearMonsters();
			MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearSkill();
		}
		adventureModuleLevelLoadParams.isHalfVampireBattleMode = isHalfBattle;
		adventureModuleLevelLoadParams.isVampireFirstHalf = isFirstHalf;
		if (specialEnemySet != null)
		{
			adventureModuleLevelLoadParams.vampireSpecialEnemySet = specialEnemySet.ToList();
		}
		if (treasureSet != null)
		{
			adventureModuleLevelLoadParams.vampireTreasureSet = treasureSet.ToList();
		}
		if (dropData != null)
		{
			adventureModuleLevelLoadParams.vampireDropList = dropData.ToList();
		}
		GameTeamConfig.ResetTeamConfigs(team);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void VampireFloorEffects(int[] roomEffects)
	{
		RefreshRoomEffects(roomEffects.ToList());
	}

	public static void EnterScoreBossFloor(int id, int[] team)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.ScoreBoss_Fromal
		};
		GameTeamConfig.ResetTeamConfigs(team);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterSkillInstanceMap(int id, int[] team)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.SkillInstance_Formal
		};
		GameTeamConfig.ResetTeamConfigs(team);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterDynamic(int id, int[] team, int levelType, string[] levelParams)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			levelType = HotfixEnum.worldLevelType.Dynamic,
			dynamicLevelType = levelType,
			enterDynamicLevelParams = levelParams
		};
		GameTeamConfig.ResetTeamConfigs(team);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterTowerDefenseLevel(int floorID, string[] levelParams)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(floorID.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.TowerDefense
		};
		adventureModuleLevelLoadParams.enterDynamicLevelParams = levelParams;
		GameTeamConfig.ResetTeamConfigs(null);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterBrickBreakerLevel(int floorID, string[] levelParams)
	{
		AdventureModuleLevelLoadParams metaData = (AdventureGameContext.LevelLoadParam = new AdventureModuleLevelLoadParams(floorID.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.BreakOut_BootConfig,
			enterDynamicLevelParams = levelParams
		});
		MonoSingleton<GameController>.Instance.metaData = metaData;
	}

	public static void TowerDefense_SetTimeScale(int value)
	{
		LockStepManager.globalTimeScaleMultiplier = (FP)value * (FP)0.01f;
	}

	public static void EnterAutoBattleClearPlayer()
	{
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearPlayerPool();
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance?.ClearSkill();
	}

	public static void EnterAutoBattleBalance(int id, int[] team, float mainPlayerHPPre, int teamIndex)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.AutoBattleBalance_BootConfig,
			autoBattleBalanceEET = AdventureGameContext.LevelLoadParam.autoBattleBalanceEET,
			autoBattleBalanceConfig = AdventureGameContext.LevelLoadParam.autoBattleBalanceConfig,
			balanceMainPlayHPPre = FP.FromConfigFloat(mainPlayerHPPre),
			balanceTeamIndex = teamIndex
		};
		adventureModuleLevelLoadParams.Mainline_GenerateFloorData();
		GameTeamConfig.ResetTeamConfigs(team);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterActivityLevelsInstance(int id, int[] team, string[] levelParams)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.ActivityLevelsInstance_Formal,
			enterDynamicLevelParams = levelParams
		};
		GameTeamConfig.ResetTeamConfigs(team);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterActivityStoryLevelsInstance(int id, int[] team)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.ActivityStoryLevels,
			mapId = id.ToString()
		};
		GameTeamConfig.ResetTeamConfigs(team);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void RefreshRoomEffects(List<int> roomEffects)
	{
		AdventureLevelController adventureLevelController = ModuleController<AdventureModuleController>.Instance?.levelInstance;
		if (null == adventureLevelController)
		{
			Debug.LogError("没有找到关卡实例！");
		}
		else
		{
			adventureLevelController.RefreshRoomRules(roomEffects);
		}
	}

	public static void FixedRoguelikeRoomEffects(List<int> effects)
	{
		RefreshRoomEffects(effects);
	}

	public static void EnterRogueBossMap(int id, int[] team, int bosslvId, int chestId, int isWeekBoss)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams;
		if (isWeekBoss == 1)
		{
			adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
			{
				loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.RegionBoss
			};
			adventureModuleLevelLoadParams.RegionBoss_GenerateFloorData();
			adventureModuleLevelLoadParams.RegionBoss_GenerateLvData(bosslvId);
		}
		else
		{
			adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
			{
				loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.WeeklyCopies
			};
		}
		GameTeamConfig gameTeamConfig = new GameTeamConfig();
		GameActorConfig[] array = new GameActorConfig[3];
		for (int i = 0; i < team.Length; i++)
		{
			GameActorConfig gameActorConfig = new GameActorConfig
			{
				actorID = team[i]
			};
			array[i] = gameActorConfig;
		}
		gameTeamConfig.ResetActorConfigs(array);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		AdventureGameContext.TeamConfig = gameTeamConfig;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterTravelerDuel(int id, int floorId, int[] team, int[] affixes)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.TravelerDuel,
			floor = floorId
		};
		GameTeamConfig.ResetTeamConfigs(team);
		AdventureGameContext.TeamConfig.ResetTravelerDuelAffixs(affixes.ToList());
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void RoguelikeEnterNextFloor()
	{
		ModuleController<AdventureModuleController>.Instance.LoadLevel();
	}

	public static void LevelStateChanged(bool isLevelFinish, float fadeTime = 0f, bool isFailOrAbandon = false)
	{
		ModuleController<AdventureModuleController>.Instance.Lua2CSharp_LevelStateChanged(isLevelFinish, fadeTime, isFailOrAbandon);
	}

	public static void SetHudFollowTarget(long entityId, GameObject gameObject, Vector3 offset, bool head)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return;
		}
		Transform target = logicEntity.transform;
		if (head)
		{
			AdventureActor component = logicEntity.gameObject.GetComponent<AdventureActor>();
			if (component != null)
			{
				target = component.GetHeadTransform();
			}
		}
		ActorHUD actorHUD = gameObject.AddOrGetComponent<ActorHUD>();
		if (actorHUD != null)
		{
			actorHUD.SetFollowTarget(target, offset);
		}
	}

	public static void SetBossIndicatorTarget(long entityId, GameObject gameObject, Vector3 offset)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null))
		{
			Transform transform = logicEntity.transform;
			FRIndicator fRIndicator = gameObject.AddOrGetComponent<FRIndicator>();
			if (fRIndicator != null)
			{
				fRIndicator.SetFollowTarget(transform, offset);
			}
		}
	}

	public static bool IsPlayerGroup(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return false;
		}
		AdventureActor adventureActor = logicEntity as AdventureActor;
		if (adventureActor == null)
		{
			return false;
		}
		return adventureActor.GroupId == "STANDALONE_PLAYER_ACTOR_GROUP";
	}

	public static void SetHudValue(GameObject gameObject, long entityId, int id, long val, bool isHeal, HitDamage hitDamage, long formEntityId, bool isCrit, bool isDot, int fromElementType, int hudColorIndex)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null))
		{
			HUDNumber component = gameObject.GetComponent<HUDNumber>();
			float hudOffsetWidth = GetHudOffsetWidth(entityId);
			float hudOffsetHeight = GetHudOffsetHeight(entityId);
			if (component != null)
			{
				component.SetValue(id, val, isHeal, logicEntity, hudOffsetWidth, hudOffsetHeight, hitDamage, formEntityId, isCrit, isDot, fromElementType, hudColorIndex);
			}
		}
	}

	public static void RefreshHudValue(GameObject gameObject, long val, int hudColorIndex)
	{
		if (!(gameObject == null))
		{
			HUDNumber component = gameObject.GetComponent<HUDNumber>();
			if (component != null)
			{
				component.RefreshMergedValue(val, hudColorIndex);
			}
		}
	}

	public static void SetHudStringValue(GameObject gameObject, long entityId, int id, string val, int valType, bool useVariant)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null))
		{
			HUDNumber component = gameObject.GetComponent<HUDNumber>();
			float hudOffsetWidth = GetHudOffsetWidth(entityId);
			float hudOffsetHeight = GetHudOffsetHeight(entityId);
			if (component != null)
			{
				component.SetStringValue(id, val, valType, logicEntity.transform, hudOffsetWidth, hudOffsetHeight, useVariant);
			}
		}
	}

	public static void SetHudToughnessDamageValue(GameObject gameObject, long entityId, int id, string val, bool useVariant, bool isChange)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null))
		{
			HUDNumber component = gameObject.GetComponent<HUDNumber>();
			float hudOffsetWidth = GetHudOffsetWidth(entityId);
			float hudOffsetHeight = GetHudOffsetHeight(entityId);
			if (component != null)
			{
				component.SetToughnessDamageValue(id, val, logicEntity.transform, hudOffsetWidth, hudOffsetHeight, useVariant, isChange);
			}
		}
	}

	public static float GetHudOffsetWidth(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0f;
		}
		HudOffsetValue component = logicEntity.GetComponent<HudOffsetValue>();
		if (component != null)
		{
			return component.x * logicEntity.transform.localScale.x / 2f;
		}
		DeterministicCollider logicComponent = logicEntity.GetLogicComponent<DeterministicCollider>();
		if (logicComponent == null)
		{
			return 0f;
		}
		return (float)logicComponent.Radius;
	}

	public static float GetHudOffsetHeight(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0f;
		}
		HudOffsetValue component = logicEntity.GetComponent<HudOffsetValue>();
		if (component != null)
		{
			return (component.y + component.centerY) * logicEntity.transform.localScale.y;
		}
		DeterministicCollider logicComponent = logicEntity.GetLogicComponent<DeterministicCollider>();
		if (logicComponent == null)
		{
			return 0f;
		}
		return (float)logicComponent.ColliderHeight;
	}

	public static float GetEntityColliderHeight(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0f;
		}
		DeterministicCollider logicComponent = logicEntity.GetLogicComponent<DeterministicCollider>();
		if (logicComponent == null)
		{
			return 0f;
		}
		return (float)logicComponent.ColliderHeight;
	}

	public static float GetEntityMonsterBarHeight(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0f;
		}
		MonsterInfo logicComponent = logicEntity.GetLogicComponent<MonsterInfo>();
		if (logicComponent == null)
		{
			return 0f;
		}
		return (float)logicComponent.barHeight;
	}

	public static float GetEntityColliderWidth(long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0f;
		}
		DeterministicCollider logicComponent = logicEntity.GetLogicComponent<DeterministicCollider>();
		if (logicComponent == null)
		{
			return 0f;
		}
		return (float)logicComponent.Radius;
	}

	public static void PlaySettlementPerform(string scenePath, string outfitSoundStateName, int[] actorIds, Action<bool> callBack)
	{
		List<int> list = new List<int>(3);
		for (int i = 0; i < actorIds.Length; i++)
		{
			list.Add(actorIds[i]);
		}
		SceneSingleton<PerformManager>.Instance.PlaySettlementPerform(scenePath, outfitSoundStateName, list, callBack);
	}

	public static void PlayTeamUpgradeFX()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (!(activedPlayerActor == null))
		{
			GameObject fX_TeamUpgradeWhenBatteFinish = AdventureModuleController.Config.FX_TeamUpgradeWhenBatteFinish;
			if (!(fX_TeamUpgradeWhenBatteFinish == null))
			{
				AdventureFXPlayer.PlayFX(fX_TeamUpgradeWhenBatteFinish, 1f, activedPlayerActor.transform.position, Quaternion.identity).Bind(activedPlayerActor.gameObject);
			}
		}
	}

	public static void LeaveAdventure()
	{
		AdventureLevelTeleporter.NextLevelData nextLevelData = new AdventureLevelTeleporter.NextLevelData
		{
			enterSettlementState = true,
			levelSuccess = false
		};
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("ADVENTURE_LEVEL_COMPLETE", null, nextLevelData);
	}

	public static GameObject SpawnPrefabInstance(GameObject prefab, string poolName, GameObject parent)
	{
		GameObject gameObject = ObjectPoolUtils.SpawnGameObjectFromPool(prefab, poolName, autoDespawn: false);
		gameObject.transform.SetParent(parent.transform);
		return gameObject;
	}

	public static void DespawnPrefabInstance(GameObject instance, string poolName)
	{
		ObjectPoolUtils.DespawnToPool(instance.transform, poolName);
	}

	public static void PauseLogic()
	{
		ModuleController<AdventureModuleController>.Instance?.PauseLogic();
	}

	public static void ResumeLogic()
	{
		ModuleController<AdventureModuleController>.Instance?.ResumeLogic();
	}

	public static void ExitSelectTeam()
	{
		if (MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance != null)
		{
			MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.ExitSelectTeamPanel();
		}
	}

	public static void OpenActiveTeleporter()
	{
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.OpenActiveTeleporter();
		}
	}

	public static void OpenTreasureAndNpcNew(List<int[]> prizeList, bool showNpc)
	{
		if (ModuleController<AdventureModuleController>.Instance != null)
		{
			ModuleController<AdventureModuleController>.Instance.OpenTreasureAndNpcNew(prizeList, showNpc);
		}
	}

	public static List<Transform> GetLevelTeleporters()
	{
		if (ModuleController<AdventureModuleController>.Instance == null)
		{
			return null;
		}
		List<AdventureLevelTeleporter> teleporters = ModuleController<AdventureModuleController>.Instance.GetTeleporters();
		if (teleporters == null)
		{
			return null;
		}
		List<Transform> list = new List<Transform>();
		for (int i = 0; i < teleporters.Count; i++)
		{
			if (teleporters.get_Item(i).gameObject.activeInHierarchy)
			{
				list.Add(teleporters.get_Item(i).transform);
			}
		}
		return list;
	}

	public static bool CheckTimelineClipFinish(PlayableDirector director, string clipName)
	{
		if (director == null || string.IsNullOrEmpty(clipName))
		{
			return true;
		}
		if (director.state == PlayState.Playing)
		{
			foreach (PlayableBinding output in director.playableAsset.outputs)
			{
				if (!(output.sourceObject is AnimationTrack animationTrack))
				{
					continue;
				}
				foreach (TimelineClip clip in animationTrack.GetClips())
				{
					if (clip.displayName.EndsWith(clipName))
					{
						return director.time >= clip.end;
					}
				}
			}
		}
		return true;
	}

	public static void SetMiniMapFeatureActive(bool active)
	{
		if (active)
		{
			SceneSingleton<AdventureMiniMapController>.Instance.Active();
		}
		else
		{
			SceneSingleton<AdventureMiniMapController>.Instance.Deactive();
		}
	}

	public static void SetMapCameraActive(bool active)
	{
		if (active)
		{
			SceneSingleton<AdventureMiniMapController>.Instance.OpenMapCamera();
		}
		else
		{
			SceneSingleton<AdventureMiniMapController>.Instance.CloseMapCamera();
		}
	}

	public static RenderTexture GetMiniMapRenderTexture()
	{
		return SceneSingleton<AdventureMiniMapController>.Instance.miniMapRenderTexture;
	}

	public static RenderTexture GetMapRenderTexture()
	{
		return SceneSingleton<AdventureMiniMapController>.Instance.mapRenderTexture;
	}

	public static void SetDirectorState(string directorPath, bool isPause)
	{
		PlayableDirector playableDirector = GameObject.Find(directorPath)?.GetComponent<PlayableDirector>();
		if (!(playableDirector == null))
		{
			playableDirector.SetPlaySpeed((!isPause) ? 1 : 0);
		}
	}

	public static void PausePerformTimeline()
	{
		SceneSingleton<PerformManager>.Instance?.PauseTimeLinePerform(isPause: true);
	}

	public static void ResumePerformTimeline()
	{
		SceneSingleton<PerformManager>.Instance?.PauseTimeLinePerform(isPause: false);
	}

	public static void StopPerformTimeline()
	{
		SceneSingleton<PerformManager>.Instance?.StopTimeLinePerform();
	}

	public static void PausePlayableDirector(bool isPause)
	{
		ModuleController<AdventureModuleController>.Instance?.levelInstance.PauseTimeLine(isPause);
	}

	public static void StopPlayableDirector()
	{
		ModuleController<AdventureModuleController>.Instance?.levelInstance.StopTimeLine();
	}

	public static bool GetFirstSlotPlayer(out int dataId, out long playerId)
	{
		dataId = 0;
		playerId = 0L;
		if (SceneSingleton<AdventurePlayerController>.Instance == null)
		{
			return false;
		}
		dataId = SceneSingleton<AdventurePlayerController>.Instance.FirstSlotActorId;
		if (!SceneSingleton<AdventurePlayerController>.Instance.ActorDicts.TryGetValue(dataId, out var value))
		{
			return false;
		}
		playerId = value.Id;
		return true;
	}

	public static bool GetSecondSlotPlayer(out int dataId, out long playerId)
	{
		dataId = 0;
		playerId = 0L;
		if (SceneSingleton<AdventurePlayerController>.Instance == null)
		{
			return false;
		}
		dataId = SceneSingleton<AdventurePlayerController>.Instance.SecondSlotActorId;
		if (!SceneSingleton<AdventurePlayerController>.Instance.ActorDicts.TryGetValue(dataId, out var value))
		{
			return false;
		}
		playerId = value.Id;
		return true;
	}

	public static void SetGuideLogicTimeScale(int val)
	{
		if (val == 1)
		{
			if (_guideTimeControlHandler != null)
			{
				_guideTimeControlHandler.Stop();
				_guideTimeControlHandler = null;
			}
		}
		else
		{
			_guideTimeControlHandler = ModuleController<AdventureModuleController>.Instance?.FreezeFrame(0, -1);
		}
	}

	public static void EnterViewSceneLevel(int levelType, int id, int[] teamIDs, bool isViewSceneMode = true, int starTowerFloorSetID = 0, int prefabID = 0, string prefabExtension = "", int playType = 0, bool sceneDoMir = false)
	{
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams(id.ToString())
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.SceneView
		};
		adventureModuleLevelLoadParams.GenerateViewSceneData((HotfixEnum.worldLevelType)levelType, isViewSceneMode, starTowerFloorSetID, prefabID, prefabExtension, playType, sceneDoMir);
		RandomMonsterSpawnWaveGizmo.RdmMonsterSpawnInfo rogRdmMonsterSpawnInfo = new RandomMonsterSpawnWaveGizmo.RdmMonsterSpawnInfo();
		adventureModuleLevelLoadParams.rogRdmMonsterSpawnInfo = rogRdmMonsterSpawnInfo;
		GameTeamConfig.ResetTeamConfigs(teamIDs);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static List<AdventureModuleController.BattleSample> GetBattleSamples(string fileName)
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (null == instance)
		{
			return null;
		}
		return instance.UploadDamageList(fileName);
	}

	public static void EnterStarTowerTestMap(Lua2CSharpInfo_FixedRoguelike info)
	{
		if (!Singleton<GameDataController>.Instance.loaded)
		{
			Singleton<GameDataController>.Instance.Load("zh_CN");
		}
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = new AdventureModuleLevelLoadParams();
		adventureModuleLevelLoadParams.StarTower_GenerateMapData(info.nMapId);
		adventureModuleLevelLoadParams.loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_ByFixedId;
		GameTeamConfig.ResetTeamConfigs(info.team, info.teamSkin);
		AdventureGameContext.LevelLoadParam = adventureModuleLevelLoadParams;
		MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
	}

	public static void EnterStarTowerMap(int difficulty, bool battleEnd, bool isFinal, int[] DropInfo, int NextStageType)
	{
		object metaData = MonoSingleton<GameController>.Instance.metaData;
		if (metaData == null)
		{
			Debug.LogError("参数为空!");
		}
		else if (metaData is AdventureModuleLevelLoadParams adventureModuleLevelLoadParams)
		{
			if (adventureModuleLevelLoadParams.loadType == AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_Formal)
			{
				adventureModuleLevelLoadParams.levelDifficultLv = difficulty;
			}
			adventureModuleLevelLoadParams.isBattleEnd = battleEnd;
			adventureModuleLevelLoadParams.isFinalLevelFloor = isFinal;
			adventureModuleLevelLoadParams.starTowerDropInfo = DropInfo;
			adventureModuleLevelLoadParams.nextRoomType = NextStageType;
			MonoSingleton<GameController>.Instance.metaData = adventureModuleLevelLoadParams;
		}
	}

	public static void SetDamageRecordId(string id)
	{
		object metaData = MonoSingleton<GameController>.Instance.metaData;
		if (metaData == null)
		{
			Debug.LogError("参数为空!");
		}
		else if (metaData is AdventureModuleLevelLoadParams adventureModuleLevelLoadParams)
		{
			adventureModuleLevelLoadParams.dmgRecordId = id;
		}
	}

	public static int RandomStarTowerMap(Lua2CSharpInfo_FixedRoguelike info, out int floorID, out string extension, out int scenePrefabID)
	{
		floorID = 0;
		scenePrefabID = 0;
		extension = string.Empty;
		AdventureModuleLevelLoadParams levelLoadParam = AdventureGameContext.LevelLoadParam;
		if (levelLoadParam != null)
		{
			if (levelLoadParam.loadType == AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_ByFixedId)
			{
				if (!string.IsNullOrEmpty(levelLoadParam.strRdmMonsterSpawnInfo))
				{
					tmpRogRdmMonsterSpawnInfo tmpRogRdmMonsterSpawnInfo2 = JsonUtility.FromJson<tmpRogRdmMonsterSpawnInfo>(levelLoadParam.strRdmMonsterSpawnInfo);
					levelLoadParam.rogRdmMonsterSpawnInfo.spawnMonsterDataList = new List<StarTowerLevelController.MonsterSpawnDataList>();
					for (int i = 0; i < tmpRogRdmMonsterSpawnInfo2.tempMonsterSpawnDatass.Count; i++)
					{
						StarTowerLevelController.MonsterSpawnDataList monsterSpawnDataList = new StarTowerLevelController.MonsterSpawnDataList(tmpRogRdmMonsterSpawnInfo2.tempMonsterSpawnDatass.get_Item(i).waveIndex);
						for (int j = 0; j < tmpRogRdmMonsterSpawnInfo2.tempMonsterSpawnDatass.get_Item(i).tempMonsterSpawnDatas.Count; j++)
						{
							tempMonsterSpawnData tempMonsterSpawnData2 = tmpRogRdmMonsterSpawnInfo2.tempMonsterSpawnDatass.get_Item(i).tempMonsterSpawnDatas.get_Item(j);
							monsterSpawnDataList.Add(new StarTowerLevelController.MonsterSpawnData
							{
								setId = tempMonsterSpawnData2.setId,
								maxNum = tempMonsterSpawnData2.maxNum,
								waveMaxNum = tempMonsterSpawnData2.waveMaxNum,
								monsterId = tempMonsterSpawnData2.monsterId,
								refInterval = tempMonsterSpawnData2.refInterval
							});
						}
						levelLoadParam.rogRdmMonsterSpawnInfo.spawnMonsterDataList.Add(monsterSpawnDataList);
					}
					levelLoadParam.strRdmMonsterSpawnInfo = string.Empty;
					levelLoadParam.StarTower_GenerateFloorData();
					levelLoadParam.StarTower_GenerateMapData(info.nMapId);
					MonoSingleton<GameController>.Instance.metaData = levelLoadParam;
					return info.nMapId;
				}
			}
			else
			{
				if (levelLoadParam.loadType == AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_ByFixedId_ThroughBootConfig)
				{
					levelLoadParam.StarTower_GenerateFloorData();
					levelLoadParam.StarTower_GenerateMapData(CommonHelper.ParseStringParamToInt(levelLoadParam.mapId));
					MonoSingleton<GameController>.Instance.metaData = levelLoadParam;
					return CommonHelper.ParseStringParamToInt(levelLoadParam.mapId);
				}
				if (levelLoadParam.loadType == AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_Limitless)
				{
					return GetMapPipeline(out floorID, out scenePrefabID, out extension);
				}
			}
		}
		levelLoadParam = new AdventureModuleLevelLoadParams(info.levelId, info.battleLv)
		{
			loadType = AdventureModuleLevelLoadParams.BootConfigLoadType.StarTower_Formal
		};
		return GetMapPipeline(out floorID, out scenePrefabID, out extension);
		int GetMapPipeline(out int floor, out int reference, out string reference2)
		{
			floor = 0;
			if (info.nMapId == 0)
			{
				MonoSingleton<GameController>.Instance.NewRdmInstance();
			}
			GameTeamConfig gameTeamConfig = new GameTeamConfig();
			GameActorConfig[] array = new GameActorConfig[3];
			int[] team = info.team;
			int[] teamSkin = info.teamSkin;
			for (int k = 0; k < team.Length; k++)
			{
				array[k] = new GameActorConfig
				{
					actorID = team[k],
					skin = teamSkin[k]
				};
			}
			gameTeamConfig.ResetActorConfigs(array);
			levelLoadParam.StarTower_GenerateMapData(info);
			RandomMonsterSpawnWaveGizmo.RdmMonsterSpawnInfo rogRdmMonsterSpawnInfo = new RandomMonsterSpawnWaveGizmo.RdmMonsterSpawnInfo();
			levelLoadParam.rogRdmMonsterSpawnInfo = rogRdmMonsterSpawnInfo;
			AdventureGameContext.LevelLoadParam = levelLoadParam;
			AdventureGameContext.TeamConfig = gameTeamConfig;
			MonoSingleton<GameController>.Instance.metaData = levelLoadParam;
			if (levelLoadParam.starTowerFloor != null)
			{
				floor = levelLoadParam.starTowerFloor.Id;
			}
			reference = levelLoadParam.starTowerScenePrefab.Id;
			reference2 = levelLoadParam.starTowerConfigExtension;
			return levelLoadParam.starTowerMap.Id;
		}
	}

	public static void LogStarTowerMap(int curSavedMapCount, int mapType, long mapId, bool bEnter, bool bReenter)
	{
	}

	public static void SpawnNPC(int npcDataID, int npcSkinID)
	{
		NPCConfig nPCConfig = Singleton<HotfixDataController>.Instance.GetNPCConfig(npcDataID);
		if (nPCConfig == null)
		{
			Debug.LogError($"没有找到ID为{npcDataID}的NPC！");
			return;
		}
		NPCSkin nPCSkin = Singleton<HotfixDataController>.Instance.GetNPCSkin(npcSkinID);
		if (nPCSkin == null)
		{
			Debug.LogError($"没有找到ID为{npcSkinID}的NPC皮肤数据！");
			return;
		}
		List<NPCSpawnPointGizmo> nPCSpawnPoints = ModuleController<AdventureModuleController>.Instance.GetNPCSpawnPoints((HotfixEnum.npcNewType)nPCConfig.Type);
		if (nPCSpawnPoints == null || nPCSpawnPoints.Count == 0)
		{
			Debug.LogError($"场景中没有找到类型为{(HotfixEnum.npcNewType)nPCConfig.Type}的NPC出生点位!");
			return;
		}
		NPCSpawnPointGizmo nPCSpawnPointGizmo = null;
		if (nPCSpawnPoints.Count == 1)
		{
			if (nPCSpawnPoints.get_Item(0).npcID <= 0 && nPCSpawnPoints.get_Item(0).index == nPCConfig.RefreshPoint)
			{
				nPCSpawnPointGizmo = nPCSpawnPoints.get_Item(0);
			}
		}
		else
		{
			for (int i = 0; i < nPCSpawnPoints.Count; i++)
			{
				NPCSpawnPointGizmo nPCSpawnPointGizmo2 = nPCSpawnPoints.get_Item(i);
				if (nPCSpawnPointGizmo2.npcID <= 0 && nPCConfig.RefreshPoint == nPCSpawnPointGizmo2.index)
				{
					nPCSpawnPointGizmo = nPCSpawnPointGizmo2;
					break;
				}
			}
		}
		if (null == nPCSpawnPointGizmo)
		{
			Debug.LogError($"场景中没有找到类型为{(HotfixEnum.npcNewType)nPCConfig.Type}，刷新点位为：{nPCConfig.RefreshPoint}的NPC出生点位!");
			return;
		}
		nPCSpawnPointGizmo.npcID = npcDataID;
		nPCSpawnPointGizmo.npcSkinID = npcSkinID;
		nPCSpawnPointGizmo.EnableSpawnLogic();
		nPCSpawnPointGizmo.ExecuteSpawnLogic();
	}

	public static void SetProloguelBattleMsg(List<string> btns)
	{
		AdventureModuleLevelLoadParams levelLoadParam = AdventureGameContext.LevelLoadParam;
		if (levelLoadParam == null)
		{
			return;
		}
		levelLoadParam.btnNames.Clear();
		if (btns != null && btns.Count > 0)
		{
			for (int i = 0; i < btns.Count; i++)
			{
				levelLoadParam.btnNames.Add(btns.get_Item(i));
			}
		}
		levelLoadParam.isStarTowerPrologue = true;
	}

	public static void UpdateUIPanlelId(int PanelId)
	{
		Debug.LogError("PanelId==" + PanelId);
		lastPanelId = currentPanelid;
		currentPanelid = PanelId;
	}

	public static ActorInfo GetSoldierActorInfo(int dataId)
	{
		List<LogicEntity> dynamicActors = ModuleController<AdventureModuleController>.Instance.levelInstance.dynamicActors;
		for (int i = 0; i < dynamicActors.Count; i++)
		{
			AdventureActor adventureActor = dynamicActors.get_Item(i) as AdventureActor;
			if (adventureActor.dataID == dataId)
			{
				return adventureActor.GetLogicComponent<ActorInfo>();
			}
		}
		return null;
	}

	public static ActorHealthInfo GetSoldierHealthInfo(int dataId)
	{
		List<LogicEntity> dynamicActors = ModuleController<AdventureModuleController>.Instance.levelInstance.dynamicActors;
		for (int i = 0; i < dynamicActors.Count; i++)
		{
			AdventureActor adventureActor = dynamicActors.get_Item(i) as AdventureActor;
			if (adventureActor.dataID == dataId)
			{
				return adventureActor.GetLogicComponent<ActorHealthInfo>();
			}
		}
		return null;
	}

	public static void Lua2CSharp_GMOrder_OpenFrameShow(bool show)
	{
		if (show)
		{
			MonoSingleton<ClientManager>.Instance.OpenPerformanceMonitorView();
		}
		else
		{
			MonoSingleton<ClientManager>.Instance.ClosePerformanceMonitorView();
		}
	}

	public static void Lua2CSharp_GMOrder_SetGameFrame(int renderFrame)
	{
		MonoSingleton<ClientManager>.Instance.SetFrameRate(renderFrame);
	}

	public static void Lua2CSharp_GMOrder_JumpoverCurLevel()
	{
		ModuleController<AdventureModuleController>.Instance.JumpOverCurLevel();
	}

	public static void Lua2CSharp_GMOrder_SetMonsterSkill(int monsterID, int skillID)
	{
		Debug.Log($"monsterID={monsterID}_skillID={skillID}");
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(monsterID);
		if (!(logicEntity == null) && logicEntity is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.testSkillId = skillID;
		}
	}

	public static void Lua2CSharp_GMOrder_ChangeMonsterAIState(int monsterID, bool startOrStop)
	{
		Debug.Log($"monsterID={monsterID}_start={startOrStop}");
	}

	public static void Lua2CSharp_GMOrder_MonsterPlaySkill(int monsterID, int skillID, int loopTimes)
	{
		Debug.Log($"monsterID={monsterID}_skillID={skillID}_looptimes:{loopTimes}");
	}

	public static void Lua2CSharp_GMOrder_SpawnMonster(int monsterID, int spawnNum)
	{
		if (monsterID <= 0 || spawnNum <= 0)
		{
			Debug.LogError($"GM召唤怪物指令参数有误!怪物Id:{monsterID},召唤数量:{spawnNum}");
			return;
		}
		PlayerAdventureActor playerAdventureActor = SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor as PlayerAdventureActor;
		ActorSpawnInfo actorSpawnInfo = new ActorSpawnInfo(monsterID);
		actorSpawnInfo.positionY = ((playerAdventureActor != null) ? playerAdventureActor.tsTransform.PositionY : default(FP));
		actorSpawnInfo.rotation = FP.Zero;
		actorSpawnInfo.summoner = null;
		actorSpawnInfo.summonGroupSuffix = null;
		actorSpawnInfo.spawnGizmo = null;
		actorSpawnInfo.callbackImmediately = true;
		ActorSpawnInfo spawnInfo = actorSpawnInfo;
		HotfixEnum.worldLevelType? worldLevelType = ModuleController<AdventureModuleController>.Instance?.levelType;
		AdventureModuleLevelLoadParams adventureModuleLevelLoadParams = ModuleController<AdventureModuleController>.Instance?.levelLoadParams;
		if (worldLevelType == HotfixEnum.worldLevelType.StarTower)
		{
			spawnInfo.isRoguelikeMonster = true;
			spawnInfo.monsterLevel = adventureModuleLevelLoadParams?.monsterLevel ?? 1;
		}
		else
		{
			spawnInfo.isRoguelikeMonster = false;
			spawnInfo.monsterLevel = adventureModuleLevelLoadParams?.monsterLevel ?? 1;
		}
		for (int i = 0; i < spawnNum; i++)
		{
			spawnInfo.position = ((playerAdventureActor != null) ? playerAdventureActor.RandomActorReachablePointInsideRing(playerAdventureActor.tsTransform.Position, 0, 5) : default(TSVector2));
			ModuleController<AdventureModuleController>.Instance?.SpawnMonster(spawnInfo, null);
		}
	}

	public static void Lua2CSharp_GMOrder_SetIndicatorMode(int value1, int value2, int value3, int value4)
	{
		AdventureIndicatorController.indicatorLs.Clear();
		AdventureIndicatorController.indicatorLs.Add(value1 > 0);
		AdventureIndicatorController.indicatorLs.Add(value2 > 0);
		AdventureIndicatorController.indicatorLs.Add(value3 > 0);
		AdventureIndicatorController.indicatorLs.Add(value4 > 0);
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (activedPlayerActor != null)
		{
			SceneSingleton<AdventureIndicatorController>.Instance.ShowIndicatorN(showIndicator: true, activedPlayerActor.actorSearchTargetInfo, activedPlayerActor.tsTransform);
		}
	}

	public static void Lua2CSharp_SwichTarget()
	{
		if (SceneSingleton<AdventurePlayerController>.Instance != null)
		{
			SceneSingleton<AdventurePlayerController>.Instance.SwitchTarget();
		}
	}

	public static void Lua2CSharp_GMOrder_SetTimeScale(int value)
	{
		LockStepManager.globalTimeScaleMultiplier = (FP)value * (FP)0.01f;
	}

	public static void Lua2CSharp_GMOrder_KillCurChar()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (!(null == activedPlayerActor))
		{
			activedPlayerActor.GetComponent<AdventureActor>().DestroySelf();
		}
	}

	public static void Lua2CSharp_GMOrder_SetCurCharResidualHp()
	{
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (!(null == activedPlayerActor))
		{
			activedPlayerActor.GetComponent<PlayerAdventureActor>().ResetHp(5);
		}
	}

	public static void Lua2CSharp_GMOrder_AddCurCharAttack()
	{
		PlayerAdventureActor activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;
		if (activedPlayerActor != null)
		{
			_ = activedPlayerActor.actorInfo;
		}
	}

	public static void Lua2CSharp_GMOrder_KillCurMonsters()
	{
		ModuleController<AdventureModuleController>.Instance.KillAllMonsters(clearOrDestroy: false, ignoreAll: true);
	}

	public static void Lua2CSharp_GMOrder_KillMonstersByActorId(int actorId)
	{
		ModuleController<AdventureModuleController>.Instance.KillAllMonsters(clearOrDestroy: false, ignoreAll: false, ignoreSpawnState: true, ignoreDiedState: false, actorId);
	}

	public static void Lua2CSharp_GMOrder_KillMonstersById(int id)
	{
		List<LogicEntity> monsterActors = ModuleController<AdventureModuleController>.Instance.monsterActors;
		if (monsterActors == null)
		{
			return;
		}
		for (int i = 0; i < monsterActors.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = monsterActors.get_Item(i) as MonsterAdventureActor;
			if (monsterAdventureActor != null && !monsterAdventureActor.isDead && monsterAdventureActor.monsterInfo.subType != HotfixEnum.monsterSubType.Trap && monsterAdventureActor.dataID == id)
			{
				monsterAdventureActor.DestroySelf();
			}
		}
	}

	public static void Lua2CSharp_GMOrder_SkipLevel()
	{
		AdventureLevelTeleporter adventureLevelTeleporter = UnityEngine.Object.FindObjectOfType<AdventureLevelTeleporter>();
		if (null != adventureLevelTeleporter)
		{
			adventureLevelTeleporter.TeleporterTriggerd_Order();
		}
	}

	public static void Lua2CSharp_GMOrder_ChangeAllCharDef(bool active)
	{
		foreach (LogicEntity member in SceneSingleton<AdventurePlayerController>.Instance.actorGroup.members)
		{
			if (member is PlayerAdventureActor playerAdventureActor)
			{
				if (active)
				{
					playerAdventureActor.EnableInvincible();
				}
				else
				{
					playerAdventureActor.DisableInvincible();
				}
			}
		}
	}

	public static void Lua2CSharp_GMOrder_UltimateIgnoreCDAndEnergy(bool active)
	{
		SceneSingleton<AdventurePlayerController>.Instance.ultimateIgnoreEnergy = active;
	}

	public static void Lua2CSharp_GMOrder_SetEntityMoveSpeedPercent(long entityId, int moveSpeedPercent)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null) && logicEntity.TryGetComponent<ActorInfo>(out var component))
		{
			component.originMoveSpeedRatio = moveSpeedPercent;
			if (logicEntity.TryGetComponent<PlayerAdventureActor>(out var component2))
			{
				component2.RefreshMovementSpeed();
			}
		}
	}

	public static void Lua2CSharp_GMOrder_FastCD(bool active, long entityId)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null))
		{
			logicEntity.GetLogicComponent<PlayerSkillCd>()?.SetFastResume(active);
		}
	}

	public static void Lua2CSharp_GMOrder_Revive()
	{
		for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
		{
			if (SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).isDead)
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).Revive();
				ActorHealthInfo entityHealthInfo = GetEntityHealthInfo(SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).Id);
				entityHealthInfo.hp = entityHealthInfo.hpMax;
			}
		}
	}

	public static void Lua2CSharp_GMOrder_ChangeAttribute(long entityId, int firstSubType, int secondSubType, float value)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (!(logicEntity == null))
		{
			AdventureActor adventureActor = logicEntity as AdventureActor;
			if (!(adventureActor == null))
			{
				adventureActor.attributeList.ChangeValue(firstSubType, secondSubType, (FDP)value);
			}
		}
	}

	public static string Lua2CSharp_GMOrder_StarTowerConfigExtension()
	{
		AdventureModuleLevelLoadParams levelLoadParam = AdventureGameContext.LevelLoadParam;
		if (levelLoadParam != null)
		{
			return levelLoadParam.starTowerConfigExtension;
		}
		return "";
	}

	public static int Lua2CSharp_GMOrder_StarTowerGameplayType()
	{
		return (int)((ModuleController<AdventureModuleController>.Instance?.levelInstance as StarTowerLevelController)?.gameplayType).Value;
	}

	public static int Lua2CSharp_GMOrder_StarTowerScenePrefabId()
	{
		return AdventureGameContext.LevelLoadParam?.starTowerScenePrefab.Id ?? 0;
	}

	public static int Lua2CSharp_GMOrder_StarTowerFloorSetRoomType()
	{
		AdventureModuleLevelLoadParams levelLoadParam = AdventureGameContext.LevelLoadParam;
		if (levelLoadParam != null && levelLoadParam.starTowerFloorSet != null)
		{
			return levelLoadParam.starTowerFloorSet.RoomType;
		}
		return 0;
	}

	public static int GMOrder_GetMonsterLevel(long Id)
	{
		MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(Id) as MonsterAdventureActor;
		if (monsterAdventureActor == null)
		{
			return 0;
		}
		return monsterAdventureActor.spawnerInfo.level;
	}

	public static int GMOrder_ConvertAttributeTypeAndElementTypeToKey(HotfixEnum.effectAttributeType attributeType, HotfixEnum.elementType elementType)
	{
		return CommonHelper.ConvertAttributeTypeAndElementTypeToKey(attributeType, elementType);
	}

	public static int GMOrder_ConvertAttributeTypeAndDamageTypeToKey(HotfixEnum.effectAttributeType attributeType, HotfixEnum.damageType damageType)
	{
		return CommonHelper.ConvertAttributeTypeAndDamageTypeToKey(attributeType, damageType);
	}

	public static float GMOrder_GetAttributeValueWithElementOrDamageType(long entityId, HotfixEnum.effectAttributeType attributeType, HotfixEnum.elementType elementType, HotfixEnum.damageType damageType)
	{
		LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(entityId);
		if (logicEntity == null)
		{
			return 0f;
		}
		if (!logicEntity.TryGetComponent<AdventureActor>(out var component))
		{
			return 0f;
		}
		return component.actorInfo.GetAttributeValueWithElementOrDamageType(attributeType, elementType, damageType).AsFloat();
	}
}
