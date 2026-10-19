using UnityEngine.InputSystem;

namespace ACT.UI;

public class RebindingContext
{
	public InputActionRebindingExtensions.RebindingOperation RebindingOperation;

	public bool Started
	{
		get
		{
			if (RebindingOperation != null)
			{
				return RebindingOperation.started;
			}
			return false;
		}
	}

	public void CancelAndCleanUp()
	{
		RebindingOperation?.Cancel();
		CleanUp();
	}

	public void CleanUp()
	{
		RebindingOperation?.Dispose();
		RebindingOperation = null;
	}
}
