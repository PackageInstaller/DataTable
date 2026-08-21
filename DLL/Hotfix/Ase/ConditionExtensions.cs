using UnityEngine;

namespace Ase;

public static class ConditionExtensions
{
	public static bool CompareValueMethod(CompareMethodType methodType, float v1, float v2)
	{
		return methodType switch
		{
			CompareMethodType.Equal => v1.FloatEquals(v2), 
			CompareMethodType.Greater => v1 > v2, 
			CompareMethodType.Less => v1 < v2, 
			CompareMethodType.GOrE => v1 >= v2, 
			CompareMethodType.LOrE => v1 <= v2, 
			CompareMethodType.NoEqual => v1 != v2, 
			_ => false, 
		};
	}

	public static bool CompareValueMethod(CompareMethodType methodType, int v1, int v2)
	{
		return methodType switch
		{
			CompareMethodType.Equal => Mathf.Abs(v1 - v2) == 0, 
			CompareMethodType.Greater => v1 > v2, 
			CompareMethodType.Less => v1 < v2, 
			CompareMethodType.GOrE => v1 >= v2, 
			CompareMethodType.LOrE => v1 <= v2, 
			CompareMethodType.NoEqual => v1 != v2, 
			_ => false, 
		};
	}

	public static bool CompareValueMethod(ChangeType changeType, float v1, float changed)
	{
		return changeType switch
		{
			ChangeType.Add => changed >= v1, 
			ChangeType.Dec => changed <= 0f - v1, 
			_ => false, 
		};
	}
}
