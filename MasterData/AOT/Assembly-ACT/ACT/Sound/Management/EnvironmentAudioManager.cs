using ACT.Config;
using ACT.Core;
using Fundamental;
using UnityEngine;

namespace ACT.Sound.Management;

public class EnvironmentAudioManager : Singleton<EnvironmentAudioManager>
{
	private uint _currentEnvironmentInstanceId;

	private string _currentEnvironmentPath;

	private float _currentParamValue;

	private int _currentAmbId;

	private bool _isPlaying;

	public override ContextType ContextType => ContextType.GAME;

	public override void Init()
	{
		_currentEnvironmentInstanceId = 0u;
		_currentEnvironmentPath = null;
		_currentParamValue = 0f;
		_currentAmbId = 0;
		_isPlaying = false;
	}

	public override void UnInit()
	{
		StopEnvironment(fadeOut: false);
	}

	public void PlayEnvironment(string eventPath, float paramValue = 1f, Transform attachTarget = null, bool useZ = false, string parameterName = "")
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			StopEnvironment();
			return;
		}
		if (_currentEnvironmentPath == eventPath && _isPlaying)
		{
			if (!string.IsNullOrEmpty(parameterName) && _currentParamValue != paramValue)
			{
				Singleton<GameManager>.instance.audioManager?.SetParameter(_currentEnvironmentInstanceId, parameterName, paramValue);
				_currentParamValue = paramValue;
			}
			return;
		}
		if (_currentEnvironmentInstanceId != 0)
		{
			Singleton<GameManager>.instance.audioManager?.Stop(_currentEnvironmentInstanceId);
			_currentEnvironmentInstanceId = 0u;
		}
		AudioPlayOptions options = new AudioPlayOptions
		{
			attachTarget = (attachTarget ?? Camera.main?.transform),
			IsLoop = true
		};
		_currentEnvironmentInstanceId = Singleton<GameManager>.instance.audioManager?.PlaySound(eventPath, options) ?? 0;
		_currentEnvironmentPath = eventPath;
		_isPlaying = _currentEnvironmentInstanceId != 0;
		if (_isPlaying && !string.IsNullOrEmpty(parameterName))
		{
			Singleton<GameManager>.instance.audioManager?.SetParameter(_currentEnvironmentInstanceId, parameterName, paramValue);
			_currentParamValue = paramValue;
		}
		if (_isPlaying)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[EnvironmentAudioManager] Playing environment sound: {eventPath}, Param: {paramValue}");
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning("[EnvironmentAudioManager] Failed to play environment sound: " + eventPath);
		}
	}

	public void PlayEnvironmentByAmbId(int ambId, float ambValue = 1f, Transform attachTarget = null, bool useZ = false)
	{
		if (ambId == 0)
		{
			StopEnvironment();
			return;
		}
		_currentAmbId = ambId;
		if (RuntimeConfigs.data?.sceneAMBDatas != null && RuntimeConfigs.data.sceneAMBDatas.ContainsKey(ambId))
		{
			SceneAMBData sceneAMBData = RuntimeConfigs.data.sceneAMBDatas[ambId];
			PlayEnvironment(sceneAMBData.sceneAMB, ambValue, attachTarget, useZ, sceneAMBData.AMBParam);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"[EnvironmentAudioManager] AMB ID {ambId} not found in config");
		}
	}

	public void StopEnvironment(bool fadeOut = true)
	{
		if (_currentEnvironmentInstanceId != 0)
		{
			Singleton<GameManager>.instance.audioManager?.Stop(_currentEnvironmentInstanceId, fadeOut);
			_currentEnvironmentInstanceId = 0u;
		}
		_currentEnvironmentPath = null;
		_currentParamValue = 0f;
		_currentAmbId = 0;
		_isPlaying = false;
	}

	public void PauseEnvironment()
	{
		if (_currentEnvironmentInstanceId != 0)
		{
			Singleton<GameManager>.instance.audioManager?.SetPause(_currentEnvironmentInstanceId, pause: true);
		}
	}

	public void ResumeEnvironment()
	{
		if (_currentEnvironmentInstanceId != 0)
		{
			Singleton<GameManager>.instance.audioManager?.SetPause(_currentEnvironmentInstanceId, pause: false);
		}
	}

	public void SetEnvironmentParameter(string parameterName, float value)
	{
		if (_currentEnvironmentInstanceId != 0 && !string.IsNullOrEmpty(parameterName))
		{
			Singleton<GameManager>.instance.audioManager?.SetParameter(_currentEnvironmentInstanceId, parameterName, value);
			_currentParamValue = value;
		}
	}

	public uint GetCurrentInstanceId()
	{
		return _currentEnvironmentInstanceId;
	}

	public int GetCurrentAmbId()
	{
		return _currentAmbId;
	}

	public bool IsPlaying()
	{
		if (_isPlaying)
		{
			return _currentEnvironmentInstanceId != 0;
		}
		return false;
	}

	public void SetAMBInfo(int ambId, float ambValue = 1f)
	{
		_currentAmbId = ambId;
		_currentParamValue = ambValue;
	}

	public void SetAMBValue(float ambValue)
	{
		_currentParamValue = ambValue;
		if (_isPlaying && _currentEnvironmentInstanceId != 0)
		{
			SetEnvironmentParameter("", ambValue);
		}
	}
}
