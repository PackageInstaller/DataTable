using System.Collections.Generic;

namespace P08.Gamepad;

public class ControlGroupList
{
	private List<ControlGroup> _groups;

	public List<ControlGroup> groups => _groups;

	public ControlGroupList(ControlGroupRes res)
	{
		_groups = new List<ControlGroup>();
		foreach (ControlGroupRes.ControlGroupData group in res.groups)
		{
			_groups.Add(new ControlGroup(group));
		}
	}
}
