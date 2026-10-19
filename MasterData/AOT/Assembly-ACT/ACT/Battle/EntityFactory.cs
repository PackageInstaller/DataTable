using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game.Data;
using Bamboo.ECS;
using Fundamental;
using Runtime.Utility;

namespace ACT.Battle;

public class EntityFactory
{
	private Bamboo.ECS.World _world;

	private readonly List<Entity> _destroyAllEntitiesBuffer = new List<Entity>(256);

	public EntityFactory(Bamboo.ECS.World world)
	{
		_world = world;
	}

	internal void DestroyAllEntities()
	{
		_destroyAllEntitiesBuffer.Clear();
		_world.GetAllEntitiesNonAlloc(_destroyAllEntitiesBuffer);
		for (int i = 0; i < _destroyAllEntitiesBuffer.Count; i++)
		{
			DestroyEntity(_destroyAllEntitiesBuffer[i]);
		}
		_destroyAllEntitiesBuffer.Clear();
	}

	private EntityBuilder MakeNavEntity()
	{
		return MakeBehaveEntity().With<CompNav>().With<CompAI>();
	}

	private EntityBuilder MakeBehaveEntity()
	{
		return MakeEntity().With<CompTransform>().With<CompTime>().With<CompInput>()
			.With<CompMotion>()
			.With<CompPhysics>()
			.With<CompAbility>()
			.With<CompEffect>()
			.With<CompAim>()
			.With<CompHatred>()
			.With<CompSound>();
	}

	public Entity GetEntity(EntityId id)
	{
		return _world.GetEntity(id);
	}

	public EntityId NewEntityId()
	{
		return _world.GenerateNewEntityId();
	}

	private EntityBuilder MakeEntity(EntityId? entityId = null)
	{
		EntityBuilder entityBuilder = _world.NewEntity().With<CompBehave>().With<CompAlliance>();
		if (entityId.HasValue)
		{
			entityBuilder.WithId(entityId.Value);
		}
		return entityBuilder;
	}

	public void DestroyEntity(Entity entity)
	{
		DestroyEntity(entity.Id);
	}

	public void DestroyEntity(EntityId eId)
	{
		if (_world.IsEntityValid(eId))
		{
			Entity entity = _world.GetEntity(eId);
			Singleton<GameManager>.instance?.ecsManager.ReportEntityBeforeDestroy(entity);
			if (entity.GetCompCharacter()?.characterSource is Character character)
			{
				EntityHelper.UnregisterBattleEntity(character, entity);
			}
			RemoveEntityBehaveEvt evt = Singleton<EventManager>.instance.GetEvt<RemoveEntityBehaveEvt>();
			evt.entityBehave = entity;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.OnRemoveEntityBeahve, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
			_world.DestroyEntity(eId);
			EventTrackSolver.Instance?.Dispatch(EventTrackSolver.Instance?.GetEvt<TrackRemoveEntity>());
		}
	}

	internal Entity CreateGroupAIEntity(int groupId, YooAssetReference ai)
	{
		return MakeEntity().With<CompBehave>().With<CompAI>().With((CompGroupAI comp) =>
		{
			comp.id = groupId;
		})
			.SpawnAndReport();
	}

	public Entity CreateStateEntity()
	{
		return MakeEntity().With<CompTransform>().With<CompTime>().With<CompSound>()
			.With<CompStateObject>()
			.SpawnAndReport();
	}

	public Entity CreateAttackEntity()
	{
		return MakeEntity().With<CompTransform>().With<CompTime>().With<CompAbility>()
			.With<CompSound>()
			.With<CompStateObject>()
			.SpawnAndReport();
	}

	public Entity CreateDummyEntity()
	{
		return MakeEntity().With<CompTransform>().With<CompProduct>().SpawnAndReport();
	}

	public Entity CreateEnemy(int paramID)
	{
		return MakeNavEntity().With<CompStateObject>().SpawnAndReport();
	}

	public Entity CreateAssistNpc()
	{
		return MakeNavEntity().With<CompAssistNpc>().SpawnAndReport();
	}

