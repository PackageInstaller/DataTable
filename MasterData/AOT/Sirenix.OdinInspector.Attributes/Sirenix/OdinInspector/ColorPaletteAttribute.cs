using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public sealed class ColorPaletteAttribute : Attribute
{
	public string PaletteName;

	public bool ShowAlpha;

	public ColorPaletteAttribute()
	{
		PaletteName = null;
		ShowAlpha = true;
	}

	public ColorPaletteAttribute(string paletteName)
	{
		PaletteName = paletteName;
		ShowAlpha = true;
	}
}
