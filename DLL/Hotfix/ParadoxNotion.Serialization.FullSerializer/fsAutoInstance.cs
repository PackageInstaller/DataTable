using System;

namespace ParadoxNotion.Serialization.FullSerializer;

[AttributeUsage(AttributeTargets.Class)]
public sealed class fsAutoInstance : Attribute
{
	public readonly bool makeInstance;

	public fsAutoInstance(bool makeInstance = true)
	{
		this.makeInstance = makeInstance;
	}
}
