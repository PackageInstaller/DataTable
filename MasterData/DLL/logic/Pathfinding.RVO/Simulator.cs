using System;
using System.Collections.Generic;
using System.Threading;
using Pathfinding.RVO.Sampled;
using UnityEngine;

namespace Pathfinding.RVO;

public class Simulator
{
	internal class WorkerContext
	{
		public Agent.VOBuffer vos = new Agent.VOBuffer(16);

		public const int KeepCount = 3;

		public Vector2[] bestPos = (Vector2[])(object)new Vector2[3];

		public float[] bestSizes = new float[3];

		public float[] bestScores = new float[4];

		public Vector2[] samplePos = (Vector2[])(object)new Vector2[50];

		public float[] sampleSize = new float[50];
	}

	private class Worker
	{
		public int start;

		public int end;

		private readonly AutoResetEvent runFlag = new AutoResetEvent(initialState: false);

		private readonly ManualResetEvent waitFlag = new ManualResetEvent(initialState: true);

		private readonly Simulator simulator;

		private int task;

		private bool terminate;

		private WorkerContext context = new WorkerContext();

		public Worker(Simulator sim)
		{
			simulator = sim;
			Thread thread = new Thread(Run);
			thread.IsBackground = true;
			thread.Name = "RVO Simulator Thread";
			thread.Start();
		}

		public void Execute(int task)
		{
			this.task = task;
			waitFlag.Reset();
			runFlag.Set();
		}

		public void WaitOne()
		{
			if (!terminate)
			{
				waitFlag.WaitOne();
			}
		}

		public void Terminate()
		{
			WaitOne();
			terminate = true;
			Execute(-1);
		}

		public void Run()
		{
			runFlag.WaitOne();
			while (!terminate)
			{
				try
				{
					List<Agent> agents = simulator.GetAgents();
					if (task == 0)
					{
						for (int i = start; i < end; i++)
						{
							agents[i].CalculateNeighbours();
							agents[i].CalculateVelocity(context);
						}
					}
					else if (task == 1)
					{
						for (int j = start; j < end; j++)
						{
							agents[j].BufferSwitch();
						}
					}
					else
					{
						if (task != 2)
						{
							Debug.LogError((object)("Invalid Task Number: " + task));
							throw new Exception("Invalid Task Number: " + task);
						}
						simulator.BuildQuadtree();
					}
				}
				catch (Exception ex)
				{
					Debug.LogError((object)ex);
				}
				waitFlag.Set();
				runFlag.WaitOne();
			}
		}
	}

	private readonly bool doubleBuffering = true;

	private float desiredDeltaTime = 0.05f;

	private readonly Worker[] workers;

	private List<Agent> agents;

	public List<ObstacleVertex> obstacles;

	private VFactor deltaTime;

	private float lastStep = -99999f;

	private bool doUpdateObstacles;

	private bool doCleanObstacles;

	public VFactor symmetryBreakingBias = new VFactor(1L, 2L);

	public readonly MovementPlane movementPlane;

	private WorkerContext coroutineWorkerContext = new WorkerContext();

	public RVOQuadtree Quadtree { get; private set; }

	public VFactor DeltaTime => deltaTime;

	public bool Multithreading
	{
		get
		{
			if (workers != null)
			{
				return workers.Length != 0;
			}
			return false;
		}
	}

	public float DesiredDeltaTime
	{
		get
		{
			return desiredDeltaTime;
		}
		set
		{
			desiredDeltaTime = Math.Max(value, 0f);
		}
	}

	public List<Agent> GetAgents()
	{
		return agents;
	}

	public List<ObstacleVertex> GetObstacles()
	{
		return obstacles;
	}

	public Simulator(int workers, bool doubleBuffering, MovementPlane movementPlane)
	{
		this.workers = new Worker[workers];
		this.doubleBuffering = doubleBuffering;
		DesiredDeltaTime = 1f;
		this.movementPlane = movementPlane;
		Quadtree = new RVOQuadtree();
		for (int i = 0; i < workers; i++)
		{
			this.workers[i] = new Worker(this);
		}
		agents = new List<Agent>();
		obstacles = new List<ObstacleVertex>();
	}

	public void ClearAgents()
	{
		BlockUntilSimulationStepIsDone();
		for (int i = 0; i < agents.Count; i++)
		{
			agents[i].simulator = null;
		}
		agents.Clear();
	}

	public void OnDestroy()
	{
		if (workers != null)
		{
			for (int i = 0; i < workers.Length; i++)
			{
				workers[i].Terminate();
			}
		}
	}

	~Simulator()
	{
		OnDestroy();
	}

	public IAgent AddAgent(IAgent agent)
	{
		if (agent == null)
		{
			throw new ArgumentNullException("Agent must not be null");
		}
		if (!(agent is Agent agent2))
		{
			throw new ArgumentException("The agent must be of type Agent. Agent was of type " + agent.GetType());
		}
		if (agent2.simulator != null && agent2.simulator == this)
		{
			throw new ArgumentException("The agent is already in the simulation");
		}
		if (agent2.simulator != null)
		{
			throw new ArgumentException("The agent is already added to another simulation");
		}
		agent2.simulator = this;
		BlockUntilSimulationStepIsDone();
		agents.Add(agent2);
		return agent;
	}

