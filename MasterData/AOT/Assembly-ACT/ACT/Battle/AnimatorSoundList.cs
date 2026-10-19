using System;
using System.Collections.Generic;
using ACT.Event;
using ACT.Sound;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[Serializable]
public class AnimatorSoundList : MonoBehaviour
{
	public List<AudioEventReference> audioEventReferences;

	[Tooltip("音效事件所需的Bank，编辑器下填入事件时自动烘焙，运行时异步加载")]
	public List<YooAssetReference> banks = new List<YooAssetReference>();

	private List<uint> eventInstances;

	private bool _isDestroying;

	private int _playRequestVersion;

	private void Awake()
	{
		eventInstances = ListPool<uint>.Get();
	}

	public async void PlaySound(int i)
	{
		if (_isDestroying || audioEventReferences == null || i < 0 || i >= audioEventReferences.Count)
		{
			return;
		}
		int requestVersion = ++_playRequestVersion;
		AudioManager audioManager = Singleton<GameManager>.instance?.audioManager;
		if (audioManager == null)
		{
			return;
		}
		_ = audioEventReferences[i];
		if (audioEventReferences[i].IsNull())
		{
			return;
		}
		foreach (uint eventInstance in eventInstances)
		{
			audioManager.Stop(eventInstance);
		}
		eventInstances.Clear();
		uint num = await audioManager.PlaySoundAsync(audioEventReferences[i], new AudioPlayOptions
		{
			attachTarget = transform
		});
		if (num != 0)
		{
			if (_isDestroying || this == null || requestVersion != _playRequestVersion)
			{
				audioManager.Stop(num);
			}
			else
			{
				eventInstances.Add(num);
			}
		}
	}

	private void OnDestroy()
	{
		_isDestroying = true;
		_playRequestVersion++;
		AudioManager audioManager = Singleton<GameManager>.instance?.audioManager;
		if (eventInstances == null)
		{
			return;
		}
		if (audioManager != null)
		{
			foreach (uint eventInstance in eventInstances)
			{
				audioManager.Stop(eventInstance);
			}
		}
		ListPool<uint>.Release(eventInstances);
		eventInstances = null;
	}

	public void PlayCommonSound(CommonAudioType t)
	{
		PlayCommonAudioEvt evt = Singleton<EventManager>.instance.GetEvt<PlayCommonAudioEvt>();
		evt.AudioType = t;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.PlayCommonAudio, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}
}
