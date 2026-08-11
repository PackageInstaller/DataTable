using System;
using System.Collections.Generic;

namespace Ase;

[Serializable]
public class ActivityMapDataGroup
{
	public int groupID;

	public List<ActivityMapDataRound> rounds;
}
