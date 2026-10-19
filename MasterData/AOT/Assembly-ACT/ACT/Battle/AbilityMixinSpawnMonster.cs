using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle.Configs;
using ACT.BluePrint;
using ACT.Config;
using ACT.Core;
using ACT.MultiPlayer;
using ACT.Utility;
using ACT.World.Asset;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class AbilityMixinSpawnMonster : BaseAbilityMixin
{
	private ConfigMixinSpawnMonster m_Config;

	private byte m_RandomSeed;

	private CmdMixinSync m_RandomSync;

	private ActionMemory m_ActionMemory;

	private CancellationTokenSource m_CancellationTokenSource;

	private List<Entity> m_EntityReferences;

	private RemoveSummonMonsterParam m_RemoveSummonMonsterParam = new RemoveSummonMonsterParam();

	public AbilityMixinSpawnMonster(ConfigMixinSpawnMonster config, Ability ab, byte index)
		: base(ab, index)
	{
		m_Config = config;
	}

	internal override void FixedUpdate()
	{
	}

	internal override void OnAdd()
	{
		CreatSeed();
		m_ActionMemory = new ActionMemory(caster, owner, FindTargetResult.EntityOnly(owner), null, ability);
		m_CancellationTokenSource = new CancellationTokenSource();
		m_EntityReferences = ListPool<Entity>.Get();
		owner.GetCompAbility().AddListener(typeof(EvtSummonMonsterDisengage), this);
	}

	internal override void OnRemove()
	{
		Release();
	}

	internal override void OnSilentRemove()
	{
		Release();
	}

	private void Release()
	{
		if (owner.IsValid)
		{
			owner.GetCompAbility().RemoveListener(typeof(EvtSummonMonsterDisengage), this);
		}
		m_CancellationTokenSource.Cancel();
		if (m_EntityReferences == null)
		{
			return;
		}
		foreach (Entity entityReference in m_EntityReferences)
		{
			if (entityReference.IsValid)
			{
				MonoECS.instance.TryRemoveBehave(entityReference);
			}
		}
		ListPool<Entity>.Release(m_EntityReferences);
		m_EntityReferences = null;
	}

	private void CreatSeed()
	{
		m_RandomSeed = (byte)System.DateTime.Now.Ticks;
		m_RandomSync.ability = ability.config.id;
		m_RandomSync.mixin = index;
		m_RandomSync.byteParam = m_RandomSeed;
	}

	internal override async void TriggerAbility()
	{
		float num = m_Config.maxValue.Return(m_ActionMemory);
		int num2 = m_EntityReferences.Count + m_Config.monsterParams.Count;
		if (m_EntityReferences != null && (float)num2 > num)
		{
			if (m_Config.limitType == ConfigMixinSpawnMonster.LimitType.Limit)
			{
				_ = LuminApplication.LogEnabled;
				return;
			}
			if (m_Config.limitType == ConfigMixinSpawnMonster.LimitType.MaxValue)
			{
				for (int i = 0; (float)i < (float)num2 - num; i++)
				{
					Entity entity = m_EntityReferences[0];
					entity.KillEntity();
					RemoveEntity(entity);
				}
			}
		}
		MonoECS ecs = MonoECS.instance;
		float lifetime = m_Config.lifeTime.Return(m_ActionMemory);
		EntityFactory entityFactory = GameManager.entities.factory;
		for (int j = 0; j < m_Config.monsterParams.Count; j++)
		{
			ConfigMixinSpawnMonster.MonsterPointPara data = m_Config.monsterParams[j];
			List<SpawnMonsterParams> list = ListPool<SpawnMonsterParams>.Get();
			GetSpawnMonsterParamsNonAlloc(data, list);
			foreach (SpawnMonsterParams item in list)
			{
				Entity eb = entityFactory.CreateProductEnemy(item.id);
				if (data.levelType == ActionCreatGeneralEntity.SpawnLevelType.Parent)
				{
					item.levelType = 1;
					item.level = owner.GetCompAbility().level + data.levelOffset;
					item.levelOverride = true;
				}
				else if (data.levelType == ActionCreatGeneralEntity.SpawnLevelType.Config)
				{
					item.levelType = 1;
					item.level = data.level;
				}
				CompProduct? compProduct = eb.GetCompProduct();
				compProduct.AbilityEntityType = m_Config.abilityEntityType;
				compProduct.lifeTime = lifetime;
				compProduct.onOutOfControl = (Action<Entity>)Delegate.Combine(compProduct.onOutOfControl, new Action<Entity>(RemoveEntity));
				await ecs.CoServerSpawnOwnerMonster(eb, item, ability.owner);
				if (data.buffList != null && data.buffList.Length != 0)
				{
					eb.GetCompAbility().AddAbilities(data.buffList, AbilitySource.Passive);
				}
				if (data.usePathOffsetChange && eb.GetEntityType() == EntityType.Monster && eb.GetConfig().MonsterAttackType != MonsterAttackType.support)
				{
					int num3 = UnityEngine.Random.Range(0, GameLoader.meta.pathOffsetChangeArray.Count - 1);
					data.pathOffset = new Vector3(0f, 0f, GameLoader.meta.pathOffsetChangeArray[num3]);
				}
				else
				{
					data.pathOffset = Vector3.zero;
				}
				eb.GetCompPhysics().SetPathOffset(data.pathOffset);
				InitProperties(eb, m_Config.overrideProperty);
				if (m_CancellationTokenSource.IsCancellationRequested)
				{
					MonoECS.instance.TryRemoveBehave(eb);
					RemoveEntity(eb);
					return;
				}
				m_EntityReferences.Add(eb);
				eb.GetCompAbility().onDie += (Action<Entity>)((Entity x) =>
				{
					SystemAbility systemAbility2 = Singleton<GameManager>.instance.ecsManager.systemAbility;
					EvtSummonMonsterDie evt3 = systemAbility2.GetEvt<EvtSummonMonsterDie>(owner, ability);
					evt3.mainEntity = owner;
					evt3.monster = x;
					systemAbility2.FireEvt(evt3);
					systemAbility2.ReleaseEvt(evt3);
					RemoveEntity(x);
				});
				if (data.lifeSpan == ActionCreatGeneralEntity.LifeSpan.Owner)
				{
					owner.GetCompAbility().onDie += (Action<Entity>)((Entity _) =>
					{
						eb.KillEntity();
					});
					owner.GetCompBehave().OnRelase += () =>
					{
						MonoECS.instance.TryRemoveBehave(eb);
					};
				}
				SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
				EvtSummonMonster evt = systemAbility.GetEvt<EvtSummonMonster>(owner, ability);
				evt.mainEntity = owner;
				evt.monster = eb;
				systemAbility.FireEvt(evt);
				systemAbility.ReleaseEvt(evt);
				EvtOnSpawnProduct evt2 = systemAbility.GetEvt<EvtOnSpawnProduct>(owner, ability);
				evt2.product = eb;
				systemAbility.FireEvt(evt2);
				systemAbility.ReleaseEvt(evt2);
			}
		}
	}

	private void GetSpawnMonsterParamsNonAlloc(ConfigMixinSpawnMonster.MonsterPointPara para, List<SpawnMonsterParams> result)
	{
		EnemySpawn data = CoreUtils.GetData(para.id, RuntimeConfigs.data.enemySpawns);
		if (data == null)
		{
			return;
		}
		Maybe monsterData = GetMonsterId(data);
		if (para.usePathOffsetChange && RuntimeConfigs.data.entityDatas[monsterData.id].type == 2 && para.groupUid == -1)
		{
			int num = UnityEngine.Random.Range(0, GameLoader.meta.pathOffsetChangeArray.Count - 1);
			para.pathOffset = new Vector3(0f, 0f, GameLoader.meta.pathOffsetChangeArray[num]);
		}
		else if (para.groupUid == -1)
		{
			para.pathOffset = Vector3.zero;
		}
		int aiIndex = -1;
		if (!para.aiConfig.Exists((AiDictionary x) =>
		{
			if (monsterData.id == x.id)
			{
				aiIndex = x.index;
				return true;
			}
			return false;
		}))
		{
			aiIndex = -1;
		}
		string bornBehaviorName = string.Empty;
		if (para.monsterBornBehaviorDataClasses != null && !para.monsterBornBehaviorDataClasses.Exists((MonsterBornBehaviorDataClass x) =>
		{
			if (monsterData.id == x.id)
			{
				bornBehaviorName = x.index;
				return true;
			}
			return false;
		}))
		{
			bornBehaviorName = string.Empty;
		}
		_ = data.dontUseWorldLevel;
		for (int num2 = 0; num2 < monsterData.count; num2++)
		{
			SpawnMonsterParams spawnMonsterParams = SpawnMonsterParams.SpawnMonsterParamsPool.Get();
			spawnMonsterParams.id = monsterData.id;
			spawnMonsterParams.monsterPointId = para.id;
			spawnMonsterParams.levelType = 1;
			spawnMonsterParams.level = data.enemyLevelOffset;
			spawnMonsterParams.pos = para.position.Return(m_ActionMemory);
			spawnMonsterParams.hatredSize = new Vector3(para.hatredSizeX, para.hatredSizeY, para.hatredSizeZ);
			spawnMonsterParams.hatredOffset = new Vector3(para.hatredOffsetX, para.hatredOffsetY, para.hatredOffsetZ);
			spawnMonsterParams.useRayCastCheckBlock = para.useRayCastCheckBlock;
			spawnMonsterParams.loseBattleSize = new Vector3(para.loseBattleSizeX, para.loseBattleSizeY, para.loseBattleSizeZ);
			spawnMonsterParams.loseBattleOffset = new Vector3(para.loseBattleOffsetX, para.loseBattleOffsetY, para.loseBattleOffsetZ);
			spawnMonsterParams.loseBattleCanCheckBlock = para.loseBattleCanCheckBlock;
			spawnMonsterParams.buffList = para.buffList;
			spawnMonsterParams.isLeft = para.isLeft;
			spawnMonsterParams.groupUid = para.groupUid;
			spawnMonsterParams.groupAi = para.groupUid;
			spawnMonsterParams.aiIndex = aiIndex;
			spawnMonsterParams.bornBehaviorName = bornBehaviorName;
			spawnMonsterParams.isHaveBornEffect = para.isHaveBornEffect;
			if (para.patrolPoints != null)
			{
				ConfigFunction<Vector3>[] patrolPoints = para.patrolPoints;
				foreach (ConfigFunction<Vector3> configFunction in patrolPoints)
				{
					spawnMonsterParams.patrolPoints.Add(configFunction.Return(m_ActionMemory));
				}
			}
			if (para.infoPos != null)
			{
				for (int num4 = 0; num4 < para.infoPos.Length; num4++)
				{
					Pos pos = new Pos();
					pos.posName = para.infoPosName[num4];
					pos.value = para.infoPos[num4].Return(m_ActionMemory);
					pos.rotate = Quaternion.identity;
					spawnMonsterParams.infoPos.Add(pos);
				}
			}
			spawnMonsterParams.bornInActive = para.bornInActive;
			result.Add(spawnMonsterParams);
		}
	}

	private Maybe GetMonsterId(EnemySpawn spawnData)
	{
		if (spawnData != null)
		{
			List<int> list = ListPool<int>.Get();
			foreach (Maybe item in spawnData.enemy)
			{
				list.Add(item.weight);
			}
			UnityEngine.Random.State state = UnityEngine.Random.state;
			UnityEngine.Random.InitState(m_RandomSeed);
			Maybe result = spawnData.enemy[AlgorithmUtility.RandomWeight(list)];
			UnityEngine.Random.state = state;
			ListPool<int>.Release(list);
			return result;
		}
		return null;
	}

	internal override void OnInheritRemove()
	{
		owner.GetCompAbility().RemoveListener(typeof(EvtSummonMonsterDisengage), this);
	}

	internal override void OnInheritAdd()
	{
		m_ActionMemory = new ActionMemory(caster, owner, FindTargetResult.EntityOnly(owner));
		CompProduct compProduct = owner.GetCompProduct();
		foreach (Entity entityReference in m_EntityReferences)
		{
			entityReference.GetCompProduct().caster = compProduct?.caster ?? owner;
		}
		owner.GetCompAbility().AddListener(typeof(EvtSummonMonsterDisengage), this);
	}

	private void InitProperties(Entity monster, ABProperty[] propertyValues)
	{
		if (propertyValues != null)
		{
			Dictionary<PropertyItem, float> dictionary = DictionaryPool<PropertyItem, float>.Get();
			CompAbility compAbility = monster.GetCompAbility();
			for (int i = 0; i < propertyValues.Length; i++)
			{
				ABProperty aBProperty = propertyValues[i];
				DamageFormula value = aBProperty.value;
				value.Cal(m_ActionMemory.ability, m_ActionMemory.owner, monster, out var p, out var m, out var constValue, out var _);
				PropertyItem propertyItem = GameLoader.meta.configProperty.GetPropertyItem(aBProperty.property);
				compAbility.GetOrCreateProperty(propertyItem);
				dictionary.Add(propertyItem, p * m + constValue);
			}
			compAbility.PushProperties(dictionary, needCal: true, PropertySource.Summon, m_ActionMemory.owner.Id.Index);
			compAbility.CalAllProperty();
			DictionaryPool<PropertyItem, float>.Release(dictionary);
		}
	}

	private void RemoveEntity(Entity entityBehave)
	{
		if (m_EntityReferences.Contains(entityBehave))
		{
			m_RemoveSummonMonsterParam.release = true;
			SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
			EvtBeforeRemoveSummonMonster evt = systemAbility.GetEvt<EvtBeforeRemoveSummonMonster>(owner, ability);
			evt.mainEntity = owner;
			evt.monster = entityBehave;
			evt.removeSummonMonsterParam = m_RemoveSummonMonsterParam;
			systemAbility.FireEvt(evt);
			systemAbility.ReleaseEvt(evt);
			m_EntityReferences.Remove(entityBehave);
		}
	}

	internal override void OnEvt(BaseEvt evt)
	{
		if (evt is EvtSummonMonsterDisengage evtSummonMonsterDisengage)
		{
			Entity summonMonster = evtSummonMonsterDisengage.GetSummonMonster();
			RemoveEntity(summonMonster);
		}
	}
}
