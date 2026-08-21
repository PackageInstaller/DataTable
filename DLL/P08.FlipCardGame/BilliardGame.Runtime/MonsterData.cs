using System;
using UnityEngine;

namespace BilliardGame.Runtime;

[Serializable]
public class MonsterData
{
	[NonSerialized]
	public int index;

	public int entityId;

	public string path;

	public BilliardTurnType turnType = BilliardTurnType.None;

	public int turn = 1;

	public int afterWave = 1;

	public int wave = 1;

	public Vector3 position;

	public Vector3 rotation;

	public Vector3 scale;
}
