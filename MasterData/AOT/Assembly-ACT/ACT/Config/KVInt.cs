using System;

namespace ACT.Config;

[Serializable]
public class KVInt
{
	public readonly int k;

	public readonly int v;

	public KVInt(int k, int v)
	{
		this.k = k;
		this.v = v;
	}
}
