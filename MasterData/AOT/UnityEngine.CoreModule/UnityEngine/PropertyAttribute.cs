using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[UsedByNativeCode]
[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = false)]
public abstract class PropertyAttribute : Attribute
{
	public int order { get; set; }
}
