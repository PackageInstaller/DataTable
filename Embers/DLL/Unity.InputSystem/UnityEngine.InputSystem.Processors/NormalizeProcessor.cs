namespace UnityEngine.InputSystem.Processors;

public class NormalizeProcessor : InputProcessor<float>
{
	public float min;

	public float max;

	public float zero;

	public override float Process(float value, InputControl control)
	{
		return Normalize(value, min, max, zero);
	}

	public static float Normalize(float value, float min, float max, float zero)
	{
		if (zero < min)
		{
			zero = min;
		}
		if (Mathf.Approximately(value, min))
		{
			if (min < zero)
			{
				return -1f;
			}
			return 0f;
		}
		float num = (value - min) / (max - min);
		if (min < zero)
		{
			return 2f * num - 1f;
		}
		return num;
	}

	internal static float Denormalize(float value, float min, float max, float zero)
	{
		if (zero < min)
		{
			zero = min;
		}
		if (min < zero)
		{
			if (value < 0f)
			{
				return min + (zero - min) * (value * -1f);
			}
			return zero + (max - zero) * value;
		}
		return min + (max - min) * value;
	}

	public override string ToString()
	{
		return $"Normalize(min={min},max={max},zero={zero})";
	}
}
