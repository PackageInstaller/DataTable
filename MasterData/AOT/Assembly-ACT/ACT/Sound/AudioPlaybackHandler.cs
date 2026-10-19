using System;
using System.Collections.Generic;
using ACT.Sound.Language;
using ACT.Sound.Management;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Sound;

internal class AudioPlaybackHandler
{
	private readonly AudioInstancePool _instancePool;

	private readonly List<PooledAudioInstance> _channelInstances;

	private readonly AudioBankManager _bankManager;

	public AudioPlaybackHandler(AudioInstancePool instancePool, List<PooledAudioInstance> channelInstances, AudioBankManager bankManager)
	{
		_instancePool = instancePool;
		_channelInstances = channelInstances;
		_bankManager = bankManager;
	}

	public uint Play(IAudioEventReference eventRef, AudioPlayOptions options)
	{
		if (eventRef == null || eventRef.IsNull())
		{
			return 0u;
		}
		string eventPath = ResolveEventPath(eventRef);
		return Play(eventPath, options);
	}

	public uint Play(string eventPath, AudioPlayOptions options)
	{
		string requiredBank = GetRequiredBank(eventPath);
		if (!string.IsNullOrEmpty(requiredBank))
		{
			_bankManager.LoadBankByGuid(requiredBank);
		}
		return CreateInstance(eventPath, options, requiredBank);
	}

	public async UniTask<uint> PlayAsync(IAudioEventReference eventRef, AudioPlayOptions options)
	{
		if (eventRef == null || eventRef.IsNull())
		{
			return 0u;
		}
		return await PlayAsync(ResolveEventPath(eventRef), options);
	}

	public async UniTask<uint> PlayAsync(string eventPath, AudioPlayOptions options)
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			return 0u;
		}
		string requiredBank = GetRequiredBank(eventPath);
		if (!string.IsNullOrEmpty(requiredBank))
		{
			UniTaskCompletionSource<bool> loadSource = new UniTaskCompletionSource<bool>();
			_bankManager.LoadBankByGuidAsync(requiredBank, (bool success) =>
			{
				loadSource.TrySetResult(success);
			});
			if (!(await loadSource.Task))
			{
				return 0u;
			}
		}
		return CreateInstance(eventPath, options, requiredBank);
	}

	private uint CreateInstance(string eventPath, AudioPlayOptions options, string requiredBank)
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			return 0u;
		}
		GameObject gameObject = ((options.attachTarget != null) ? options.attachTarget.gameObject : GameUtility.mainCamera?.gameObject);
		PooledAudioInstance pooledAudioInstance = _instancePool.CreateInstance(eventPath, gameObject);
		if (pooledAudioInstance == null)
		{
			if (!string.IsNullOrEmpty(requiredBank))
			{
				UnloadRequiredBank(requiredBank);
			}
			return 0u;
		}
		pooledAudioInstance.IsLoop = options.IsLoop;
		pooledAudioInstance.RequiredBank = requiredBank;
		if (options.volume > 0f)
		{
			pooledAudioInstance.Instance.SetVolume(options.volume);
		}
		options.onParametersSetup?.Invoke(pooledAudioInstance.Instance);
		pooledAudioInstance.OnCompleteCallback = options.onCompleteCallback;
		pooledAudioInstance.OnStopCallback = (Action<PooledAudioInstance>)Delegate.Combine(pooledAudioInstance.OnStopCallback, new Action<PooledAudioInstance>(OnAudioInstanceSoundStop));
		pooledAudioInstance.Instance.Start();
		_channelInstances.Add(pooledAudioInstance);
		return pooledAudioInstance.Id;
	}

	private void OnAudioInstanceSoundStop(PooledAudioInstance p)
	{
		UnloadRequiredBank(p.RequiredBank);
		_channelInstances.Remove(p);
	}

	private string ResolveEventPath(IAudioEventReference eventRef)
	{
		return eventRef.GetEventPath();
	}

	private string GetRequiredBank(string eventPath)
	{
		if (string.IsNullOrEmpty(eventPath))
		{
			return null;
		}
		AudioConfig instance = AudioConfig.Instance;
		if (instance == null)
		{
			return null;
		}
		return instance.GetBankGuidForEvent(eventPath);
	}

	private void UnloadRequiredBank(string bankGuid)
	{
		if (!string.IsNullOrEmpty(bankGuid))
		{
			_bankManager.UnloadBankByGuid(bankGuid);
		}
	}
}
