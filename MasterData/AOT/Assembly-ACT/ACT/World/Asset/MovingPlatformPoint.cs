using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class MovingPlatformPoint : IDataToBake
{
	[SerializeField]
	private Pos _position;

	[SerializeField]
	private float _waitingTime;

	[SerializeField]
	private float _nextPathTime = 1f;

	[SerializeField]
	private bool _moveInstantly;

	[SerializeField]
	private MovingPlatformStateChange[] _arrivalStateChanges;

	public Pos position => _position;

	public float waitingTime => _waitingTime;

	public float nextPathTime => _nextPathTime;

	public bool moveInstantly => _moveInstantly;

	public MovingPlatformStateChange[] arrivalStateChanges => _arrivalStateChanges;
}
