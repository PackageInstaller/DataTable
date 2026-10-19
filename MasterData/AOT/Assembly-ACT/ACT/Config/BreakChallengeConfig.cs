using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

public class BreakChallengeConfig : ScriptableObject
{
	[SerializeField]
	private BreakChallengeCustomLocalStringConfig _customLocalStringConfig;

	[SerializeField]
	private string _breakPointModelGUID;

	[SerializeField]
	private ChallengeStateConfig[] _stateConfig;

	[SerializeField]
	private List<BreakPointData> _breakPoints = new List<BreakPointData>();

	[SerializeReference]
	private Round[] _rounds;

	[SerializeField]
	private ExitField[] _triggerBounds;

	public BreakChallengeCustomLocalStringConfig CustomLocalStringConfig => _customLocalStringConfig;

	public string BreakPointModelGuid => _breakPointModelGUID;

	public ChallengeStateConfig[] StateConfig => _stateConfig;

	public List<BreakPointData> BreakPoints => _breakPoints;

	public Round[] Rounds => _rounds;

	public ExitField[] TriggerBounds => _triggerBounds;
}
