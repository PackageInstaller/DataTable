using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[DontApplyToListElements]
[AttributeUsage(AttributeTargets.All, AllowMultiple = true, Inherited = true)]
public sealed class OnCollectionChangedAttribute : Attribute
{
	public string Before;

	public string After;

	public OnCollectionChangedAttribute()
	{
	}

	public OnCollectionChangedAttribute(string after)
	{
		After = after;
	}

	public OnCollectionChangedAttribute(string before, string after)
	{
		Before = before;
		After = after;
	}
}
