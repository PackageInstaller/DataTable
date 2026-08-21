using System.Collections.Generic;
using System.Linq;
using System.Text;
using FMOD.Studio;
using UnityEngine;

namespace Ase;

public class AudioGroup
{
	private const int historyCount = 10;

	private LinkedList<AudioItem> audioItems = new LinkedList<AudioItem>();

	private bool peekIsFadingOut;

	public void Play(AudioInfo audioInfo, EventInstance eventInstance, int priority, float volume, List<AudioParameter> audioParams, Transform transform, bool canReturn, STOP_MODE stopMode, List<AudioParameter> fadeInParams, List<AudioParameter> fadeOutParams)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		Play(audioInfo, eventInstance, priority, volume, audioParams, transform, canReturn, priorityCheck: false, stopMode, resetParamsIfSameAudio: false, forcePlay: true, fadeInParams, fadeOutParams);
	}

	public void PlayHighPriorityAndStopCurrent(AudioInfo audioInfo, EventInstance eventInstance, int priority, float volume, List<AudioParameter> audioParams, Transform transform, bool canReturn, STOP_MODE stopMode, List<AudioParameter> fadeInParams, List<AudioParameter> fadeOutParams)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		Play(audioInfo, eventInstance, priority, volume, audioParams, transform, canReturn, priorityCheck: true, stopMode, resetParamsIfSameAudio: false, forcePlay: true, fadeInParams, fadeOutParams);
	}

	public void PlayAndStopCurrent(AudioInfo audioInfo, EventInstance eventInstance, float volume, List<AudioParameter> audioParams, Transform transform, bool canReturn, STOP_MODE stopMode, List<AudioParameter> fadeInParams, List<AudioParameter> fadeOutParams)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		Play(audioInfo, eventInstance, int.MaxValue, volume, audioParams, transform, canReturn, priorityCheck: true, stopMode, resetParamsIfSameAudio: false, forcePlay: true, fadeInParams, fadeOutParams);
	}

	public void PlayAndReplaceIfSame(AudioInfo audioInfo, EventInstance eventInstance, float volume, List<AudioParameter> audioParams, Transform transform, bool canReturn, STOP_MODE stopMode, List<AudioParameter> fadeInParams, List<AudioParameter> fadeOutParams)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		Play(audioInfo, eventInstance, int.MaxValue, volume, audioParams, transform, canReturn, priorityCheck: true, stopMode, resetParamsIfSameAudio: true, forcePlay: true, fadeInParams, fadeOutParams);
	}

	private void Play(AudioInfo audioInfo, EventInstance eventInstance, int priority = -1, float volume = 1f, List<AudioParameter> audioParams = null, Transform transform = null, bool canReturn = false, bool priorityCheck = false, STOP_MODE stopMode = (STOP_MODE)0, bool resetParamsIfSameAudio = false, bool forcePlay = true, List<AudioParameter> fadeInParams = null, List<AudioParameter> fadeOutParams = null)
	{
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_003e: Unknown result type (might be due to invalid IL or missing references)
		AudioItem peek = GetPeek();
		bool flag = true;
		if (!peek.SameAudio(audioInfo) || !resetParamsIfSameAudio)
		{
			flag = PriorityCheck(peek, priority, priorityCheck, !peek.ClearStack, fadeOutParams);
		}
		if (flag)
		{
			AudioItem audioItem = AudioItem.Create(audioInfo, eventInstance, priority, volume, audioParams, transform, !canReturn, stopMode);
			PlayCheck(audioItem, resetParamsIfSameAudio, forcePlay, fadeInParams);
		}
	}

	private bool PriorityCheck(AudioItem current, int priority, bool priorityCheck = false, bool pauseInstead = false, List<AudioParameter> fadeOutParams = null)
	{
		//IL_0097: Unknown result type (might be due to invalid IL or missing references)
		current.GetPaused(out var isPaused);
		if ((!priorityCheck | isPaused) || current == AudioItem.EmptyAudioItem || !current.Valid())
		{
			return true;
		}
		current.GetPlaying(out var isPlaying);
		if (isPlaying && current.Priority > priority)
		{
			return false;
		}
		peekIsFadingOut = fadeOutParams != null && fadeOutParams.Count > 0;
		current.SetParameters(fadeOutParams, replace: false, peekIsFadingOut);
		if (peekIsFadingOut)
		{
			current.SetStopTimer(fadeOutParams[0].duration);
		}
		if (pauseInstead)
		{
			current.SetPaused(pause: true, peekIsFadingOut);
			return true;
		}
		if (!peekIsFadingOut)
		{
			current.Stop(current.StopMode);
		}
		return true;
	}

	private void PlayCheck(AudioItem audioItem, bool resetParamsIfSameAudio, bool forcePlay = true, List<AudioParameter> fadeInParams = null)
	{
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		AudioItem peek = GetPeek();
		peek.GetPlaybackState(out var _);
		if (audioItem.SameAudio(AudioInfo.EmptyInfo))
		{
			peekIsFadingOut = false;
			return;
		}
		if (resetParamsIfSameAudio && peek.SameAudio(audioItem))
		{
			peek.SetVolume(audioItem.Volume).SetPriority(audioItem.Priority).SetTransform(audioItem.FollowTrans)
				.SetStopMode(audioItem.StopMode)
				.SetClearStack(audioItem.ClearStack)
				.SetParametersIfDiff(audioItem.AudioParams)
				.SetPaused(pause: false);
			peekIsFadingOut = false;
			return;
		}
		Push(audioItem);
		audioItem.SetParameters(fadeInParams, replace: false, temporary: true);
		audioItem.PlayItem(forcePlay, peekIsFadingOut);
		peekIsFadingOut = false;
	}

	public void Stop(AudioInfo audioInfo, STOP_MODE stopMode, bool clearStack)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		Stop(audioInfo, stopMode, clearStack, null, null, true, false);
	}

	public void Stop(AudioInfo audioInfo, STOP_MODE stopMode, List<AudioParameter> fadeInParams, List<AudioParameter> fadeOutParams, bool clearStack, bool forcePlay)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		Stop(audioInfo, stopMode, clearStack, fadeInParams, fadeOutParams, forcePlay, playback: true);
	}

	public bool Stop(STOP_MODE stopMode, List<AudioParameter> fadeInParams, List<AudioParameter> fadeOutParams, bool clearStack, bool forcePlay, bool playback)
	{
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		AudioItem peek = GetPeek();
		return Stop(peek.Info, stopMode, clearStack, fadeInParams, fadeOutParams, forcePlay, playback);
	}

	public bool Stop(AudioInfo audioInfo, STOP_MODE stopMode = (STOP_MODE)0, bool clearStack = false, List<AudioParameter> fadeInParams = null, List<AudioParameter> fadeOutParams = null, bool forcePlay = true, bool playback = false)
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		if (audioItems.Count <= 0)
		{
			return false;
		}
		if (GetPeek().SameAudio(audioInfo))
		{
			return Stop(clearStack, stopMode, fadeInParams, fadeOutParams, forcePlay, playback);
		}
		return false;
	}

	private bool Stop(bool clearStack = false, STOP_MODE stopMode = (STOP_MODE)0, List<AudioParameter> fadeInParams = null, List<AudioParameter> fadeOutParams = null, bool forcePlay = true, bool playback = false)
	{
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		if (audioItems.Count <= 0)
		{
			return false;
		}
		AudioItem audioItem = Pop();
		peekIsFadingOut = fadeOutParams != null && fadeOutParams.Count > 0;
		if (peekIsFadingOut)
		{
			FadeOutItem(audioItem, fadeOutParams);
		}
		else
		{
			audioItem.Stop(stopMode);
		}
		if (clearStack)
		{
			audioItems.Clear();
		}
		if ((audioItems.Count > 0) & playback)
		{
			Playback(fadeInParams, forcePlay);
		}
		return true;
	}

	private void FadeOutItem(AudioItem item, List<AudioParameter> fadeOutParams)
	{
		item.SetParameters(fadeOutParams, replace: false, temporary: true);
		item.SetStopTimer(fadeOutParams[0].duration);
	}

	public void SetPause(bool pause)
	{
		AudioItem peek = GetPeek();
		if (peek != AudioItem.EmptyAudioItem && peek.Valid())
		{
			peek.SetPaused(pause);
		}
	}

	public void Playback(List<AudioParameter> fadeParams = null, bool forcePlay = true)
	{
		if (audioItems.Count > 0)
		{
			AudioItem peek = GetPeek();
			peek.SetParameters(fadeParams, replace: false, temporary: true);
			peek.PlayItem(forcePlay, peekIsFadingOut);
			peekIsFadingOut = false;
		}
	}

	public void DebugInfo()
	{
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		AudioItem[] array = audioItems.ToArray();
		foreach (AudioItem audioItem in array)
		{
			audioItem.GetPlaybackState(out var state);
			Debug.Log($"栈中信息  {audioItem.InPtrInfo},{state}");
		}
	}

	public void DebugBgmStacks(ref StringBuilder sb)
	{
		foreach (AudioItem audioItem in audioItems)
		{
			audioItem.Debug(sb);
		}
	}

	public void Push(AudioItem audioItem)
	{
		if (audioItems.Count >= 10)
		{
			audioItems.First.Value.Stop((STOP_MODE)0);
			audioItems.First.Value.Dispose();
			audioItems.RemoveFirst();
		}
		audioItems.AddLast(audioItem);
	}

	public AudioItem Pop()
	{
		if (audioItems.Count <= 0)
		{
			return AudioItem.EmptyAudioItem;
		}
		AudioItem value = audioItems.Last.Value;
		audioItems.RemoveLast();
		return value;
	}

	public AudioItem GetFirst()
	{
		AudioItem result = AudioItem.EmptyAudioItem;
		if (audioItems.Count > 0)
		{
			result = audioItems.First.Value;
		}
		return result;
	}

	public AudioItem PopFirst()
	{
		AudioItem result = AudioItem.EmptyAudioItem;
		if (audioItems.Count > 0)
		{
			result = audioItems.First.Value;
			audioItems.RemoveFirst();
		}
		return result;
	}

	public AudioItem GetPeek()
	{
		AudioItem result = AudioItem.EmptyAudioItem;
		if (audioItems.Count > 0)
		{
			result = audioItems.Last.Value;
		}
		return result;
	}

	public int Count()
	{
		return audioItems.Count;
	}

	public void Dispose(List<AudioParameter> fadeOutParams = null)
	{
		//IL_0048: Unknown result type (might be due to invalid IL or missing references)
		while (audioItems.Count > 0)
		{
			AudioItem audioItem = Pop();
			audioItem.GetPaused(out var isPaused);
			if (audioItem.Valid() && !isPaused)
			{
				audioItem.SetParameters(fadeOutParams, replace: false, temporary: true);
				if (fadeOutParams != null && fadeOutParams.Count > 0)
				{
					audioItem.SetStopTimer(fadeOutParams[0].duration);
				}
				else
				{
					audioItem.Stop(audioItem.StopMode);
				}
			}
		}
		audioItems.Clear();
		peekIsFadingOut = false;
	}
}
