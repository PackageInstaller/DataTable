using System;
using Pathfinding;
using UnityEngine;

public class QWFindPathSeeker : QWSeekerBase
{
	private Path seekerPath;

	private OnPathDelegate seekerResultDelegate;

	private bool isInSeeker;

	private float endRadius;

	private int curSeekerStage;

	private Transform trans;

	private Vector3 endPosition;

	private QWSeekerMoveComponent comp;

	public override void Init(Transform agent, QWSeekerMoveComponent comp)
	{
		trans = agent;
		seekerResultDelegate = (OnPathDelegate)Delegate.Combine(seekerResultDelegate, new OnPathDelegate(OnPathFinded));
		isInSeeker = false;
		curSeekerStage = 0;
		this.comp = comp;
	}

	private void OnPathFinded(Path p)
	{
		if (!isInSeeker)
		{
			comp.OnStartMove?.Invoke();
		}
		QWorldPathFinderManager.Instance.PathSmooth(p);
		seekerPath = p;
		curSeekerStage = 0;
		isInSeeker = true;
	}

	public override void Dispose()
	{
	}

	public override void Stop()
	{
		if (isInSeeker)
		{
			comp.OnStop?.Invoke();
			isInSeeker = false;
		}
		seekerPath = null;
	}

	public override void Pause()
	{
	}

	public override bool IsPausing()
	{
		return false;
	}

	public void StartSeeker(Vector3 endPos, float radius = 0f)
	{
		endRadius = radius;
		endPosition = endPos;
		QWorldPathFinderManager.Instance.FindPath((Int3)trans.position, (Int3)endPos, seekerResultDelegate);
	}

	public override void Tick()
	{
		if (!isInSeeker || seekerPath == null)
		{
			return;
		}
		if (Vector3.Distance(endPosition, trans.position) <= endRadius)
		{
			Stop();
			return;
		}
		int count = seekerPath.vectorPath.Count;
		Vector3 vector = seekerPath.vectorPath[curSeekerStage];
		if (Vector3.Distance(trans.position, vector) < 0.25f)
		{
			curSeekerStage++;
			if (curSeekerStage >= count)
			{
				Stop();
				return;
			}
			vector = seekerPath.vectorPath[curSeekerStage];
		}
		Vector3 position = trans.position;
		Vector3 vector2 = vector - position;
		Vector3 normalized = new Vector3(vector2.x, 0f, vector2.z).normalized;
		comp.OnMove?.Invoke(normalized, vector);
	}

	public override bool IsSeeking()
	{
		return isInSeeker;
	}

	public override void StopNoNotify()
	{
		isInSeeker = false;
		seekerPath = null;
	}
}
