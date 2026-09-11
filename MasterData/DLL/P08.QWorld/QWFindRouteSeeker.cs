using System;
using UnityEngine;

public class QWFindRouteSeeker : QWSeekerBase
{
	private Vector3[] paths;

	private bool isInSeeker;

	private bool isInPause;

	private bool lerpY;

	private float endRadius;

	private float pauseRadius = -1f;

	private int curSeekerStage;

	private Transform trans;

	public Action StopCallback;

	public Action<int> ArriveStageCallback;

	public Action PauseCallback;

	public QWOnOnInteractionChange changeInteractionAction;

	private QWAgent Player;

	private QWSeekerByRouteContext ctx;

	private QWSeekerMoveComponent comp;

	public override void Dispose()
	{
	}

	public override void Init(Transform agent, QWSeekerMoveComponent comp)
	{
		trans = agent;
		isInSeeker = false;
		isInPause = false;
		curSeekerStage = 0;
		this.comp = comp;
		Player = (NScene.GetCurrentScene() as QWorldScene).Agent;
	}

	public override void Stop()
	{
		if (isInSeeker)
		{
			if (ctx.enableInteraction)
			{
				changeInteractionAction?.Invoke(enableInteraction: false, 0);
			}
			comp.OnStop?.Invoke();
			comp.Stop();
			isInSeeker = false;
			isInPause = false;
			Action stopCallback = StopCallback;
			StopCallback = null;
			ArriveStageCallback = null;
			PauseCallback = null;
			paths = null;
			stopCallback?.Invoke();
		}
		else
		{
			StopCallback = null;
			ArriveStageCallback = null;
			PauseCallback = null;
			paths = null;
		}
	}

	public override void StopNoNotify()
	{
		isInSeeker = false;
		isInPause = false;
		StopCallback = null;
		ArriveStageCallback = null;
		PauseCallback = null;
		paths = null;
	}

	public override void Pause()
	{
		if (!isInPause)
		{
			isInPause = true;
			if (ctx.enableInteraction)
			{
				changeInteractionAction?.Invoke(enableInteraction: false, 0);
			}
			PauseCallback?.Invoke();
			comp.OnStop?.Invoke();
		}
	}

	public override bool IsPausing()
	{
		return isInPause;
	}

	public override void Tick()
	{
		if (!isInSeeker || paths == null)
		{
			return;
		}
		if (pauseRadius != -1f && Vector3.Distance(Player.Position, trans.position) > pauseRadius)
		{
			Pause();
			return;
		}
		if (isInPause)
		{
			if (ctx.enableInteraction)
			{
				changeInteractionAction?.Invoke(enableInteraction: true, ctx.inteactionMode);
			}
			comp.OnStartMove?.Invoke();
		}
		isInPause = false;
		int num = paths.Length;
		if (Vector3.Distance(paths[num - 1], trans.position) <= endRadius)
		{
			if (ctx.needForward)
			{
				if (Vector3.Angle(trans.forward.normalized, ctx.endForward.normalized) <= 5f)
				{
					Stop();
					return;
				}
				Quaternion rot = Quaternion.LookRotation(Vector3.Slerp(trans.forward, Vector3.ProjectOnPlane(ctx.endForward.normalized, Vector3.up), Time.deltaTime * 8f));
				comp.OnRotate?.Invoke(rot);
			}
			else
			{
				Stop();
			}
			return;
		}
		Vector3 vector = paths[(curSeekerStage >= num) ? (num - 1) : curSeekerStage];
		if (Vector3.Distance(trans.position, vector) < 0.25f)
		{
			curSeekerStage++;
			ArriveStageCallback?.Invoke((curSeekerStage >= num) ? (num - 1) : curSeekerStage);
			if (curSeekerStage >= num)
			{
				if (ctx.needForward)
				{
					if (Vector3.Angle(trans.forward.normalized, ctx.endForward.normalized) <= 5f)
					{
						Stop();
						return;
					}
					Quaternion rot2 = Quaternion.LookRotation(Vector3.Slerp(trans.forward, Vector3.ProjectOnPlane(ctx.endForward.normalized, Vector3.up), Time.deltaTime * 8f));
					comp.OnRotate?.Invoke(rot2);
				}
				else
				{
					Stop();
				}
				return;
			}
			vector = paths[curSeekerStage];
		}
		Vector3 position = trans.position;
		Vector3 vector2 = vector - position;
		Vector3 dir = ((!lerpY) ? new Vector3(vector2.x, 0f, vector2.z).normalized : vector2.normalized);
		comp.OnMove?.Invoke(dir, vector);
	}

	public void StartSeeker(QWSeekerByRouteContext ctx, Vector3[] posList, Action stopCB, Action<int> arriveCB, float radius = 0f, float pauseRadius = -1f, Action pauseAction = null, bool lerpY = false, QWOnOnInteractionChange OnInteractionChange = null)
	{
		changeInteractionAction = OnInteractionChange;
		this.ctx = ctx;
		isInPause = false;
		paths = posList;
		this.lerpY = lerpY;
		if (!isInSeeker)
		{
			if (ctx.enableInteraction)
			{
				changeInteractionAction?.Invoke(enableInteraction: true, ctx.inteactionMode);
			}
			comp.OnStartMove?.Invoke();
		}
		StopCallback = stopCB;
		ArriveStageCallback = arriveCB;
		PauseCallback = pauseAction;
		paths = posList;
		curSeekerStage = 0;
		endRadius = radius;
		this.pauseRadius = pauseRadius;
		isInSeeker = true;
	}

	public override bool IsSeeking()
	{
		return isInSeeker;
	}
}
