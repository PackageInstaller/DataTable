using ACT;
using ACT.Battle;
using ACT.BluePrint;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.UI;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace Runtime.Factory;

public static class EnemyFactory
{
	public static Entity SpawnMonsterDataPart(ICharacterSource pbCharacter)
	{
		foreach (Entity allEntity in GameManager.entities.GetAllEntities())
		{
			CompCharacter compCharacter = allEntity.GetCompCharacter();
			if (compCharacter != null && compCharacter.characterSource == pbCharacter)
			{
				return allEntity;
			}
		}
		Entity entity = GameManager.entities.factory.CreateBaseCharacter();
		entity.GetCompCharacter().characterSource = pbCharacter;
		SpawnMonsterDataPart(pbCharacter.Id(), pbCharacter.Level(), 0, entity, out var cData);
		entity.GetCompBehave().ConfigPath = cData.config;
		return entity;
	}

	private static void SpawnMonsterDataPart(int id, int level, int monsterPointId, Entity eb, out EntityEnemyData cData, bool levelOverride = false)
	{
		if (!RuntimeConfigs.data.entityEnemyDatas.TryGetValue(id, out cData))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"monster {id} not exist");
			}
			return;
		}
		CompMonster compMonster = eb.AddComponent<CompMonster>();
		compMonster.id = id;
		compMonster.level = level;
		compMonster.monsterPointId = monsterPointId;
		CompAbility? component = eb.GetComponent<CompAbility>();
		component.SetLevel(level, levelOverride);
		component.Init(compMonster);
		component.InitCommon(RuntimeConfigs.data.entityDatas[id]);
		eb.SetEntityType(id);
		GameManager.entityTickLodSystem?.Register(eb);
		SpawnMonsterDataPartEvt evt = Singleton<EventManager>.instance.GetEvt<SpawnMonsterDataPartEvt>();
		evt.entityBehave = eb;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnSpawnMonsterDataPart, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private static void SpawnAssistNpcDataPart(int id, int level, SpawnMonsterParams smp, Entity eb, out EntityEnemyData cData)
	{
		if (!RuntimeConfigs.data.entityEnemyDatas.TryGetValue(id, out cData))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"assist npcId {id} not exist");
			}
			return;
		}
		CompAssistNpc compAssistNpc = eb.GetCompAssistNpc();
		compAssistNpc.npcId = id;
		compAssistNpc.id = smp.id;
		eb.GetComponent<CompAI>().Init(smp);
		CompAbility? compAbility = eb.GetCompAbility();
		compAbility.SetLevel(level);
		compAbility.Init(compAssistNpc);
		compAbility.InitCommon(RuntimeConfigs.data.entityDatas[id]);
		eb.GetCompBehave().SetEntityType(EntityType.AssistNpc);
	}

	public static async UniTask CoServerSpawnMonster(Entity er, SpawnMonsterParams smp)
	{
		GameUtility.ModifyMonsterPointLevel(smp);
		GameUtility.ModifyMonsterPointAI(smp);
		Entity eb = er;
		SpawnMonsterDataPart(smp.id, smp.level, smp.monsterPointId, eb, out var cData, smp.levelOverride);
		eb.SetAlliance(smp.alliance);
		GameManager.entities.factory.EnqueueBehave(eb);
		await BattleEntityFactory.SpawnBattlePart(eb, cData.config, smp.pos, smp.isLeft);
		eb.GetCompAI().RegisterGroupAI(smp);
		CompBehave compBehave = eb.GetComponent<CompBehave>();
		if (compBehave.IsToRemove())
		{
			SpawnMonsterParams.SpawnMonsterParamsPool.Release(smp);
			compBehave.SetCanRemove();
			return;
		}
		compBehave.SetBehaveAvailable();
		await MonoECS.instance.SpawnCharacterAIPart(eb, smp.aiIndex, smp);
		compBehave.SetLogicAvailable();
		compBehave.SetCanRemove();
		MonoECS.instance.EntityDither(eb, 1f, isShow: true);
		EntityType entityType = eb.GetEntityType();
		if (entityType == EntityType.Elite || entityType == EntityType.Monster)
		{
			Singleton<EntityUIManager>.instance.Register(eb);
		}
		if (smp.isHaveBornEffect)
		{
			YooAssetReference bornEffectAssetID = compBehave.Config.bornEffectAssetID;
			if (bornEffectAssetID.RuntimeKeyIsValid())
			{
				GameManager.effectSystem.FireEffect(bornEffectAssetID, compBehave.Model.transform.position, Quaternion.identity);
			}
		}
		SpawnMonsterParams.SpawnMonsterParamsPool.Release(smp);
	}

	public static async UniTask CoServerSpawnOwnerMonster(Entity entity, SpawnMonsterParams smp, Entity owner)
	{
		if (owner.IsValid)
		{
			smp.alliance = owner.GetAlliance();
			CompProduct? compProduct = entity.GetCompProduct();
			compProduct.caster = owner.GetCaster();
			compProduct.productOwner = owner;
			compProduct.actionSource = entity;
		}
		await CoServerSpawnMonster(entity, smp);
	}

	public static async UniTask SpawnAssistNpc(Entity eb, SpawnMonsterParams smp, int npcId)
	{
		smp.alliance = Alliance.Character;
		GameUtility.ModifyMonsterPointLevel(smp);
		GameUtility.ModifyMonsterPointAI(smp);
		smp.level = Mathf.Clamp(smp.level, 1, 120);
		eb.GetCompAssistNpc().npcId = npcId;
		eb.SetAlliance(smp.alliance);
		SpawnAssistNpcDataPart(smp.id, smp.level, smp, eb, out var cData);
		GameManager.entities.factory.EnqueueBehave(eb);
		await BattleEntityFactory.SpawnBattlePart(eb, cData.config, smp.pos, smp.isLeft);
		CompAI? compAI = eb.GetCompAI();
		compAI.groupUid = smp.groupUid;
		compAI.groupAI = smp.groupAi;
		Singleton<GroupAIManager>.instance.RegisterGroupAI(eb, smp.groupUid, smp.groupAi);
		CompBehave compBehave = eb.GetCompBehave();
		if (compBehave.IsToRemove())
		{
			SpawnMonsterParams.SpawnMonsterParamsPool.Release(smp);
			compBehave.SetCanRemove();
			return;
		}
		compBehave.SetBehaveAvailable();
		await MonoECS.instance.SpawnCharacterAIPart(eb, smp.aiIndex, smp);
		compBehave.SetLogicAvailable();
		compBehave.SetCanRemove();
		MonoECS.instance.EntityDither(eb, 1f, isShow: true);
		if (smp.isHaveBornEffect)
		{
			YooAssetReference bornEffectAssetID = compBehave.Config.bornEffectAssetID;
			if (bornEffectAssetID.RuntimeKeyIsValid())
			{
				GameManager.effectSystem.FireEffect(bornEffectAssetID, compBehave.Model.transform.position, Quaternion.identity);
			}
		}
		SpawnMonsterParams.SpawnMonsterParamsPool.Release(smp);
		if (eb.GetEntityType() == EntityType.AssistNpc)
		{
			Singleton<EntityUIManager>.instance.Register(eb);
		}
	}
}
