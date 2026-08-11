using System;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = false)]
public abstract class PropertyAttribute : Attribute
{
	public int order { get; set; }
}
