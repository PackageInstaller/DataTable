using System;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Method)]
public class BeforeRenderOrderAttribute : Attribute
{
	public int order { get; }
}
