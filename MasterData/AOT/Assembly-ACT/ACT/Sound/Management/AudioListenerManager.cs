using ACT.Battle.ECS.System;
using ACT.Sound.Core;
using Cinemachine;
using UnityEngine;

namespace ACT.Sound.Management;

internal class AudioListenerManager
{
	private IAudioListener _listener;

	public void Initialize()
	{
		GameObject gameObject = null;
		SystemCamera cameraSystem = GameManager.cameraSystem;
		if (cameraSystem != null)
		{
			CinemachineBrain brain = cameraSystem.Brain;
			if ((object)brain != null)
			{
				gameObject = brain.gameObject;
			}
		}
		if (gameObject == null)
		{
			gameObject = GameObject.FindGameObjectWithTag("MainCamera");
			if (gameObject == null)
			{
				return;
			}
		}
		_listener = AudioCore.CreateListener(gameObject);
	}

	public void SetAttenuationObject(GameObject obj)
	{
		_listener?.SetAttenuationObject(obj);
	}

	public void Cleanup()
	{
		_listener?.Cleanup();
		_listener = null;
	}
}
