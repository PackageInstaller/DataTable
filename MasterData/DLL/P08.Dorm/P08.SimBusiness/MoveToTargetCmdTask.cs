using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Dorm;
using Dorm.Character;
using P08.SimBusiness.Pathfinding;
using Pathfinding;
using UnityEngine;

namespace P08.SimBusiness;

public class MoveToTargetCmdTask : DormEntityAction.MoveCmdTask
{
	public Transform target;

	public Vector3? targetPos;

	public float repathRate = 0.5f;

	private float nextRepath = float.MinValue;

	public float nearByWaypointRange = 0.2f;

	private bool repathFinish;

	private Path path;

	private bool firstFindPath;

	private bool ShouldRepath => false;

	private Vector3? Dest
	{
		get
		{
			if (!target)
			{
				return targetPos;
			}
			return target.position;
		}
	}

	public MoveToTargetCmdTask(Transform target)
	{
		this.target = target;
	}

	public MoveToTargetCmdTask(Vector3 target)
	{
		targetPos = target;
	}

	private bool NearEnough(Vector3 p1, Vector3 p2)
	{
		return (p2 - p1).sqrMagnitude < nearByWaypointRange * nearByWaypointRange;
	}

	private void OnPathFound(DormEntity entity, Path p)
	{
		p.Claim(entity);
		if (!p.error)
		{
			if (path != null)
			{
				path.Release(entity);
			}
			path = p;
			repathFinish = true;
		}
		else
		{
			p.Release(entity);
		}
	}

	public void Stop(DormEntity entity)
	{
		if (path != null)
		{
			path.Release(entity);
		}
		path = null;
		target = null;
		targetPos = null;
	}

	private bool UpdatePathFinding(DormEntity entity, PathfindingSeeker seeker)
	{
		if (seeker.IsDone() && (!firstFindPath || ShouldRepath))
		{
			firstFindPath = true;
			nextRepath = Time.time + Random.value * repathRate;
			XPath xPath = XPath.Construct((Int3)entity.GetWorldPos(), (Int3)Dest.Value);
			IProvideInteractArea provideInteractArea = null;
			if ((bool)target)
			{
				provideInteractArea = target.GetComponentInChildren<IProvideInteractArea>();
			}
			if (provideInteractArea == null)
			{
				xPath.endingCondition = new EndingConditionProximity(xPath, 0.25f);
			}
			else
			{
				xPath.endingCondition = new SceneNavSurface.EndingConditionProximityInArea(xPath, provideInteractArea);
			}
			xPath.heuristic = Heuristic.Manhattan;
			seeker.StartPath(xPath, delegate(Path path)
			{
				OnPathFound(entity, path);
			});
		}
		if (path != null && repathFinish)
		{
			repathFinish = false;
			return true;
		}
		return false;
	}

	protected override IEnumerator StartTask(EntityCmdExecutor executor)
	{
		firstFindPath = false;
		DormComplexEntity entity = executor.entity;
		PathfindingSeeker seeker = SimBusinessMgr.GetEntityPathSeeker(entity);
		InteractAreaScanner scanner = entity.Scanner;
		if (!entity.Movable || !Dest.HasValue || !seeker)
		{
			WalkEnd(entity.Movable && (bool)seeker);
			yield break;
		}
		if (AstarPath.active == null)
		{
			Debug.LogError("No Active AStar Data!!!");
			WalkEnd(reachTarget: false);
			yield break;
		}
		base.ResetMoveAnime = true;
		yield return null;
		scanner.StartScan(skipClear: true);
		IEnumerator moveTask = null;
		while (Dest.HasValue)
		{
			if (UpdatePathFinding(entity, seeker))
			{
				List<Vector3> wayPoints = FindSubpathByNearest(path, entity.GetWorldPos());
				moveTask = MoveByPathCoroutine(entity, wayPoints, Vector3.zero);
			}
			if (base.ResetMoveAnime)
			{
				entity.Play(DormEntity.DormEntityAnime.Move);
				base.ResetMoveAnime = false;
			}
			if (moveTask == null)
			{
				yield return null;
			}
			else if (moveTask.MoveNext())
			{
				yield return moveTask.Current;
			}
			else
			{
				Stop(entity);
			}
		}
		WalkEnd(reachTarget: true);
	}

	private static Vector3 ToNearest(Vector3 pos, Vector3 segStart, Vector3 segEnd)
	{
		Vector3 vector = segEnd - segStart;
		Vector3 vector2 = pos - segStart;
		float num = Vector3.Dot(vector2, vector);
		if (num > 1f)
		{
			return pos - segEnd;
		}
		if (num < 0f)
		{
			return vector2;
		}
		return pos - (segStart + num * vector);
	}

	private List<Vector3> FindSubpathByNearest(Path path, Vector3 pos)
	{
		List<Vector3> vectorPath = path.vectorPath;
		if (vectorPath.Count <= 1)
		{
			return vectorPath;
		}
		int count = 0;
		float num = float.MaxValue;
		for (int i = 0; i < vectorPath.Count - 1; i++)
		{
			Vector3 segStart = vectorPath[i];
			Vector3 segEnd = vectorPath[i + 1];
			Vector3 vector = ToNearest(pos, segStart, segEnd);
			if (vector.sqrMagnitude <= num)
			{
				count = i;
				num = vector.sqrMagnitude;
			}
		}
		return vectorPath.Skip(count).ToList();
	}

	protected override void OnExecuteFinished(EntityCmdExecutor executor)
	{
		executor.entity.Scanner.EndScan();
		Stop(executor.entity);
		base.OnExecuteFinished(executor);
	}

	protected override void OnStopByExecutor(EntityCmdExecutor executor)
	{
		executor.entity.Scanner.EndScan();
		Stop(executor.entity);
		base.OnStopByExecutor(executor);
	}
}
