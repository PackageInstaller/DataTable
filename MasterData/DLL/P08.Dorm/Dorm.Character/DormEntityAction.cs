using System;
using System.Collections;
using System.Collections.Generic;
using Cinemachine;
using Pathfinding;
using UnityEngine;

namespace Dorm.Character;

public static class DormEntityAction
{
	public class MoveByControllerCmd : CmdTask
	{
		private readonly CharacterController controller;

		public Vector3? lookingDir;

		public Transform lookingTarget;

		private bool stopWhenInputZero = true;

		private float waitWhenBlocked;

		private Transform forwardDirReferance;

		private Func<Vector3> GetInputVec;

		private bool forceStop;

		private bool reachTarget;

		public bool ResetMoveAnime { get; internal set; } = true;

		private Vector3 InputMovingVec => GetInputVec?.Invoke() ?? Vector3.zero;

		public MoveByControllerCmd(CharacterController controller, Transform contrllerRefTrs)
			: base(DormEntityManager.EntityCmdPriority.Normal)
		{
			this.controller = controller;
			forwardDirReferance = contrllerRefTrs;
		}

		public MoveByControllerCmd UseStickController(IMoveController stick)
		{
			GetInputVec = stick.GetMovingVec;
			return this;
		}

		public MoveByControllerCmd UseCustomController(Func<Vector3> inputGetter)
		{
			GetInputVec = inputGetter;
			return this;
		}

		public MoveByControllerCmd StandWhenBlocked(float waitWhenBlocked)
		{
			stopWhenInputZero = false;
			this.waitWhenBlocked = waitWhenBlocked;
			return this;
		}

		private Vector3 ProcessMoveInput(DormEntity entity)
		{
			Transform modelTrs = entity.ModelTrs;
			Vector3 inputMovingVec = InputMovingVec;
			Vector3 vector = (forwardDirReferance ? forwardDirReferance.TransformDirection(inputMovingVec) : inputMovingVec);
			if (inputMovingVec.x != 0f || inputMovingVec.z != 0f)
			{
				vector.y = 0f;
				Vector3 forward = (lookingTarget ? (lookingTarget.position - modelTrs.position) : (lookingDir ?? vector));
				forward.y = 0f;
				Quaternion rotation = Quaternion.LookRotation(forward);
				modelTrs.rotation = rotation;
			}
			return vector.normalized * entity.Speed;
		}

		private bool CmdFinish()
		{
			if (forceStop)
			{
				return true;
			}
			if (stopWhenInputZero)
			{
				return InputMovingVec == Vector3.zero;
			}
			return false;
		}

		public void ForceStop()
		{
			forceStop = true;
		}

		public void Reset()
		{
			forceStop = false;
		}

		protected override IEnumerator StartTask(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			yield return null;
			ResetMoveAnime = true;
			float waitTimer = 0f;
			if (controller == null || !executor.entity.Movable)
			{
				OnWalkEnd(reachTarget: false);
				yield break;
			}
			controller.enabled = true;
			DormEntity.DormEntityAnime anime = DormEntity.DormEntityAnime.Move;
			while (!CmdFinish() && executor.entity.Movable)
			{
				float deltaTime = Time.deltaTime;
				Vector3 vector;
				if (waitTimer > 0f)
				{
					waitTimer -= deltaTime;
					vector = Vector3.zero;
				}
				else
				{
					vector = ProcessMoveInput(entity);
				}
				CollisionFlags collisionFlags = controller.Move((vector + Vector3.down) * Time.deltaTime);
				bool flag = collisionFlags.HasFlag(CollisionFlags.Sides);
				DormEntity.DormEntityAnime dormEntityAnime = ((!((waitTimer > 0f) | flag) && !(vector == Vector3.zero)) ? DormEntity.DormEntityAnime.Move : DormEntity.DormEntityAnime.Stand);
				if (((waitTimer <= 0f && !stopWhenInputZero) & flag) && dormEntityAnime != anime && dormEntityAnime == DormEntity.DormEntityAnime.Stand)
				{
					waitTimer = waitWhenBlocked;
				}
				ResetMoveAnime = ResetMoveAnime || dormEntityAnime != anime;
				if (ResetMoveAnime)
				{
					entity.Play(dormEntityAnime);
					ResetMoveAnime = false;
				}
				anime = dormEntityAnime;
				yield return null;
			}
			controller.enabled = false;
			OnWalkEnd(reachTarget: true);
		}

