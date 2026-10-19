using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.Asset;

[Serializable]
public class StandardElevatorLayer : IDataToBake
{
	public StateWorldUid lockFlag;

	public List<IncludeObject> includedObjects;

	public int weight;

	public LocalizedString layerName;

	public Pos pos;

	public int iconId;

	public int layerID;

	public bool hasExitPath;

	public StateWorldUid exitPath;

	[SerializeField]
	private bool _needCheckButtonVisibility;

	[SerializeField]
	private StateWorldUid _buttonVisibilityCondition;

	[SerializeField]
	private List<int> _showButtonStates = new List<int>();

	[SerializeField]
	private List<int> _hideButtonStates = new List<int>();

	public bool NeedCheckButtonVisibility => _needCheckButtonVisibility;

	public StateWorldUid ButtonVisibilityCondition => _buttonVisibilityCondition;

	public IReadOnlyList<int> ShowButtonStates => _showButtonStates;

	public IReadOnlyList<int> HideButtonStates => _hideButtonStates;
}
