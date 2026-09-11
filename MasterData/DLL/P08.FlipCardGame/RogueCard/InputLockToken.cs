namespace RogueCard;

public class InputLockToken
{
	public string lockName;

	public bool isReleased;

	public bool ignoreError;

	public InputLockToken(string name, bool ignoreError = false)
	{
		lockName = name;
		isReleased = false;
		this.ignoreError = ignoreError;
	}

	public void Release()
	{
		if (!isReleased)
		{
			isReleased = true;
			if (RogueCardGameMain.Instance != null)
			{
				RogueCardGameMain.Instance.ReleaseInputLock(this);
			}
		}
	}
}
