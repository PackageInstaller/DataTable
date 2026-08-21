using System;
using System.Collections.Generic;
using P08Common;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding.RVO.Sampled;

public class Agent : IAgent
{
	internal struct VO
	{
		private Int2 line1;

		private Int2 line2;

		private Int2 dir1;

		private Int2 dir2;

		private Int2 cutoffLine;

		private Int2 cutoffDir;

		private Int2 circleCenter;

		private bool colliding;

		private Int radius;

		private VFactor weightFactor;

		private Int weightBonus;

		private Int2 segmentStart;

		private Int2 segmentEnd;

		private bool segment;

		public VO(Int2 center, Int2 offset, Int radius, VFactor inverseDt, VFactor inverseDeltaTime)
		{
			weightFactor = VFactor.one;
			weightBonus = 0;
			circleCenter = center * inverseDt + offset;
			double num = IntMath.Exp(-(center.sqrMagnitudeLong / (radius.i * radius.i)) * (center.sqrMagnitudeLong / (radius.i * radius.i)));
			weightFactor = (VFactor)(float)(4.0 * num + 1.0);
			if (center.magnitude < radius)
			{
				colliding = true;
				line1 = center.normalized * ((center.magnitude - radius.i - 1) * inverseDeltaTime * 3L / 10000L);
				dir1 = new Int2(line1.y, -line1.x).normalized;
				line1 += offset;
				cutoffDir = Int2.zero;
				cutoffLine = Int2.zero;
				dir2 = Int2.zero;
				line2 = Int2.zero;
				this.radius = 0;
			}
			else
			{
				colliding = false;
				center *= inverseDt;
				radius *= inverseDt;
				Int2 @int = center + offset;
				VFactor vFactor = new VFactor(center.magnitude - radius.i + 1, 1000L);
				cutoffLine = center.normalized * vFactor;
				cutoffDir = new Int2(-cutoffLine.y, cutoffLine.x).normalized;
				cutoffLine += offset;
				VFactor vFactor2 = IntMath.atan2(-center.y, -center.x);
				VFactor vFactor3 = IntMath.Abs(IntMath.acos(radius.i, center.magnitude));
				this.radius = radius;
				line1 = new Int2((Int.one * IntMath.cos(vFactor2 + vFactor3)).i, (Int.one * IntMath.sin(vFactor2 + vFactor3)).i);
				dir1 = new Int2(line1.y, -line1.x);
				line2 = new Int2((Int.one * IntMath.cos(vFactor2 - vFactor3)).i, (Int.one * IntMath.sin(vFactor2 - vFactor3)).i);
				dir2 = new Int2(line2.y, -line2.x);
				line1 = line1 * (VFactor)radius + @int;
				line2 = line2 * (VFactor)radius + @int;
			}
			segmentStart = Int2.zero;
			segmentEnd = Int2.zero;
			segment = false;
		}

		private static Vector2 ComplexMultiply(Vector2 a, Vector2 b)
		{
			//IL_0000: Unknown result type (might be due to invalid IL or missing references)
			//IL_0006: Unknown result type (might be due to invalid IL or missing references)
			//IL_000d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0013: Unknown result type (might be due to invalid IL or missing references)
			//IL_001b: Unknown result type (might be due to invalid IL or missing references)
			//IL_0021: Unknown result type (might be due to invalid IL or missing references)
			//IL_0028: Unknown result type (might be due to invalid IL or missing references)
			//IL_002e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0036: Unknown result type (might be due to invalid IL or missing references)
			return new Vector2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
		}

