using System;

namespace UnityEngine.Rendering;

[AttributeUsage(AttributeTargets.Field)]
public class DisplayInfoAttribute : Attribute
{
	public string name;

	public int order;
}
