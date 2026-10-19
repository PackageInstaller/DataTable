using UnityEngine;

namespace Unity.VisualScripting.Community.Libraries.Humility;

public static class HUMMath
{
	public static class Data
	{
		public struct AddRect(Rect rect)
		{
			public Rect rect = rect;
		}

		public struct SubtractRect(Rect rect)
		{
			public Rect rect = rect;
		}

		public struct MultiplyRect(Rect rect)
		{
			public Rect rect = rect;
		}

		public struct DivideRect(Rect rect)
		{
			public Rect rect = rect;
		}

		public struct SplitRect(Rect rect)
		{
			public Rect rect = rect;
		}

		public struct SplitInto(SplitRect split)
		{
			public SplitRect split = split;
		}

		public struct SetRect(Rect rect)
		{
			public Rect rect = rect;
		}

		public struct LeftRect(Rect rect)
		{
			public Rect rect = rect;
		}

		public struct RightRect(Rect rect)
		{
			public Rect rect = rect;
		}

		public struct TopRect(Rect rect)
		{
			public Rect rect = rect;
		}

		public struct BottomRect(Rect rect)
		{
			public Rect rect = rect;
		}

		public struct SetVector3(Vector3 vector)
		{
			public Vector3 vector = vector;
		}

		public struct SetVector2(Vector2 vector)
		{
			public Vector2 vector = vector;
		}
	}

	public static float Negate(this float value)
	{
		return value *= -1f;
	}

	public static float Positive(this float value)
	{
		if (value < 0f)
		{
			return value.Negate();
		}
		return value;
	}

	public static float Negative(this float value)
	{
		if (value > 0f)
		{
			return value.Negate();
		}
		return value;
	}

	public static float Remap(this float from, float fromMin, float fromMax, float toMin, float toMax)
	{
		float num = from - fromMin;
		float num2 = fromMax - fromMin;
		float num3 = num / num2;
		return (toMax - toMin) * num3 + toMin;
	}

	public static int Negate(this int value)
	{
		return value *= -1;
	}

	public static int Positive(this int value)
	{
		if (value < 0)
		{
			return value.Negate();
		}
		return value;
	}

	public static int Negative(this int value)
	{
		if (value > 0)
		{
			return value.Negate();
		}
		return value;
	}

	public static int ToInt(this string str)
	{
		return int.Parse(str);
	}

	public static int Remap(this int from, int fromMin, int fromMax, int toMin, int toMax)
	{
		int num = from - fromMin;
		int num2 = fromMax - fromMin;
		int num3 = num / num2;
		return (toMax - toMin) * num3 + toMin;
	}

	public static Data.AddRect Add(this Rect rect)
	{
		return new Data.AddRect(rect);
	}

	public static Rect Add(this Rect A, Rect B)
	{
		return new Rect(A.x + B.x, A.y + B.y, A.width + B.width, A.height + B.height);
	}

	public static Data.SubtractRect Subtract(this Rect rect)
	{
		return new Data.SubtractRect(rect);
	}

	public static Rect Subtract(this Rect A, Rect B)
	{
		return new Rect(A.x - B.x, A.y - B.y, A.width - B.width, A.height - B.height);
	}

	public static Data.MultiplyRect Multiply(this Rect rect)
	{
		return new Data.MultiplyRect(rect);
	}

	public static Rect Multiply(this Rect A, Rect B)
	{
		return new Rect(A.x * B.x, A.y * B.y, A.width * B.width, A.height * B.height);
	}

	public static Data.DivideRect Divide(this Rect rect)
	{
		return new Data.DivideRect(rect);
	}

	public static Rect Divide(this Rect A, Rect B)
	{
		return new Rect(A.x / B.x, A.y / B.y, A.width / B.width, A.height / B.height);
	}

	public static Data.SplitRect Split(this Rect rect)
	{
		return new Data.SplitRect(rect);
	}

	public static Data.SetRect Set(this Rect rect)
	{
		return new Data.SetRect(rect);
	}