		private static Int2 ComplexMultiply(Int2 a, Int2 b)
		{
			return new Int2(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
		}

		public static VO SegmentObstacle(Int2 segmentStart, Int2 segmentEnd, Int2 offset, Int radius, VFactor inverseDt, VFactor inverseDeltaTime)
		{
			VO result = new VO
			{
				weightFactor = VFactor.one,
				weightBonus = IntMath.Max(radius, Int.one) * 40
			};
			Int3 v = VectorMath.ClosestPointOnSegment((Int3)segmentStart, (Int3)segmentEnd, (Int3)Int2.zero);
			if (v.IntMagnitude <= radius)
			{
				result.colliding = true;
				long magnitude = 0L;
				VFactor vFactor = new VFactor(3L, 10L);
				result.line1 = Int3.Normalize(v, out magnitude) * (VFactor)(v.IntMagnitude - radius) * vFactor * inverseDeltaTime;
				result.dir1 = new Int2(result.line1.y, -result.line1.x).normalized;
				result.line1 += offset;
				result.cutoffDir = Int2.zero;
				result.cutoffLine = Int2.zero;
				result.dir2 = Int2.zero;
				result.line2 = Int2.zero;
				result.radius = 0;
				result.segmentStart = Int2.zero;
				result.segmentEnd = Int2.zero;
				result.segment = false;
			}
			else
			{
				result.colliding = false;
				segmentStart *= inverseDt;
				segmentEnd *= inverseDt;
				radius *= inverseDt;
				Int2 @int = (result.cutoffDir = (segmentEnd - segmentStart).normalized);
				result.cutoffLine = segmentStart + new Int2(-@int.y, @int.x) * (VFactor)radius;
				result.cutoffLine += offset;
				long sqrMagnitudeLong = segmentStart.sqrMagnitudeLong;
				Int2 int2 = -ComplexMultiply(segmentStart, new Int2(radius.i, IntMath.Sqrt(IntMath.Max(0L, sqrMagnitudeLong - radius.i * radius.i))));
				Int2 int3 = int2 * new VFactor(1000L, sqrMagnitudeLong);
				long sqrMagnitudeLong2 = segmentEnd.sqrMagnitudeLong;
				int2 = -ComplexMultiply(segmentEnd, new Int2(radius.i, -IntMath.Sqrt(IntMath.Max(0L, sqrMagnitudeLong2 - radius.i * radius.i))));
				Int2 int4 = int2 * new VFactor(1000L, sqrMagnitudeLong2);
				result.line1 = segmentStart + int3 * (VFactor)radius + offset;
				result.line2 = segmentEnd + int4 * (VFactor)radius + offset;
				result.dir1 = new Int2(int3.y, -int3.x);
				result.dir2 = new Int2(int4.y, -int4.x);
				result.segmentStart = segmentStart;
				result.segmentEnd = segmentEnd;
				result.radius = radius;
				result.segment = true;
			}
			return result;
		}

		public static Int SignedDistanceFromLine(Int2 a, Int2 dir, Int2 p)
		{
			return IntMath.Divide((p.x - a.x) * dir.y - dir.x * (p.y - a.y), 1000);
		}

		public Int2 ScaledGradient(Int2 p, out Int weight)
		{
			Int2 result = Gradient(p, out weight);
			if (weight > 0)
			{
				result *= 2 * weightFactor;
				weight *= 2 * weightFactor;
				weight += Int.one + weightBonus;
			}
			return result;
		}

		public Int2 Gradient(Int2 p, out Int weight)
		{
			if (colliding)
			{
				Int obj = SignedDistanceFromLine(line1, dir1, p);
				if (obj >= 0)
				{
					weight = obj;
					return new Int2(-dir1.y, dir1.x);
				}
				weight = 0;
				return new Int2(0, 0);
			}
			Int obj2 = SignedDistanceFromLine(cutoffLine, cutoffDir, p);
			if (obj2 <= 0)
			{
				weight = 0;
				return Int2.zero;
			}
			Int obj3 = SignedDistanceFromLine(line1, dir1, p);
			Int obj4 = SignedDistanceFromLine(line2, dir2, p);
			if (obj3 >= 0 && obj4 >= 0)
			{
				Int2 result;
				if (Int2.Dot(p - line1, dir1) > 0 && Int2.Dot(p - line2, dir2) < 0)
				{
					if (!segment)
					{
						result = p - circleCenter;
						Int obj5 = (int)result.Normalize();
						weight = radius - obj5;
						return result;
					}
					if (obj2 < radius)
					{
						Int2 @int = VectorMath.ClosestPointOnSegment((Int3)segmentStart, (Int3)segmentEnd, (Int3)p);
						result = p - @int;
						Int obj6 = (int)result.Normalize();
						weight = radius - obj6;
						return result;
					}
				}
				if (segment && obj2 < obj3 && obj2 < obj4)
				{
					weight = obj2;
					return new Int2(-cutoffDir.y, cutoffDir.x);
				}
				if (obj3 < obj4)
				{
					weight = obj3;
					result = new Int2(-dir1.y, dir1.x);
				}
				else
				{
					weight = obj4;
					result = new Int2(-dir2.y, dir2.x);
				}
				return result;
			}
			weight = 0;
			return Int2.zero;
		}
	}

	internal class VOBuffer
	{
		public VO[] buffer;

		public int length;

		public void Clear()
		{
			length = 0;
		}

		public VOBuffer(int n)
		{
			buffer = new VO[n];
			length = 0;
		}

		public void Add(VO vo)
		{
			if (length >= buffer.Length)
			{
				VO[] array = new VO[buffer.Length * 2];
				buffer.CopyTo(array, 0);
				buffer = array;
			}
			buffer[length++] = vo;
		}
	}

