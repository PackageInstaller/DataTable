using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public class ChallengeStateConfig
{
	[SerializeField]
	private int _stateWorldUid;

	[SerializeField]
	private int _startState;

	[SerializeField]
	private int _failState;

	[SerializeField]
	private int _successState;

	public int StateWorldUid => _stateWorldUid;

	public int StartState => _startState;

	public int FailState => _failState;

	public int SuccessState => _successState;
}
