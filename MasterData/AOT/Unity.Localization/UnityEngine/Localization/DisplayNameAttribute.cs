using System;

namespace UnityEngine.Localization;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false)]
public class DisplayNameAttribute : Attribute
{
	public string Name { get; set; }

	public string IconPath { get; set; }

	public DisplayNameAttribute(string name, string iconPath = null)
	{
		Name = name;
		IconPath = iconPath;
	}
}
