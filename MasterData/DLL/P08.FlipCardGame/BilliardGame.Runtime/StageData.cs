using System;
using System.Collections.Generic;
using UnityEngine;

namespace BilliardGame.Runtime;

[Serializable]
public class StageData : ScriptableObject
{
	public int stageId;

	[SerializeField]
	public List<GridData> gridData;

	public static int mWidth = 19;

	public static int mHeight = 9;

	[SerializeField]
	public List<Vector3> playerBornPos = new List<Vector3>
	{
		Vector3.zero,
		Vector3.zero,
		Vector3.zero
	};

	[SerializeField]
	public List<MonsterData> monsters;

	[SerializeField]
	public List<MechanismData> mechanisms;

	public float[] initParams;

	public bool isMagnify;

	public float[] magnifyParams = new float[3];

	public int magnifyMapRound;

	public int magnifyMapStageId;

	public static int ExchangeIndexFromPosition(Vector3Int pos)
	{
		Vector3Int vector3Int = pos - new Vector3Int(-(mWidth - 1) / 2, (mHeight - 1) / 2);
		return Math.Abs(vector3Int.y) * mWidth + vector3Int.x;
	}

	public static Vector3Int ExchangePositionFromIndex(int index)
	{
		int y = -(index / mWidth) + (mHeight - 1) / 2;
		return new Vector3Int(index % mWidth - (mWidth - 1) / 2, y, 0);
	}
}
