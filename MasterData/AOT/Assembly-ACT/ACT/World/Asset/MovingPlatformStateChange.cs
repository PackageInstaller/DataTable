using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class MovingPlatformStateChange : IDataToBake
{
	[SerializeField]
	private StateWorldUid _stateWorldUid;

	[SerializeField]
	private int _stateId;

	public StateWorldUid stateWorldUid => _stateWorldUid;

	public int stateId => _stateId;
}
