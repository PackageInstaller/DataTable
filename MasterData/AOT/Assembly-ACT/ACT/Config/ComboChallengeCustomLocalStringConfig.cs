using System;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.Config;

[Serializable]
public struct ComboChallengeCustomLocalStringConfig
{
	[SerializeField]
	private bool _customLocalString;

	[SerializeField]
	private LocalizedString _mainTipText;

	[SerializeField]
	private LocalizedString _mainProgressText;

	[SerializeField]
	private LocalizedString _subProgressTip;

	public bool CustomLocalString => _customLocalString;

	public LocalizedString MainTipText => _mainTipText;

	public LocalizedString MainProgressText => _mainProgressText;

	public LocalizedString SubProgressTip => _subProgressTip;
}
