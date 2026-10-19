using System.Collections.Generic;
using ACT.Sound.Language;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Sound;

public class AudioVoiceManager : Singleton<AudioVoiceManager>
{
	private readonly List<uint> _voiceInstanceIds = new List<uint>();

	private readonly Dictionary<uint, PlotVoiceInstance> _plotVoiceInstances = new Dictionary<uint, PlotVoiceInstance>();

	public override void Init()
	{
	}

	public override void UnInit()
	{
		StopAll();
		_voiceInstanceIds.Clear();
		StopAllPlot();
		_plotVoiceInstances.Clear();
	}

	public uint Play(string eventPath, AudioPlayOptions options = default(AudioPlayOptions))
	{
		string eventPath2 = ResolveLanguagePath(eventPath);
		uint num = Singleton<GameManager>.instance.audioManager?.PlaySound(eventPath2, options) ?? 0;
		if (num != 0)
		{
			_voiceInstanceIds.Add(num);
		}
		return num;
	}

	public uint Play(IAudioEventReference eventRef, AudioPlayOptions options = default(AudioPlayOptions))
	{
		if (eventRef == null || eventRef.IsNull())
		{
			return 0u;
		}
		return Play(eventRef.GetEventPath(), options);
	}

	public void Pause(uint id, bool paused)
	{
		Singleton<GameManager>.instance.audioManager?.SetPause(id, paused);
	}

	public void PauseAll(bool paused)
	{
		foreach (uint voiceInstanceId in _voiceInstanceIds)
		{
			Singleton<GameManager>.instance.audioManager?.SetPause(voiceInstanceId, paused);
		}
	}

	public void Stop(uint id, bool fadeOut = true)
	{
		_voiceInstanceIds.Remove(id);
		Singleton<GameManager>.instance.audioManager?.Stop(id, fadeOut);
	}

	public void StopAll(bool fadeOut = true)
	{
		foreach (uint voiceInstanceId in _voiceInstanceIds)
		{
			Singleton<GameManager>.instance.audioManager?.Stop(voiceInstanceId, fadeOut);
		}
		_voiceInstanceIds.Clear();
	}

	public void SetParameter(uint id, string parameterName, float value)
	{
		Singleton<GameManager>.instance.audioManager?.SetParameter(id, parameterName, value);
	}

	public uint SetPlotVoice(string eventPath, AudioPlayOptions options = default(AudioPlayOptions))
	{
		string eventPath2 = ResolveLanguagePath(eventPath);
		string paramNameFromPath = GetParamNameFromPath(eventPath2);
		uint num = Singleton<GameManager>.instance.audioManager?.PlaySound(eventPath2, options) ?? 0;
		if (num != 0)
		{
			Singleton<GameManager>.instance.audioManager?.SetPause(num, pause: true);
			_plotVoiceInstances[num] = new PlotVoiceInstance
			{
				Id = num,
				EventPath = eventPath2,
				ParamName = paramNameFromPath,
				CurrentState = 0
			};
		}
		return num;
	}

	public async UniTask SetPlotVoiceState(uint id, int state)
	{
		if (_plotVoiceInstances.TryGetValue(id, out var value) && state != 0)
		{
			value.CurrentState = state;
			Singleton<GameManager>.instance.audioManager?.SetPause(id, pause: false);
			Singleton<GameManager>.instance.audioManager?.SetParameter(id, value.ParamName, state);
			await UniTask.WaitUntil(() => !Singleton<GameManager>.instance.audioManager.IsPlaying(id));
		}
	}

	public void PausePlotVoice(uint id, bool paused)
	{
		Singleton<GameManager>.instance.audioManager?.SetPause(id, paused);
	}

	public void StopPlotVoice(uint id, bool fadeOut = true)
	{
		if (_plotVoiceInstances.ContainsKey(id))
		{
			_plotVoiceInstances.Remove(id);
		}
		Singleton<GameManager>.instance.audioManager?.Stop(id, fadeOut);
	}

	public void StopAllPlot(bool fadeOut = true)
	{
		foreach (KeyValuePair<uint, PlotVoiceInstance> plotVoiceInstance in _plotVoiceInstances)
		{
			Singleton<GameManager>.instance.audioManager?.Stop(plotVoiceInstance.Key, fadeOut);
		}
		_plotVoiceInstances.Clear();
	}

	public PlotVoiceInstance GetPlotVoiceInstance(uint id)
	{
		_plotVoiceInstances.TryGetValue(id, out var value);
		return value;
	}

	private string GetParamNameFromPath(string eventPath)
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			return string.Empty;
		}
		string[] array = eventPath.Split('/');
		if (array.Length == 0)
		{
			return string.Empty;
		}
		return array[array.Length - 1];
	}

	public static string ResolveLanguagePath(string eventPath)
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			return eventPath;
		}
		if (AudioConfig.Instance == null)
		{
			return eventPath;
		}
		AudioLanguageType currentLanguageType = AudioLanguageManager.CurrentLanguageType;
		if (AudioLanguageManager.HasLanguageSupport(eventPath, currentLanguageType))
		{
			string eventPath2 = AudioLanguageManager.GetEventPath(eventPath, currentLanguageType);
			if (!string.IsNullOrEmpty(eventPath2))
			{
				return eventPath2;
			}
		}
		if (currentLanguageType != AudioLanguageType.Chinese && AudioLanguageManager.HasLanguageSupport(eventPath, AudioLanguageType.Chinese))
		{
			return AudioLanguageManager.GetEventPath(eventPath, AudioLanguageType.Chinese);
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"[AudioVoiceManager] Voice event path not found for key '{eventPath}' in language '{currentLanguageType}' or Chinese, using original path");
		}
		return eventPath;
	}
}
