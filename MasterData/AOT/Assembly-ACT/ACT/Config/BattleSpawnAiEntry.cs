using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public class BattleSpawnAiEntry
{
	[SerializeField]
	private int _id;

	[SerializeField]
	private int _index;

	public int Id => _id;

	public int Index => _index;
}
