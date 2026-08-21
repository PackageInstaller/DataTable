namespace YS.CustomTimelineTrack;

public struct CriAtomClipPlayConfig(string cueSheetName, string cueName, long startTimeMs, double speedRate, bool loop)
{
	public readonly string cueSheetName = cueSheetName;

	public readonly string cueName = cueName;

	public readonly long startTimeMs = startTimeMs;

	public readonly double speedRate = speedRate;

	public readonly bool loop = loop;
}
