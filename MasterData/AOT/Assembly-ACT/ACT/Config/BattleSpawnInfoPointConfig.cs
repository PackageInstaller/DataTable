using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public class BattleSpawnInfoPointConfig
{
	[SerializeField]
	private string _posName;

	[SerializeField]
	private Vector3 _position;

	public string PosName => _posName;

	public Vector3 Position => _position;
}
