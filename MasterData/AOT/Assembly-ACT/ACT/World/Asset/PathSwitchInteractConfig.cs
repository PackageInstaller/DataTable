using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class PathSwitchInteractConfig
{
	[SerializeField]
	private int _tipIcon = -1;

	[SerializeField]
	private Pos _interactTipPos = new Pos();

	public int TipIcon => _tipIcon;

	public Pos InteractTipPos => _interactTipPos;
}
