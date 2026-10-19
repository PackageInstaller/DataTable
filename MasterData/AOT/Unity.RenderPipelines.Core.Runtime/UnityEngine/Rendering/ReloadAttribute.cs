using System;

namespace UnityEngine.Rendering;

[AttributeUsage(AttributeTargets.Field)]
public sealed class ReloadAttribute : Attribute
{
	public enum Package
	{
		Builtin,
		Root,
		BuiltinExtra
	}

	public ReloadAttribute(string[] paths, Package package = Package.Root)
	{
	}

	public ReloadAttribute(string path, Package package = Package.Root)
		: this(new string[1] { path }, package)
	{
	}

	public ReloadAttribute(string pathFormat, int rangeMin, int rangeMax, Package package = Package.Root)
	{
	}
}
