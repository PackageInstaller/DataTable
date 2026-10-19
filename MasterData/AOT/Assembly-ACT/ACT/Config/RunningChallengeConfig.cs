using UnityEngine;

namespace ACT.Config;

public class RunningChallengeConfig : ScriptableObject
{
	[SerializeField]
	private RunningChallengeCustomLocalStringConfig _customLocalStringConfig;

	[SerializeField]
	private string _checkpointModelGUID;

	[SerializeField]
	private Vector3[] _checkpointPositions;

	[SerializeField]
	private float _timeLimit;

	[SerializeField]
	private ChallengeStateConfig[] _stateConfig;

	[SerializeField]
	private ExitField[] _triggerBounds;

	public RunningChallengeCustomLocalStringConfig CustomLocalStringConfig => _customLocalStringConfig;

	public string CheckpointModelGuid => _checkpointModelGUID;

	public Vector3[] CheckpointPositions => _checkpointPositions;

	public float TimeLimit => _timeLimit;

	public ChallengeStateConfig[] StateConfig => _stateConfig;

	public ExitField[] TriggerBounds => _triggerBounds;
}
