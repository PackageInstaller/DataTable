using System.Collections.Generic;

namespace ACT.Event;

public class UnLockTextLibraries : BaseEventContent
{
	public List<int> unlockTextLibraries;

	public bool isFromAVG;

	public bool isFromAVGSkip;

	public override void ReleaseEvt()
	{
		unlockTextLibraries = null;
		isFromAVG = false;
		isFromAVGSkip = false;
	}
}
