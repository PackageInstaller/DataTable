using System.Collections.Generic;

namespace Ase;

public static class FusionExtension
{
	public static FusionTrackEntryData CopyFusionTrackEntryData(FusionTrackEntryData raw)
	{
		return new FusionTrackEntryData
		{
			aniName = raw.aniName,
			startFrame = raw.startFrame,
			frameRate = raw.frameRate,
			transitionDuration = raw.transitionDuration,
			timeScale = raw.timeScale,
			startTime = raw.startTime,
			isLoop = raw.isLoop,
			endTime = raw.endTime
		};
	}

	public static FusionData CopyFusionData(FusionData raw)
	{
		FusionData fusionData = new FusionData();
		fusionData.name = raw.name;
		fusionData.length = raw.length;
		fusionData.mainTrack = CopyTrackData(raw.mainTrack);
		fusionData.faceTrack = CopyTrackData(raw.faceTrack);
		fusionData.talkTrack = CopyTrackData(raw.talkTrack);
		fusionData.bubbleData = raw.bubbleData;
		fusionData.extraTracks = new List<TrackData>();
		foreach (TrackData extraTrack in raw.extraTracks)
		{
			fusionData.extraTracks.Add(CopyTrackData(extraTrack));
		}
		fusionData.audioTracksDatas = new List<AudioClipData>(raw.audioTracksDatas);
		return fusionData;
	}

	public static TrackData CopyTrackData(TrackData raw)
	{
		TrackData result = new TrackData
		{
			trackIndex = raw.trackIndex,
			tracks = new List<FusionTrackEntryData>()
		};
		if (raw.tracks == null)
		{
			return result;
		}
		foreach (FusionTrackEntryData track in raw.tracks)
		{
			result.tracks.Add(CopyFusionTrackEntryData(track));
		}
		return result;
	}
}
