using System;

namespace ACT.Config;

[Serializable]
public class ItemNavigation
{
	public readonly int id;

	public readonly int jumpId;

	public readonly int jumpText;

	public ItemNavigation(int id, int jumpId, int jumpText)
	{
		this.id = id;
		this.jumpId = jumpId;
		this.jumpText = jumpText;
	}
}