		private void OnWalkEnd(bool reachTarget)
		{
			this.reachTarget = reachTarget;
		}

		protected override void OnExecuteFinished(EntityCmdExecutor executor)
		{
			Notify("ON_DORM_CHARACTER_MOVE_FINISH", executor.entity.id, reachTarget);
		}

		protected override void OnStopByExecutor(EntityCmdExecutor executor)
		{
			_ = executor.entity;
			controller.enabled = false;
			OnWalkEnd(reachTarget: false);
			base.OnStopByExecutor(executor);
		}
	}

	public abstract class MoveCmdTask : CmdTask
	{
		private bool reachTarget;

		public bool ResetMoveAnime { get; internal set; } = true;

		protected MoveCmdTask()
			: base(DormEntityManager.EntityCmdPriority.Normal)
		{
		}

		protected void WalkEnd(bool reachTarget)
		{
			this.reachTarget = reachTarget;
		}

		protected override void OnExecuteFinished(EntityCmdExecutor executor)
		{
			Notify("ON_DORM_CHARACTER_MOVE_FINISH", executor.entity.id, reachTarget);
		}

		protected override void OnStopByExecutor(EntityCmdExecutor executor)
		{
			base.OnStopByExecutor(executor);
		}

		private static bool FurtherThan(Vector3 p1, Vector3 p2, float len)
		{
			return (p2 - p1).sqrMagnitude >= len * len;
		}

		protected IEnumerator MoveByPathCoroutine(DormComplexEntity entity, IList<Vector3> wayPoints, Vector3 lookDir)
		{
			List<Vector3> path = new List<Vector3>();
			foreach (Vector3 wayPoint in wayPoints)
			{
				if (path.Count > 0)
				{
					Vector3 vector = path[path.Count - 1];
					if (FurtherThan(vector, wayPoint, 1f))
					{
						path.Add(Vector3.MoveTowards(vector, wayPoint, 0.5f));
						path.Add(Vector3.MoveTowards(wayPoint, vector, 0.5f));
					}
					else if (FurtherThan(vector, wayPoint, 0.5f))
					{
						path.Add((vector + wayPoint) * 0.5f);
					}
					else if (vector == wayPoint)
					{
						continue;
					}
				}
				path.Add(wayPoint);
			}
			if (!entity.Movable)
			{
				WalkEnd(reachTarget: false);
				yield break;
			}
			if (path.Count > 1)
			{
				_ = path[0];
				Vector3 end = path[path.Count - 1];
				lookDir.y = 0f;
				lookDir.Normalize();
				if (lookDir == Vector3.zero)
				{
					lookDir = (end - path[path.Count - 2]).normalized;
				}
				yield return null;
				float distanceAlongSegment = 0f;
				for (int i = 0; i < path.Count - 1; i++)
				{
					Vector3 p1 = path[i];
					Vector3 p2 = path[i + 1];
					Vector3 p3 = ((i != 0) ? path[i - 1] : (p2 - entity.ModelTrs.forward));
					Vector3 p4 = ((i != path.Count - 2) ? path[i + 2] : ((lookDir == Vector3.zero) ? p2 : (p1 + lookDir)));
					float segmentLength;
					for (segmentLength = Vector3.Distance(p1, p2); distanceAlongSegment <= segmentLength; distanceAlongSegment += Time.deltaTime * entity.Speed)
					{
						if (ResetMoveAnime)
						{
							entity.Play(DormEntity.DormEntityAnime.Move);
							ResetMoveAnime = false;
						}
						InterpolateEntityMove(entity, p3, p1, p2, p4, distanceAlongSegment / segmentLength, useCatmullRom: true);
						yield return null;
					}
					distanceAlongSegment -= segmentLength;
				}
				entity.ModelTrs.position = end;
			}
			if (lookDir != Vector3.zero)
			{
				entity.ModelTrs.forward = lookDir;
			}
			WalkEnd(reachTarget: true);
		}

