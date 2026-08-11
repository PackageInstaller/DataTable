using System;
using System.Diagnostics;

namespace Sirenix.OdinInspector;

[DontApplyToListElements]
[Conditional("UNITY_EDITOR")]
[AttributeUsage(AttributeTargets.All, AllowMultiple = false, Inherited = true)]
public class PropertySpaceAttribute : Attribute
{
	public float SpaceBefore;

	public float SpaceAfter;

	public PropertySpaceAttribute()
	{
		SpaceBefore = 8f;
		SpaceAfter = 0f;
	}

	public PropertySpaceAttribute(float spaceBefore)
	{
		SpaceBefore = spaceBefore;
		SpaceAfter = 0f;
	}

	public PropertySpaceAttribute(float spaceBefore, float spaceAfter)
	{
		SpaceBefore = spaceBefore;
		SpaceAfter = spaceAfter;
	}
}
