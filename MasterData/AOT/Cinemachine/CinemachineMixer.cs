using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;

internal sealed class CinemachineMixer : PlayableBehaviour
{
	public delegate PlayableDirector MasterDirectorDelegate();

	public static MasterDirectorDelegate GetMasterPlayableDirector;

	private CinemachineBrain mBrain;

	private int mBrainOverrideId = -1;

	private bool mPreviewPlay;

	public override void OnPlayableDestroy(Playable playable)
	{
		if (mBrain != null)
		{
			mBrain.ReleaseCameraOverride(mBrainOverrideId);
		}
		mBrainOverrideId = -1;
	}

	public override void PrepareFrame(Playable playable, FrameData info)
	{
		mPreviewPlay = false;
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		GameObject gameObject = playerData as GameObject;
		if (gameObject == null)
		{
			mBrain = (CinemachineBrain)playerData;
		}
		else
		{
			mBrain = gameObject.GetComponent<CinemachineBrain>();
		}
		if (mBrain == null)
		{
			return;
		}
		int num = 0;
		int num2 = -1;
		int num3 = -1;
		bool flag = false;
		float num4 = 1f;
		for (int i = 0; i < playable.GetInputCount(); i++)
		{
			float inputWeight = playable.GetInputWeight(i);
			ScriptPlayable<CinemachineShotPlayable> playable2 = (ScriptPlayable<CinemachineShotPlayable>)playable.GetInput(i);
			CinemachineShotPlayable behaviour = playable2.GetBehaviour();
			if (behaviour == null || !behaviour.IsValid || playable.GetPlayState() != PlayState.Playing || !(inputWeight > 0f))
			{
				continue;
			}
			num2 = num3;
			num3 = i;
			num4 = inputWeight;
			if (++num == 2)
			{
				Playable input = playable.GetInput(num2);
				flag = playable2.GetTime() >= input.GetTime();
				if (playable2.GetTime() == input.GetTime())
				{
					flag = playable2.GetDuration() < input.GetDuration();
				}
				break;
			}
		}
		if (num == 1 && num4 < 1f && playable.GetInput(num3).GetTime() > playable.GetInput(num3).GetDuration() / 2.0)
		{
			flag = true;
		}
		if (flag)
		{
			int num5 = num3;
			int num6 = num2;
			num2 = num5;
			num3 = num6;
			num4 = 1f - num4;
		}
		ICinemachineCamera camA = null;
		if (num2 >= 0)
		{
			camA = ((ScriptPlayable<CinemachineShotPlayable>)playable.GetInput(num2)).GetBehaviour().VirtualCamera;
		}
		ICinemachineCamera camB = null;
		if (num3 >= 0)
		{
			camB = ((ScriptPlayable<CinemachineShotPlayable>)playable.GetInput(num3)).GetBehaviour().VirtualCamera;
		}
		mBrainOverrideId = mBrain.SetCameraOverride(mBrainOverrideId, camA, camB, num4, GetDeltaTime(info.deltaTime));
	}

	private float GetDeltaTime(float deltaTime)
	{
		if (mPreviewPlay || Application.isPlaying)
		{
			return deltaTime;
		}
		if (TargetPositionCache.CacheMode == TargetPositionCache.Mode.Playback && TargetPositionCache.HasCurrentTime)
		{
			return 0f;
		}
		return -1f;
	}
}
