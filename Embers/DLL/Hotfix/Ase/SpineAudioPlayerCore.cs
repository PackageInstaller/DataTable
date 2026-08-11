using System;
using System.Collections.Generic;
using System.Threading;
using Cysharp.Threading.Tasks;
using FMOD.Studio;
using FMODUnity;

namespace Ase;

public class SpineAudioPlayerCore : ISpineAudioPlayer
{
	private readonly Func<bool> isDevelopMode;

	private readonly List<EventInstance> curAudioInstances = new List<EventInstance>();

	private Action<int, EventInstance> onAudioPlayAction;

	private CancellationTokenSource musicCts;

	public SpineAudioPlayerCore(Func<bool> isDevelopMode)
	{
		this.isDevelopMode = isDevelopMode;
	}

	public void PlayAudio(FusionData fusionData)
	{
		if (fusionData != null && fusionData.audioTracksDatas != null && fusionData.audioTracksDatas.Count > 0)
		{
			PlayAudio(fusionData.audioTracksDatas);
		}
	}

	public void PlayAudio(List<AudioClipData> audios, List<AudioParameterSerializable> audioParameters)
	{
		try
		{
			if (audios != null && audios.Count > 0)
			{
				musicCts?.Cancel();
				musicCts = new CancellationTokenSource();
				foreach (AudioClipData audio in audios)
				{
					PlayAudiosAsync(audio, musicCts.Token);
				}
			}
			if (audioParameters != null && audioParameters.Count > 0)
			{
				Singleton<AudioSystem>.Instance.SetCurBgmParameter(audioParameters);
			}
		}
		catch (Exception)
		{
		}
	}

	public void StopAllAudio()
	{
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		musicCts?.Cancel();
		if (curAudioInstances == null)
		{
			return;
		}
		foreach (EventInstance curAudioInstance in curAudioInstances)
		{
			ReleaseAudioInstance(curAudioInstance, (STOP_MODE)1);
		}
		curAudioInstances.Clear();
	}

	public void AddAudioPlayAction(Action<int, EventInstance> action)
	{
		onAudioPlayAction = (Action<int, EventInstance>)Delegate.Combine(onAudioPlayAction, action);
	}

	private void PlayAudio(List<AudioClipData> clipDatas)
	{
		try
		{
			if (clipDatas == null || clipDatas.Count <= 0)
			{
				return;
			}
			StopAllAudio();
			musicCts?.Cancel();
			musicCts = new CancellationTokenSource();
			foreach (AudioClipData clipData in clipDatas)
			{
				PlayAudiosAsync(clipData, musicCts.Token);
			}
		}
		catch (Exception)
		{
		}
	}

	private async UniTask PlayAudiosAsync(AudioClipData clipData, CancellationToken token)
	{
		EventInstance ins = ((isDevelopMode == null || !isDevelopMode()) ? Singleton<AudioSystem>.Instance.CreateInstance(clipData.audioId) : RuntimeManager.CreateInstance(clipData.audioClip));
		curAudioInstances.Add(ins);
		await UniTask.WaitForSeconds(clipData.startTime);
		((EventInstance)(ref ins)).start();
		onAudioPlayAction?.Invoke(clipData.audioId, ins);
		try
		{
			while (true)
			{
				token.ThrowIfCancellationRequested();
				await UniTask.Yield();
			}
		}
		finally
		{
			ReleaseAudioInstance(ins, (STOP_MODE)1);
		}
	}

	private void ReleaseAudioInstance(EventInstance audioInstance, STOP_MODE stopMode)
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		if (((EventInstance)(ref audioInstance)).isValid())
		{
			((EventInstance)(ref audioInstance)).stop(stopMode);
			((EventInstance)(ref audioInstance)).release();
			((EventInstance)(ref audioInstance)).clearHandle();
		}
	}
}
