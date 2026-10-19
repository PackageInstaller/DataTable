using System;
using UnityEngine;

namespace Sirenix.OdinInspector;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Interface)]
public class TypeRegistryItemAttribute : Attribute
{
	public string Name;

	public string CategoryPath;

	public SdfIconType Icon;

	public Color? LightIconColor;

	public Color? DarkIconColor;

	public int Priority;

	public TypeRegistryItemAttribute(string name = null, string categoryPath = null, SdfIconType icon = SdfIconType.None, float lightIconColorR = 0f, float lightIconColorG = 0f, float lightIconColorB = 0f, float lightIconColorA = 0f, float darkIconColorR = 0f, float darkIconColorG = 0f, float darkIconColorB = 0f, float darkIconColorA = 0f, int priority = 0)
	{
		Name = name;
		CategoryPath = categoryPath;
		Icon = icon;
		if (lightIconColorR != 0f || lightIconColorG != 0f || lightIconColorB != 0f || lightIconColorA > 0f)
		{
			LightIconColor = new Color(lightIconColorR, lightIconColorG, lightIconColorB, (lightIconColorA > 0f) ? lightIconColorA : 1f);
		}
		else
		{
			LightIconColor = null;
		}
		if (darkIconColorR != 0f || darkIconColorG != 0f || darkIconColorB != 0f || darkIconColorA > 0f)
		{
			DarkIconColor = new Color(darkIconColorR, darkIconColorG, darkIconColorB, (darkIconColorA > 0f) ? darkIconColorA : 1f);
		}
		else
		{
			DarkIconColor = null;
		}
		Priority = priority;
	}
}
