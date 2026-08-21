using System;
using UnityEngine;

public class QWMoveToTargetAction : QWAgentAction
{
	public QWMoveActionType moveType = QWMoveActionType.FindPath;

	public Transform target;

	public float testRadius;

	public float pauseRadius = -1f;

	public Vector3[] routes;

	public Action stopCallback;

	public Action<int> arriveCallback;

	public Action pauseCallback;

	public bool isRun;

	public bool needForward;

	public Vector3 endForward;

	public Vector3 forward;

	public bool enableInteraction;

	public int interactionMode;

	public QWMoveToTargetAction()
		: base(E_Type.MoveToTarget)
	{
	}

	public override void Reset()
	{
		base.Reset();
		target = null;
		routes = null;
		stopCallback = null;
		arriveCallback = null;
		pauseCallback = null;
		isRun = false;
		testRadius = 0f;
		pauseRadius = -1f;
		needForward = false;
		enableInteraction = false;
	}
}
