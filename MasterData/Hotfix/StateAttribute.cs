using System;

public struct StateAttribute
{
	public int referenceCount;

	public Action<int> enableAction;

	public Action<int> disableAction;

	public Action interruptAction;

	public Func<bool> checkAction;

	public bool CanEnable()
	{
		if (checkAction != null)
		{
			return checkAction();
		}
		return true;
	}
}
