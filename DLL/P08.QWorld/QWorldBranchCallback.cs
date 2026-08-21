using System;

public class QWorldBranchCallback
{
	public string id;

	public string nextId;

	public Action<string> clickAction;

	public void Invoke()
	{
		clickAction?.Invoke(nextId);
	}
}
