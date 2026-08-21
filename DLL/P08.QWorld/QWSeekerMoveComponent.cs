using System;
using UnityEngine;

public class QWSeekerMoveComponent
{
	private QWFindPathSeeker pathSeeker;

	private QWFindRouteSeeker routeSeeker;

	private QWSeekerBase curSeeker;

	public Action OnStartMove;

	public QWOnSeekerDelegate OnMove;

	public QWOnRotateDelegate OnRotate;

	public Action OnStop;

	public QWOnOnInteractionChange OnInteractionChange;

	public bool isRun;

	private Transform agent;

	public QWSeekerMoveComponent(Transform agent)
	{
		this.agent = agent;
		curSeeker = null;
		isRun = false;
	}

	public void StartSeeker(Vector3 endPos, float radius = 0f)
	{
		if (curSeeker != null && curSeeker.IsSeeking())
		{
			curSeeker.Stop();
		}
		if (pathSeeker == null)
		{
			pathSeeker = new QWFindPathSeeker();
			pathSeeker.Init(agent, this);
		}
		curSeeker = pathSeeker;
		pathSeeker.StartSeeker(endPos, radius);
	}

	public void StartSeekerByRoute(QWSeekerByRouteContext ctx, Vector3[] path, Action callback, Action<int> arriveStage, bool isRun, float radius = 0f, float pauseRadius = -1f, Action onPauseAction = null, bool lerpY = false)
	{
		this.isRun = isRun;
		if (curSeeker != null && curSeeker.IsSeeking())
		{
			curSeeker.Stop();
		}
		if (routeSeeker == null)
		{
			routeSeeker = new QWFindRouteSeeker();
			routeSeeker.Init(agent, this);
		}
		curSeeker = routeSeeker;
		routeSeeker.StartSeeker(ctx, path, callback, arriveStage, radius, pauseRadius, onPauseAction, lerpY, OnInteractionChange);
	}

	public void Tick()
	{
		curSeeker?.Tick();
	}

	public void Stop()
	{
		curSeeker = null;
		isRun = false;
	}

	public void StopNoNotify()
	{
		if (curSeeker != null)
		{
			curSeeker.StopNoNotify();
			Stop();
		}
	}

	public void Dispose()
	{
		pathSeeker?.Dispose();
		routeSeeker?.Dispose();
		pathSeeker = null;
		routeSeeker = null;
	}

	public bool isInSeeking()
	{
		if (curSeeker != null && curSeeker.IsSeeking())
		{
			return true;
		}
		return false;
	}

	public bool isInPausing()
	{
		if (curSeeker != null && curSeeker.IsSeeking() && curSeeker.IsPausing())
		{
			return true;
		}
		return false;
	}
}