		protected IEnumerator MoveFollowTargetCoroutine(DormComplexEntity entity, Vector3 startPoint, Vector3 startForward, Transform target, Transform lookTarget)
		{
			if (!entity.Movable)
			{
				WalkEnd(reachTarget: false);
				yield break;
			}
			entity.Play(DormEntity.DormEntityAnime.Move);
			_ = entity.ModelTrs;
			float len;
			do
			{
				float num = Time.deltaTime * entity.Speed;
				Vector3 worldPos = entity.GetWorldPos();
				len = Vector3.Distance(worldPos, target.position);
				Vector3 position = lookTarget.position;
				position = Vector3.MoveTowards(target.position, position, 0.5f);
				Vector3 p = worldPos - 0.5f * entity.GetForward();
				float t = ((len == 0f) ? 1f : Mathf.Clamp01(num / len));
				InterpolateEntityMove(entity, p, worldPos, target.position, position, t, len > 0.15f);
				yield return null;
			}
			while (len > 0.075f);
		}

		protected static IList<Vector3> GetPath(Vector3 start, Vector3 target, bool ignorePathFinding)
		{
			if (ignorePathFinding || DormCoordinate.Instance.astarPath == null)
			{
				return new List<Vector3> { start, target };
			}
			return CalcPath(start, target);
		}
	}

	public class MoveAndLookAtPosCmdTask : MoveCmdTask
	{
		private Vector3 lookAt;

		private Vector3 targetPos;

		private bool ignorePathFinding;

		public MoveAndLookAtPosCmdTask(Vector3 targetPos, Vector3 lookAt, bool ignorePathFinding)
		{
			this.lookAt = lookAt;
			this.targetPos = targetPos;
			this.ignorePathFinding = ignorePathFinding;
		}

		protected override IEnumerator StartTask(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			IList<Vector3> path = MoveCmdTask.GetPath(entity.GetWorldPos(), targetPos, ignorePathFinding);
			Vector3 lookDir = lookAt - path[path.Count - 1];
			return MoveByPathCoroutine(entity, path, lookDir);
		}
	}

	public class MoveAndLookToDirCmdTask : MoveCmdTask
	{
		private Vector3 targetPos;

		private Vector3 lookDir;

		private bool ignorePathFinding;

		public MoveAndLookToDirCmdTask(Vector3 targetPos, Vector3 lookDir, bool ignorePathFinding)
		{
			this.ignorePathFinding = ignorePathFinding;
			this.targetPos = targetPos;
			this.lookDir = lookDir;
		}

		protected override IEnumerator StartTask(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			IList<Vector3> path = MoveCmdTask.GetPath(entity.GetWorldPos(), targetPos, ignorePathFinding);
			return MoveByPathCoroutine(entity, path, lookDir);
		}
	}

	public class PatrolCmdTask : MoveCmdTask
	{
		private float reachPointRange = 0.075f;

		private float? pos = 0f;

		private bool reverse;

		private CinemachinePathBase path;

		public PatrolCmdTask(CinemachinePathBase path, bool reverse, float? offset)
		{
			this.path = path;
			pos = offset;
			this.reverse = reverse;
		}

		private IEnumerable<T> RingEnumerte<T>(IEnumerable<T> source)
		{
			while (true)
			{
				foreach (T item in source)
				{
					yield return item;
				}
			}
		}

