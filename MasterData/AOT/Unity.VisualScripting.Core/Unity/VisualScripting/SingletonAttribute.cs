using System;
using UnityEngine;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Class, Inherited = true, AllowMultiple = false)]
public sealed class SingletonAttribute : Attribute
{
	public bool Persistent { get; set; }

	public bool Automatic { get; set; }

	public HideFlags HideFlags { get; set; }

	public string Name { get; set; }

	public SingletonAttribute()
	{
		HideFlags = HideFlags.None;
	}
}