	[Obsolete("Use AddAgent(Vector2,float) instead")]
	public IAgent AddAgent(Vector3 position)
	{
		return null;
	}

	public IAgent AddAgent(Int2 position, Int elevationCoordinate)
	{
		return AddAgent((IAgent)new Agent(position, elevationCoordinate));
	}

	public void RemoveAgent(IAgent agent)
	{
		if (agent == null)
		{
			throw new ArgumentNullException("Agent must not be null");
		}
		if (!(agent is Agent agent2))
		{
			throw new ArgumentException("The agent must be of type Agent. Agent was of type " + agent.GetType());
		}
		if (agent2.simulator != this)
		{
			throw new ArgumentException("The agent is not added to this simulation");
		}
		BlockUntilSimulationStepIsDone();
		agent2.simulator = null;
		if (!agents.Remove(agent2))
		{
			throw new ArgumentException("Critical Bug! This should not happen. Please report this.");
		}
	}

	public ObstacleVertex AddObstacle(ObstacleVertex v)
	{
		if (v == null)
		{
			throw new ArgumentNullException("Obstacle must not be null");
		}
		BlockUntilSimulationStepIsDone();
		obstacles.Add(v);
		UpdateObstacles();
		return v;
	}

	public ObstacleVertex AddObstacle(Int3[] vertices, Int height, bool cycle = true)
	{
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		return AddObstacle(vertices, height, Matrix4x4.identity, RVOLayer.DefaultObstacle, cycle);
	}

	public ObstacleVertex AddObstacle(Int3[] vertices, Int height, Matrix4x4 matrix, RVOLayer layer = RVOLayer.DefaultObstacle, bool cycle = true)
	{
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		if (vertices == null)
		{
			throw new ArgumentNullException("Vertices must not be null");
		}
		if (vertices.Length < 2)
		{
			throw new ArgumentException("Less than 2 vertices in an obstacle");
		}
		ObstacleVertex obstacleVertex = null;
		ObstacleVertex obstacleVertex2 = null;
		BlockUntilSimulationStepIsDone();
		for (int i = 0; i < vertices.Length; i++)
		{
			ObstacleVertex obstacleVertex3 = new ObstacleVertex
			{
				prev = obstacleVertex2,
				layer = layer,
				height = height
			};
			if (obstacleVertex == null)
			{
				obstacleVertex = obstacleVertex3;
			}
			else
			{
				obstacleVertex2.next = obstacleVertex3;
			}
			obstacleVertex2 = obstacleVertex3;
		}
		if (cycle)
		{
			obstacleVertex2.next = obstacleVertex;
			obstacleVertex.prev = obstacleVertex2;
		}
		UpdateObstacle(obstacleVertex, vertices, matrix);
		obstacles.Add(obstacleVertex);
		return obstacleVertex;
	}

	public ObstacleVertex AddObstacle(Int3 a, Int3 b, Int height)
	{
		ObstacleVertex obstacleVertex = new ObstacleVertex();
		ObstacleVertex obstacleVertex2 = new ObstacleVertex();
		obstacleVertex.layer = RVOLayer.DefaultObstacle;
		obstacleVertex2.layer = RVOLayer.DefaultObstacle;
		obstacleVertex.prev = obstacleVertex2;
		obstacleVertex2.prev = obstacleVertex;
		obstacleVertex.next = obstacleVertex2;
		obstacleVertex2.next = obstacleVertex;
		obstacleVertex.position = a;
		obstacleVertex2.position = b;
		obstacleVertex.height = height;
		obstacleVertex2.height = height;
		obstacleVertex2.ignore = true;
		obstacleVertex.dir = new Int2(b.x - a.x, b.z - a.z).normalized;
		obstacleVertex2.dir = -obstacleVertex.dir;
		BlockUntilSimulationStepIsDone();
		obstacles.Add(obstacleVertex);
		UpdateObstacles();
		return obstacleVertex;
	}

