using UnityEngine;

namespace ParadoxNotion;

public static class OperationTools
{
	public static string GetOperationString(OperationMethod om)
	{
		return om switch
		{
			OperationMethod.Set => " = ", 
			OperationMethod.Add => " += ", 
			OperationMethod.Subtract => " -= ", 
			OperationMethod.Multiply => " *= ", 
			OperationMethod.Divide => " /= ", 
			_ => string.Empty, 
		};
	}

	public static float Operate(float a, float b, OperationMethod om, float delta = 1f)
	{
		return om switch
		{
			OperationMethod.Set => b, 
			OperationMethod.Add => a + b * delta, 
			OperationMethod.Subtract => a - b * delta, 
			OperationMethod.Multiply => a * (b * delta), 
			OperationMethod.Divide => a / (b * delta), 
			_ => a, 
		};
	}

	public static int Operate(int a, int b, OperationMethod om)
	{
		return om switch
		{
			OperationMethod.Set => b, 
			OperationMethod.Add => a + b, 
			OperationMethod.Subtract => a - b, 
			OperationMethod.Multiply => a * b, 
			OperationMethod.Divide => a / b, 
			_ => a, 
		};
	}

	public static long Operate(long a, long b, OperationMethod om)
	{
		return om switch
		{
			OperationMethod.Set => b, 
			OperationMethod.Add => a + b, 
			OperationMethod.Subtract => a - b, 
			OperationMethod.Multiply => a * b, 
			OperationMethod.Divide => a / b, 
			_ => a, 
		};
	}

	public static Vector3 Operate(Vector3 a, Vector3 b, OperationMethod om, float delta = 1f)
	{
		switch (om)
		{
		case OperationMethod.Set:
			return b;
		case OperationMethod.Add:
			return a + b * delta;
		case OperationMethod.Subtract:
			return a - b * delta;
		case OperationMethod.Multiply:
			return Vector3.Scale(a, b * delta);
		case OperationMethod.Divide:
			b *= delta;
			return new Vector3(a.x / b.x, a.y / b.y, a.z / b.z);
		default:
			return a;
		}
	}

	public static string GetCompareString(CompareMethod cm)
	{
		return cm switch
		{
			CompareMethod.EqualTo => " == ", 
			CompareMethod.GreaterThan => " > ", 
			CompareMethod.LessThan => " < ", 
			CompareMethod.GreaterOrEqualTo => " >= ", 
			CompareMethod.LessOrEqualTo => " <= ", 
			_ => string.Empty, 
		};
	}

	public static bool Compare(float a, float b, CompareMethod cm, float floatingPoint)
	{
		return cm switch
		{
			CompareMethod.EqualTo => Mathf.Abs(a - b) <= floatingPoint, 
			CompareMethod.GreaterThan => a > b, 
			CompareMethod.LessThan => a < b, 
			CompareMethod.GreaterOrEqualTo => a >= b, 
			CompareMethod.LessOrEqualTo => a <= b, 
			_ => true, 
		};
	}

	public static bool Compare(int a, int b, CompareMethod cm)
	{
		return cm switch
		{
			CompareMethod.EqualTo => a == b, 
			CompareMethod.GreaterThan => a > b, 
			CompareMethod.LessThan => a < b, 
			CompareMethod.GreaterOrEqualTo => a >= b, 
			CompareMethod.LessOrEqualTo => a <= b, 
			_ => true, 
		};
	}
}
