using System;

namespace MessagePack;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
public class KeyAttribute : Attribute
{
	public int? IntKey { get; private set; }

	public string StringKey { get; private set; }

	public KeyAttribute(int x)
	{
		IntKey = x;
	}

	public KeyAttribute(string x)
	{
		StringKey = x;
	}
}
