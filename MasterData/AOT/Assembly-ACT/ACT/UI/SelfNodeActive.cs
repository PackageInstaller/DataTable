namespace ACT.UI;

public class SelfNodeActive : RedDotDisplayAction
{
	public SelfNodeActive()
	{
		comment = "自己关联的树中节点是否激活";
	}

	public override bool Do(RedDotTrieNode node)
	{
		return node.isActive;
	}
}
