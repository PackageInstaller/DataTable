using UnityEngine;

namespace ACT.Config;

public class BattleChallengeConfig : ScriptableObject
{
	[SerializeField]
	private BattleChallengeCustomLocalStringConfig _customLocalStringConfig;

	[SerializeField]
	private BattleSpawnPointConfig[] _spawnPoints;

	[SerializeField]
	private float _timeLimit;

	[SerializeField]
	private ChallengeStateConfig[] _stateConfig;

	[SerializeField]
	private ExitField[] _triggerBounds;

	public BattleChallengeCustomLocalStringConfig CustomLocalStringConfig => _customLocalStringConfig;

	public BattleSpawnPointConfig[] SpawnPoints => _spawnPoints;

	public float TimeLimit => _timeLimit;

	public ChallengeStateConfig[] StateConfig => _stateConfig;

	public ExitField[] TriggerBounds => _triggerBounds;
}
