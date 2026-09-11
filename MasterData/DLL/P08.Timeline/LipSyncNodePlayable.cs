using System;
using RogoDigital.Lipsync;
using UnityEngine;
using UnityEngine.Playables;

public class LipSyncNodePlayable : PlayableBehaviour
{
	public LipSync lipSync;

	public LipSyncData lipSyncData;

	[NonSerialized]
	private bool previewOutOfDate = true;

	public bool IsValid => lipSyncData != null;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		lipSync = (LipSync)playerData;
		if (lipSync == null)
		{
			return;
		}
		lipSync.loop = false;
		lipSync.keepEmotionWhenFinished = true;
		if (!Application.isPlaying || !previewOutOfDate)
		{
			return;
		}
		lipSync.Stop(stopAudio: true);
		lipSync.SetEmotion(lipSync.lastEmotion, 0.05f);
		lipSync.keepEmotionWhenFinished = true;
		if (playable.GetTime() > 0.05999999865889549)
		{
			previewOutOfDate = false;
			lipSync.PlayFromTime(lipSyncData, (float)(playable.GetTime() / playable.GetDuration()));
			if (lipSyncData.emotionData != null && lipSyncData.emotionData.Length != 0)
			{
				lipSync.lastEmotion = lipSyncData.emotionData[lipSyncData.emotionData.Length - 1].emotion;
			}
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		previewOutOfDate = true;
	}

	public override void OnGraphStop(Playable playable)
	{
		previewOutOfDate = true;
	}

	public override void OnGraphStart(Playable playable)
	{
		previewOutOfDate = true;
	}
}
