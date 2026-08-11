namespace UnityEngine.InputSystem;

public static class InputExtensions
{
	public static bool IsInProgress(this InputActionPhase phase)
	{
		if (phase != InputActionPhase.Started)
		{
			return phase == InputActionPhase.Performed;
		}
		return true;
	}

	public static bool IsEndedOrCanceled(this TouchPhase phase)
	{
		if (phase != TouchPhase.Canceled)
		{
			return phase == TouchPhase.Ended;
		}
		return true;
	}

	public static bool IsActive(this TouchPhase phase)
	{
		if ((uint)(phase - 1) <= 1u || phase == TouchPhase.Stationary)
		{
			return true;
		}
		return false;
	}

	public static bool IsModifierKey(this Key key)
	{
		if ((uint)(key - 51) <= 7u)
		{
			return true;
		}
		return false;
	}

	public static bool IsTextInputKey(this Key key)
	{
		if ((uint)key <= 3u || (uint)(key - 51) <= 26u || (uint)(key - 94) <= 17u)
		{
			return false;
		}
		return true;
	}
}
