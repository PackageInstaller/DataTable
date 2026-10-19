namespace ACT.UI;

public abstract class RedDotDisplayAction
{
	public string comment;

	public abstract bool Do(RedDotTrieNode node);
}
