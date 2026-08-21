using System;
using Ase;
using UnityEngine;

public static class SkillVariableType
{
	public static Type[] SkillTimeLineVariableType = new Type[9]
	{
		typeof(int),
		typeof(float),
		typeof(bool),
		typeof(string),
		typeof(Vector3),
		typeof(Vector2),
		typeof(AnimationCurve),
		typeof(HeroSkillTypeEnum),
		typeof(InputOptionEnum)
	};
}
