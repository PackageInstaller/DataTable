using System;
using System.Diagnostics;
using UnityEngine;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
[Conditional("UNITY_EDITOR")]
public class GUIColorAttribute : Attribute
{
	public Color Color;

	public string GetColor;

	public GUIColorAttribute(float r, float g, float b, float a = 1f)
	{
		Color = new Color(r, g, b, a);
	}

	public GUIColorAttribute(string getColor)
	{
		GetColor = getColor;
	}
}