	internal Int radius;

	internal Int height;

	internal Int desiredSpeed;

	internal Int maxSpeed;

	internal VFactor obstacleTimeHorizon;

	internal VFactor agentTimeHorizon;

	internal bool locked;

	private RVOLayer layer;

	private RVOLayer collidesWith;

	private int maxNeighbours;

	internal Int2 position;

	private Int elevationCoordinate;

	private Int2 currentVelocity;

	private Int2 desiredTargetPointInVelocitySpace;

	private Int2 desiredVelocity;

	private Int2 nextTargetPoint;

	private Int nextDesiredSpeed;

	private Int nextMaxSpeed;

	private Int2 collisionNormal;

	private bool manuallyControlled;

	private bool debugDraw;

	public int ownerID;

	internal Agent next;

	private Int calculatedSpeed;

	private Int2 calculatedTargetPoint;

	internal Simulator simulator;

	private List<Agent> neighbours = new List<Agent>();

	private List<long> neighbourDists = new List<long>();

	private List<ObstacleVertex> obstaclesBuffered = new List<ObstacleVertex>();

	private List<ObstacleVertex> obstacles = new List<ObstacleVertex>();

	private VFactor DesiredVelocityWeight = new VFactor(1L, 10L);

	private const float WallWeight = 5f;

	private OrcaSolver orcaSolver = new OrcaSolver();

	public VFactor rvoZeroSpeed = new VFactor(1L, 100L);

	private VFactor rvoLowSpeed = new VFactor(5L, 100L);

	private VFactor rvoHighSpeed = VFactor.half;

	private VFactor rvoLowSpeedTimer = VFactor.one;

	private VFactor rvoHighSpeedTimer = new VFactor(5L, 1L);

	private bool rvoAvoidancePriority = true;

	private bool rvoUnstuckPriority = true;

	private bool rvoIdlePriority = true;

	private VFactor rvoPriorityRange = new VFactor(3L, 2L);

	private VFactor rvoPriorityRadiusMultiplier = new VFactor(11L, 10L);

	private VFactor rvoMaxPriorityPropagationDepth = new VFactor(20L, 1L);

	private bool rvoUnmovingAvoidance = true;

	public VFactor rvoSurroundBehaviorDuration = new VFactor(5L, 1L);

	private bool IsAvoidingCollisions = true;

	public Int2 Position { get; set; }

	public Int ElevationCoordinate { get; set; }

	public Int2 CalculatedTargetPoint { get; private set; }

	public Int CalculatedSpeed { get; private set; }

	public bool Locked { get; set; }

	public Int Radius { get; set; }

	public Int Height { get; set; }

	public VFactor AgentTimeHorizon { get; set; }

	public VFactor ObstacleTimeHorizon { get; set; }

	public int MaxNeighbours { get; set; }

	public int NeighbourCount { get; private set; }

	public RVOLayer Layer { get; set; }

	public RVOLayer CollidesWith { get; set; }

	public bool DebugDraw
	{
		get
		{
			return debugDraw;
		}
		set
		{
			debugDraw = value && simulator != null && !simulator.Multithreading;
		}
	}

	public VFactor Priority { get; set; }

	public Action PreCalculationCallback { private get; set; }

	public List<ObstacleVertex> NeighbourObstacles => null;

	public List<Agent> Neighbours => neighbours;

	public void SetTarget(int ownerID, Int2 targetPoint, Int desiredSpeed, Int maxSpeed)
	{
		this.ownerID = ownerID;
		maxSpeed = IntMath.Max(maxSpeed, 0);
		desiredSpeed = IntMath.Min(IntMath.Max(desiredSpeed, 0), maxSpeed);
		nextTargetPoint = targetPoint;
		nextDesiredSpeed = desiredSpeed;
		nextMaxSpeed = maxSpeed;
	}

	public void SetCollisionNormal(Int2 normal)
	{
		collisionNormal = normal;
	}

	public void ForceSetVelocity(Int2 velocity)
	{
		CalculatedTargetPoint = position + velocity * 1000;
		CalculatedSpeed = velocity.magnitude;
		manuallyControlled = true;
	}

	public Agent(Int2 pos, Int elevationCoordinate)
	{
		AgentTimeHorizon = new VFactor(2L, 1L);
		ObstacleTimeHorizon = new VFactor(2L, 1L);
		Height = 5000;
		Radius = 500;
		MaxNeighbours = 10;
		Locked = false;
		Position = pos;
		ElevationCoordinate = elevationCoordinate;
		Layer = RVOLayer.DefaultAgent;
		CollidesWith = (RVOLayer)(-1);
		Priority = VFactor.half;
		CalculatedTargetPoint = pos;
		CalculatedSpeed = 0;
		SetTarget(0, pos, 0, 0);
	}

