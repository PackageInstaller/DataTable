using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public class BattleSpawnBornBehaviorEntry
{
	[SerializeField]
	private int _id;

	[SerializeField]
	private string _behaviorName;

	public int Id => _id;

	public string BehaviorName => _behaviorName;
}
