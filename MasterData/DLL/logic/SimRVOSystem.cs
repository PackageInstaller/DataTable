using Entitas;
using Pathfinding;
using Pathfinding.RVO;
using Pathfinding.RVO.Sampled;

public class SimRVOSystem : IInitializeSystem, ISystem, IExecuteSystem, ITearDownSystem
{
	public ThreadCount workerThreads;

	public bool doubleBuffering;

	public float symmetryBreakingBias = 0.1f;

	public static MovementPlane movementPlane;

	public static Simulator simulator;

	private SimContext mSimContext;

	private ISimulatorInferface simulatorInferface;

	public static Simulator RVOSimulator
	{
		get
		{
			if (simulator == null)
			{
				int workers = AstarPath.CalculateThreadCount(ThreadCount.None);
				simulator = new Simulator(workers, doubleBuffering: false, MovementPlane.XZ);
			}
			return simulator;
		}
	}

	public Simulator GetSimulator()
	{
		if (simulator == null)
		{
			Initialize();
		}
		return simulator;
	}

	public SimRVOSystem(Contexts contexts)
	{
		mSimContext = contexts.sim;
	}

	public SimRVOSystem(Contexts contexts, ISimulatorInferface simulatorInferface)
		: this(contexts)
	{
		this.simulatorInferface = simulatorInferface;
	}

	public void Initialize()
	{
		mSimContext.SimEventSystem.AddHandler<EntitySpawnedEvent>(OnSpawnEntityEventHandler);
		mSimContext.SimEventSystem.AddHandler<EntityDespawnedEvent>(OnDespawnEntityEventHandler);
		if (simulator == null)
		{
			int workers = AstarPath.CalculateThreadCount(workerThreads);
			simulator = new Simulator(workers, doubleBuffering, movementPlane);
		}
	}

	private void OnDespawnEntityEventHandler(EntityDespawnedEvent eventReceived)
	{
		if (simulator != null)
		{
			SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(eventReceived.DestroyedEntity);
			if (entityWithEntityID.hasEntityRVO && simulator != null)
			{
				simulator.RemoveAgent(entityWithEntityID.entityRVO.agent);
			}
		}
	}

	private void OnSpawnEntityEventHandler(EntitySpawnedEvent eventReceived)
	{
		SimEntity entityWithEntityID = mSimContext.GetEntityWithEntityID(eventReceived.NewEntity);
		if (!entityWithEntityID.hasEntityShape)
		{
			XLogger.Debug("实体没有外形组件，无法绑定RVO");
		}
	}

	public void Execute()
	{
		Simulator simulator = GetSimulator();
		mSimContext.GetGroup(SimMatcher.EntityRVO).DoAction(delegate(SimEntity simEnity)
		{
			if (simEnity.hasEntityPositon)
			{
				SetTarget(simEnity);
				UpdateAgentProperties(simEnity.entityRVO.agent, simEnity);
			}
		});
		int tickTime = mSimContext.simStatus.runtimeSetting.kSimTickPeriodMS;
		simulator.UpdateLogic(tickTime);
		mSimContext.GetGroup(SimMatcher.EntityRVO).DoAction(delegate(SimEntity simEnity)
		{
			if (simEnity.hasEntityPositon)
			{
				Int3 @int = CalculateMovementDelta(simEnity, simEnity.entityRVO.agent.CalculatedTargetPoint, simEnity.entityRVO.agent.CalculatedSpeed, tickTime);
				Int obj = simEnity.entityRVO.agent.CalculatedSpeed;
				Int3 position = simEnity.entityPositon.mPosition + @int;
				NNInfo nearest = AstarPath.active.GetNearest(position);
				RecastGraph recastGraph = AstarData.GetGraph(nearest.node) as RecastGraph;
				NNConstraint nNConstraint = new NNConstraint
				{
					distanceXZ = true
				};
				TriangleMeshNode triangleMeshNode = nearest.node as TriangleMeshNode;
				if (triangleMeshNode == null && simEnity.entityRVO.bugDirection != 0)
				{
					@int = Int3.zero;
					obj = 0;
				}
				simEnity.entityPositon.mPosition += @int;
				simEnity[EntityVarName.ENTITY_CALCULATED_SPEED] = obj;
				@int.Normalize();
				simEnity[EntityVarName.ENTITY_CALCULATED_VELOCITY] = @int;
				@int.Normalize();
				if (simEnity.hasEntityRemotePlayer)
				{
					simEnity.entityShape.mShape.UpdateWorldShape(simEnity.entityPositon.mPosition, @int);
				}
			}
		});
	}

