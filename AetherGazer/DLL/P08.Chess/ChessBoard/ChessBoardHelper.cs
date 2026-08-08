using System;
using System.Collections.Generic;
using UnityEngine;

namespace ChessBoard;

public class ChessBoardHelper
{
	public static List<Vector3> forwardMap = new List<Vector3>
	{
		new Vector3(1f, 0f, 0f),
		new Vector3(0.5f, 0f, 0.9f),
		new Vector3(-0.5f, 0f, 0.9f),
		new Vector3(-1f, 0f, 0f),
		new Vector3(-0.5f, 0f, -0.9f),
		new Vector3(0.5f, 0f, -0.9f)
	};

	private const float DELTA = 0.2f;

	public static List<Int2> GetRangeNodeS(int centerX, int centerZ, int range)
	{
		List<Int2> list = new List<Int2>();
		Int3 @int = NewHexGridCoord.AxialToCubeCoord(centerX, centerZ);
		for (int i = -range; i <= range; i++)
		{
			for (int j = Mathf.Max(-range, -i - range); j <= Mathf.Min(range, -i + range); j++)
			{
				int z = -i - j;
				Int3 int2 = @int + new Int3(i, j, z);
				list.Add(NewHexGridCoord.CubeToAxialCoord(int2.x, int2.y, int2.z));
			}
		}
		return list;
	}

	public static Animator GetGridAnimator(GameObject go)
	{
		Animator component = go.GetComponent<Animator>();
		if (component == null)
		{
			Transform transform = go.transform.Find("ani");
			if (transform != null)
			{
				component = transform.GetComponent<Animator>();
			}
		}
		return component;
	}

	public static void PlayDisappearEffect(GameObject go, Action callBack = null)
	{
		HexTransitionEffect transitionController = GetTransitionController(go);
		if (transitionController == null || !transitionController.enabled)
		{
			callBack?.Invoke();
		}
		else
		{
			transitionController.Disappear(go, callBack);
		}
	}

	public static HexTransitionEffect GetTransitionController(GameObject go)
	{
		Transform transform = go.transform.Find("Transition");
		if (transform == null)
		{
			return null;
		}
		return transform.gameObject.GetComponent<HexTransitionEffect>();
	}

	public static int WaitForAnimationEnd(Animator animator, Action callback)
	{
		int timer = 0;
		int fullPathHash = -1;
		timer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			if (animator == null)
			{
				FuncTimerManager.inst.RemoveFuncTimer(timer);
			}
			else
			{
				AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
				if (fullPathHash == -1)
				{
					fullPathHash = currentAnimatorStateInfo.fullPathHash;
				}
				if (currentAnimatorStateInfo.normalizedTime > 0.96f || fullPathHash != currentAnimatorStateInfo.fullPathHash)
				{
					FuncTimerManager.inst.RemoveFuncTimer(timer);
					if (callback != null)
					{
						callback();
					}
				}
			}
		}, 0.1f);
		return timer;
	}

	public static void PlayAppearEffect(GameObject go, Action callBack = null)
	{
		HexTransitionEffect transitionController = GetTransitionController(go);
		if (transitionController == null || !transitionController.enabled)
		{
			callBack?.Invoke();
		}
		else
		{
			transitionController.Appear(go, callBack);
		}
	}

	public static int GetDirByRotation(int rot)
	{
		if (rot < 0)
		{
			rot += 360;
		}
		if (rot >= 360)
		{
			rot %= 360;
		}
		return (6 - rot / 60) % 6;
	}

	public static int GetDirectionByForward(Vector3 forward)
	{
		for (int i = 0; i < forwardMap.Count; i++)
		{
			if (Math.Abs(forwardMap[i].x - (float)Math.Round(forward.x, 1)) < 0.2f && Math.Abs(forwardMap[i].y - (float)Math.Round(forward.y, 1)) < 0.2f && Math.Abs(forwardMap[i].z - (float)Math.Round(forward.z, 1)) < 0.2f)
			{
				return i;
			}
		}
		return 0;
	}

	public static int GetDirByOffset(int offsetx, int offsetz)
	{
		for (int i = 0; i < ChessBoardHexGridCoord.mGridDirection.Length; i++)
		{
			if (ChessBoardHexGridCoord.mGridDirection[i].x == offsetx && ChessBoardHexGridCoord.mGridDirection[i].y == offsetz)
			{
				return i;
			}
		}
		Debug.Log("lrq 获取方向错误 ， x,z:" + offsetx + " ," + offsetz);
		return 0;
	}
}
