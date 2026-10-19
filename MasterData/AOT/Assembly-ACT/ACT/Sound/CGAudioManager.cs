using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using ACT.Core;
using ACT.Model;
using ACT.Sound.Core;
using ACT.Sound.Management;
using FMOD.Studio;
using Fundamental;

namespace ACT.Sound;

public class CGAudioManager : Singleton<CGAudioManager>
{
	private readonly Dictionary<uint, CGAudioInstance> _instances = new Dictionary<uint, CGAudioInstance>();

	private readonly HashSet<int> _showingIds = new HashSet<int>();

	private readonly object _lock = new object();

	public override ContextType ContextType => ContextType.GAME;

	public event Action<CGAudioInstance, CGTimelineMarker> OnTimelineMarker;

	public event Action<CGAudioInstance> OnStopped;

	public override void Init()
	{
		AOTScripts.CGAudioCallback = (Action<EVENT_CALLBACK_TYPE, IntPtr, IntPtr>)Delegate.Combine(AOTScripts.CGAudioCallback, new Action<EVENT_CALLBACK_TYPE, IntPtr, IntPtr>(OnFmodCallback));
	}

	public override void UnInit()
	{
		AOTScripts.CGAudioCallback = (Action<EVENT_CALLBACK_TYPE, IntPtr, IntPtr>)Delegate.Remove(AOTScripts.CGAudioCallback, new Action<EVENT_CALLBACK_TYPE, IntPtr, IntPtr>(OnFmodCallback));
		StopAll();
		lock (_lock)
		{
			_instances.Clear();
		}
		OnTimelineMarker = null;
		OnStopped = null;
	}

	public uint Play(string eventPath, AudioPlayOptions options = default(AudioPlayOptions))
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			return 0u;
		}
		uint num = Singleton<GameManager>.instance.audioManager.PlaySound(eventPath, options);
		if (num == 0)
		{
			return 0u;
		}
		return SetupCGInstance(num, eventPath);
	}

	public uint Play(IAudioEventReference eventRef, AudioPlayOptions options = default(AudioPlayOptions))
	{
		if (eventRef == null || eventRef.IsNull())
		{
			return 0u;
		}
		uint num = Singleton<GameManager>.instance.audioManager.PlaySound(eventRef, options);
		if (num == 0)
		{
			return 0u;
		}
		return SetupCGInstance(num, eventRef.GetEventPath());
	}

	private uint SetupCGInstance(uint audioId, string eventPath)
	{
		PooledAudioInstance instanceById = Singleton<GameManager>.instance.audioManager.GetInstanceById(audioId);
		if (instanceById?.Instance == null)
		{
			return 0u;
		}
		CGAudioInstance value = new CGAudioInstance
		{
			AudioId = audioId,
			EventPath = eventPath,
			Handle = instanceById.Instance.GetHandle()
		};
		instanceById.Instance.SetCallback(AudioCallbackType.TimelineMarker);
		_instances[audioId] = value;
		return audioId;
	}

	public void Pause(uint id, bool paused)
	{
		if (_instances.ContainsKey(id))
		{
			Singleton<GameManager>.instance.audioManager.SetPause(id, paused);
		}
	}

	public void PauseAll(bool paused)
	{
		foreach (KeyValuePair<uint, CGAudioInstance> instance in _instances)
		{
			Singleton<GameManager>.instance.audioManager.SetPause(instance.Key, paused);
		}
	}

	public void Stop(uint id, bool fadeOut = true)
	{
		if (_instances.TryGetValue(id, out var value))
		{
			Singleton<GameManager>.instance.audioManager.Stop(id, fadeOut);
			OnStopped?.Invoke(value);
			_instances.Remove(id);
		}
	}

	public void StopAll(bool fadeOut = true)
	{
		foreach (KeyValuePair<uint, CGAudioInstance> instance in _instances)
		{
			Singleton<GameManager>.instance.audioManager.Stop(instance.Key, fadeOut);
			OnStopped?.Invoke(instance.Value);
		}
		lock (_lock)
		{
			_instances.Clear();
		}
		ClearTexts();
	}

	public void ClearTexts()
	{
		lock (_lock)
		{
			_showingIds.Clear();
		}
		Model<CGModule>.Interface?.Clear();
	}

	public void SetParameter(uint id, string parameterName, float value)
	{
		if (_instances.ContainsKey(id))
		{
			Singleton<GameManager>.instance.audioManager.SetParameter(id, parameterName, value);
		}
	}

	public void SetParameter(uint id, string parameterName, int value)
	{
		if (_instances.ContainsKey(id))
		{
			Singleton<GameManager>.instance.audioManager.SetParameter(id, parameterName, value);
		}
	}

	public CGAudioInstance GetInstance(uint id)
	{
		_instances.TryGetValue(id, out var value);
		return value;
	}

	public List<CGTimelineMarker> GetMarkers(uint id)
	{
		if (_instances.TryGetValue(id, out var value))
		{
			return value.Markers;
		}
		return null;
	}

	public CGTimelineMarker GetLastMarker(uint id)
	{
		if (_instances.TryGetValue(id, out var value) && value.Markers.Count > 0)
		{
			return value.Markers[value.Markers.Count - 1];
		}
		return null;
	}

	public void ClearMarkers(uint id)
	{
		if (_instances.TryGetValue(id, out var value))
		{
			value.Markers.Clear();
		}
	}

	public bool IsPlaying(uint id)
	{
		if (!_instances.ContainsKey(id))
		{
			return false;
		}
		return Singleton<GameManager>.instance.audioManager.IsPlaying(id);
	}

	private void OnFmodCallback(EVENT_CALLBACK_TYPE type, IntPtr instancePtr, IntPtr parameterPtr)
	{
		if (type != EVENT_CALLBACK_TYPE.TIMELINE_MARKER)
		{
			return;
		}
		TIMELINE_MARKER_PROPERTIES tIMELINE_MARKER_PROPERTIES = Marshal.PtrToStructure<TIMELINE_MARKER_PROPERTIES>(parameterPtr);
		string text = tIMELINE_MARKER_PROPERTIES.name;
		int position = tIMELINE_MARKER_PROPERTIES.position;
		lock (_lock)
		{
			foreach (KeyValuePair<uint, CGAudioInstance> instance in _instances)
			{
				CGAudioInstance value = instance.Value;
				if (value.Handle != instancePtr)
				{
					continue;
				}
				CGTimelineMarker cGTimelineMarker = new CGTimelineMarker
				{
					Name = text,
					Position = position
				};
				value.Markers.Add(cGTimelineMarker);
				OnTimelineMarker?.Invoke(value, cGTimelineMarker);
				if (!int.TryParse(text, out var result))
				{
					break;
				}
				if (_showingIds.Contains(result))
				{
					_showingIds.Remove(result);
					Model<CGModule>.Interface?.Remove(result);
				}
				else
				{
					if (!RuntimeConfigs.data.dialogueCGs.TryGetValue(result, out var value2))
					{
						break;
					}
					_showingIds.Add(result);
					List<int> list = Model<CGModule>.Interface?.Set(result, value2);
					if (list != null)
					{
						for (int i = 0; i < list.Count; i++)
						{
							_showingIds.Remove(list[i]);
						}
					}
				}
				break;
			}
		}
	}
}
