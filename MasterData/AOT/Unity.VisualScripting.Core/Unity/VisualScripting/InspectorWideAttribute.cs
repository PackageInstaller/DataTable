using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public sealed class InspectorWideAttribute : Attribute
{
	public bool toEdge { get; private set; }

	public InspectorWideAttribute()
	{
	}

	public InspectorWideAttribute(bool toEdge)
	{
		this.toEdge = toEdge;
	}
}