	public void BufferSwitch()
	{
		radius = Radius;
		height = Height;
		maxSpeed = nextMaxSpeed;
		desiredSpeed = nextDesiredSpeed;
		agentTimeHorizon = AgentTimeHorizon;
		obstacleTimeHorizon = ObstacleTimeHorizon;
		maxNeighbours = MaxNeighbours;
		locked = Locked;
		position = Position;
		elevationCoordinate = ElevationCoordinate;
		collidesWith = CollidesWith;
		layer = Layer;
		desiredTargetPointInVelocitySpace = nextTargetPoint - position;
		currentVelocity = (CalculatedTargetPoint - position).normalized * (VFactor)CalculatedSpeed;
		desiredVelocity = desiredTargetPointInVelocitySpace.normalized * (VFactor)desiredSpeed;
	}

	public void PreCalculation()
	{
		if (PreCalculationCallback != null)
		{
			PreCalculationCallback();
		}
	}

	public void PostCalculation()
	{
		if (!manuallyControlled)
		{
			CalculatedTargetPoint = calculatedTargetPoint;
			CalculatedSpeed = calculatedSpeed;
		}
		List<ObstacleVertex> list = obstaclesBuffered;
		obstaclesBuffered = obstacles;
		obstacles = list;
		manuallyControlled = false;
	}

	public void CalculateNeighbours()
	{
		neighbours.Clear();
		neighbourDists.Clear();
		if (MaxNeighbours > 0 && !locked)
		{
			simulator.Quadtree.Query(position, maxSpeed, agentTimeHorizon, radius, this);
		}
		NeighbourCount = neighbours.Count;
	}

	private static float Sqr(float x)
	{
		return x * x;
	}

	internal long InsertAgentNeighbour(Agent agent, long rangeSq)
	{
		if (this == agent || (agent.layer & collidesWith) == 0)
		{
			return rangeSq;
		}
		long sqrMagnitudeLong = (agent.position - position).sqrMagnitudeLong;
		if (sqrMagnitudeLong < rangeSq)
		{
			if (neighbours.Count < maxNeighbours)
			{
				neighbours.Add(null);
				neighbourDists.Add(long.MaxValue);
			}
			int num = neighbours.Count - 1;
			if (sqrMagnitudeLong < neighbourDists[num])
			{
				while (num != 0 && sqrMagnitudeLong < neighbourDists[num - 1])
				{
					neighbours[num] = neighbours[num - 1];
					neighbourDists[num] = neighbourDists[num - 1];
					num--;
				}
				neighbours[num] = agent;
				neighbourDists[num] = sqrMagnitudeLong;
			}
			if (neighbours.Count == maxNeighbours)
			{
				rangeSq = neighbourDists[neighbourDists.Count - 1];
			}
		}
		return rangeSq;
	}

	private static Int3 FromXZ(Int2 p)
	{
		return new Int3(p.x, 0, p.y);
	}

	private static Vector3 FromXZ(Vector2 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		return new Vector3(p.x, 0f, p.y);
	}

	private static Int2 ToXZ(Int3 p)
	{
		return new Int2(p.x, p.z);
	}

	private static Vector2 FromXZ(Vector3 p)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		return new Vector2(p.x, p.z);
	}

	private Int2 To2D(Int3 p, out int elevation)
	{
		if (simulator.movementPlane == MovementPlane.XY)
		{
			elevation = p.z;
			return new Int2(p.x, p.y);
		}
		elevation = p.y;
		return new Int2(p.x, p.z);
	}

