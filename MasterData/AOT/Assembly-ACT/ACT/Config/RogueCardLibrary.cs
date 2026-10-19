using System;

namespace ACT.Config;

[Serializable]
public class RogueCardLibrary
{
	public readonly int id;

	public readonly int[] effectLibrary = new int[0];

	public readonly int[] triggerLibrary = new int[0];

	public readonly float[][] pressureGroup = new float[0][];

	public readonly int[][] rareGroup = new int[0][];

	public readonly int[][] effectAddGroup = new int[0][];

	public RogueCardLibrary(int id, int[] effectLibrary, int[] triggerLibrary, float[][] pressureGroup, int[][] rareGroup, int[][] effectAddGroup)
	{
		this.id = id;
		this.effectLibrary = effectLibrary;
		this.triggerLibrary = triggerLibrary;
		this.pressureGroup = pressureGroup;
		this.rareGroup = rareGroup;
		this.effectAddGroup = effectAddGroup;
	}
}
