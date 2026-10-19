using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class RunChangeStateObject : IDataToBake
{
	[SerializeField]
	private StateWorldUid _linkObject;

	[SerializeField]
	private int _stateId;

	public StateWorldUid LinkObject => _linkObject;

	public int StateId => _stateId;
}