	private static void DrawVO(Int2 circleCenter, Int radius, Int2 origin)
	{
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		//IL_008d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		//IL_009e: Unknown result type (might be due to invalid IL or missing references)
		//IL_00af: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_0101: Unknown result type (might be due to invalid IL or missing references)
		//IL_0106: Unknown result type (might be due to invalid IL or missing references)
		//IL_010b: Unknown result type (might be due to invalid IL or missing references)
		//IL_010d: Unknown result type (might be due to invalid IL or missing references)
		//IL_010e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0113: Unknown result type (might be due to invalid IL or missing references)
		//IL_0115: Unknown result type (might be due to invalid IL or missing references)
		//IL_011a: Unknown result type (might be due to invalid IL or missing references)
		//IL_011e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0128: Unknown result type (might be due to invalid IL or missing references)
		//IL_012d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0137: Unknown result type (might be due to invalid IL or missing references)
		//IL_0139: Unknown result type (might be due to invalid IL or missing references)
		//IL_013e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0140: Unknown result type (might be due to invalid IL or missing references)
		//IL_0145: Unknown result type (might be due to invalid IL or missing references)
		//IL_0149: Unknown result type (might be due to invalid IL or missing references)
		//IL_0153: Unknown result type (might be due to invalid IL or missing references)
		//IL_0158: Unknown result type (might be due to invalid IL or missing references)
		float num = Mathf.Atan2((float)(origin - circleCenter).y, (float)(origin - circleCenter).x);
		float num2 = radius.i / (origin - circleCenter).magnitude;
		float num3 = ((num2 <= 1f) ? Mathf.Abs(Mathf.Acos(num2)) : 0f);
		Draw.Debug.CircleXZ((Vector3)FromXZ(circleCenter), (float)radius, Color.black, num - num3, num + num3);
		Vector2 val = new Vector2(Mathf.Cos(num - num3), Mathf.Sin(num - num3)) * (float)radius;
		Vector2 val2 = new Vector2(Mathf.Cos(num + num3), Mathf.Sin(num + num3)) * (float)radius;
		Vector2 p = -new Vector2(0f - val.y, val.x);
		Vector2 p2 = default(Vector2);
		((Vector2)(ref p2))._002Ector(0f - val2.y, val2.x);
		val += (Vector2)circleCenter;
		val2 += (Vector2)circleCenter;
		Vector3 val3 = FromXZ(val);
		Vector3 val4 = FromXZ(p);
		Debug.DrawRay(val3, ((Vector3)(ref val4)).normalized * 100f, Color.black);
		Vector3 val5 = FromXZ(val2);
		val4 = FromXZ(p2);
		Debug.DrawRay(val5, ((Vector3)(ref val4)).normalized * 100f, Color.black);
	}

	internal void CalculateVelocity(Simulator.WorkerContext context)
	{
		//IL_00ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a6: Unknown result type (might be due to invalid IL or missing references)
		if (manuallyControlled)
		{
			return;
		}
		if (locked)
		{
			calculatedSpeed = 0;
			calculatedTargetPoint = position;
			return;
		}
		VOBuffer vos = context.vos;
		vos.Clear();
		GenerateObstacleVOs(vos);
		GenerateNeighbourAgentVOs(vos);
		if (!BiasDesiredVelocity(vos, ref desiredVelocity, ref desiredTargetPointInVelocitySpace, simulator.symmetryBreakingBias))
		{
			calculatedTargetPoint = desiredTargetPointInVelocitySpace + position;
			calculatedSpeed = desiredSpeed;
			if (DebugDraw)
			{
				Draw.Debug.CrossXZ((Vector3)FromXZ(calculatedTargetPoint), Color.white);
			}
			return;
		}
		Int2 zero = Int2.zero;
		zero = GradientDescent(vos, currentVelocity, desiredVelocity);
		if (DebugDraw)
		{
			Draw.Debug.CrossXZ((Vector3)FromXZ(zero + position), Color.white);
		}
		calculatedTargetPoint = position + zero;
		calculatedSpeed = IntMath.Min(zero.magnitude, maxSpeed);
	}

	internal void CalculateVelocity2(Simulator.WorkerContext context)
	{
		if (locked)
		{
			calculatedSpeed = 0;
			calculatedTargetPoint = position;
			currentVelocity = Int2.zero;
			return;
		}
		orcaSolver.Initialize(desiredVelocity.normalized * new VFactor(maxSpeed.i, 1000L), maxSpeed.scalar);
		GetORCALines(desiredVelocity * new VFactor(maxSpeed.i, 1000L));
		currentVelocity = orcaSolver.ComputeResult();
		calculatedTargetPoint = position + currentVelocity * new VFactor(1L, 10L);
		calculatedSpeed = IntMath.Min(currentVelocity.magnitude, maxSpeed);
		string[] obj = new string[9]
		{
			ownerID.ToString(),
			":currentVelocity: ",
			null,
			null,
			null,
			null,
			null,
			null,
			null
		};
		Int2 @int = currentVelocity;
		obj[2] = @int.ToString();
		obj[3] = ",";
		obj[4] = currentVelocity.magnitude.ToString();
		obj[5] = ",calculatedTargetPoint = ";
		@int = calculatedTargetPoint;
		obj[6] = @int.ToString();
		obj[7] = ",position: ";
		@int = position;
		obj[8] = @int.ToString();
		XLogger.Debug(string.Concat(obj));
	}

