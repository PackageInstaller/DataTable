using System;
using TrueSync;

[Serializable]
public class SummonCfg
{
	public SummonType summonType;

	public SummonFollowType summonFollowType;

	public SummonAttrType summonAttrType;

	public SummonRelation summonRelation;

	public int attrPercent;

	public FP leftTime;

	public int maxCount;

	public bool retainWhenCrossLevel;

	public bool useSummonHit;

	public SummonCfg()
	{
		summonType = SummonType.Minion;
		summonFollowType = SummonFollowType.NotFollow;
		summonAttrType = SummonAttrType.Self;
		summonRelation = SummonRelation.Independent;
		attrPercent = 100;
		leftTime = 0;
		maxCount = 0;
		retainWhenCrossLevel = false;
		useSummonHit = false;
	}
}
