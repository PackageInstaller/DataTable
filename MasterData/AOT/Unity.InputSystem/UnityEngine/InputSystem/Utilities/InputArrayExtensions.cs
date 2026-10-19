namespace UnityEngine.InputSystem.Utilities;

internal static class InputArrayExtensions
{
	public static int IndexOfReference<TValue>(this InlinedArray<TValue> array, TValue value) where TValue : class
	{
		for (int i = 0; i < array.length; i++)
		{
			if (array[i] == value)
			{
				return i;
			}
		}
		return -1;
	}

	public static bool Contains<TValue>(this InlinedArray<TValue> array, TValue value)
	{
		for (int i = 0; i < array.length; i++)
		{
			if (array[i].Equals(value))
			{
				return true;
			}
		}
		return false;
	}

	public static bool ContainsReference<TValue>(this InlinedArray<TValue> array, TValue value) where TValue : class
	{
		return array.IndexOfReference(value) != -1;
	}
}
