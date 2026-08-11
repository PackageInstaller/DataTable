using System;

namespace NodeCanvas.Framework;

[AttributeUsage(AttributeTargets.Class)]
public class DropReferenceType : Attribute
{
	public readonly Type type;

	public DropReferenceType(Type type)
	{
		this.type = type;
	}
}
