using System;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Field, Inherited = true, AllowMultiple = false)]
public sealed class GradientUsageAttribute : PropertyAttribute
{
	public readonly bool hdr = false;

	public readonly ColorSpace colorSpace = ColorSpace.Gamma;

	public GradientUsageAttribute(bool hdr)
	{
		this.hdr = hdr;
		colorSpace = ColorSpace.Gamma;
	}

	public GradientUsageAttribute(bool hdr, ColorSpace colorSpace)
	{
		this.hdr = hdr;
		this.colorSpace = colorSpace;
	}
}