		protected override IEnumerator StartTask(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			if (!entity.Movable)
			{
				yield break;
			}
			float p = pos ?? DormLuaBridge.FindClosestPointOnPath(entity.GetWorldPos(), path);
			bool r = reverse;
			bool move = false;
			while (entity.Movable)
			{
				if (!move && entity.Speed != 0f)
				{
					move = true;
					entity.Play(DormEntity.DormEntityAnime.Move);
				}
				else if (move && entity.Speed == 0f)
				{
					move = false;
					entity.Play(DormEntity.DormEntityAnime.Stand);
				}
				p += (float)((!r) ? 1 : (-1)) * Time.deltaTime * entity.Speed;
				if (!path.Looped)
				{
					float num = p / path.PathLength;
					if (num <= 0f)
					{
						r = false;
					}
					else if (num >= 1f)
					{
						r = true;
					}
				}
				entity.ModelTrs.position = path.EvaluatePositionAtUnit(p, CinemachinePathBase.PositionUnits.Distance);
				Quaternion rotation = path.EvaluateOrientationAtUnit(p, CinemachinePathBase.PositionUnits.Distance);
				if (r)
				{
					rotation *= Quaternion.Euler(0f, 180f, 0f);
				}
				entity.ModelTrs.rotation = rotation;
				yield return null;
			}
			WalkEnd(reachTarget: false);
		}
	}

	public class InteractCmdTask : CmdTask
	{
		private readonly DormEntity target;

		private readonly int? action;

		private readonly DormEntityManager.WaitForNotify waitEvent = new DormEntityManager.WaitForNotify();

		public InteractCmdTask(DormEntity otherEntity, DormEntityManager.EntityCmdPriority priority, int? interactAction = null)
			: base(priority)
		{
			target = otherEntity;
			action = interactAction;
		}

		protected override IEnumerator StartTask(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			entity.animeReleaseControl = true;
			if (target.id != entity.id)
			{
				target.BeInteractedBy(entity.id, waitEvent);
			}
			Notify("ON_DORM_CHARACTER_INTERACT", entity.id, target.id, waitEvent, action);
			yield return waitEvent;
		}

		protected override void OnStopByExecutor(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			waitEvent.Cancel();
			entity.animeReleaseControl = false;
			entity.RestoreAttachedInteractEfx();
			entity.RestoreSelfItemPart();
			entity.DetachItemHost(resetFaceDir: false);
			if (target.id != entity.id)
			{
				target.BeInteractedFinished(waitEvent);
			}
			Notify("ON_DORM_CHARACTER_INTERACT_ABORTED", entity.id, target.id);
			base.OnStopByExecutor(executor);
		}

		protected override void OnExecuteFinished(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			entity.animeReleaseControl = false;
			entity.RestoreAttachedInteractEfx();
			entity.RestoreSelfItemPart();
			if (target.id != entity.id)
			{
				target.BeInteractedFinished(waitEvent);
			}
			Notify("ON_DORM_CHARACTER_INTERACT_FINISH", entity.id, target.id, waitEvent.success);
		}
	}

	public class WanderMoveCmd : MoveCmdTask
	{
		private Vector3 dir;

		private float max;

		public WanderMoveCmd(Vector3 dir, float maxDistance)
		{
			this.dir = dir;
			max = maxDistance;
		}

		protected override IEnumerator StartTask(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			Vector3 worldPos = entity.GetWorldPos();
			Vector3 target = CalcMoveTarget(worldPos, dir, entity.radius, max);
			return MoveByPathCoroutine(entity, MoveCmdTask.GetPath(worldPos, target, ignorePathFinding: true), dir);
		}
	}

	public class RndWanderMoveCmd : MoveCmdTask
	{
		private bool treatAsResumeLastRndWander;

		private int maxTry = 16;

		private float minDistance = 1f;

		private float maxDistance = 1f;

