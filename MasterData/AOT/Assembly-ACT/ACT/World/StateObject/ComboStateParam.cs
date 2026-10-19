using System;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.World.StateObject;

[Serializable]
public struct ComboStateParam
{
	[SerializeField]
	[FormerlySerializedAs("startComboCount")]
	private int _startComboCount;

	[SerializeField]
	[FormerlySerializedAs("endComboCount")]
	private int _endComboCount;

	public int startComboCount => _startComboCount;

	public int endComboCount => _endComboCount;
}
