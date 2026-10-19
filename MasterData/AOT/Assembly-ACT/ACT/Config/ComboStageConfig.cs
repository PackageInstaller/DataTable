using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public class ComboStageConfig
{
	[SerializeField]
	private int _startComboCount;

	[SerializeField]
	private int _endComboCount;

	public int StartComboCount => _startComboCount;

	public int EndComboCount => _endComboCount;
}