		private int maxStep;

		public RndWanderMoveCmd(bool treatAsResumeLastRndWander, int maxStep, float maxDistance, float minDistance = 0.5f)
		{
			this.treatAsResumeLastRndWander = treatAsResumeLastRndWander;
			this.minDistance = minDistance;
			this.maxDistance = maxDistance;
			this.maxStep = maxStep;
		}

		private IEnumerator CalcPathCoroutine(DormEntity entity, List<Vector3> path)
		{
			Vector3 start = entity.GetWorldPos();
			path.Add(start);
			for (int _ = 0; _ < maxStep; _++)
			{
				int degree = UnityEngine.Random.Range(0, 360);
				for (int i = 0; i < maxTry; i++)
				{
					float num = (float)i * 360f / (float)maxTry;
					Vector3 dir = Quaternion.Euler(0f, (float)degree + num, 0f) * Vector3.forward;
					Vector3 target = CalcMoveTarget(start, dir, entity.radius, maxDistance);
					yield return null;
					float num2 = Vector3.Distance(start, target);
					if (!(num2 < minDistance))
					{
						if (num2 > 1f)
						{
							path.Add(start + 0.5f * dir);
						}
						if (num2 > 2f)
						{
							path.Add(target - 0.5f * dir);
						}
						path.Add(target);
						start = target;
						break;
					}
				}
			}
		}

		protected override IEnumerator StartTask(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			if (!entity.Movable || IsStuck(entity))
			{
				yield break;
			}
			List<Vector3> path = new List<Vector3>();
			IEnumerator calcPathTask = CalcPathCoroutine(entity, path);
			while (calcPathTask.MoveNext())
			{
				yield return calcPathTask.Current;
			}
			if (path.Count > 1)
			{
				entity.Scanner.StartScan(treatAsResumeLastRndWander);
				IEnumerator task = MoveByPathCoroutine(entity, path, path[path.Count - 1] - path[path.Count - 2]);
				while (task.MoveNext())
				{
					yield return task.Current;
				}
				entity.Scanner.EndScan();
			}
			else
			{
				WalkEnd(reachTarget: true);
			}
		}

		protected override void OnStopByExecutor(EntityCmdExecutor executor)
		{
			base.OnStopByExecutor(executor);
			executor.entity.Scanner.EndScan();
		}
	}

	public class PlayAnimeCmd : CmdTask
	{
		private string anime;

		private string subType;

		private bool loop;

		private float crossFade;

		public PlayAnimeCmd(string anime, string subType, bool loop, float crossFade = 0.05f)
			: base(DormEntityManager.EntityCmdPriority.Normal)
		{
			this.anime = anime;
			this.subType = subType;
			this.loop = loop;
			this.crossFade = crossFade;
		}

		protected override IEnumerator StartTask(EntityCmdExecutor executor)
		{
			DormComplexEntity entity = executor.entity;
			yield return null;
			string playingClipName = entity.Play(anime, subType, crossFade);
			yield return null;
			while (entity.CurPlaying == playingClipName && (loop || entity.GetCurAnimePlayNormalizedTime() < 1f))
			{
				yield return null;
			}
		}

		protected override void OnExecuteFinished(EntityCmdExecutor executor)
		{
			Notify("ON_PLAY_ACTION_FINISH", executor.EntityID);
		}
	}

	private const string LUA_INVOKE_DORM_ENTITY_EVENT = "Dorm.InvokeEntityEvent";

	public static Func<Vector3, Vector3, Vector3, Vector3, float, Vector3> publicEntityMoveInterpolateFunc = CatmullRom3D;

	private static Func<Vector3, Vector3, Vector3, Vector3, float, Vector3> EntityMoveInterpolateFunc = CatmullRom3D;

	private const float MOVE_PATH_SEG_CUT = 0.5f;

	private const float FOLLOW_TARGET_PREVENT_SPIN_AROUND_MIN_DISTANCE = 0.15f;

