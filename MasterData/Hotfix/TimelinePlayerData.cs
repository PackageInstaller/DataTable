using System;
using TrueSync;

[Serializable]
public class TimelinePlayerData
{
	public InteractiveManager.typeState strackName;

	public TimelinePlayerClip pbClip;

	public FP bSwichTime;

	public bool checkByType(InteractiveManager.typeState activeSateName)
	{
		return strackName == activeSateName;
	}

	public void saveSwichTime()
	{
		if (bSwichTime < 0)
		{
			bSwichTime = 0;
		}
		if (pbClip != null && pbClip.playableAsset != null)
		{
			FP fP = FP.FromMyriad(pbClip.longDuration);
			bSwichTime = ((bSwichTime > fP) ? fP : bSwichTime);
		}
	}
}
