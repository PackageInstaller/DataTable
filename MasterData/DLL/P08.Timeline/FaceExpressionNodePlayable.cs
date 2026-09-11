using System;
using RogoDigital.Lipsync;
using UnityEngine;
using UnityEngine.Playables;

public class FaceExpressionNodePlayable : PlayableBehaviour
{
	public LipSync lipSync;

	public string emotion;

	public float blendTime;

	[NonSerialized]
	private bool previewOutOfDate = true;

	private float lastTime;

	public bool IsValid => lipSync != null;

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		lipSync = (LipSync)playerData;
		if (!(lipSync == null) && Application.isPlaying && previewOutOfDate)
		{
			previewOutOfDate = false;
			lipSync.SetEmotion(emotion, blendTime);
		}
	}

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		previewOutOfDate = true;
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
