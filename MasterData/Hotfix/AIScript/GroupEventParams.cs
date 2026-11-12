using System;
using System.Collections.Generic;

namespace AIScript;

public class GroupEventParams
{
	public GroupEventType type;

	public bool active;

	public Action<IEvent> operation;

	public List<int> intParams;

	public List<string> stringParams;

	public GroupEventParams(GroupEventType type, bool active, Action<IEvent> operation)
	{
		this.type = type;
		this.active = active;
		this.operation = operation;
	}

	public GroupEventParams(GroupEventType type, bool active, Action<IEvent> operation, List<int> intParams)
	{
		this.type = type;
		this.active = active;
		this.operation = operation;
		this.intParams = intParams;
	}

	public GroupEventParams(GroupEventType type, bool active, Action<IEvent> operation, List<string> stringParams)
	{
		this.type = type;
		this.active = active;
		this.operation = operation;
		this.stringParams = stringParams;
	}
}
