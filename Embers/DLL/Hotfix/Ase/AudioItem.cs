using System;
using System.Collections.Generic;
using DG.Tweening;
using FMOD;
using FMOD.Studio;
using FMODUnity;
using GameFramework;
using UnityEngine;

namespace Ase;

public class AudioItem : IReference
{
	private AudioInfo audioInfo;

	private EventInstance eventInstance;

	private float volume;

	private int priority;

	private List<AudioParameter> audioParams;

	private Transform followTrans;

	private bool clearStack;

	private STOP_MODE stopMode;

	private bool paused;

	private int stopPos;

	private Dictionary<string, Tweener> tweenerDict = new Dictionary<string, Tweener>();

	private Timer stopTimer;

	public static readonly AudioItem EmptyAudioItem;

	public AudioInfo Info => audioInfo;

	public float Volume => volume;

	public int Priority => priority;

	public List<AudioParameter> AudioParams => audioParams;

	public Transform FollowTrans => followTrans;

	public bool ClearStack => clearStack;

	public STOP_MODE StopMode
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return stopMode;
		}
	}

	public EventInstance EventInstance
	{
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return eventInstance;
		}
	}

	public int InPtrInfo => eventInstance.handle.ToInt32();

	public static AudioItem Create(AudioInfo audioInfo, EventInstance eventInstance, int priority = -1, float volume = 1f, List<AudioParameter> audioParams = null, Transform transform = null, bool clearStack = false, STOP_MODE stopMode = (STOP_MODE)0)
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0043: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		AudioItem audioItem = ReferencePool.Acquire<AudioItem>();
		audioItem.audioInfo = audioInfo;
		audioItem.eventInstance = eventInstance;
		audioItem.volume = volume;
		audioItem.priority = priority;
		audioItem.audioParams = audioParams ?? new List<AudioParameter>();
		audioItem.followTrans = transform;
		audioItem.clearStack = clearStack;
		audioItem.stopMode = stopMode;
		audioItem.paused = false;
		audioItem.stopPos = 0;
		audioItem.tweenerDict = new Dictionary<string, Tweener>();
		return audioItem;
	}

	public AudioItem SetOriParameters()
	{
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		if (audioParams == null || !Valid())
		{
			return this;
		}
		float oriVal = default(float);
		for (int i = 0; i < audioParams.Count; i++)
		{
			AudioParameter value = audioParams[i];
			if ((int)((EventInstance)(ref eventInstance)).getParameterByName(value.key, ref oriVal) == 0)
			{
				value.oriVal = oriVal;
			}
			else
			{
				value.oriVal = 0f;
			}
			audioParams[i] = value;
		}
		return this;
	}

	public AudioItem SetAttributes()
	{
		//IL_0012: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_002c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_0046: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		if (!Valid())
		{
			return this;
		}
		EventDescription val = default(EventDescription);
		((EventInstance)(ref eventInstance)).getDescription(ref val);
		bool flag = default(bool);
		((EventDescription)(ref val)).is3D(ref flag);
		if (!flag)
		{
			return this;
		}
		ATTRIBUTES_3D val2 = RuntimeUtils.To3DAttributes(Vector3.zero);
		if (followTrans != null)
		{
			val2 = RuntimeUtils.To3DAttributes(followTrans);
		}
		((EventInstance)(ref eventInstance)).set3DAttributes(val2);
		return this;
	}

	public AudioItem SetParameters(List<AudioParameter> audioParams = null, bool replace = false, bool temporary = false)
	{
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		if (!Valid())
		{
			return this;
		}
		if (audioParams == null)
		{
			return this;
		}
		float startValue = default(float);
		for (int i = 0; i < audioParams.Count; i++)
		{
			if (!temporary)
			{
				CheckParameters(audioParams[i].key, audioParams[i].targetVal, audioParams[i].duration);
			}
			if ((int)((EventInstance)(ref eventInstance)).getParameterByName(audioParams[i].key, ref startValue) == 0)
			{
				DynamicSetParameters(audioParams[i].key, startValue, audioParams[i].targetVal, audioParams[i].duration);
			}
		}
		if (replace)
		{
			this.audioParams = new List<AudioParameter>(audioParams);
		}
		return this;
	}

	public AudioItem SetParametersIfDiff(List<AudioParameter> audioParams = null)
	{
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		if (!Valid())
		{
			return this;
		}
		if (audioParams == null)
		{
			return this;
		}
		float startValue = default(float);
		for (int i = 0; i < audioParams.Count; i++)
		{
			if ((int)((EventInstance)(ref eventInstance)).getParameterByName(audioParams[i].key, ref startValue) == 0)
			{
				CheckParameters(audioParams[i].key, audioParams[i].targetVal, audioParams[i].duration);
				DynamicSetParameters(audioParams[i].key, startValue, audioParams[i].targetVal, audioParams[i].duration);
			}
		}
		return this;
	}

	public AudioItem ReSetParameters()
	{
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		if (!Valid())
		{
			return this;
		}
		if (audioParams == null)
		{
			return this;
		}
		float startValue = default(float);
		for (int i = 0; i < audioParams.Count; i++)
		{
			if ((int)((EventInstance)(ref eventInstance)).getParameterByName(audioParams[i].key, ref startValue) == 0)
			{
				DynamicSetParameters(audioParams[i].key, startValue, audioParams[i].oriVal, audioParams[i].duration);
			}
		}
		return this;
	}

	private void CheckParameters(string key, float targetVal, float duration)
	{
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_0049: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		if (!Valid() || audioParams == null)
		{
			return;
		}
		int num = audioParams.FindIndex((AudioParameter x) => x.key == key);
		float oriVal = default(float);
		RESULT parameterByName = ((EventInstance)(ref eventInstance)).getParameterByName(key, ref oriVal);
		if (num == -1)
		{
			if ((int)parameterByName != 0)
			{
				oriVal = 0f;
			}
			audioParams.Add(new AudioParameter
			{
				key = key,
				oriVal = oriVal,
				targetVal = targetVal,
				duration = duration
			});
		}
	}

	private void DynamicSetParameters(string key, float startValue, float endValue, float duration, Action completeAction = null, Ease ease = Ease.Linear)
	{
		//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
		if (!((EventInstance)(ref eventInstance)).isValid())
		{
			return;
		}
		int num = audioParams.FindIndex((AudioParameter x) => x.key == key);
		if (num != -1)
		{
			AudioParameter value = audioParams[num];
			value.targetVal = endValue;
			audioParams[num] = value;
		}
		Tweener tweener = (tweenerDict.TryGetValue(key, out tweener) ? tweener : null);
		if (duration <= 0f || startValue == endValue)
		{
			if (tweener.IsActive())
			{
				tweener.Kill();
			}
			((EventInstance)(ref eventInstance)).setParameterByName(key, endValue, false);
			return;
		}
		float value2 = startValue;
		if (!tweener.IsActive())
		{
			tweener = DOTween.To(() => value2, delegate(float x)
			{
				value2 = x;
			}, endValue, duration).OnStart(delegate
			{
				//IL_0018: Unknown result type (might be due to invalid IL or missing references)
				((EventInstance)(ref eventInstance)).setParameterByName(key, value2, false);
			}).OnUpdate(delegate
			{
				//IL_0018: Unknown result type (might be due to invalid IL or missing references)
				((EventInstance)(ref eventInstance)).setParameterByName(key, value2, false);
			})
				.OnComplete(delegate
				{
					completeAction?.Invoke();
				})
				.SetUpdate(isIndependentUpdate: true)
				.SetEase(ease)
				.SetAutoKill();
			tweenerDict[key] = tweener;
		}
		else
		{
			tweener.ChangeValues(value2, endValue, duration);
		}
	}

	public AudioItem SetVolume(float volume)
	{
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		this.volume = volume;
		if (Valid() && volume >= 0f)
		{
			((EventInstance)(ref eventInstance)).setVolume(volume);
		}
		return this;
	}

	public AudioItem SetPriority(int priority)
	{
		this.priority = priority;
		return this;
	}

	public AudioItem SetTransform(Transform transform)
	{
		followTrans = transform;
		return this;
	}

	public AudioItem SetClearStack(bool clearStack)
	{
		this.clearStack = clearStack;
		return this;
	}

	public AudioItem SetStopMode(STOP_MODE stopMode)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		this.stopMode = stopMode;
		return this;
	}

	public void GetPaused(out bool isPaused)
	{
		isPaused = paused;
	}

	public void GetPlaying(out bool isPlaying)
	{
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Invalid comparison between Unknown and I4
		GetPlaybackState(out var state);
		isPlaying = false;
		if (!paused)
		{
			isPlaying = (int)state == 0 || (int)state == 3;
		}
	}

	public void Start(bool forcePlay = true, bool needAwait = true)
	{
		if (Valid())
		{
			SetVolume(volume);
			if (forcePlay)
			{
				paused = false;
			}
			if (paused)
			{
				SetPaused(pause: false);
				return;
			}
			stopPos = 0;
			InternalStart();
		}
	}

	public void SetPaused(bool pause, bool fading = false)
	{
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		if (!Valid())
		{
			return;
		}
		if (pause)
		{
			((EventInstance)(ref eventInstance)).getTimelinePosition(ref stopPos);
			if (!fading)
			{
				Stop((STOP_MODE)0);
			}
			paused = pause;
		}
		else if (paused || pause)
		{
			InternalStart();
			((EventInstance)(ref eventInstance)).setTimelinePosition(stopPos);
			stopPos = 0;
			paused = pause;
		}
	}

	public void Stop(STOP_MODE stopMode = (STOP_MODE)0)
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		if (Valid())
		{
			((EventInstance)(ref eventInstance)).stop(stopMode);
			paused = false;
		}
	}

	public void OriClear(STOP_MODE stopMode = (STOP_MODE)0)
	{
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		if (Valid())
		{
			Stop(stopMode);
			((EventInstance)(ref eventInstance)).clearHandle();
			((EventInstance)(ref eventInstance)).release();
		}
	}

	private void InternalStart()
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		CancelStopTimer();
		((EventInstance)(ref eventInstance)).start();
	}

	private void CancelStopTimer()
	{
		stopTimer?.Cancel();
	}

	public void SetStopTimer(float duration)
	{
		if (stopTimer == null)
		{
			stopTimer = Timer.Register(duration, delegate
			{
				SetPaused(pause: true);
			}, null, isLooped: false, useRealTime: true);
		}
	}

	public bool Valid()
	{
		return ((EventInstance)(ref eventInstance)).isValid();
	}

	public void GetPlaybackState(out PLAYBACK_STATE state)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		((EventInstance)(ref eventInstance)).getPlaybackState(ref state);
	}

	public void Dispose()
	{
		ReferencePool.Release(this);
	}

	public void Clear()
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		audioInfo = AudioInfo.EmptyInfo;
		eventInstance = new EventInstance(IntPtr.Zero);
		volume = 1f;
		priority = -1;
		audioParams.Clear();
		followTrans = null;
		clearStack = false;
		stopPos = 0;
		tweenerDict.Clear();
		stopTimer = null;
	}

	public AudioItem Clone()
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_0060: Unknown result type (might be due to invalid IL or missing references)
		//IL_0065: Unknown result type (might be due to invalid IL or missing references)
		AudioItem audioItem = ReferencePool.Acquire<AudioItem>();
		audioItem.audioInfo = audioInfo;
		audioItem.eventInstance = eventInstance;
		audioItem.volume = volume;
		audioItem.priority = priority;
		audioItem.audioParams = new List<AudioParameter>(audioParams);
		audioItem.followTrans = followTrans;
		audioItem.clearStack = clearStack;
		audioItem.stopMode = stopMode;
		audioItem.paused = paused;
		audioItem.stopPos = stopPos;
		audioItem.tweenerDict = new Dictionary<string, Tweener>();
		audioItem.stopTimer = null;
		return audioItem;
	}

	static AudioItem()
	{
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		EmptyAudioItem = new AudioItem
		{
			audioInfo = AudioInfo.EmptyInfo,
			eventInstance = new EventInstance(IntPtr.Zero),
			volume = 1f,
			priority = -1,
			audioParams = new List<AudioParameter>(),
			followTrans = null,
			clearStack = false,
			stopMode = (STOP_MODE)0,
			stopPos = 0,
			paused = false,
			tweenerDict = new Dictionary<string, Tweener>()
		};
	}
}
