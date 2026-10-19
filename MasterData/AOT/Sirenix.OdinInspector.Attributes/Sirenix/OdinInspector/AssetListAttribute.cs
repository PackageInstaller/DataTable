using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public sealed class AssetListAttribute : Attribute
{
	public bool AutoPopulate;

	public string Tags;

	public string LayerNames;

	public string AssetNamePrefix;

	public string Path;

	public string CustomFilterMethod;

	public AssetListAttribute()
	{
		AutoPopulate = false;
		Tags = null;
		LayerNames = null;
		AssetNamePrefix = null;
		CustomFilterMethod = null;
	}
}
