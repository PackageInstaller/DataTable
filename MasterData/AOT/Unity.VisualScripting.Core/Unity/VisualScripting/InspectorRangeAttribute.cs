using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Parameter, AllowMultiple = false, Inherited = true)]
public sealed class InspectorRangeAttribute : Attribute
{
	public float min { get; private set; }

	public float max { get; private set; }

	public InspectorRangeAttribute(float min, float max)
	{
		this.min = min;
		this.max = max;
	}
}