	public void UpdateObstacle(ObstacleVertex obstacle, Int3[] vertices, Matrix4x4 matrix)
	{
		//IL_002d: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0064: Unknown result type (might be due to invalid IL or missing references)
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		if (vertices == null)
		{
			throw new ArgumentNullException("Vertices must not be null");
		}
		if (obstacle == null)
		{
			throw new ArgumentNullException("Obstacle must not be null");
		}
		if (vertices.Length < 2)
		{
			throw new ArgumentException("Less than 2 vertices in an obstacle");
		}
		bool flag = matrix == Matrix4x4.identity;
		BlockUntilSimulationStepIsDone();
		int num = 0;
		ObstacleVertex obstacleVertex = obstacle;
		do
		{
			if (num >= vertices.Length)
			{
				Debug.DrawLine((Vector3)obstacleVertex.prev.position, (Vector3)obstacleVertex.position, Color.red);
				throw new ArgumentException("Obstacle has more vertices than supplied for updating (" + vertices.Length + " supplied)");
			}
			obstacleVertex.position = (flag ? vertices[num] : ((Int3)((Matrix4x4)(ref matrix)).MultiplyPoint3x4((Vector3)vertices[num])));
			obstacleVertex = obstacleVertex.next;
			num++;
		}
		while (obstacleVertex != obstacle && obstacleVertex != null);
		obstacleVertex = obstacle;
		do
		{
			if (obstacleVertex.next == null)
			{
				obstacleVertex.dir = Int2.zero;
			}
			else
			{
				Int3 @int = obstacleVertex.next.position - obstacleVertex.position;
				obstacleVertex.dir = new Int2(@int.x, @int.z).normalized;
			}
			obstacleVertex = obstacleVertex.next;
		}
		while (obstacleVertex != obstacle && obstacleVertex != null);
		ScheduleCleanObstacles();
		UpdateObstacles();
	}

	private void ScheduleCleanObstacles()
	{
		doCleanObstacles = true;
	}

	private void CleanObstacles()
	{
	}

	public void RemoveObstacle(ObstacleVertex v)
	{
		if (v == null)
		{
			throw new ArgumentNullException("Vertex must not be null");
		}
		BlockUntilSimulationStepIsDone();
		obstacles.Remove(v);
		UpdateObstacles();
	}

	public void UpdateObstacles()
	{
		doUpdateObstacles = true;
	}

	private void BuildQuadtree()
	{
		Quadtree.Clear();
		if (agents.Count > 0)
		{
			VRect bounds = VRect.MinMaxRect(agents[0].position.x, agents[0].position.y, agents[0].position.x, agents[0].position.y);
			for (int i = 1; i < agents.Count; i++)
			{
				Int2 position = agents[i].position;
				bounds = VRect.MinMaxRect(Mathf.Min(bounds.xMin, position.x), Mathf.Min(bounds.yMin, position.y), Mathf.Max(bounds.xMax, position.x), Mathf.Max(bounds.yMax, position.y));
			}
			Quadtree.SetBounds(bounds);
			for (int j = 0; j < agents.Count; j++)
			{
				Quadtree.Insert(agents[j]);
			}
		}
		Quadtree.CalculateSpeeds();
	}

	private void BlockUntilSimulationStepIsDone()
	{
		if (Multithreading && doubleBuffering)
		{
			for (int i = 0; i < workers.Length; i++)
			{
				workers[i].WaitOne();
			}
		}
	}

	private void PreCalculation()
	{
		for (int i = 0; i < agents.Count; i++)
		{
			agents[i].PreCalculation();
		}
	}

	private void CleanAndUpdateObstaclesIfNecessary()
	{
		if (doCleanObstacles)
		{
			CleanObstacles();
			doCleanObstacles = false;
			doUpdateObstacles = true;
		}
		if (doUpdateObstacles)
		{
			doUpdateObstacles = false;
		}
	}

	public void UpdateLogic(int turnTime)
	{
		if (deltaTime == VFactor.zero)
		{
			deltaTime = new VFactor(turnTime, 1000L);
		}
		if (Multithreading)
		{
			if (doubleBuffering)
			{
				for (int i = 0; i < workers.Length; i++)
				{
					workers[i].WaitOne();
				}
				for (int j = 0; j < agents.Count; j++)
				{
					agents[j].PostCalculation();
				}
			}
			PreCalculation();
			CleanAndUpdateObstaclesIfNecessary();
			BuildQuadtree();
			for (int k = 0; k < workers.Length; k++)
			{
				workers[k].start = k * agents.Count / workers.Length;
				workers[k].end = (k + 1) * agents.Count / workers.Length;
			}
			for (int l = 0; l < workers.Length; l++)
			{
				workers[l].Execute(1);
			}
			for (int m = 0; m < workers.Length; m++)
			{
				workers[m].WaitOne();
			}
			for (int n = 0; n < workers.Length; n++)
			{
				workers[n].Execute(0);
			}
			if (!doubleBuffering)
			{
				for (int num = 0; num < workers.Length; num++)
				{
					workers[num].WaitOne();
				}
				for (int num2 = 0; num2 < agents.Count; num2++)
				{
					agents[num2].PostCalculation();
				}
			}
		}
		else
		{
			PreCalculation();
			CleanAndUpdateObstaclesIfNecessary();
			BuildQuadtree();
			for (int num3 = 0; num3 < agents.Count; num3++)
			{
				agents[num3].BufferSwitch();
			}
			for (int num4 = 0; num4 < agents.Count; num4++)
			{
				agents[num4].CalculateNeighbours();
				agents[num4].CalculateVelocity(coroutineWorkerContext);
			}
			for (int num5 = 0; num5 < agents.Count; num5++)
			{
				agents[num5].PostCalculation();
			}
		}
	}
}
