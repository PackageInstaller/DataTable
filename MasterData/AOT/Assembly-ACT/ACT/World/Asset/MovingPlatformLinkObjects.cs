using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class MovingPlatformLinkObjects : IDataToBake
{
	[SerializeField]
	private StateWorldUid _stateWorldUid;

	[SerializeField]
	private bool _startChangeState;

	[SerializeField]
	private int _startState;

	[SerializeField]
	private bool _endChangeState;

	[SerializeField]
	private int _endState;

	public StateWorldUid StateWorldUid => _stateWorldUid;

	public bool StartChangeState => _startChangeState;

	public int StartState => _startState;

	public bool EndChangeState => _endChangeState;

	public int EndState => _endState;
}
