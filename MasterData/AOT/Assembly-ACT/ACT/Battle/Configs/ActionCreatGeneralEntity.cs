using System;
using System.Collections.Generic;
using ACT.BluePrint;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行CreatGeneral实体", "Action", new string[] { "creat", "general", "entity", "state", "status", "tag" })]
public class ActionCreatGeneralEntity : ConfigAction, ISpawnMonsterParams
{
	public enum SpawnLevelType
	{
		Config,
		Parent,
		World
	}

	public enum SpawnRelationType
	{
		None,
		Product
	}

	public enum LifeSpan
	{
		Self,
		Owner
	}

	public ConfigFunction<Vector3> spawnPoint;

	public Vector3 offset;

	[Tooltip("当召唤小怪")]
	public ConfigAction[] onMonsterSpawn;

	[Tooltip("每当小怪死亡")]
	public ConfigAction[] onMonsterDie;

	public SpawnMonsterParams monsterConfig;

	public SpawnLevelType levelType;

	public int levelOffset;

	public LifeSpan lifeSpan;

	public SpawnRelationType spawnRelationType;

	public override void Do(ActionMemory memory)
	{
		DoAsync(memory).Forget();
	}

	private async UniTaskVoid DoAsync(ActionMemory memory)
	{
		Vector3 actualPos = spawnPoint.Return(memory) + offset;
		Entity entity = memory.target.entity;
		await DoCreate(actualPos, entity, memory);
		SystemAbility.DoActions(memory.caster, memory.owner, FindTargetResult.EntityOnly(memory.target.entity), null, memory.ability, onMonsterSpawn);
	}

	private async UniTask<Entity> DoCreate(Vector3 actualPos, Entity spawnOwner, ActionMemory memory)
	{
		SpawnMonsterParams spawnMonsterParams = GetSpawnMonsterParams();
		spawnMonsterParams.pos = actualPos;
		if (levelType == SpawnLevelType.Parent)
		{
			spawnMonsterParams.levelType = 1;
			spawnMonsterParams.level = spawnOwner.GetCompAbility().level + levelOffset;
		}
		bool isProduct = spawnRelationType == SpawnRelationType.Product;
		EntityFactory factory = GameManager.entities.factory;
		Entity entity = (isProduct ? factory.CreateProductEnemy(spawnMonsterParams.id) : factory.CreateEnemy(spawnMonsterParams.id));
		string[] buffList = spawnMonsterParams.buffList;
		if (!isProduct)
		{
			await MonoECS.instance.CoServerSpawnMonster(entity, spawnMonsterParams);
		}
		else
		{
			await MonoECS.instance.CoServerSpawnOwnerMonster(entity, spawnMonsterParams, spawnOwner);
		}
		RegisterMonsterDie(entity, memory, isProduct);
		if (isProduct)
		{
			AddBuff(entity, buffList);
			FireProductSpawnEvents(memory.owner, memory.ability, entity);
			BindOwnerLifeSpan(entity, spawnOwner);
		}
		else
		{
			BindOwnerLifeSpan(entity, spawnOwner);
			AddBuff(entity, buffList);
		}
		return entity;
	}

	private void RegisterMonsterDie(Entity entity, ActionMemory memory, bool isProduct)
	{
		Entity eventOwner = memory.owner;
		Ability ability = memory.ability;
		entity.GetCompAbility().onDie += (Action<Entity>)((Entity deadEntity) =>
		{
			DoMonsterDieActions(deadEntity);
			if (isProduct)
			{
				FireProductDieEvent(eventOwner, ability, deadEntity);
			}
		});
	}

	private static void FireProductSpawnEvents(Entity eventOwner, Ability ability, Entity product)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtSummonMonster evt = systemAbility.GetEvt<EvtSummonMonster>(eventOwner, ability);
		evt.mainEntity = eventOwner;
		evt.monster = product;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
		EvtOnSpawnProduct evt2 = systemAbility.GetEvt<EvtOnSpawnProduct>(eventOwner, ability);
		evt2.mainEntity = eventOwner;
		evt2.product = product;
		systemAbility.FireEvt(evt2);
		systemAbility.ReleaseEvt(evt2);
	}

	private static void FireProductDieEvent(Entity eventOwner, Ability ability, Entity product)
	{
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtSummonMonsterDie evt = systemAbility.GetEvt<EvtSummonMonsterDie>(eventOwner, ability);
		evt.mainEntity = eventOwner;
		evt.monster = product;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
	}

	private void BindOwnerLifeSpan(Entity entity, Entity spawnOwner)
	{
		if (lifeSpan != LifeSpan.Owner)
		{
			return;
		}
		if (spawnOwner.IsValid && spawnOwner.IsAlive())
		{
			spawnOwner.GetCompAbility().onDie += (Action<Entity>)((Entity _) =>
			{
				OnOwnerDie(entity);
			});
			spawnOwner.GetCompBehave().OnRelase += () =>
			{
				MonoECS.instance.TryRemoveBehave(entity);
			};
		}
		else
		{
			OnOwnerDie(entity);
		}
	}

	private void AddBuff(Entity entity, string[] names)
	{
		if (!entity.IsValid || names == null)
		{
			return;
		}
		entity.GetCompAbility().AddAbilities(names, AbilitySource.NetSync);
		if (!(entity != MonoECS.instance.mainEntity))
		{
			foreach (string item in names)
			{
				StageChallengeManager.localChallengeBuff.Add(item);
			}
		}
	}

	private void OnOwnerDie(Entity newEntity)
	{
		if (newEntity.IsValid)
		{
			newEntity.KillEntity();
		}
	}

	private void DoMonsterDieActions(Entity entity)
	{
		SystemAbility.DoActions(new ActionMemory(entity, entity, entity), onMonsterDie);
	}

	public override void CacheActionList(List<ConfigAction[]> list, ConfigAbility ab)
	{
		ConfigAbility.CacheActionList(list, onMonsterDie, ab);
		ConfigAbility.CacheActionList(list, onMonsterSpawn, ab);
	}

	public SpawnMonsterParams GetSpawnMonsterParams()
	{
		return (SpawnMonsterParams)monsterConfig.Clone();
	}
}
