using System;
using System.Collections.Generic;
using ACT.Battle.ECS.System;
using ACT.Battle.ECS.System.SystemBubble;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class ECSManager : GameSubManager, IEntities
{
	private EntityFactory _factory;

	private readonly ActionList<Entity> _onEntityCreate = new ActionList<Entity>();

	private readonly ActionList<Entity> _onEntityBeforeDestroy = new ActionList<Entity>();

	private readonly Bamboo.ECS.World _world = new Bamboo.ECS.World();

	public EntityFactory factory => GetEntityFactory();

	public SystemRogue systemRogue { get; private set; }

	public SystemEntityScope systemEntityScope { get; private set; }

	public SystemBloodBottleRecoverUseCount systemBloodBottleRecoverUseCount { get; private set; }

	public SystemEffect systemEffect { get; private set; }

	public SystemInput systemInput { get; private set; }

	public SystemHandleInput systemHandleInput { get; private set; }

	public SystemTime systemTime { get; private set; }

	public SystemAI systemAI { get; private set; }

	public SystemTeleportMove systemTeleportMove { get; private set; }

	public SystemBehave systemBehave { get; private set; }

	public SystemAssist systemAssist { get; private set; }

	public SystemAnimPlayable systemAnimPlayable { get; private set; }

	public SystemMotionDie systemMotionDie { get; private set; }

	public SystemPhysics systemPhysics { get; private set; }

	public SystemFollow systemFollow { get; private set; }

	public SystemSpotLightBuffer systemSpotLightBuffer { get; private set; }

	public SystemAbility systemAbility { get; private set; }

	public SystemGas systemGas { get; private set; }

	public SystemLaser systemLaser { get; private set; }

	public SystemCamera systemCamera { get; private set; }

	public SystemMonster systemMonster { get; private set; }

	public SystemHatred systemHatred { get; private set; }

	public SystemApc systemApc { get; private set; }

	public SystemComboCount systemComboCount { get; private set; }

	public SystemNpc systemNpc { get; private set; }

	public SystemBubble systemBubble { get; private set; }

	public SystemTrajectory systemTrajectory { get; private set; }

	public SystemProduct systemProduct { get; private set; }

	public SystemGameStateCheck systemGameStateCheck { get; private set; }

	public SystemCommonAudio systemCommonAudio { get; private set; }

	public SystemTheOtherWorld systemTheOtherWorld { get; private set; }

	public SystemEntityTickLOD systemEntityTickLOD { get; private set; }

	public override ContextType ContextType => ContextType.GAME;

	public event Action<Entity> OnEntityCreate
	{
		add
		{
			_onEntityCreate.Add(value);
		}
		remove
		{
			_onEntityCreate.Remove(value);
		}
	}

	public event Action<Entity> OnEntityBeforeDestroy
	{
		add
		{
			_onEntityBeforeDestroy.Add(value);
		}
		remove
		{
			_onEntityBeforeDestroy.Remove(value);
		}
	}

	private EntityFactory GetEntityFactory()
	{
		return _factory ?? (_factory = new EntityFactory(_world));
	}

	public Entity GetEntity(EntityId id)
	{
		return _world.GetEntity(id);
	}

	public void GetAllEntities(List<Entity> output)
	{
		_world.GetAllEntitiesNonAlloc(output);
	}

	public void ForEachEntities(Action<Entity> callback)
	{
		_world.ForEachEntity(callback);
	}

	public IEnumerable<Entity> GetAllEntities()
	{
		return _world.GetAllEntities();
	}

	public void Clear()
	{
		_onEntityCreate.Clear();
		_onEntityBeforeDestroy.Clear();
	}

	internal void ReportEntityCreate(Entity entity)
	{
		_onEntityCreate.Invoke(entity);
	}

	internal void ReportEntityBeforeDestroy(Entity entity)
	{
		_onEntityBeforeDestroy.Invoke(entity);
	}

	private T AddSystem<T>() where T : ECSSystem, new()
	{
		T val = _world.AddSystem(new T());
		val.Enabled = true;
		return val;
	}

	public void DoEndOrPause()
	{
		systemPhysics.Pause();
		systemTime.Pause();
		systemAnimPlayable.Pause();
		systemAI.Pause();
	}

	public void DoStartOrResume()
	{
		systemPhysics.Resume();
		systemTime.Resume();
		systemAnimPlayable.Resume();
		systemAI.Resume();
	}

	public void InitSystems()
	{
		systemEntityScope = AddSystem<SystemEntityScope>();
		systemRogue = AddSystem<SystemRogue>();
		systemBloodBottleRecoverUseCount = AddSystem<SystemBloodBottleRecoverUseCount>();
		systemEntityTickLOD = AddSystem<SystemEntityTickLOD>();
		systemInput = AddSystem<SystemInput>();
		systemHandleInput = AddSystem<SystemHandleInput>();
		systemTime = AddSystem<SystemTime>();
		systemAI = AddSystem<SystemAI>();
		systemTeleportMove = AddSystem<SystemTeleportMove>();
		systemBehave = AddSystem<SystemBehave>();
		systemAssist = AddSystem<SystemAssist>();
		systemAnimPlayable = AddSystem<SystemAnimPlayable>();
		systemMotionDie = AddSystem<SystemMotionDie>();
		systemPhysics = AddSystem<SystemPhysics>();
		systemFollow = AddSystem<SystemFollow>();
		systemSpotLightBuffer = AddSystem<SystemSpotLightBuffer>();
		systemAbility = AddSystem<SystemAbility>();
		systemEffect = AddSystem<SystemEffect>();
		systemGas = AddSystem<SystemGas>();
		systemLaser = AddSystem<SystemLaser>();
		systemCamera = AddSystem<SystemCamera>();
		systemMonster = AddSystem<SystemMonster>();
		systemHatred = AddSystem<SystemHatred>();
		systemApc = AddSystem<SystemApc>();
		systemComboCount = AddSystem<SystemComboCount>();
		systemNpc = AddSystem<SystemNpc>();
		systemBubble = AddSystem<SystemBubble>();
		systemCommonAudio = AddSystem<SystemCommonAudio>();
		systemTrajectory = AddSystem<SystemTrajectory>();
		systemProduct = AddSystem<SystemProduct>();
		systemGameStateCheck = AddSystem<SystemGameStateCheck>();
		systemTheOtherWorld = AddSystem<SystemTheOtherWorld>();
	}

	protected override void Init()
	{
		_world.SetSamplerLevel(Bamboo.ECS.World.SamplerLevel.FixedLateUpdate);
		_world.ChangeEntityLogLevel(EntityLogLevel.Components);
		_world.Start();
	}

	protected override void UnInit()
	{
		_world?.ClearAllEntities();
		_world.Stop();
	}

	protected override void Update()
	{
		_world.Update();
	}

	protected override void FixedUpdate()
	{
		_world.FixedUpdate();
	}

	protected override void FixedLateUpdate()
	{
		_world.FixedLateUpdate();
	}

	protected override void LateUpdate()
	{
		_world.LateUpdate();
	}
}
