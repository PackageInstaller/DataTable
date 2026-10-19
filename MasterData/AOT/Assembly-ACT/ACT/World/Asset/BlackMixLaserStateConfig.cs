using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BlackMixLaserStateConfig
{
	[SerializeField]
	private int _stateId;

	[SerializeField]
	private int[] _activeLaserIndices;

	public int StateId => _stateId;

	public int[] ActiveLaserIndices => _activeLaserIndices;
}