	private const float FOLLOW_TARGET_PREVENT_STUCK_MIN_DISTANCE = 0.075f;

	public static readonly int ignoreGroundRaycastLayer = -5 & ~DormConst.GROUND_LAYER_MASK;

	public static readonly int ignoreGroundRaycastAndCharaLayer = ignoreGroundRaycastLayer & ~DormConst.CHARA_LAYER_MASK;

	internal static void Notify(string notifyEvent, int entityID)
	{
		LuaHelper.GetFunc("Dorm.InvokeEntityEvent")?.Call(notifyEvent, entityID);
	}

	internal static void Notify<T>(string notifyEvent, int entityID, T arg)
	{
		LuaHelper.GetFunc("Dorm.InvokeEntityEvent")?.Call(notifyEvent, entityID, arg);
	}

	internal static void Notify<T1, T2>(string notifyEvent, int entityID, T1 arg1, T2 arg2)
	{
		LuaHelper.GetFunc("Dorm.InvokeEntityEvent")?.Call(notifyEvent, entityID, arg1, arg2);
	}

	internal static void Notify<T1, T2, T3>(string notifyEvent, int entityID, T1 arg1, T2 arg2, T3 arg3)
	{
		LuaHelper.GetFunc("Dorm.InvokeEntityEvent")?.Call(notifyEvent, entityID, arg1, arg2, arg3);
	}

	internal static void Notify<T1, T2, T3, T4>(string notifyEvent, int entityID, T1 arg1, T2 arg2, T3 arg3, T4 arg4)
	{
		LuaHelper.GetFunc("Dorm.InvokeEntityEvent")?.Call(notifyEvent, entityID, arg1, arg2, arg3, arg4);
	}

	internal static void Notify<T1, T2, T3, T4, T5>(string notifyEvent, int entityID, T1 arg1, T2 arg2, T3 arg3, T4 arg4, T5 arg5)
	{
		LuaHelper.GetFunc("Dorm.InvokeEntityEvent")?.Call(notifyEvent, entityID, arg1, arg2, arg3, arg4, arg5);
	}

	private static Vector3 CatmullRom3D(Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3, float t)
	{
		return GetPoint(p0, p1, p2, p3, t);
		static float GetKnotInterval(Vector3 a, Vector3 b)
		{
			float num = 1f;
			return Mathf.Pow(Vector3.SqrMagnitude(a - b), 0.5f * num);
		}
		static Vector3 GetPoint(Vector3 vector, Vector3 vector2, Vector3 vector3, Vector3 vector4, float t2)
		{
			float num = GetKnotInterval(vector, vector2);
			float num2 = GetKnotInterval(vector2, vector3) + num;
			float b = GetKnotInterval(vector3, vector4) + num2;
			float u = Mathf.LerpUnclamped(num, num2, t2);
			Vector3 c = Remap(0f, num, vector, vector2, u);
			Vector3 vector5 = Remap(num, num2, vector2, vector3, u);
			Vector3 d = Remap(num2, b, vector3, vector4, u);
			Vector3 c2 = Remap(0f, num2, c, vector5, u);
			Vector3 d2 = Remap(num, b, vector5, d, u);
			return Remap(num, num2, c2, d2, u);
		}
		static Vector3 Remap(float a, float b, Vector3 c, Vector3 d, float u)
		{
			if (a == b)
			{
				return c;
			}
			return Vector3.LerpUnclamped(c, d, (u - a) / (b - a));
		}
	}

	public static void InterpolateEntityMove(DormEntity entity, Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3, float t, bool useCatmullRom = false, float dt = 0.01f)
	{
		InterpolateEntityMove(entity.ModelTrs, p0, p1, p2, p3, t, useCatmullRom, dt);
	}

