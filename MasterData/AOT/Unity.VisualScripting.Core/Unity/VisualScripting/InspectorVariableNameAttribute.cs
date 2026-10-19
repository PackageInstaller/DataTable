using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Parameter, AllowMultiple = false, Inherited = true)]
public sealed class InspectorVariableNameAttribute : Attribute
{
	public ActionDirection direction { get; private set; }

	public InspectorVariableNameAttribute(ActionDirection direction)
	{
		this.direction = direction;
	}
}
