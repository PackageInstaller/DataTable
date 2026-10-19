using System;

namespace UnityEngine.Rendering;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false)]
public class VolumeComponentMenu : Attribute
{
	public readonly string menu;

	public VolumeComponentMenu(string menu)
	{
		this.menu = menu;
	}
}