	private void GetORCALines(Int2 desiredVelocity)
	{
		//IL_0671: Unknown result type (might be due to invalid IL or missing references)
		//IL_067d: Unknown result type (might be due to invalid IL or missing references)
		if (Radius <= 0)
		{
			return;
		}
		Int2 @int = currentVelocity;
		Int obj = maxSpeed;
		Int obj2 = calculatedSpeed;
		Int2 int2 = nextTargetPoint;
		VFactor vFactor = new VFactor(1L, 10L);
		VFactor vFactor2 = ((obj2 == 0) ? AgentTimeHorizon : new VFactor((position - int2).magnitude, obj2.i));
		VFactor vFactor3 = vFactor2;
		Debug.Log((object)("estTime : " + vFactor3.ToString()));
		VFactor inverse = (IsAvoidingCollisions ? IntMath.Max(2 * vFactor, (vFactor2 < AgentTimeHorizon) ? vFactor2 : AgentTimeHorizon) : (2 * vFactor)).Inverse;
		VFactor vFactor4 = vFactor;
		VFactor inverse2 = vFactor4.Inverse;
		VFactor vFactor5 = new VFactor((radius + obj * vFactor).i, 1000L);
		vFactor5 *= vFactor5;
		orcaSolver.collisionCount = orcaSolver.obstCount;
		int count = neighbours.Count;
		for (int i = 0; i < count; i++)
		{
			Agent agent = neighbours[i];
			if (agent == this || ((locked || maxSpeed <= 0) && !agent.locked && agent.maxSpeed > 0) || agent.Radius <= 0)
			{
				continue;
			}
			Int2 int3 = agent.Position - Position;
			Int2 int4 = @int - agent.currentVelocity;
			VFactor vFactor6 = new VFactor(int3.magnitude, 1000L);
			VFactor vFactor7 = (VFactor)(agent.Radius + Radius);
			VFactor vFactor8 = vFactor7 * vFactor7;
			int num = 1;
			Int2 int5 = Int2.zero;
			Int2 int6 = Int2.zero;
			bool collision = false;
			vFactor3 = vFactor6;
			string text = vFactor3.ToString();
			vFactor3 = vFactor7;
			Debug.Log((object)("dis == " + text + "," + vFactor3.ToString()));
			Int2 int7;
			if (vFactor6 > vFactor7)
			{
				int i2 = ((Int)(vFactor7 * vFactor7)).i;
				VFactor vFactor9 = ((Int2.SquareDistance(int2, agent.position) <= i2 || num > 0) ? inverse2 : inverse);
				Int2 a = int4 - int3 * vFactor9;
				int7 = int4;
				string text2 = int7.ToString();
				int7 = int3;
				Debug.Log((object)("relativeVelocity:" + text2 + ",relativePosition:" + int7.ToString()));
				long sqrMagnitudeLong = a.sqrMagnitudeLong;
				long num2 = IntMath.Divide(Int2.DotLong(a, int3), 1000L);
				if (num2 < 0 && num2 * num2 <= (vFactor8 * sqrMagnitudeLong).integer)
				{
				}
			}
			else
			{
				Int2 int8 = int4 - int3 * inverse2;
				VFactor vFactor10 = new VFactor(int8.magnitude, 1000L);
				Int2 int9 = Int2.zero;
				if (vFactor10 == VFactor.zero)
				{
					Debug.Log((object)"===================================");
				}
				else
				{
					int9 = int8.normalized;
				}
				int6 = int9 * (vFactor7 * inverse2 - vFactor10);
				string[] obj3 = new string[13]
				{
					ownerID.ToString(),
					": and +",
					agent.ownerID.ToString(),
					":碰撞在一起：unitW:",
					null,
					null,
					null,
					null,
					null,
					null,
					null,
					null,
					null
				};
				int7 = int9;
				obj3[4] = int7.ToString();
				obj3[5] = ", u:";
				int7 = int6;
				obj3[6] = int7.ToString();
				obj3[7] = ", combinedRadius:";
				vFactor3 = vFactor7;
				obj3[8] = vFactor3.ToString();
				obj3[9] = ", obstInvTimeHorizon:";
				vFactor3 = inverse2;
				obj3[10] = vFactor3.ToString();
				obj3[11] = ", wLength:";
				vFactor3 = vFactor10;
				obj3[12] = vFactor3.ToString();
				XLogger.Debug(string.Concat(obj3));
				int5 = -int9.Perpendicular;
				num = -1;
				collision = true;
			}
			VFactor vFactor11 = ((obj2 <= obj * rvoZeroSpeed) ? ((desiredVelocity != Int2.zero || agent.calculatedSpeed <= obj * rvoZeroSpeed || num < 0) ? VFactor.half : VFactor.zero) : ((!(agent.calculatedSpeed <= obj * rvoZeroSpeed)) ? VFactor.half : VFactor.one));
			Int2 int10 = @int + int6 * vFactor11;
			string[] obj4 = new string[23]
			{
				ownerID.ToString(),
				":point: ",
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null
			};
			int7 = int10;
			obj4[2] = int7.ToString();
			obj4[3] = ",desiredSpeed:";
			Int obj5 = desiredSpeed;
			obj4[4] = obj5.ToString();
			obj4[5] = ",velocity: ";
			int7 = @int;
			obj4[6] = int7.ToString();
			obj4[7] = ",u: ";
			int7 = int6;
			obj4[8] = int7.ToString();
			obj4[9] = ",f:";
			vFactor3 = vFactor11;
			obj4[10] = vFactor3.ToString();
			obj4[11] = ", direction: ";
			int7 = int5;
			obj4[12] = int7.ToString();
			obj4[13] = ",desiredVelocity == ";
			int7 = desiredVelocity;
			obj4[14] = int7.ToString();
			obj4[15] = ",calculatedSpeed== ";
			obj5 = calculatedSpeed;
			obj4[16] = obj5.ToString();
			obj4[17] = ",";
			obj5 = obj2;
			obj4[18] = obj5.ToString();
			obj4[19] = ",";
			obj4[20] = (obj * rvoZeroSpeed).ToString();
			obj4[21] = ", agentB.calculatedSpeed ==";
			obj5 = agent.calculatedSpeed;
			obj4[22] = obj5.ToString();
			XLogger.Debug(string.Concat(obj4));
			orcaSolver.AddLine((Vector2)int10, (Vector2)int5, collision);
		}
	}

