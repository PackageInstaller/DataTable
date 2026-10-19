using Fundamental;

namespace ACT.UI;

public static class RedDotTrieNodePool
{
	private static ObjectPool<RedDotTrieNode> redDotTrieNodePool = new ObjectPool<RedDotTrieNode>(OnGet, OnRelease);

	private static void OnGet(RedDotTrieNode node)
	{
		node.OnGetFromPool();
	}

	private static void OnRelease(RedDotTrieNode node)
	{
		node.OnReleaseToPool();
	}

	public static RedDotTrieNode Get()
	{
		return redDotTrieNodePool.Get();
	}

	public static void Release(RedDotTrieNode node)
	{
		redDotTrieNodePool.Release(node);
	}
}
