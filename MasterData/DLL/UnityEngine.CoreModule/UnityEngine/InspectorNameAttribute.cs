using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = false)]
[UsedByNativeCode]
public class InspectorNameAttribute : PropertyAttribute
{
	public readonly string displayName;

	public InspectorNameAttribute(string displayName)
	{
		this.displayName = displayName;
	}
}