	private static Color Rainbow(float v)
	{
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_006a: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		Color val = default(Color);
		((Color)(ref val))._002Ector(v, 0f, 0f);
		if (val.r > 1f)
		{
			val.g = val.r - 1f;
			val.r = 1f;
		}
		if (val.g > 1f)
		{
			val.b = val.g - 1f;
			val.g = 1f;
		}
		return val;
	}

	private void GenerateObstacleVOs(VOBuffer vos)
	{
		Int obj = maxSpeed * obstacleTimeHorizon;
		for (int i = 0; i < simulator.obstacles.Count; i++)
		{
			ObstacleVertex obstacleVertex = simulator.obstacles[i];
			ObstacleVertex obstacleVertex2 = obstacleVertex;
			do
			{
				if (obstacleVertex2.ignore || (obstacleVertex2.layer & collidesWith) == 0)
				{
					XLogger.Debug("simulator.obstacles.Count == " + simulator.obstacles.Count);
					obstacleVertex2 = obstacleVertex2.next;
					continue;
				}
				Int2 @int = To2D(obstacleVertex2.position, out var elevation);
				Int2 int2 = To2D(obstacleVertex2.next.position, out var elevation2);
				Int2 normalized = (int2 - @int).normalized;
				Int obj2 = VO.SignedDistanceFromLine(@int, normalized, position);
				if (obj2 >= -10 && obj2 < obj)
				{
					VFactor f = new VFactor(Int2.DotLong(position - @int, int2 - @int), (int2 - @int).sqrMagnitudeLong);
					long num = IntMath.Lerp(elevation, elevation2, f.nom, f.den);
					long sqrMagnitudeLong = (Int2.Lerp(@int, int2, f) - position).sqrMagnitudeLong;
					if (sqrMagnitudeLong < obj.i * obj.i && elevationCoordinate.i <= num + obstacleVertex2.height.i && elevationCoordinate.i + height.i >= num)
					{
						vos.Add(VO.SegmentObstacle(int2 - position, @int - position, Int2.zero, radius * new VFactor(1L, 100L), ObstacleTimeHorizon.Inverse, simulator.DeltaTime.Inverse));
					}
				}
				obstacleVertex2 = obstacleVertex2.next;
			}
			while (obstacleVertex2 != obstacleVertex && obstacleVertex2 != null && obstacleVertex2.next != null);
		}
	}

	private void GenerateNeighbourAgentVOs(VOBuffer vos)
	{
		VFactor inverse = agentTimeHorizon.Inverse;
		Int2 a = currentVelocity;
		for (int i = 0; i < neighbours.Count; i++)
		{
			Agent agent = neighbours[i];
			if (agent == this)
			{
				continue;
			}
			Int obj = IntMath.Min(elevationCoordinate + height, agent.elevationCoordinate + agent.height);
			Int obj2 = IntMath.Max(elevationCoordinate, agent.elevationCoordinate);
			if (!(obj - obj2 < 0))
			{
				Int obj3 = radius + agent.radius;
				Int2 @int = agent.position - position;
				VFactor vFactor = ((!agent.locked && !agent.manuallyControlled) ? ((!(agent.Priority > VFactor.minValue) && !(Priority > VFactor.minValue)) ? VFactor.half : (agent.Priority / (Priority + agent.Priority))) : VFactor.one);
				Int2 b = Int2.Lerp(agent.currentVelocity, agent.desiredVelocity, 2 * vFactor - VFactor.one);
				Int2 int2 = Int2.Lerp(a, b, vFactor);
				vos.Add(new VO(@int, int2, obj3, inverse, simulator.DeltaTime.Inverse));
				if (DebugDraw)
				{
					DrawVO(position + @int * inverse + int2, obj3 * inverse, position + int2);
				}
			}
		}
	}

