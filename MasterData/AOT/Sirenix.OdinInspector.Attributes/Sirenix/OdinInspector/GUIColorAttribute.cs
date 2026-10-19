using System;
using System.Diagnostics;
using UnityEngine;

namespace Sirenix.OdinInspector;

[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
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
