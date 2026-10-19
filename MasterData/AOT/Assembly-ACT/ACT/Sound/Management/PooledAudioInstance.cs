using System;
using ACT.Sound.Core;
using UnityEngine;

namespace ACT.Sound.Management;

public class PooledAudioInstance
{
	public uint Id { get; set; }

	public string EventPath { get; set; }

	public IAudioInstance Instance { get; set; }

	public float CreateTime { get; set; }

	public GameObject AttachTarget { get; set; }

	public bool IsLoop { get; set; }

	public string RequiredBank { get; set; }

	public Action<PooledAudioInstance> OnStopCallback { get; set; }

	public Action OnCompleteCallback { get; set; }

	internal Action<uint> OnRegistrationReleased { get; set; }

	public float StopRequestTime { get; set; }

	internal void NotifyRegistrationReleased()
	{
		Action<uint> onRegistrationReleased = OnRegistrationReleased;
		OnRegistrationReleased = null;
		onRegistrationReleased?.Invoke(Id);
	}

	public void MarkStopRequested()
	{
		if (StopRequestTime <= 0f)
		{
			StopRequestTime = Time.unscaledTime;
		}
	}

	public void Reset()
	{
		Id = 0u;
		EventPath = null;
		Instance = null;
		CreateTime = 0f;
		AttachTarget = null;
		IsLoop = false;
		RequiredBank = null;
		OnStopCallback = null;
		OnCompleteCallback = null;
		OnRegistrationReleased = null;
		StopRequestTime = 0f;
	}
}
