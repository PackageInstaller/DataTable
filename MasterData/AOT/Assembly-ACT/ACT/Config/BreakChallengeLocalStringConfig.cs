using UnityEngine;
using UnityEngine.Localization;

namespace ACT.Config;

public class BreakChallengeLocalStringConfig : ScriptableObject
{
	[SerializeField]
	private LocalizedString _mainTipText;

	[SerializeField]
	private LocalizedString _mainProgressText;

	[SerializeField]
	private LocalizedString _subProgressTip;

	public LocalizedString MainTipText => _mainTipText;

	public LocalizedString MainProgressText => _mainProgressText;

	public LocalizedString SubProgressTip => _subProgressTip;
}
