using System;
using ACT.ViewControl;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

[Serializable]
public sealed class TaskViewV3InputBinding
{
	[SerializeField]
	private ViewControlLayer _listControlLayer;

	[SerializeField]
	private ViewControlLayer _detailControlLayer;

	[SerializeField]
	private ScrollRect _detailScrollRect;

	[SerializeField]
	private RightStickScrollSupport _rightStickScrollSupport;

	[SerializeField]
	private GamePadTipsComp _gamePadTips;

	internal ViewControlLayer ListControlLayer => _listControlLayer;

	internal ViewControlLayer DetailControlLayer => _detailControlLayer;

	internal ScrollRect DetailScrollRect => _detailScrollRect;

	internal RightStickScrollSupport RightStickScrollSupport => _rightStickScrollSupport;

	internal GamePadTipsComp GamePadTips => _gamePadTips;
}
