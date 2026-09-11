using System;
using System.Collections.Generic;
using Chess;
using UnityEngine;

public class HexGuiderManager
{
	private static HexGuiderManager sInstance;

	public HexGuiderAnimator hexAnimator;

	public static HexGuiderManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new HexGuiderManager();
			}
			return sInstance;
		}
	}

	public void InitGuider(string path, int x, int z)
	{
		GameObject gameObject = Asset.InstantiateWithoutCache(path);
		hexAnimator = gameObject.GetComponent<HexGuiderAnimator>();
		if (hexAnimator == null)
		{
			hexAnimator = gameObject.AddComponent<HexGuiderAnimator>();
		}
		hexAnimator.WantedPosition = ChessHelper.GetWorldPositionByHexCoord(x, z);
	}

	public void MoveGuiderAlongPath(List<Int2> pathNodeS, float speed = 0f, Action walkEndCallBack = null)
	{
		if (pathNodeS.Count < 2)
		{
			Debug.LogError("At Least Need 2 Node");
			return;
		}
		bool needYOffsetStart = HexManager.Instance.FindEntity(pathNodeS[1].x, pathNodeS[1].y).gridData.typeID != 10101;
		bool needYOffsetEnd = HexManager.Instance.FindEntity(pathNodeS[pathNodeS.Count - 1].x, pathNodeS[pathNodeS.Count - 1].y).gridData.typeID != 10101;
		List<Vector3> list = new List<Vector3>();
		for (int i = 0; i < pathNodeS.Count; i++)
		{
			list.Add(ChessHelper.GetWorldPositionByHexCoord(pathNodeS[i].x, pathNodeS[i].y));
		}
		if (hexAnimator != null)
		{
			hexAnimator.StartMoveAlongPath(list, needYOffsetStart, needYOffsetEnd, speed, walkEndCallBack);
		}
	}
}
