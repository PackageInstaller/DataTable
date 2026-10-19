using System;

namespace ACT;

[Serializable]
public struct TimelineBindingChunk
{
	public int chunkId;

	public int chunkState;

	public bool loadNPC;

	public bool loadInteractStateObject;

	public bool loadMonster;
}