	private Int2 GradientDescent(VOBuffer vos, Int2 sampleAround1, Int2 sampleAround2)
	{
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_006b: Unknown result type (might be due to invalid IL or missing references)
		Int2 @int = Trace(vos, sampleAround1, out var score);
		if (DebugDraw)
		{
			Draw.Debug.CrossXZ((Vector3)FromXZ(@int + position), Color.yellow, 0.5f);
		}
		Int2 int2 = Trace(vos, sampleAround2, out var score2);
		if (DebugDraw)
		{
			Draw.Debug.CrossXZ((Vector3)FromXZ(int2 + position), Color.magenta, 0.5f);
		}
		if (!(score < score2))
		{
			return int2;
		}
		return @int;
	}

	private static bool BiasDesiredVelocity(VOBuffer vos, ref Int2 desiredVelocity, ref Int2 targetPointInVelocitySpace, VFactor maxBiasRadians)
	{
		int magnitude = desiredVelocity.magnitude;
		Int obj = 0;
		for (int i = 0; i < vos.length; i++)
		{
			vos.buffer[i].Gradient(desiredVelocity, out var weight);
			obj = IntMath.Max(obj, weight);
		}
		bool result = obj > 0;
		if (magnitude < 1)
		{
			return result;
		}
		VFactor vFactor = IntMath.Min(maxBiasRadians, new VFactor(obj.i, magnitude));
		desiredVelocity += new Int2(desiredVelocity.y, -desiredVelocity.x) * vFactor;
		targetPointInVelocitySpace += new Int2(targetPointInVelocitySpace.y, -targetPointInVelocitySpace.x) * vFactor;
		return result;
	}

	private Int2 EvaluateGradient(VOBuffer vos, Int2 p, out Int value)
	{
		Int2 result = Int2.zero;
		value = 0;
		for (int i = 0; i < vos.length; i++)
		{
			Int2 @int = vos.buffer[i].ScaledGradient(p, out var weight);
			if (weight > value)
			{
				value = weight;
				result = @int;
			}
		}
		Int2 int2 = desiredVelocity - p;
		Int obj = int2.magnitude;
		if (obj > 1)
		{
			result += int2 * (DesiredVelocityWeight * (VFactor)obj);
			value += obj * DesiredVelocityWeight;
		}
		long sqrMagnitudeLong = p.sqrMagnitudeLong;
		if (sqrMagnitudeLong > desiredSpeed.i * desiredSpeed.i)
		{
			Int obj2 = IntMath.Sqrt(sqrMagnitudeLong);
			if (obj2 > maxSpeed)
			{
				value += 3 * (obj2 - maxSpeed);
				result -= p * new VFactor(3000L, obj2.i);
			}
			VFactor vFactor = 2 * DesiredVelocityWeight;
			value += (obj2 - desiredSpeed) * vFactor;
			result -= IntMath.Divide(p, (long)obj2.i) * vFactor;
		}
		return result;
	}

	private Int2 Trace(VOBuffer vos, Int2 p, out Int score)
	{
		//IL_00c3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		Int obj = IntMath.Max(radius, desiredSpeed * new VFactor(1L, 5L));
		Int obj2 = Int.MaxValue;
		Int2 result = p;
		for (int i = 0; i < 50; i++)
		{
			Int obj3 = IntMath.Sqrt(((Int)(VFactor.one - new VFactor(i, 50L))).i);
			obj3 = obj * (VFactor)obj3;
			Int2 @int = EvaluateGradient(vos, p, out var value);
			if (value < obj2)
			{
				obj2 = value;
				result = p;
			}
			@int.Normalize();
			@int *= (VFactor)obj3;
			Int2 int2 = p;
			p += @int;
			if (DebugDraw)
			{
				Debug.DrawLine((Vector3)FromXZ(int2 + position), (Vector3)FromXZ(p + position), Rainbow((float)i * 0.1f) * new Color(1f, 1f, 1f, 1f));
			}
		}
		score = obj2;
		return result;
	}
}
