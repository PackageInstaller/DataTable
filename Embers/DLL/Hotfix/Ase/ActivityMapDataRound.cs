using System;
using System.Collections.Generic;

namespace Ase;

[Serializable]
public class ActivityMapDataRound
{
	public ActivityMapDataRoundChangeType roundType;

	public float time;

	public int killNum;

	public List<ActivityMapDataObjData> roundObjs;
}
