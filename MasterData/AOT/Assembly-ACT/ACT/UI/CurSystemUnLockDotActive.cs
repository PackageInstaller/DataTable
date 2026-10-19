namespace ACT.UI;

public class CurSystemUnLockDotActive : RedDotDisplayAction
{
	public bool isActive;

	public override bool Do(RedDotTrieNode node)
	{
		return isActive;
	}
}
