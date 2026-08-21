using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public class PropertyOrderAttribute : Attribute
{
	public float Order;

	public PropertyOrderAttribute()
	{
	}

	public PropertyOrderAttribute(float order)
	{
		Order = order;
	}
}
