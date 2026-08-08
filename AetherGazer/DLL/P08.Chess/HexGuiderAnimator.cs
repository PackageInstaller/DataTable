using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HexGuiderAnimator : HexAnimatorBase
{
	private IEnumerator co;

	private bool needYOffsetStart;

	private bool needYOffsetEnd;

	public override string GetStartState()
	{
		if (!needYOffsetStart)
		{
			return "start";
		}
		return "start 0";
	}

	public override string GetEndState()
	{
		if (!needYOffsetEnd)
		{
			return "end";
		}
		return "end 0";
	}

	public override string GetIdleState()
	{
		return "stand";
	}

	public void StartMoveAlongPath(List<Vector3> list, bool needYOffsetStart = false, bool needYOffsetEnd = false, float speed = 0f, Action walkEndCallBack = null)
	{
		if (co != null)
		{
			StopCoroutine(co);
		}
		this.needYOffsetStart = needYOffsetStart;
		this.needYOffsetEnd = needYOffsetEnd;
		co = MoveAlongPath(list, speed, walkEndCallBack);
		StartCoroutine(co);
	}

	private void OnDestroy()
	{
		if (co != null)
		{
			StopCoroutine(co);
		}
	}
}