	public static void InterpolateEntityMove(Transform entityTrans, Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3, float t, bool useCatmullRom = false, float dt = 0.01f)
	{
		if (p0 == p1 && p2 == p3)
		{
			useCatmullRom = false;
		}
		Vector3 vector;
		Vector3 vector2;
		if (useCatmullRom)
		{
			vector = EntityMoveInterpolateFunc(p0, p1, p2, p3, t);
			float arg = t + dt;
			vector2 = EntityMoveInterpolateFunc(p0, p1, p2, p3, arg) - vector;
		}
		else
		{
			vector = Vector3.Lerp(p1, p2, t);
			float t2 = 1f - Mathf.Clamp01(Vector3.Distance(vector, p2) / 0.5f);
			vector2 = ((!(p3 == p2)) ? Vector3.Slerp(p2 - p1, p3 - p2, t2) : (p2 - p1));
		}
		vector2.y = 0f;
		vector2 = vector2.normalized;
		if (vector2 != Vector3.zero)
		{
			entityTrans.forward = vector2;
			entityTrans.position = vector;
		}
	}

	private static void AdjustPath(List<Vector3> path, Vector3 start, Vector3 end)
	{
		GridNode gridNode = DormCoordinate.Instance.astarPath.GetNearest((Int3)start).node as GridNode;
		GridNode gridNode2 = DormCoordinate.Instance.astarPath.GetNearest((Int3)end).node as GridNode;
		GridNode gridNode3 = DormCoordinate.Instance.astarPath.GetNearest((Int3)path[0]).node as GridNode;
		GridNode gridNode4 = DormCoordinate.Instance.astarPath.GetNearest((Int3)path[path.Count - 1]).node as GridNode;
		if (gridNode4.XCoordinateInGrid == gridNode2.XCoordinateInGrid && gridNode4.ZCoordinateInGrid == gridNode2.ZCoordinateInGrid)
		{
			path[path.Count - 1] = end;
		}
		if (gridNode3.XCoordinateInGrid == gridNode.XCoordinateInGrid && gridNode3.ZCoordinateInGrid == gridNode.ZCoordinateInGrid)
		{
			path[0] = start;
		}
		else
		{
			path.Insert(0, start);
		}
	}

	public static List<Vector3> CalcPath(Vector3 start, Vector3 target)
	{
		List<Vector3> vectorPath = DormCoordinate.Instance.FindPath(start, target).vectorPath;
		AdjustPath(vectorPath, start, target);
		return vectorPath;
	}

	private static bool IsStuck(DormComplexEntity entity)
	{
		return Physics.CheckSphere(entity.GetWorldPos(), entity.radius, ignoreGroundRaycastAndCharaLayer, QueryTriggerInteraction.Ignore);
	}

	private static Vector3 CalcMoveTarget(Vector3 start, Vector3 dir, float radius, float maxDistance)
	{
		int layerMask = ignoreGroundRaycastLayer;
		float num = 0.0005f;
		bool flag = Physics.SphereCast(start - dir * num, radius, dir, out var hitInfo, maxDistance, layerMask, QueryTriggerInteraction.Ignore);
		return CalcHitPos(start, dir, radius, flag ? hitInfo.point : ((radius + maxDistance) * dir + start));
	}

	private static Vector3 CalcHitPos(Vector3 start, Vector3 dir, float radius, Vector3 hitPoint)
	{
		Vector3 vector = hitPoint - start;
		Vector3 vector2 = Vector3.Dot(vector, dir) * dir;
		float sqrMagnitude = (vector - vector2).sqrMagnitude;
		Vector3 vector3 = start + (Vector3.Dot(vector, dir) - Mathf.Sqrt(radius * radius - sqrMagnitude)) * dir;
		float num = 0.0005f;
		return vector3 - dir * num;
	}

	public static Vector3 RndDir()
	{
		int num = UnityEngine.Random.Range(0, 360);
		return (Quaternion.Euler(0f, num, 0f) * Vector3.forward).normalized;
	}
}
