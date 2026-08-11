using System;
using System.Collections.Generic;

namespace Ase;

[Serializable]
public class PlatformTriggerData
{
	public List<int> TargetMovingPlatIds;

	public List<int> MovingPlatIds;

	public int Index;

	public bool CanHit;
}
