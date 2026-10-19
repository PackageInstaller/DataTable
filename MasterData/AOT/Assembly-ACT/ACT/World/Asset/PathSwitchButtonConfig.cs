using System;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.Asset;

[Serializable]
public class PathSwitchButtonConfig
{
	[SerializeField]
	private LocalizedString _localizedString = new LocalizedString();

	[SerializeField]
	private int _weight;

	[SerializeField]
	private int _iconId;

	public LocalizedString LocalizedString => _localizedString;

	public int Weight => _weight;

	public int IconId => _iconId;
}
