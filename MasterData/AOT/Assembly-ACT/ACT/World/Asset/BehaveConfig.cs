using System;

namespace ACT.World.Asset;

[Serializable]
public abstract class BehaveConfig : IDataToBake
{
	public bool useAgent;

	public float stopDistance = 0.2f;

	public float triggerBoxRadius = -1f;
}
