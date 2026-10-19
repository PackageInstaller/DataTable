using System;

namespace ACT.World.Asset;

[Serializable]
public class RecallPoint : IDataToBake
{
	public Pos pos;

	public void Bake(object baker)
	{
	}
}
