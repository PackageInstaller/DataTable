using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field | AttributeTargets.Parameter, AllowMultiple = false, Inherited = true)]
public sealed class InspectorActionDirectionAttribute : Attribute
{
	public ActionDirection direction { get; private set; }

	public InspectorActionDirectionAttribute(ActionDirection direction)
	{
		this.direction = direction;
	}
}