	public Entity CreateCommonEntity()
	{
		return MakeEntity().With<CompTransform>().With<CompTime>().With<CompInput>()
			.With<CompMotion>()
			.With<CompPhysics>()
			.With<CompNav>()
			.With<CompEffect>()
			.With<CompAI>()
			.With<CompStateObject>()
			.With<CompAbility>()
			.With<CompSound>()
			.SpawnAndReport();
	}

	public void AttachSpotLightComp(Entity entity)
	{
		entity.AddCompSpotLightBuffer();
	}

	internal void SpawnBehave(Entity eb, bool faceLeft)
	{
		eb.GetMono().SetEB(eb);
		GameManager.physicsSystem.OnSpawn(eb, faceLeft);
		GameManager.behaveSystem.OnSpawn(eb);
		ConfigCharacter config = eb.GetConfig();
		if (config.animationSchema == AnimationSchema.LookAtCamera)
		{
			faceLeft = false;
		}
		if (faceLeft && config.animationSchema == AnimationSchema.LockRotation)
		{
			eb.SetBool("born_left", value: true);
		}
	}

	public void EnqueueBehave(Entity eb)
	{
		GameManager.timeSystem.InitializeEntity(eb);
	}

	public Entity CreateProductEnemy(int paraID)
	{
		return MakeNavEntity().With<CompProduct>().SpawnAndReport();
	}

	public Entity CreateBaseCharacter()
	{
		return MakeEntity().With<CompAbility>().With<CompCharacter>().SpawnAndReport();
	}

	public Entity CreateBattleCharacter()
	{
		return MakeBehaveEntity().With<CompCharacter>().With<CompTrigger>().With<CompOperateBtn>()
			.SpawnAndReport();
	}

	public Entity CreateMechanismTrapEntity()
	{
		return MakeEntity().With<CompTransform>().With<CompTime>().With<CompAbility>()
			.With<CompEffect>()
			.With<CompNeutral>()
			.With<CompSound>()
			.With<CompAim>()
			.With<CompLaser>()
			.With<CompStateObject>()
			.SpawnAndReport();
	}

	public Entity CreatLaserEntity()
	{
		return MakeEntity().With<CompTransform>().With<CompTime>().With<CompAbility>()
			.With<CompEffect>()
			.With<CompSound>()
			.With<CompStateObject>()
			.With<CompLaser>()
			.SpawnAndReport();
	}

	public Entity CreateNPCEntity()
	{
		return MakeEntity().With<CompTransform>().With<CompTime>().With<CompSound>()
			.With<CompInteract>()
			.With<CompNpc>()
			.With<CompBubble>()
			.SpawnAndReport();
	}

	public void RemoveBattlePart(Entity entity)
	{
		entity.RemoveCompTransform();
		entity.RemoveCompTime();
		entity.RemoveCompInput();
		entity.RemoveCompMotion();
		entity.RemoveCompPhysics();
		entity.RemoveCompEffect();
		entity.RemoveCompAim();
		entity.RemoveCompHatred();
		entity.RemoveCompSound();
		entity.RemoveCompTrigger();
		entity.RemoveCompOperateBtn();
		entity.GetCompBehave()?.ReleaseInstance();
	}

	public Entity AddBattlePart(Entity entity)
	{
		return entity.AddCompTransform().AddCompTime().AddCompInput()
			.AddCompMotion()
			.AddCompPhysics()
			.AddCompEffect()
			.AddCompAim()
			.AddCompHatred()
			.AddCompSound()
			.AddCompTrigger()
			.AddCompOperateBtn();
	}

	public Entity CreateAbilityEntity()
	{
		return MakeEntity().With<CompTransform>().With<CompTime>().With<CompVelocity>()
			.With<CompAbility>()
			.With<CompProduct>()
			.With<CompTrajectory>()
			.With<CompEffect>()
			.With<CompAim>()
			.With<CompSound>()
			.With<CompHatred>()
			.SpawnAndReport();
	}
}
