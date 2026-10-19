using System;

namespace ACT.Config;

[Serializable]
public class BubbleSystem
{
	public readonly int id;

	public readonly int icon;

	public readonly int targetId;

	public readonly int bubblename;

	public readonly int priority;

	public readonly int[] jumpParam = new int[0];

	public readonly bool canBeSee;

	public BubbleSystem(int id, int icon, int targetId, int bubblename, int priority, int[] jumpParam, bool canBeSee)
	{
		this.id = id;
		this.icon = icon;
		this.targetId = targetId;
		this.bubblename = bubblename;
		this.priority = priority;
		this.jumpParam = jumpParam;
		this.canBeSee = canBeSee;
	}
}
