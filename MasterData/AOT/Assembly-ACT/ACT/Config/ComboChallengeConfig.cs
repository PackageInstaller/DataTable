using UnityEngine;

namespace ACT.Config;

public class ComboChallengeConfig : ScriptableObject
{
	[SerializeField]
	private ComboChallengeCustomLocalStringConfig _customLocalStringConfig;

	[SerializeField]
	private string _comboSwitchModelGUID;

	[SerializeField]
	private string _comboTargetModelGUID;

	[SerializeField]
	private Vector3 _comboTargetLocalPosition;

	[SerializeField]
	private int _comboCountNeed;

	[SerializeField]
	private float _timeLimit;

	[SerializeField]
	private float _deathAnimDuration = 1f;

	[SerializeField]
	private float _bornAnimDuration = 1f;

	[SerializeField]
	private ComboStageConfig _comboStageConfig1;

	[SerializeField]
	private ComboStageConfig _comboStageConfig2;

	[SerializeField]
	private ComboStageConfig _comboStageConfig3;

	[SerializeField]
	private ChallengeStateConfig[] _stateConfig;

	[SerializeField]
	private ExitField[] _triggerBounds;

	public ComboChallengeCustomLocalStringConfig CustomLocalStringConfig => _customLocalStringConfig;

	public string ComboSwitchModelGuid => _comboSwitchModelGUID;

	public string ComboTargetModelGuid => _comboTargetModelGUID;

	public Vector3 ComboTargetLocalPosition => _comboTargetLocalPosition;

	public int ComboCountNeed => _comboCountNeed;

	public float TimeLimit => _timeLimit;

	public float DeathAnimDuration => _deathAnimDuration;

	public float BornAnimDuration => _bornAnimDuration;

	public ComboStageConfig ComboStageConfig1 => _comboStageConfig1;

	public ComboStageConfig ComboStageConfig2 => _comboStageConfig2;

	public ComboStageConfig ComboStageConfig3 => _comboStageConfig3;

	public ChallengeStateConfig[] StateConfig => _stateConfig;

	public ExitField[] TriggerBounds => _triggerBounds;
}
