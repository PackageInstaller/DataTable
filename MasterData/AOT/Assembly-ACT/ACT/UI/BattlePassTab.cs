using System;
using UnityEngine;

namespace ACT.UI;

public class BattlePassTab : BaseTabToggle
{
	[Header("正常态")]
	[SerializeField]
	private GameObject _normalState;

	[Header("选中态")]
	[SerializeField]
	private GameObject _selectedState;

	[SerializeField]
	private RedDotItem _redDotItem;

	public RedDotItem RedDotItem => _redDotItem;

	public override Func<bool> CanActive => () => true;

	protected override void OnTabActive()
	{
		base.OnTabActive();
	}

	protected override void OnTabDeActive()
	{
		base.OnTabDeActive();
	}
}
