using System;
using System.Collections.Generic;

namespace P08.Gamepad;

[Serializable]
public class ControlGroup
{
	private EControlType _controlType;

	private int _conflictGroup;

	private List<En_ButtonType> _keys;

	public EControlType controlType => _controlType;

	public int conflictGroup => _conflictGroup;

	public List<En_ButtonType> keys => _keys;

	public ControlGroup(ControlGroupRes.ControlGroupData data)
	{
		_controlType = data.controlType;
		_conflictGroup = data.conflictGroup;
		_keys = data.keys;
	}
}
