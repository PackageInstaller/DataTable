using System;

namespace ACT.Config;

[Serializable]
public class RogueArtifactLibrary
{
	public readonly int id;

	public readonly int[] effectLibrary = new int[0];

	public readonly float[][] pressureGroup = new float[0][];

	public readonly float[][] rareGroup = new float[0][];

	public RogueArtifactLibrary(int id, int[] effectLibrary, float[][] pressureGroup, float[][] rareGroup)
	{
		this.id = id;
		this.effectLibrary = effectLibrary;
		this.pressureGroup = pressureGroup;
		this.rareGroup = rareGroup;
	}
}
