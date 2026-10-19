using System;
using UnityEngine;

namespace ACT;

[Serializable]
public class GraphicSettingPreset
{
	[SerializeField]
	private string _optionId;

	[SerializeField]
	private int _value;

	[SerializeField]
	private bool _onlyForInitUse;

	public string OptionId => _optionId;

	public int Value => _value;

	public bool OnlyForInitUse => _onlyForInitUse;
}
