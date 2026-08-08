using System;

namespace UnityEngine;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
public sealed class CreateAssetMenuAttribute : Attribute
{
	public string menuName { get; set; }

	public string fileName { get; set; }

	public int order { get; set; }
}
