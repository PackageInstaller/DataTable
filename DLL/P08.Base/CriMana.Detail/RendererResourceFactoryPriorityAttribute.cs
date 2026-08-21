using System;

namespace CriMana.Detail;

[AttributeUsage(AttributeTargets.Class)]
public class RendererResourceFactoryPriorityAttribute : Attribute
{
	public readonly int priority;

	public RendererResourceFactoryPriorityAttribute(int priority)
	{
		this.priority = priority;
	}
}
