using System.Collections.Generic;
using ACT.Sound.Core;
using UnityEngine;

namespace ACT.Sound.Management;

public class AudioInstancePool
{
	private readonly Dictionary<uint, PooledAudioInstance> _activeInstances;

	private readonly Stack<PooledAudioInstance> _pool;

	private readonly List<uint> _toRemove;

	private uint _nextInstanceId = 1u;

	private const int InitialCapacity = 32;

	private const float StopFadeTimeoutSeconds = 3f;

	public AudioInstancePool()
	{
		_activeInstances = new Dictionary<uint, PooledAudioInstance>(32);
		_pool = new Stack<PooledAudioInstance>(32);
		_toRemove = new List<uint>(32);
	}

	public PooledAudioInstance CreateInstance(string eventPath, GameObject gameObject = null)
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			return null;
		}
		IAudioInstance audioInstance = AudioCore.CreateInstance(eventPath);
		if (audioInstance == null || !audioInstance.IsValid)
		{
			return null;
		}
		PooledAudioInstance pooledAudioInstance = ((_pool.Count > 0) ? _pool.Pop() : new PooledAudioInstance());
		pooledAudioInstance.Id = _nextInstanceId++;
		pooledAudioInstance.EventPath = eventPath;
		pooledAudioInstance.Instance = audioInstance;
		pooledAudioInstance.CreateTime = Time.time;
		pooledAudioInstance.AttachTarget = gameObject;
		pooledAudioInstance.IsLoop = false;
		pooledAudioInstance.RequiredBank = null;
		pooledAudioInstance.OnStopCallback = null;
		pooledAudioInstance.StopRequestTime = 0f;
		if (gameObject != null)
		{
			audioInstance.AttachToGameObject(gameObject);
		}
		_activeInstances[pooledAudioInstance.Id] = pooledAudioInstance;
		return pooledAudioInstance;
	}

	public PooledAudioInstance GetInstance(uint id)
	{
		if (!_activeInstances.TryGetValue(id, out var value))
		{
			return null;
		}
		return value;
	}

	public void ReleaseInstance(uint id)
	{
		if (_activeInstances.TryGetValue(id, out var value))
		{
			ReleaseImmediate(value);
		}
	}

	private void ReleaseImmediate(PooledAudioInstance pooled)
	{
		pooled.NotifyRegistrationReleased();
		if (pooled.Instance != null)
		{
			pooled.Instance.Stop(allowFadeOut: false);
			pooled.Instance.Release();
		}
		_activeInstances.Remove(pooled.Id);
		pooled.Reset();
		_pool.Push(pooled);
	}

	public void ReleaseAll()
	{
		foreach (PooledAudioInstance value in _activeInstances.Values)
		{
			value.NotifyRegistrationReleased();
			if (value.Instance != null)
			{
				value.Instance.Stop(allowFadeOut: false);
				value.Instance.Release();
			}
			value.Reset();
			_pool.Push(value);
		}
		_activeInstances.Clear();
	}

	public void Update()
	{
		_toRemove.Clear();
		foreach (KeyValuePair<uint, PooledAudioInstance> activeInstance in _activeInstances)
		{
			PooledAudioInstance value = activeInstance.Value;
			IAudioInstance instance = value.Instance;
			if (instance == null || !instance.IsValid)
			{
				value.OnStopCallback?.Invoke(value);
				_toRemove.Add(activeInstance.Key);
				continue;
			}
			instance.GetPlaybackState(out var state);
			switch (state)
			{
			case AudioPlaybackState.Stopping:
			{
				value.MarkStopRequested();
				bool flag = Time.unscaledTime - value.StopRequestTime > 3f;
				if (instance.IsPaused | flag)
				{
					if (LuminApplication.LogEnabled)
					{
						Debug.LogWarning(string.Format("[AudioInstancePool] Stop fade stalled({0}), force release: {1}, id={2}", flag ? "timeout" : "paused", value.EventPath, value.Id));
					}
					value.OnStopCallback?.Invoke(value);
					_toRemove.Add(activeInstance.Key);
				}
				continue;
			}
			case AudioPlaybackState.Stopped:
				if (!instance.IsPaused)
				{
					value.OnStopCallback?.Invoke(value);
					_toRemove.Add(activeInstance.Key);
					continue;
				}
				break;
			}
			if (state != AudioPlaybackState.Stopped)
			{
				value.StopRequestTime = 0f;
			}
		}
		for (int i = 0; i < _toRemove.Count; i++)
		{
			uint key = _toRemove[i];
			if (_activeInstances.TryGetValue(key, out var value2))
			{
				value2.NotifyRegistrationReleased();
				value2.OnCompleteCallback?.Invoke();
				value2.Instance?.Release();
				_activeInstances.Remove(key);
				value2.Reset();
				_pool.Push(value2);
			}
		}
	}

	public void PauseAll(bool paused)
	{
		foreach (PooledAudioInstance value in _activeInstances.Values)
		{
			value.Instance?.Pause(paused);
		}
	}

	public void Pause(uint id)
	{
		GetInstance(id)?.Instance?.Pause(pause: true);
	}

	public void Resume(uint id)
	{
		GetInstance(id)?.Instance?.Pause(pause: false);
	}
}
