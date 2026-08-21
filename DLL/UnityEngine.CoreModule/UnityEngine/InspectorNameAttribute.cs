using System;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = false)]
public class InspectorNameAttribute : PropertyAttribute
{
	public readonly string displayName;

	public InspectorNameAttribute(string displayName)
	{
		this.displayName = displayName;
	}
}
