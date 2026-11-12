using System;
using System.Collections.Generic;
using TrueSync;

[Serializable]
public class OrbitNodeCfg
{
	public FP radius;

	public FP rotSpeed;

	public int monsterId;

	public SummonCfg summonCfg = new SummonCfg();

	public List<FP> attachOffsetRot = new List<FP>();
}
