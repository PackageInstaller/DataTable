using System;
using UnityEngine;

namespace Pathfinding.RVO;

[AddComponentMenu("Pathfinding/Local Avoidance/RVO Controller")]
[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_r_v_o_1_1_r_v_o_controller.php")]
public class RVOController : VersionedMonoBehaviour
{
	[Tooltip("Radius of the agent")]
	public float radius = 0.5f;

	[Tooltip("Height of the agent. In world units")]
	[HideInInspector]
	public float height = 2f;

	[Tooltip("A locked unit cannot move. Other units will still avoid it. But avoidance quality is not the best")]
	public bool locked;

	[Tooltip("Automatically set #locked to true when desired velocity is approximately zero")]
	public bool lockWhenNotMoving = true;

	[Tooltip("How far into the future to look for collisions with other agents (in seconds)")]
	public float agentTimeHorizon = 2f;

	[Tooltip("How far into the future to look for collisions with obstacles (in seconds)")]
	public float obstacleTimeHorizon = 2f;

	[Tooltip("Max number of other agents to take into account.\nA smaller value can reduce CPU load, a higher value can lead to better local avoidance quality.")]
	public int maxNeighbours = 10;

	public RVOLayer layer = RVOLayer.DefaultAgent;

	[AstarEnumFlag]
	public RVOLayer collidesWith = (RVOLayer)(-1);

	[HideInInspector]
	[Obsolete]
	public float wallAvoidForce = 1f;

	[Obsolete]
	[HideInInspector]
	public float wallAvoidFalloff = 1f;

	[Tooltip("How strongly other agents will avoid this agent")]
	[Range(0f, 1f)]
	public float priority = 0.5f;

	[Tooltip("Center of the agent relative to the pivot point of this game object")]
	[HideInInspector]
	public float center = 1f;

	protected Transform tr;

	public bool debug;

	[Obsolete("This field is obsolete in version 4.0 and will not affect anything. Use the LegacyRVOController if you need the old behaviour")]
	public LayerMask mask
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return LayerMask.op_Implicit(0);
		}
		set
		{
		}
	}

	[Obsolete("This field is obsolete in version 4.0 and will not affect anything. Use the LegacyRVOController if you need the old behaviour")]
	public bool enableRotation
	{
		get
		{
			return false;
		}
		set
		{
		}
	}

	[Obsolete("This field is obsolete in version 4.0 and will not affect anything. Use the LegacyRVOController if you need the old behaviour")]
	public float rotationSpeed
	{
		get
		{
			return 0f;
		}
		set
		{
		}
	}

	[Obsolete("This field is obsolete in version 4.0 and will not affect anything. Use the LegacyRVOController if you need the old behaviour")]
	public float maxSpeed
	{
		get
		{
			return 0f;
		}
		set
		{
		}
	}

	public MovementPlane movementPlane
	{
		get
		{
			if (simulator != null)
			{
				return simulator.movementPlane;
			}
			if (Object.op_Implicit((Object)(object)RVOSimulator.active))
			{
				return RVOSimulator.active.movementPlane;
			}
			return MovementPlane.XZ;
		}
	}

	public IAgent rvoAgent { get; private set; }

	public Simulator simulator { get; private set; }

	public Vector3 position
	{
		get
		{
			//IL_0017: Unknown result type (might be due to invalid IL or missing references)
			return To3D(rvoAgent.Position, rvoAgent.ElevationCoordinate);
		}
	}

	public Vector3 velocity
	{
		get
		{
			//IL_0022: Unknown result type (might be due to invalid IL or missing references)
			//IL_0012: Unknown result type (might be due to invalid IL or missing references)
			//IL_001c: Unknown result type (might be due to invalid IL or missing references)
			if (Time.deltaTime > 1E-05f)
			{
				return CalculateMovementDelta(Time.deltaTime) / Time.deltaTime;
			}
			return Vector3.zero;
		}
	}

	public Vector3 CalculateMovementDelta(float deltaTime)
	{
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		if (rvoAgent == null)
		{
			return Vector3.zero;
		}
		return To3D(Vector2.ClampMagnitude((Vector2)rvoAgent.CalculatedTargetPoint - To2D(tr.position), (float)rvoAgent.CalculatedSpeed * deltaTime), 0f);
	}

	public Vector3 CalculateMovementDelta(Vector3 position, float deltaTime)
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		return To3D(Vector2.ClampMagnitude((Vector2)rvoAgent.CalculatedTargetPoint - To2D(position), (float)rvoAgent.CalculatedSpeed * deltaTime), 0f);
	}

	public void SetCollisionNormal(Vector3 normal)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		rvoAgent.SetCollisionNormal((Int2)To2D(normal));
	}

	public void ForceSetVelocity(Vector3 velocity)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		rvoAgent.ForceSetVelocity((Int2)To2D(velocity));
	}

	public Vector2 To2D(Vector3 p)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0004: Unknown result type (might be due to invalid IL or missing references)
		float elevation;
		return To2D(p, out elevation);
	}

	public Int2 To2D(Int3 p)
	{
		float elevation;
		return To2D(p, out elevation);
	}

	public Vector2 To2D(Vector3 p, out float elevation)
	{
		//IL_0024: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		if (movementPlane == MovementPlane.XY)
		{
			elevation = p.z;
			return new Vector2(p.x, p.y);
		}
		elevation = p.y;
		return new Vector2(p.x, p.z);
	}

	public Int2 To2D(Int3 p, out float elevation)
	{
		if (movementPlane == MovementPlane.XY)
		{
			elevation = p.z;
			return new Int2(p.x, p.y);
		}
		elevation = p.y;
		return new Int2(p.x, p.z);
	}

	public Vector3 To3D(Vector2 p, float elevationCoordinate)
	{
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		if (movementPlane == MovementPlane.XY)
		{
			return new Vector3(p.x, p.y, elevationCoordinate);
		}
		return new Vector3(p.x, elevationCoordinate, p.y);
	}

	public Vector3 To3D(Int2 p, Int elevationCoordinate)
	{
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		if (movementPlane == MovementPlane.XY)
		{
			return new Vector3((float)p.x * 0.001f, (float)p.y * 0.001f, (float)elevationCoordinate);
		}
		return new Vector3((float)p.x * 0.001f, (float)elevationCoordinate, (float)p.y * 0.001f);
	}

	private void OnDisable()
	{
		if (simulator != null)
		{
			simulator.RemoveAgent(rvoAgent);
		}
	}

	private void OnEnable()
	{
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		tr = ((Component)this).transform;
		if ((Object)(object)RVOSimulator.active == (Object)null)
		{
			Debug.LogError((object)"No RVOSimulator component found in the scene. Please add one.");
			return;
		}
		simulator = RVOSimulator.active.GetSimulator();
		if (rvoAgent != null)
		{
			simulator.AddAgent(rvoAgent);
		}
		else
		{
			Vector2 val = To2D(((Component)this).transform.position, out var elevation);
			rvoAgent = simulator.AddAgent((Int2)val, (Int)elevation);
			rvoAgent.PreCalculationCallback = UpdateAgentProperties;
		}
		UpdateAgentProperties();
	}

	protected void UpdateAgentProperties()
	{
		//IL_00c5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		rvoAgent.Radius = IntMath.Max(1, (Int)radius);
		rvoAgent.AgentTimeHorizon = (VFactor)agentTimeHorizon;
		rvoAgent.ObstacleTimeHorizon = (VFactor)obstacleTimeHorizon;
		rvoAgent.Locked = locked;
		rvoAgent.MaxNeighbours = maxNeighbours;
		rvoAgent.DebugDraw = debug;
		rvoAgent.Layer = layer;
		rvoAgent.CollidesWith = collidesWith;
		rvoAgent.Priority = (VFactor)priority;
		rvoAgent.Position = (Int2)To2D(((Component)this).transform.position, out var elevation);
		if (movementPlane == MovementPlane.XZ)
		{
			rvoAgent.Height = (Int)height;
			rvoAgent.ElevationCoordinate = new Int(elevation + center - 0.5f * height);
		}
		else
		{
			rvoAgent.Height = 1;
			rvoAgent.ElevationCoordinate = 0;
		}
	}

	public void SetTarget(Vector3 pos, float speed, float maxSpeed)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_0039: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		if (simulator != null)
		{
			Debug.Log((object)("Target pos === " + ((object)(pos * 1000f)/*cast due to constrained. prefix*/).ToString()));
			rvoAgent.SetTarget(0, (Int2)To2D(pos), new Int(speed), new Int(maxSpeed));
			if (lockWhenNotMoving)
			{
				locked = speed < 0.001f;
			}
		}
	}

	public void SetTarget(Int3 pos, Int speed, Int maxSpeed)
	{
		if (simulator != null)
		{
			rvoAgent.SetTarget(0, To2D(pos), speed, maxSpeed);
			if (lockWhenNotMoving)
			{
				locked = speed < 1;
			}
		}
	}

	public void Move(Vector3 vel)
	{
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		if (simulator != null)
		{
			Vector2 val = To2D(vel);
			float magnitude = ((Vector2)(ref val)).magnitude;
			rvoAgent.SetTarget(0, (Int2)(To2D(tr.position) + val), new Int(magnitude), new Int(magnitude));
			if (lockWhenNotMoving)
			{
				locked = magnitude < 0.001f;
			}
		}
	}
}