	public static Int3 CalculateMovementDelta(SimEntity entity, Int2 calculatedTargetPoint, Int calculatedSpeed, int deltaTime)
	{
		Int2 @int = Int2.ClampMagnitude(calculatedTargetPoint - To2D(entity.entityPositon.mPosition), (calculatedSpeed * new VFactor(deltaTime, 1000L)).i);
		return To3D(@int, 0);
	}

	public void TearDown()
	{
		if (simulator != null)
		{
			simulator.OnDestroy();
			simulator = null;
		}
	}

	protected IAgent AddRVOAgent(SimEntity entity)
	{
		Int2 position = To2D(entity.entityPositon.mPosition, out var elevation);
		IAgent agent = simulator.AddAgent(position, elevation);
		UpdateAgentProperties(agent, entity);
		entity.entityRVO.agent = agent as Agent;
		return agent;
	}

	protected void RemoveAgent(IAgent agent)
	{
		simulator.RemoveAgent(agent);
	}

	protected static void UpdateAgentProperties(IAgent rvoAgent, SimEntity entity)
	{
		rvoAgent.Radius = entity.entityShape.mShape.AvgCollisionRadius;
		rvoAgent.AgentTimeHorizon = entity.entityRVO.mAgentTimeHorizon;
		rvoAgent.ObstacleTimeHorizon = entity.entityRVO.mObstacleTimeHorizon;
		rvoAgent.MaxNeighbours = entity.entityRVO.mMaxNeighbours;
		rvoAgent.Layer = entity.entityRVO.mLayer;
		rvoAgent.CollidesWith = entity.entityRVO.mColliderWith;
		rvoAgent.Priority = entity.entityRVO.mPriority;
		rvoAgent.Position = To2D(entity.entityPositon.mPosition, out var elevation);
		if (movementPlane == MovementPlane.XZ)
		{
			rvoAgent.Height = entity.entityShape.mShape.WorldPos.y * 1000;
			rvoAgent.ElevationCoordinate = elevation - rvoAgent.Height * VFactor.half;
		}
		else
		{
			rvoAgent.Height = 1;
			rvoAgent.ElevationCoordinate = 0;
		}
	}

	public static void SetTarget(SimEntity simEnity)
	{
		if (simulator != null)
		{
			simEnity.entityRVO.agent.SetTarget(simEnity.creationIndex, To2D(simEnity[EntityVarName.ENTITY_DESIRED_POSITION]), simEnity[EntityVarName.ENTITY_DESIRED_SPEED].intVar, (Int)simEnity.entityBlackboard.var.mMaxSpeed);
			simEnity.entityRVO.agent.Locked = (simEnity.hasEntityActionAttack || simEnity.hasEntityHitRecover || simEnity.hasEntityActionAbility || simEnity.hasEntityActionMelee || simEnity.entityRVO.mlockWhenNotMoving) && (int)simEnity[EntityVarName.ENTITY_DESIRED_SPEED] < 1;
		}
	}

	public void SetCollisionNormal(IAgent rvoAgent, Int3 normal)
	{
		rvoAgent.SetCollisionNormal(To2D(normal));
	}

	public void ForceSetVelocity(IAgent rvoAgent, Int3 velocity)
	{
		rvoAgent.ForceSetVelocity(To2D(velocity));
	}

	public static Int2 To2D(Int3 p, out int elevation)
	{
		if (movementPlane == MovementPlane.XY)
		{
			elevation = p.z;
			return new Int2(p.x, p.y);
		}
		elevation = p.y;
		return new Int2(p.x, p.z);
	}

	public static Int3 To3D(Int3 p, int elevationCoordinate)
	{
		if (movementPlane == MovementPlane.XY)
		{
			return new Int3(p.x, p.y, elevationCoordinate);
		}
		return new Int3(p.x, elevationCoordinate, p.y);
	}

	public static Int2 To2D(Int3 p)
	{
		int elevation;
		return To2D(p, out elevation);
	}
}