	public static Data.LeftRect Left(this Rect rect)
	{
		return new Data.LeftRect(rect);
	}

	public static Data.RightRect Right(this Rect rect)
	{
		return new Data.RightRect(rect);
	}

	public static Data.TopRect Top(this Rect rect)
	{
		return new Data.TopRect(rect);
	}

	public static Data.BottomRect Bottom(this Rect rect)
	{
		return new Data.BottomRect(rect);
	}

	public static Vector2 Add(this Vector2 multiplyValue, float value)
	{
		return new Vector2(multiplyValue.x + value, multiplyValue.y + value);
	}

	public static Vector2 Add(this Vector2 multiplyValue, Vector2 value)
	{
		return new Vector2(multiplyValue.x + value.x, multiplyValue.y + value.y);
	}

	public static Vector2 Subtract(this Vector2 multiplyValue, float value)
	{
		return new Vector2(multiplyValue.x - value, multiplyValue.y - value);
	}

	public static Vector2 Subtract(this Vector2 multiplyValue, Vector2 value)
	{
		return new Vector2(multiplyValue.x - value.x, multiplyValue.y - value.y);
	}

	public static Vector2 Multiply(this Vector2 multiplyValue, float value)
	{
		return new Vector2(multiplyValue.x * value, multiplyValue.y * value);
	}

	public static Vector2 Multiply(this Vector2 multiplyValue, Vector2 value)
	{
		return new Vector2(multiplyValue.x * value.x, multiplyValue.y * value.y);
	}

	public static Vector2 Divide(this Vector2 multiplyValue, float value)
	{
		return new Vector2(multiplyValue.x / value, multiplyValue.y / value);
	}

	public static Vector2 Divide(this Vector2 multiplyValue, Vector2 value)
	{
		return new Vector2(multiplyValue.x / value.x, multiplyValue.y / value.y);
	}

	public static Vector2 Half(this Vector2 vector)
	{
		return vector / 2f;
	}

	public static Vector2 Quarter(this Vector2 vector)
	{
		return vector / 4f;
	}

	public static Vector3 Add(this Vector3 multiplyValue, float value)
	{
		return new Vector3(multiplyValue.x + value, multiplyValue.y + value, multiplyValue.z + value);
	}

	public static Vector3 Add(this Vector3 multiplyValue, Vector3 value)
	{
		return new Vector3(multiplyValue.x + value.x, multiplyValue.y + value.y, multiplyValue.z + value.z);
	}

	public static Vector3 Subtract(this Vector3 multiplyValue, float value)
	{
		return new Vector3(multiplyValue.x - value, multiplyValue.y - value, multiplyValue.z - value);
	}

	public static Vector3 Subtract(this Vector3 multiplyValue, Vector3 value)
	{
		return new Vector3(multiplyValue.x - value.x, multiplyValue.y - value.y, multiplyValue.z - value.z);
	}

	public static Vector3 Multiply(this Vector3 multiplyValue, float value)
	{
		return new Vector3(multiplyValue.x * value, multiplyValue.y * value, multiplyValue.z * value);
	}

	public static Vector3 Multiply(this Vector3 multiplyValue, Vector3 value)
	{
		return new Vector3(multiplyValue.x * value.x, multiplyValue.y * value.y, multiplyValue.z * value.z);
	}

	public static Vector3 Divide(this Vector3 multiplyValue, float value)
	{
		return new Vector3(multiplyValue.x / value, multiplyValue.y / value, multiplyValue.z / value);
	}

	public static Vector3 Divide(this Vector3 multiplyValue, Vector3 value)
	{
		return new Vector3(multiplyValue.x / value.x, multiplyValue.y / value.y, multiplyValue.z / value.z);
	}

	public static Vector3 Half(this Vector3 vector)
	{
		return vector / 2f;
	}

	public static Data.SetVector3 Set(this Vector3 vector)
	{
		return new Data.SetVector3(vector);
	}
}
