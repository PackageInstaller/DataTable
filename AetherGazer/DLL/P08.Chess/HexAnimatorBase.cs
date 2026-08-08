using System;
using System.Collections;
using System.Collections.Generic;
using Pathfinding;
using UnityEngine;

public class HexAnimatorBase : MonoBehaviour
{
	public float roleSpeed = 2f;

	public const string idle = "stand";

	public const string runStart = "start";

	public const string runEnd = "end";

	public Action onWalkStart;

	public Action onWalkStop;

	private Vector3 wantedPostion;

	private Vector3 forwardPosition;

	private Animator m_animator;

	public Vector3 WantedPosition
	{
		get
		{
			return wantedPostion;
		}
		set
		{
			wantedPostion = value;
		}
	}

	private void Awake()
	{
		wantedPostion = base.transform.position;
		m_animator = GetComponent<Animator>();
	}

	private void Update()
	{
	}

	protected void OnAnimatorMove()
	{
		Vector3 normalized = (wantedPostion - base.transform.position).normalized;
		if (!(normalized != Vector3.zero))
		{
			_ = forwardPosition;
			if (!(forwardPosition != Vector3.zero))
			{
				return;
			}
		}
		base.transform.position = wantedPostion;
		_ = forwardPosition;
		if (forwardPosition != Vector3.zero)
		{
			base.transform.forward = forwardPosition;
			forwardPosition = Vector3.zero;
		}
		else
		{
			base.transform.forward = normalized;
		}
	}

	public virtual string GetStartState()
	{
		return "start";
	}

	public virtual string GetEndState()
	{
		return "end";
	}

	public virtual string GetIdleState()
	{
		return "stand";
	}

	public IEnumerator MoveAlongPath(List<Vector3> path, float speed = 0f, Action walkEndCallBack = null)
	{
		if (path.Count == 0)
		{
			throw new ArgumentException("Cannot follow an empty path");
		}
		if (walkEndCallBack != null)
		{
			onWalkStop = walkEndCallBack;
		}
		if (onWalkStart != null)
		{
			onWalkStart();
		}
		m_animator.CrossFade(GetStartState(), 0.2f);
		float distanceAlongSegment = 0f;
		for (int i = 0; i < path.Count - 1; i++)
		{
			Vector3 p0 = path[Mathf.Max(i - 1, 0)];
			Vector3 p1 = path[i];
			Vector3 p2 = path[i + 1];
			Vector3 p3 = path[Mathf.Min(i + 2, path.Count - 1)];
			float segmentLength = Vector3.Distance(p1, p2);
			if (i == path.Count - 2)
			{
				m_animator.CrossFade(GetEndState(), 0.2f);
			}
			for (; distanceAlongSegment < segmentLength; distanceAlongSegment += Time.deltaTime * ((speed == 0f) ? roleSpeed : speed))
			{
				Vector3 vector = AstarSplines.CatmullRom(p0, p1, p2, p3, distanceAlongSegment / segmentLength);
				wantedPostion = vector;
				yield return null;
			}
			distanceAlongSegment -= segmentLength;
		}
		wantedPostion = path[path.Count - 1];
		m_animator.CrossFade(GetIdleState(), 0.2f);
		if (onWalkStop != null)
		{
			onWalkStop();
		}
	}
}
