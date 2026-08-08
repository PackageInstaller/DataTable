using UnityEngine;

namespace Pathfinding.RVO;

[AddComponentMenu("Pathfinding/Local Avoidance/RVO Simulator")]
[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_r_v_o_1_1_r_v_o_simulator.php")]
public class RVOSimulator : VersionedMonoBehaviour
{
	[Tooltip("Desired FPS for rvo simulation. It is usually not necessary to run a crowd simulation at a very high fps.\nUsually 10-30 fps is enough, but can be increased for better quality.\nThe rvo simulation will never run at a higher fps than the game")]
	public int desiredSimulationFPS = 20;

	private int turnTime = 50;

	[Tooltip("Number of RVO worker threads. If set to None, no multithreading will be used.")]
	public ThreadCount workerThreads;

	[Tooltip("Calculate local avoidance in between frames.\nThis can increase jitter in the agents' movement so use it only if you really need the performance boost. It will also reduce the responsiveness of the agents to the commands you send to them.")]
	public bool doubleBuffering;

	[Range(0f, 0.2f)]
	[Tooltip("Bias agents to pass each other on the right side.\nIf the desired velocity of an agent puts it on a collision course with another agent or an obstacle its desired velocity will be rotated this number of radians (1 radian is approximately 57°) to the right. This helps to break up symmetries and makes it possible to resolve some situations much faster.\n\nWhen many agents have the same goal this can however have the side effect that the group clustered around the target point may as a whole start to spin around the target point.")]
	public float symmetryBreakingBias = 0.1f;

	[Tooltip("Determines if the XY (2D) or XZ (3D) plane is used for movement")]
	public MovementPlane movementPlane;

	private Simulator simulator;

	private float accumilateTime;

	public static RVOSimulator active { get; private set; }

	public int GameFrame { get; private set; }

	public Simulator GetSimulator()
	{
		if (simulator == null)
		{
			Awake();
		}
		return simulator;
	}

	private void OnEnable()
	{
		active = this;
	}

	protected override void Awake()
	{
		base.Awake();
		turnTime = 1000 / desiredSimulationFPS;
		if (simulator == null && Application.isPlaying)
		{
			int workers = AstarPath.CalculateThreadCount(workerThreads);
			simulator = new Simulator(workers, doubleBuffering, movementPlane);
		}
	}

	private void Update()
	{
		if (Application.isPlaying)
		{
			if (desiredSimulationFPS < 1)
			{
				desiredSimulationFPS = 1;
			}
			Simulator simulator = GetSimulator();
			accumilateTime += Time.deltaTime * 1000f;
			while (accumilateTime > (float)(1000 / desiredSimulationFPS))
			{
				simulator.UpdateLogic(100);
				GameFrame++;
				accumilateTime -= turnTime;
			}
		}
	}

	private void OnDestroy()
	{
		active = null;
		if (simulator != null)
		{
			simulator.OnDestroy();
		}
	}
}
