namespace UnityEngine.InputSystem.Processors;

public class StickDeadzoneProcessor : InputProcessor<Vector2>
{
	public float min;

	public float max;

	private float minOrDefault
	{
		get
		{
			if (min != 0f)
			{
				return min;
			}
			return InputSystem.settings.defaultDeadzoneMin;
		}
	}

	private float maxOrDefault
	{
		get
		{
			if (max != 0f)
			{
				return max;
			}
			return InputSystem.settings.defaultDeadzoneMax;
		}
	}

	public override Vector2 Process(Vector2 value, InputControl control = null)
	{
		float magnitude = value.magnitude;
		float deadZoneAdjustedValue = GetDeadZoneAdjustedValue(magnitude);
		if (deadZoneAdjustedValue == 0f)
		{
			value = Vector2.zero;
		}
		else
		{
			value *= deadZoneAdjustedValue / magnitude;
		}
		return value;
	}

	private float GetDeadZoneAdjustedValue(float value)
	{
		float num = minOrDefault;
		float num2 = maxOrDefault;
		float num3 = Mathf.Abs(value);
		if (num3 < num)
		{
			return 0f;
		}
		if (num3 > num2)
		{
			return Mathf.Sign(value);
		}
		return Mathf.Sign(value) * ((num3 - num) / (num2 - num));
	}

	public override string ToString()
	{
		return $"StickDeadzone(min={minOrDefault},max={maxOrDefault})";
	}
}
