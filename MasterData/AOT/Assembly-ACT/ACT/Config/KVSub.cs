using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class KVSub
{
	public readonly int k;

	public readonly int v;

	public readonly Dictionary<int, int> subs;

	public KVSub(int k, int v, Dictionary<int, int> subs)
	{
		this.k = k;
		this.v = v;
		this.subs = subs;
	}
}
